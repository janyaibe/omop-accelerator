# OMOP Source System Diagrams

Mapping Layer Overview:
    Source tables provide raw clinical data but lack standardization.
    Person Mapping aligns source patient identifiers to a consistent OMOP person_id across all domains.
    Domain Mapping classifies source records by clinical type and directs them to the correct OMOP table.
    Hydration notebooks apply both mappings to transform, standardize, and load data into OMOP.
---

## TouchWorks → OMOP

```mermaid
flowchart LR

subgraph SOURCE[TouchWorks Source]
    tw_person[TW PERSON]
    tw_visit[TW VISIT]
    tw_med[TW dbo_medication]
    tw_med_de[TW dbo_medication_de]
    tw_item_med[TW dbo_item_medication]
    tw_charge[TW dbo_charge]
    tw_charge_code[TW dbo_charge_code_de]
    tw_item_result_proc[TW dbo_item_result]
    tw_order_activity[TW dbo_order_activity_header]
    tw_item_result_meas[TW dbo_item_result]
    tw_result[TW dbo_result]
    tw_order_activity_meas[TW dbo_order_activity_header]
    tw_charge_device[TW dbo_charge]
    tw_charge_code_device[TW dbo_charge_code_de]
    tw_visit_device[TW dbo_visit]
    tw_person_death[TW dbo_person]
    tw_person_other[TW dbo_person_other]
    tw_oah[TW dbo_order_activity_header]
    tw_order_mapper[TW dbo_order_result_mapper]
    tw_result_text[TW dbo_result_text]
    tw_provider[TW dbo_provider]
    tw_person_provider[TW dbo_person]
    tw_sex[TW dbo_sex_de]
    tw_specialty[TW dbo_specialty_de]
    tw_person_address[TW dbo_person_address]
    tw_billing_loc[TW dbo_billing_location_de]
    tw_location_de[TW dbo_location_de]
    tw_site_de[TW dbo_site_de]
    tw_site_loc[TW dbo_site_location_de]
end

subgraph MAP[Mapping Tables]
    map_person[PERSON MAPPING]
    map_domain[DOMAIN MAPPING]
end

subgraph NB[Hydration Notebooks]
    nb_person[allscripts_touchworks_person.ipynb]
    nb_visit_occ[allscripts_touchworks_visit_occurrence.ipynb]
    nb_visit_detail[allscripts_touchworks_visit_detail.ipynb]
    nb_obs[allscripts_touchworks_observation.ipynb]
    nb_drug[allscripts_touchworks_drug_exposure.ipynb]
    nb_proc[allscripts_touchworks_procedure_occurrence.ipynb]
    nb_meas[allscripts_touchworks_measurement.ipynb]
    nb_device[allscripts_touchworks_device_exposure.ipynb]
    nb_death[allscripts_touchworks_death.ipynb]
    nb_note[allscripts_touchworks_note.ipynb]
    nb_provider[allscripts_touchworks_provider.ipynb]
    nb_location[allscripts_touchworks_location.ipynb]
    nb_care_site[allscripts_touchworks_care_site.ipynb]
end

subgraph OMOP[OMOP Tables]
    PERSON
    VISIT_OCCURRENCE
    VISIT_DETAIL
    OBSERVATION
    DRUG_EXPOSURE
    PROCEDURE_OCCURRENCE
    MEASUREMENT
    DEVICE_EXPOSURE
    DEATH
    NOTE
    PROVIDER
    LOCATION
    CARE_SITE
end

tw_person --> nb_person
map_person --> nb_person
nb_person --> PERSON

tw_visit --> nb_visit_occ
nb_visit_occ --> VISIT_OCCURRENCE

tw_visit --> nb_visit_detail
nb_visit_detail --> VISIT_DETAIL

tw_visit --> nb_obs
map_domain --> nb_obs
nb_obs --> OBSERVATION

tw_med --> nb_drug
tw_med_de --> nb_drug
tw_item_med --> nb_drug
map_domain --> nb_drug
map_person --> nb_drug
nb_drug --> DRUG_EXPOSURE

tw_charge --> nb_proc
tw_charge_code --> nb_proc
tw_item_result_proc --> nb_proc
tw_order_activity --> nb_proc
map_domain --> nb_proc
map_person --> nb_proc
nb_proc --> PROCEDURE_OCCURRENCE

tw_item_result_meas --> nb_meas
tw_result --> nb_meas
tw_order_activity_meas --> nb_meas
map_domain --> nb_meas
map_person --> nb_meas
nb_meas --> MEASUREMENT

tw_charge_device --> nb_device
tw_charge_code_device --> nb_device
tw_visit_device --> nb_device
map_domain --> nb_device
map_person --> nb_device
nb_device --> DEVICE_EXPOSURE

tw_person_death --> nb_death
tw_person_other --> nb_death
map_person --> nb_death
nb_death --> DEATH

tw_oah --> nb_note
tw_order_mapper --> nb_note
tw_result_text --> nb_note
map_person --> nb_note
nb_note --> NOTE

tw_provider --> nb_provider
tw_person_provider --> nb_provider
tw_sex --> nb_provider
tw_specialty --> nb_provider
map_domain --> nb_provider
nb_provider --> PROVIDER

tw_person_address --> nb_location
map_domain --> nb_location
nb_location --> LOCATION

tw_billing_loc --> nb_care_site
tw_location_de --> nb_care_site
tw_site_de --> nb_care_site
tw_site_loc --> nb_care_site
map_domain --> nb_care_site
nb_care_site --> CARE_SITE
```

