# Databricks notebook source
# Query Information
subjectarea = "procedures"
sourcesystem = "SCM"

silvertable = "northwell.omny_silver.procedures_SCM"
silvertableloadtype = "APPEND"

filename = "NWH_SCM_procedures_{start_date}_{end_date}"

# COMMAND ----------

# Bronze to Silver Query
bronzesql_df = spark.sql(
"""

with scm_encounter_mapper AS (

    SELECT encounter_identifier, v.EncounterNumber, RIGHT('0000000000000' || v.EncounterNumber , 13) as ext_encounter, t.patient_epi
    FROM northwell.omny_silver._temp_encounter_scm t
    INNER JOIN _bronze.sca_acutecare_uat.dbo_scavisit v 
        ON t.encounter_identifier = v.VisitID and t.patient_identifier = v.PatientDimID

), soarian_scm_accounts AS 
(
    SELECT distinct 
        a.Facility as facility,
        e.encounter_identifier as encounter_identifier -- VisitID
        , e.patient_epi  AS patient_identifier -- EPI
        , CPT_code AS cpt_code
        , '' as cpt_description
        , modifiers AS mods
        , 2 as prio
        , a.service_date as service_date
        , a.billing_provider_NPI as billing_provider_npi
 
    FROM _bronze.soarian.omny_accounts a
    INNER JOIN scm_encounter_mapper e
        on RIGHT('0000000000000' || LTRIM(RTRIM(a.encounter_id)), 13) = e.ext_encounter
        and a.Patient_EPI = e.patient_epi
)
, dss_scm_accounts AS 
(
    SELECT distinct 
        a.Facility as facility,
        e.encounter_identifier as encounter_identifier
        , e.patient_epi  AS patient_identifier
        , CASE WHEN length(CPT_code) = 7 THEN substring(CPT_code, 1, 5) ELSE CPT_code END AS cpt_code
        , '' as cpt_description
        , CASE 
            WHEN length(CPT_code) = 7 THEN 
                CASE 
                    WHEN modifiers = '' OR modifiers IS NULL THEN substring(CPT_code, 6, 2)
                    ELSE concat(modifiers, ',', substring(CPT_code, 6, 2))
                END
            ELSE modifiers
          END AS mods
        , 1 as prio
        , a.service_date as service_date
        , a.billing_provider_NPI as billing_provider_npi

    FROM _bronze.dss.omny_accounts a
    INNER JOIN scm_encounter_mapper e
        on RIGHT('0000000000000' || LTRIM(RTRIM(a.encounter_id)), 13) = e.ext_encounter
        and a.Patient_EPI = e.patient_epi
)
, athena_scm_accounts AS 
(
    SELECT distinct 
        '' as facility,
        e.encounter_identifier as encounter_identifier -- VisitID
        , e.patient_epi  AS patient_identifier -- EPI
        , CPT AS cpt_code
        , a.CPT_Description as cpt_description
        , Mod_List AS mods
        , 3 as prio
        , a.SerDt as service_date
        , a.NpiNumber as billing_provider_npi

    FROM _bronze.athena.omny_accounts a
    INNER JOIN scm_encounter_mapper e
    on RIGHT('0000000000000' || SUBSTRING(LTRIM(RTRIM(a.encounter_identifier)),3,len(a.encounter_identifier)), 13) = e.ext_encounter
    and SUBSTRING(TRIM(a.Patient_Identifier), 4) = e.patient_epi
)
, scm_accounts AS 
(
    SELECT * 
    FROM (
        SELECT DISTINCT *
        FROM soarian_scm_accounts as soarian 

        UNION 

        SELECT DISTINCT *
        FROM dss_scm_accounts as dss 

        UNION

        SELECT DISTINCT *
        FROM  athena_scm_accounts as athena 
    )
    QUALIFY ROW_NUMBER() OVER (PARTITION BY encounter_identifier, patient_identifier, cpt_code, service_date, mods, billing_provider_npi ORDER BY prio ) = 1

)
select
    distinct 
    sha2(concat_ws('-',
        coalesce(e.patient_identifier, ''),
        coalesce(e.patient_epi, ''),
        coalesce(e.encounter_identifier, ''),
        coalesce(accounts.cpt_code, ''),
        coalesce(accounts.mods, ''),
        coalesce(accounts.service_date, ''),
        coalesce(accounts.billing_provider_npi, '')
        ),
        256    
    ) as transaction_identifier,
    MD5(CAST(e.encounter_identifier as STRING)) AS account_identifier,
    '' as order_procedure_identifier,
    '' as ordering_encounter_identifier,
    e.encounter_identifier as performing_encounter_identifier,
    e.patient_identifier as patient_identifier,
    e.patient_epi as patient_epi,
    '' as ordering_date_time,
    accounts.service_date as service_date_time,
    '' as performing_department,
    '' as authorizing_provider_npi,
    accounts.billing_provider_npi as billing_provider_npi,
    '' as performing_provider_npi,
    CASE
        WHEN length(accounts.cpt_code) = 6 AND (
            regexp_like(substring(accounts.cpt_code, 1, 5), '^[0-9]{{5}}$') -- 5 digits
            OR regexp_like(substring(accounts.cpt_code, 1, 5), '^[A-Za-z][0-9]{{4}}$') -- 1 letter + 4 digits
            OR regexp_like(substring(accounts.cpt_code, 1, 5), '^[0-9]{{4}}[A-Za-z]$') -- 4 digits + 1 letter
        ) THEN 'CPT'
        WHEN length(accounts.cpt_code) = 5 THEN 'CPT' 
        ELSE 'CUSTOM' 
    END as procedure_code_type,
    CASE 
        WHEN length(accounts.cpt_code) = 6 AND (
            regexp_like(substring(accounts.cpt_code, 1, 5), '^[0-9]{{5}}$') -- 5 digits
            OR regexp_like(substring(accounts.cpt_code, 1, 5), '^[A-Za-z][0-9]{{4}}$') -- 1 letter + 4 digits
            OR regexp_like(substring(accounts.cpt_code, 1, 5), '^[0-9]{{4}}[A-Za-z]$') -- 4 digits + 1 letter
        ) THEN substring(accounts.cpt_code, 1, 5)
        ELSE accounts.cpt_code
    END AS procedure_code,
    accounts.cpt_description as procedure_name,
    NULLIF(rtrim(',', trim(accounts.mods)), '') AS modifiers,
    {week_num} as week_num
from
    northwell.omny_silver._temp_encounter_scm e
    inner join scm_accounts accounts 
        on e.encounter_identifier = accounts.encounter_identifier 
        and e.patient_epi = accounts.patient_identifier
where
    e.patient_epi is not null and e.patient_epi <> ''
    and accounts.cpt_code is not null
    and accounts.service_date is not null and accounts.service_date <> ''

""")

display(bronzesql_df)

# COMMAND ----------

# Silver table to store the bronzesql_df
silvertable = "northwell.omny_silver.procedures_SCM"
silvertableloadtype = "APPEND"

# COMMAND ----------

# Export to file query (column remapping when needed) 
filesql_df = spark.sql(
"""
SELECT DISTINCT transaction_identifier,account_identifier,order_procedure_identifier,ordering_encounter_identifier,performing_encounter_identifier,patient_epi as patient_identifier,ordering_date_time,service_date_time,performing_department,authorizing_provider_npi,billing_provider_npi,performing_provider_npi,procedure_code_type,procedure_code,procedure_name,modifiers FROM northwell.omny_silver.procedures_SCM WHERE week_num = {week_num} AND patient_epi IS NOT NULL AND patient_epi != '' 
""")

display(filesql_df)

# COMMAND ----------

# the filename to store the filesql_df
filename = "NWH_SCM_procedures_{start_date}_{end_date}"
