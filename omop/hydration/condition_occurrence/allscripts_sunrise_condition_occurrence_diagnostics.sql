-- Databricks notebook source
-- SCM condition_occurrence diagnostics.
-- This notebook is read-only. It validates the client-provided SCM diagnosis views
-- and the diagnosis dimension joins needed by condition_occurrence.

-- COMMAND ----------

SELECT 'vw_diagnosis' AS object_name, COUNT(*) AS row_count
FROM _exponent._bronze_allscripts_scm.vw_diagnosis
UNION ALL
SELECT 'vw_diagdim' AS object_name, COUNT(*) AS row_count
FROM _exponent._bronze_allscripts_scm.vw_diagdim;

-- COMMAND ----------

DESCRIBE TABLE _exponent._bronze_allscripts_scm.vw_diagnosis;

-- COMMAND ----------

DESCRIBE TABLE _exponent._bronze_allscripts_scm.vw_diagdim;

-- COMMAND ----------

SELECT *
FROM _exponent._bronze_allscripts_scm.vw_diagnosis
LIMIT 25;

-- COMMAND ----------

SELECT *
FROM _exponent._bronze_allscripts_scm.vw_diagdim
LIMIT 25;

-- COMMAND ----------

-- Validate the actual SCM diagnosis dimension shape observed in Databricks:
-- vw_diagnosis has SNOMEDDiagDimID, ICD10DiagDimID, ICD9DiagDimID, and DiagDimID.
-- vw_diagdim has DiagDimID, DiagCode, and DiagCodeType.
WITH joined AS (
  SELECT
    d.ClientVisitGUID,
    d.DiagnosisID,
    d.DiagDimID,
    d.SNOMEDDiagDimID,
    d.ICD10DiagDimID,
    d.ICD9DiagDimID,
    dd_snomed.DiagCode AS snomed_code,
    dd_icd10.DiagCode AS icd10_code,
    dd_icd9.DiagCode AS icd9_code,
    dd_primary.DiagCode AS primary_code,
    dd_primary.DiagCodeType AS primary_code_type
  FROM _exponent._bronze_allscripts_scm.vw_diagnosis d
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_snomed
    ON CAST(d.SNOMEDDiagDimID AS STRING) = CAST(dd_snomed.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_icd10
    ON CAST(d.ICD10DiagDimID AS STRING) = CAST(dd_icd10.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_icd9
    ON CAST(d.ICD9DiagDimID AS STRING) = CAST(dd_icd9.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_primary
    ON CAST(d.DiagDimID AS STRING) = CAST(dd_primary.DiagDimID AS STRING)
)
SELECT '01 raw diagnosis rows' AS metric, COUNT(*) AS rows FROM joined
UNION ALL SELECT '02 with ClientVisitGUID', COUNT(*) FROM joined WHERE ClientVisitGUID IS NOT NULL
UNION ALL SELECT '03 with SNOMED dim id', COUNT(*) FROM joined WHERE SNOMEDDiagDimID IS NOT NULL
UNION ALL SELECT '04 with ICD10 dim id', COUNT(*) FROM joined WHERE ICD10DiagDimID IS NOT NULL
UNION ALL SELECT '05 with ICD9 dim id', COUNT(*) FROM joined WHERE ICD9DiagDimID IS NOT NULL
UNION ALL SELECT '06 with primary DiagDimID', COUNT(*) FROM joined WHERE DiagDimID IS NOT NULL
UNION ALL SELECT '07 joined SNOMED code', COUNT(*) FROM joined WHERE snomed_code IS NOT NULL
UNION ALL SELECT '08 joined ICD10 code', COUNT(*) FROM joined WHERE icd10_code IS NOT NULL
UNION ALL SELECT '09 joined ICD9 code', COUNT(*) FROM joined WHERE icd9_code IS NOT NULL
UNION ALL SELECT '10 joined primary code', COUNT(*) FROM joined WHERE primary_code IS NOT NULL
UNION ALL SELECT '11 usable diagnosis code', COUNT(*) FROM joined WHERE COALESCE(snomed_code, icd10_code, icd9_code, primary_code) IS NOT NULL;

-- COMMAND ----------

WITH joined AS (
  SELECT
    d.ClientVisitGUID,
    d.DiagnosisID,
    d.DiagDimID,
    d.SNOMEDDiagDimID,
    d.ICD10DiagDimID,
    d.ICD9DiagDimID,
    dd_snomed.DiagCode AS snomed_code,
    dd_icd10.DiagCode AS icd10_code,
    dd_icd9.DiagCode AS icd9_code,
    dd_primary.DiagCode AS primary_code,
    dd_primary.DiagCodeType AS primary_code_type,
    COALESCE(dd_snomed.DiagCode, dd_icd10.DiagCode, dd_icd9.DiagCode, dd_primary.DiagCode) AS source_code,
    CASE
      WHEN dd_snomed.DiagCode IS NOT NULL THEN 'SNOMED'
      WHEN dd_icd10.DiagCode IS NOT NULL THEN 'ICD10CM'
      WHEN dd_icd9.DiagCode IS NOT NULL THEN 'ICD9CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%SNOMED%' THEN 'SNOMED'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD10%' THEN 'ICD10CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD-10%' THEN 'ICD10CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD9%' THEN 'ICD9CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD-9%' THEN 'ICD9CM'
      ELSE NULL
    END AS source_vocabulary_id
  FROM _exponent._bronze_allscripts_scm.vw_diagnosis d
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_snomed
    ON CAST(d.SNOMEDDiagDimID AS STRING) = CAST(dd_snomed.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_icd10
    ON CAST(d.ICD10DiagDimID AS STRING) = CAST(dd_icd10.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_icd9
    ON CAST(d.ICD9DiagDimID AS STRING) = CAST(dd_icd9.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_primary
    ON CAST(d.DiagDimID AS STRING) = CAST(dd_primary.DiagDimID AS STRING)
)
SELECT
  source_vocabulary_id,
  COUNT(*) AS rows,
  COUNT(DISTINCT source_code) AS distinct_codes
FROM joined
WHERE source_code IS NOT NULL
GROUP BY source_vocabulary_id
ORDER BY rows DESC;

-- COMMAND ----------

WITH joined AS (
  SELECT
    d.ClientVisitGUID,
    d.DiagnosisID,
    d.DiagDimID,
    d.SNOMEDDiagDimID,
    d.ICD10DiagDimID,
    d.ICD9DiagDimID,
    dd_snomed.DiagCode AS snomed_code,
    dd_icd10.DiagCode AS icd10_code,
    dd_icd9.DiagCode AS icd9_code,
    dd_primary.DiagCode AS primary_code,
    dd_primary.DiagCodeType AS primary_code_type,
    COALESCE(dd_snomed.DiagCode, dd_icd10.DiagCode, dd_icd9.DiagCode, dd_primary.DiagCode) AS source_code,
    CASE
      WHEN dd_snomed.DiagCode IS NOT NULL THEN 'SNOMED'
      WHEN dd_icd10.DiagCode IS NOT NULL THEN 'ICD10CM'
      WHEN dd_icd9.DiagCode IS NOT NULL THEN 'ICD9CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%SNOMED%' THEN 'SNOMED'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD10%' THEN 'ICD10CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD-10%' THEN 'ICD10CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD9%' THEN 'ICD9CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD-9%' THEN 'ICD9CM'
      ELSE NULL
    END AS source_vocabulary_id
  FROM _exponent._bronze_allscripts_scm.vw_diagnosis d
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_snomed
    ON CAST(d.SNOMEDDiagDimID AS STRING) = CAST(dd_snomed.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_icd10
    ON CAST(d.ICD10DiagDimID AS STRING) = CAST(dd_icd10.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_icd9
    ON CAST(d.ICD9DiagDimID AS STRING) = CAST(dd_icd9.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_primary
    ON CAST(d.DiagDimID AS STRING) = CAST(dd_primary.DiagDimID AS STRING)
)
SELECT *
FROM joined
WHERE source_code IS NOT NULL
LIMIT 100;

-- COMMAND ----------

WITH source_data AS (
  SELECT
    d.ClientVisitGUID,
    COALESCE(dd_snomed.DiagCode, dd_icd10.DiagCode, dd_icd9.DiagCode, dd_primary.DiagCode) AS source_code,
    CASE
      WHEN dd_snomed.DiagCode IS NOT NULL THEN 'SNOMED'
      WHEN dd_icd10.DiagCode IS NOT NULL THEN 'ICD10CM'
      WHEN dd_icd9.DiagCode IS NOT NULL THEN 'ICD9CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%SNOMED%' THEN 'SNOMED'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD10%' THEN 'ICD10CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD-10%' THEN 'ICD10CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD9%' THEN 'ICD9CM'
      WHEN dd_primary.DiagCode IS NOT NULL AND UPPER(CAST(dd_primary.DiagCodeType AS STRING)) LIKE '%ICD-9%' THEN 'ICD9CM'
      ELSE NULL
    END AS source_vocabulary_id,
    CONCAT_WS(
      CHR(31),
      'allscripts_scm',
      'dbo_cv3clientvisit',
      'GUID',
      CAST(d.ClientVisitGUID AS STRING)
    ) AS visit_occurrence_source_value
  FROM _exponent._bronze_allscripts_scm.vw_diagnosis d
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_snomed
    ON CAST(d.SNOMEDDiagDimID AS STRING) = CAST(dd_snomed.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_icd10
    ON CAST(d.ICD10DiagDimID AS STRING) = CAST(dd_icd10.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_icd9
    ON CAST(d.ICD9DiagDimID AS STRING) = CAST(dd_icd9.DiagDimID AS STRING)
  LEFT JOIN _exponent._bronze_allscripts_scm.vw_diagdim dd_primary
    ON CAST(d.DiagDimID AS STRING) = CAST(dd_primary.DiagDimID AS STRING)
)
SELECT '01 raw joined rows' AS stage, COUNT(*) AS rows FROM source_data
UNION ALL SELECT '02 with code and vocabulary', COUNT(*) FROM source_data WHERE source_code IS NOT NULL AND source_vocabulary_id IS NOT NULL
UNION ALL SELECT '03 with mapped visit', COUNT(*) FROM source_data sd
  JOIN _exponent.omop_mapping.source_to_visit_occurrence stvo
    ON stvo.visit_occurrence_source_value = sd.visit_occurrence_source_value
   AND stvo.source_system = 'allscripts_scm'
   AND stvo.active_flag = TRUE
  WHERE sd.source_code IS NOT NULL AND sd.source_vocabulary_id IS NOT NULL
UNION ALL SELECT '04 source concept matched', COUNT(*) FROM source_data sd
  JOIN _exponent.omop.concept c
    ON c.concept_code = sd.source_code
   AND c.vocabulary_id = sd.source_vocabulary_id
   AND c.invalid_reason IS NULL
  WHERE sd.source_code IS NOT NULL AND sd.source_vocabulary_id IS NOT NULL;