---

## SCM / Sunrise → OMOP

```mermaid
flowchart LR

subgraph SOURCE[SCM / Sunrise Source]
    scm_person[SCM PERSON]
    scm_visit[SCM VISIT]
    scm_order[SCM dbo_cv3order - Medication]
    scm_medext[SCM dbo_cv3medicationextension]
    scm_generic[SCM dbo_sxammgenericitem - RxNorm]
    scm_proc_placeholder[SCM procedure tables - not available]
    scm_obs[SCM dbo_cv3observationcur]
    scm_order_task[SCM dbo_cv3ordertaskoccurrence]
    scm_device_placeholder[SCM device exposure - notebook not found]
    scm_client[SCM dbo_cv3client]
    scm_obs_note[SCM dbo_scaobservation]
    scm_doc[SCM dbo_scadocument]
    scm_docdim[SCM dbo_scadocumentdim]
    scm_client_note[SCM dbo_cv3client]
    scm_careprovider[SCM dbo_cv3careprovider]
    scm_careproviderid[SCM dbo_cv3careproviderid]
    scm_address[SCM dbo_cv3address]
    scm_location_cs[SCM dbo_cv3location]
end

subgraph MAP[Mapping Tables]
    map_person[PERSON MAPPING]
    map_domain[DOMAIN MAPPING]
end

subgraph NB[Hydration Notebooks]
    nb_person[allscripts_scm_person.ipynb]
    nb_visit_occ[allscripts_sunrise_visit_occurence.ipynb]
    nb_visit_detail[allscripts_scm_visit_detail.ipynb]
    nb_obs[allscripts_scm_observation.ipynb]
    nb_drug[allscripts_sunrise_drug_exposure.ipynb]
    nb_proc[allscripts_scm_procedure_occurrence.ipynb]
    nb_meas[allscripts_scm_measurement.ipynb]
    nb_death[allscripts_scm_death.ipynb]
    nb_note[allscripts_scm_note.ipynb]
    nb_provider[allscripts_scm_provider.ipynb]
    nb_location[allscripts_scm_location.ipynb]
    nb_care_site[allscripts_scm_care_site.ipynb]
end

subgraph OMOP[OMOP Tables]
    PERSON
    VISIT_OCCURRENCE
    VISIT_DETAIL
    OBSERVATION
    DRUG_EXPOSURE
    PROCEDURE_OCCURRENCE
    MEASUREMENT
    DEVICE_EXPOSURE
    DEATH
    NOTE
    PROVIDER
    LOCATION
    CARE_SITE
end

scm_person --> nb_person
map_person --> nb_person
nb_person --> PERSON

scm_visit --> nb_visit_occ
nb_visit_occ --> VISIT_OCCURRENCE

scm_visit --> nb_visit_detail
nb_visit_detail --> VISIT_DETAIL

scm_visit --> nb_obs
map_domain --> nb_obs
nb_obs --> OBSERVATION

scm_order --> nb_drug
scm_medext --> nb_drug
scm_generic --> nb_drug
map_domain --> nb_drug
map_person --> nb_drug
nb_drug --> DRUG_EXPOSURE

scm_proc_placeholder --> nb_proc
map_domain --> nb_proc
map_person --> nb_proc
nb_proc --> PROCEDURE_OCCURRENCE

scm_obs --> nb_meas
scm_order_task --> nb_meas
map_domain --> nb_meas
map_person --> nb_meas
nb_meas --> MEASUREMENT

scm_device_placeholder --> DEVICE_EXPOSURE

scm_client --> nb_death
map_person --> nb_death
nb_death --> DEATH

scm_obs_note --> nb_note
scm_doc --> nb_note
scm_docdim --> nb_note
scm_client_note --> nb_note
map_person --> nb_note
nb_note --> NOTE

scm_careprovider --> nb_provider
scm_careproviderid --> nb_provider
map_domain --> nb_provider
nb_provider --> PROVIDER

scm_address --> nb_location
map_domain --> nb_location
nb_location --> LOCATION

scm_location_cs --> nb_care_site
map_domain --> nb_care_site
nb_care_site --> CARE_SITE
```

---

## Epic → OMOP

```mermaid
flowchart LR

subgraph SOURCE[Epic Source]
    epic_person[EPIC PERSON]
    epic_visit[EPIC VISIT]
    epic_order_med[EPIC ORDER_MED]
    epic_med_sig[EPIC ORDER_MED_SIG]
    epic_med_master[EPIC CLARITY_MEDICATION]
    epic_order_proc[EPIC order_proc]
    epic_or_log[EPIC or_log]
    epic_order_results[EPIC order_results]
    epic_flowsheet[EPIC V_EHI_FLO_MEAS_EDITED]
    epic_or_imp[EPIC or_imp]
    epic_patient[EPIC patient]
    epic_hno[EPIC hno_info]
    epic_note_type[EPIC zc_note_type_ip]
    epic_clarity_ser[EPIC clarity_ser]
    epic_patient_addr[EPIC patient]
    epic_dep[EPIC clarity_dep]
    epic_loc[EPIC clarity_loc]
end

subgraph MAP[Mapping Tables]
    map_person[PERSON MAPPING]
    map_domain[DOMAIN MAPPING]
end

subgraph NB[Hydration Notebooks]
    nb_person[epic_clarity_person.ipynb]
    nb_visit_occ[epic_clarity_visit_occurence.ipynb]
    nb_visit_detail[epic_clarity_visit_detail.ipynb]
    nb_obs[epic_clarity_observation.ipynb]
    nb_drug[epic_clarity_drug_exposure.ipynb]
    nb_proc[epic_clarity_procedure_occurrence.ipynb]
    nb_meas[epic_clarity_measurement.ipynb]
    nb_device[epic_clarity_device_exposure.ipynb]
    nb_death[epic_clarity_death.ipynb]
    nb_note[epic_clarity_note.ipynb]
    nb_provider[epic_clarity_provider.ipynb]
    nb_location[epic_clarity_location.ipynb]
    nb_care_site[epic_clarity_care_site.ipynb]
end

subgraph OMOP[OMOP Tables]
    PERSON
    VISIT_OCCURRENCE
    VISIT_DETAIL
    OBSERVATION
    DRUG_EXPOSURE
    PROCEDURE_OCCURRENCE
    MEASUREMENT
    DEVICE_EXPOSURE
    DEATH
    NOTE
    PROVIDER
    LOCATION
    CARE_SITE
end

epic_person --> nb_person
map_person --> nb_person
nb_person --> PERSON

epic_visit --> nb_visit_occ
nb_visit_occ --> VISIT_OCCURRENCE

epic_visit --> nb_visit_detail
nb_visit_detail --> VISIT_DETAIL

epic_visit --> nb_obs
map_domain --> nb_obs
nb_obs --> OBSERVATION

epic_order_med --> nb_drug
epic_med_sig --> nb_drug
epic_med_master --> nb_drug
map_domain --> nb_drug
map_person --> nb_drug
nb_drug --> DRUG_EXPOSURE

epic_order_proc --> nb_proc
epic_or_log --> nb_proc
map_domain --> nb_proc
map_person --> nb_proc
nb_proc --> PROCEDURE_OCCURRENCE

epic_order_results --> nb_meas
epic_flowsheet --> nb_meas
map_domain --> nb_meas
map_person --> nb_meas
nb_meas --> MEASUREMENT

epic_or_imp --> nb_device
map_domain --> nb_device
map_person --> nb_device
nb_device --> DEVICE_EXPOSURE

epic_patient --> nb_death
map_person --> nb_death
nb_death --> DEATH

epic_hno --> nb_note
epic_note_type --> nb_note
map_person --> nb_note
nb_note --> NOTE

epic_clarity_ser --> nb_provider
map_domain --> nb_provider
nb_provider --> PROVIDER

epic_patient_addr --> nb_location
map_domain --> nb_location
nb_location --> LOCATION

epic_dep --> nb_care_site
epic_loc --> nb_care_site
map_domain --> nb_care_site
nb_care_site --> CARE_SITE
```
