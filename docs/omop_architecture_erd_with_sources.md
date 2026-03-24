# OMOP CDM v5.4 Entity Relationship Diagrams

This document contains ERDs for the OMOP Common Data Model v5.4, organized by category for easier viewing.

---

## 1. Databricks Hydration Flow (Source → OMOP)

```mermaid
flowchart LR

%% ======================
%% SOURCE SYSTEMS
%% ======================

subgraph Source_Systems

    subgraph TW
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

    subgraph SCM
        scm_person[SCM PERSON]
        scm_visit[SCM VISIT]

        scm_order[SCM dbo_cv3order - Medication]
        scm_medext[SCM dbo_cv3medicationextension]
        scm_generic[SCM dbo_sxammgenericitem - RxNorm]

        scm_proc_placeholder[SCM procedure tables - not available]

        scm_obs[SCM dbo_cv3observationcur]
        scm_order_task[SCM dbo_cv3ordertaskoccurrence]

        scm_device_placeholder[SCM device exposure - not provided yet]

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

    subgraph EPIC
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

end

%% ======================
%% MAPPING
%% ======================

subgraph Mapping_Tables
    map_person[PERSON MAPPING]
    map_domain[DOMAIN MAPPING]
end

%% ======================
%% NOTEBOOKS
%% ======================

subgraph Notebooks
    nb_person_scm[allscripts_scm_person.ipynb]
    nb_person_tw[allscripts_touchworks_person.ipynb]
    nb_person_epic[epic_clarity_person.ipynb]

    nb_visit_occ_scm[allscripts_sunrise_visit_occurrence.ipynb]
    nb_visit_occ_tw[allscripts_touchworks_visit_occurrence.ipynb]
    nb_visit_occ_epic[epic_clarity_visit_occurrence.ipynb]

    nb_visit_detail_scm[allscripts_scm_visit_detail.ipynb]
    nb_visit_detail_tw[allscripts_touchworks_visit_detail.ipynb]
    nb_visit_detail_epic[epic_clarity_visit_detail.ipynb]

    nb_obs_scm[allscripts_scm_observation.ipynb]
    nb_obs_tw[allscripts_touchworks_observation.ipynb]
    nb_obs_epic[epic_clarity_observation.ipynb]

    nb_drug_scm[allscripts_sunrise_drug_exposure.ipynb]
    nb_drug_tw[allscripts_touchworks_drug_exposure.ipynb]
    nb_drug_epic[epic_clarity_drug_exposure.ipynb]

    nb_proc_scm[allscripts_scm_procedure_occurrence.ipynb]
    nb_proc_tw[allscripts_touchworks_procedure_occurrence.ipynb]
    nb_proc_epic[epic_clarity_procedure_occurrence.ipynb]

    nb_meas_scm[allscripts_scm_measurement.ipynb]
    nb_meas_tw[allscripts_touchworks_measurement.ipynb]
    nb_meas_epic[epic_clarity_measurement.ipynb]

    nb_device_scm[allscripts_scm_care_site_nope.ipynb]
    nb_device_tw[allscripts_touchworks_device_exposure.ipynb]
    nb_device_epic[epic_clarity_device_exposure.ipynb]

    nb_death_scm[allscripts_scm_death.ipynb]
    nb_death_tw[allscripts_touchworks_death.ipynb]
    nb_death_epic[epic_clarity_death.ipynb]

    nb_note_scm[allscripts_scm_note.ipynb]
    nb_note_tw[allscripts_touchworks_note.ipynb]
    nb_note_epic[epic_clarity_note.ipynb]

    nb_provider_scm[allscripts_scm_provider.ipynb]
    nb_provider_tw[allscripts_touchworks_provider.ipynb]
    nb_provider_epic[epic_clarity_provider.ipynb]

    nb_location_scm[allscripts_scm_location.ipynb]
    nb_location_tw[allscripts_touchworks_location.ipynb]
    nb_location_epic[epic_clarity_location.ipynb]

    nb_care_site_scm[allscripts_scm_care_site.ipynb]
    nb_care_site_tw[allscripts_touchworks_care_site.ipynb]
    nb_care_site_epic[epic_clarity_care_site.ipynb]
end

%% ======================
%% OMOP
%% ======================

subgraph OMOP
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

%% ======================
%% PERSON
%% ======================

tw_person --> nb_person_tw
scm_person --> nb_person_scm
epic_person --> nb_person_epic

map_person --> nb_person_tw
map_person --> nb_person_scm
map_person --> nb_person_epic

nb_person_tw --> PERSON
nb_person_scm --> PERSON
nb_person_epic --> PERSON

%% ======================
%% VISIT OCCURRENCE
%% ======================

tw_visit --> nb_visit_occ_tw
scm_visit --> nb_visit_occ_scm
epic_visit --> nb_visit_occ_epic

nb_visit_occ_tw --> VISIT_OCCURRENCE
nb_visit_occ_scm --> VISIT_OCCURRENCE
nb_visit_occ_epic --> VISIT_OCCURRENCE

%% ======================
%% VISIT DETAIL
%% ======================

tw_visit --> nb_visit_detail_tw
scm_visit --> nb_visit_detail_scm
epic_visit --> nb_visit_detail_epic

nb_visit_detail_tw --> VISIT_DETAIL
nb_visit_detail_scm --> VISIT_DETAIL
nb_visit_detail_epic --> VISIT_DETAIL

%% ======================
%% OBSERVATION
%% ======================

tw_visit --> nb_obs_tw
scm_visit --> nb_obs_scm
epic_visit --> nb_obs_epic

map_domain --> nb_obs_tw
map_domain --> nb_obs_scm
map_domain --> nb_obs_epic

nb_obs_tw --> OBSERVATION
nb_obs_scm --> OBSERVATION
nb_obs_epic --> OBSERVATION

%% ======================
%% DRUG EXPOSURE
%% ======================

tw_med --> nb_drug_tw
tw_med_de --> nb_drug_tw
tw_item_med --> nb_drug_tw

scm_order --> nb_drug_scm
scm_medext --> nb_drug_scm
scm_generic --> nb_drug_scm

epic_order_med --> nb_drug_epic
epic_med_sig --> nb_drug_epic
epic_med_master --> nb_drug_epic

map_domain --> nb_drug_tw
map_domain --> nb_drug_scm
map_domain --> nb_drug_epic
map_person --> nb_drug_tw
map_person --> nb_drug_scm
map_person --> nb_drug_epic

nb_drug_tw --> DRUG_EXPOSURE
nb_drug_scm --> DRUG_EXPOSURE
nb_drug_epic --> DRUG_EXPOSURE

%% ======================
%% PROCEDURE OCCURRENCE
%% ======================

tw_charge --> nb_proc_tw
tw_charge_code --> nb_proc_tw
tw_item_result_proc --> nb_proc_tw
tw_order_activity --> nb_proc_tw

scm_proc_placeholder --> nb_proc_scm

epic_order_proc --> nb_proc_epic
epic_or_log --> nb_proc_epic

map_domain --> nb_proc_tw
map_domain --> nb_proc_scm
map_domain --> nb_proc_epic
map_person --> nb_proc_tw
map_person --> nb_proc_scm
map_person --> nb_proc_epic

nb_proc_tw --> PROCEDURE_OCCURRENCE
nb_proc_scm --> PROCEDURE_OCCURRENCE
nb_proc_epic --> PROCEDURE_OCCURRENCE

%% ======================
%% MEASUREMENT
%% ======================

tw_item_result_meas --> nb_meas_tw
tw_result --> nb_meas_tw
tw_order_activity_meas --> nb_meas_tw

scm_obs --> nb_meas_scm
scm_order_task --> nb_meas_scm

epic_order_results --> nb_meas_epic
epic_flowsheet --> nb_meas_epic

map_domain --> nb_meas_tw
map_domain --> nb_meas_scm
map_domain --> nb_meas_epic
map_person --> nb_meas_tw
map_person --> nb_meas_scm
map_person --> nb_meas_epic

nb_meas_tw --> MEASUREMENT
nb_meas_scm --> MEASUREMENT
nb_meas_epic --> MEASUREMENT

%% ======================
%% DEVICE EXPOSURE
%% ======================

tw_charge_device --> nb_device_tw
tw_charge_code_device --> nb_device_tw
tw_visit_device --> nb_device_tw

scm_device_placeholder --> nb_device_scm

epic_or_imp --> nb_device_epic

map_domain --> nb_device_tw
map_domain --> nb_device_scm
map_domain --> nb_device_epic
map_person --> nb_device_tw
map_person --> nb_device_scm
map_person --> nb_device_epic

nb_device_tw --> DEVICE_EXPOSURE
nb_device_scm --> DEVICE_EXPOSURE
nb_device_epic --> DEVICE_EXPOSURE

%% ======================
%% DEATH
%% ======================

tw_person_death --> nb_death_tw
tw_person_other --> nb_death_tw

scm_client --> nb_death_scm

epic_patient --> nb_death_epic

map_person --> nb_death_tw
map_person --> nb_death_scm
map_person --> nb_death_epic

nb_death_tw --> DEATH
nb_death_scm --> DEATH
nb_death_epic --> DEATH

%% ======================
%% NOTE
%% ======================

tw_oah --> nb_note_tw
tw_order_mapper --> nb_note_tw
tw_result_text --> nb_note_tw

scm_obs_note --> nb_note_scm
scm_doc --> nb_note_scm
scm_docdim --> nb_note_scm
scm_client_note --> nb_note_scm

epic_hno --> nb_note_epic
epic_note_type --> nb_note_epic

map_person --> nb_note_tw
map_person --> nb_note_scm
map_person --> nb_note_epic

nb_note_tw --> NOTE
nb_note_scm --> NOTE
nb_note_epic --> NOTE

%% ======================
%% PROVIDER
%% ======================

tw_provider --> nb_provider_tw
tw_person_provider --> nb_provider_tw
tw_sex --> nb_provider_tw
tw_specialty --> nb_provider_tw

scm_careprovider --> nb_provider_scm
scm_careproviderid --> nb_provider_scm

epic_clarity_ser --> nb_provider_epic

map_domain --> nb_provider_tw
map_domain --> nb_provider_scm
map_domain --> nb_provider_epic

nb_provider_tw --> PROVIDER
nb_provider_scm --> PROVIDER
nb_provider_epic --> PROVIDER

%% ======================
%% LOCATION
%% ======================

tw_person_address --> nb_location_tw
scm_address --> nb_location_scm
epic_patient_addr --> nb_location_epic

map_domain --> nb_location_tw
map_domain --> nb_location_scm
map_domain --> nb_location_epic

nb_location_tw --> LOCATION
nb_location_scm --> LOCATION
nb_location_epic --> LOCATION

%% ======================
%% CARE SITE
%% ======================

tw_billing_loc --> nb_care_site_tw
tw_location_de --> nb_care_site_tw
tw_site_de --> nb_care_site_tw
tw_site_loc --> nb_care_site_tw

scm_location_cs --> nb_care_site_scm

epic_dep --> nb_care_site_epic
epic_loc --> nb_care_site_epic

map_domain --> nb_care_site_tw
map_domain --> nb_care_site_scm
map_domain --> nb_care_site_epic

nb_care_site_tw --> CARE_SITE
nb_care_site_scm --> CARE_SITE
nb_care_site_epic --> CARE_SITE
```

## 2. Clinical Events Tables

Tables that capture clinical events during patient visits.

```mermaid
erDiagram
    CONDITION_OCCURRENCE {
        bigint condition_occurrence_id PK
        bigint person_id FK
        int condition_concept_id FK
        date condition_start_date
        date condition_end_date
        int condition_type_concept_id FK
        int condition_status_concept_id FK
        string stop_reason
        bigint provider_id FK
        bigint visit_occurrence_id FK
        bigint visit_detail_id FK
        string condition_source_value
        int condition_source_concept_id FK
    }

    DRUG_EXPOSURE {
        bigint drug_exposure_id PK
        bigint person_id FK
        int drug_concept_id FK
        date drug_exposure_start_date
        date drug_exposure_end_date
        int drug_type_concept_id FK
        string stop_reason
        int refills
        double quantity
        int days_supply
        string sig
        int route_concept_id FK
        bigint provider_id FK
        bigint visit_occurrence_id FK
        bigint visit_detail_id FK
        string drug_source_value
    }

    PROCEDURE_OCCURRENCE {
        bigint procedure_occurrence_id PK
        bigint person_id FK
        int procedure_concept_id FK
        date procedure_date
        date procedure_end_date
        int procedure_type_concept_id FK
        int modifier_concept_id FK
        int quantity
        bigint provider_id FK
        bigint visit_occurrence_id FK
        bigint visit_detail_id FK
        string procedure_source_value
    }

    MEASUREMENT {
        bigint measurement_id PK
        bigint person_id FK
        int measurement_concept_id FK
        date measurement_date
        int measurement_type_concept_id FK
        int operator_concept_id FK
        double value_as_number
        int value_as_concept_id FK
        int unit_concept_id FK
        double range_low
        double range_high
        bigint provider_id FK
        bigint visit_occurrence_id FK
        string measurement_source_value
    }

    OBSERVATION {
        bigint observation_id PK
        bigint person_id FK
        int observation_concept_id FK
        date observation_date
        int observation_type_concept_id FK
        double value_as_number
        string value_as_string
        int value_as_concept_id FK
        int qualifier_concept_id FK
        int unit_concept_id FK
        bigint provider_id FK
        bigint visit_occurrence_id FK
        string observation_source_value
    }

    DEVICE_EXPOSURE {
        bigint device_exposure_id PK
        bigint person_id FK
        int device_concept_id FK
        date device_exposure_start_date
        date device_exposure_end_date
        int device_type_concept_id FK
        string unique_device_id
        int quantity
        bigint provider_id FK
        bigint visit_occurrence_id FK
        string device_source_value
    }

    PERSON ||--o{ CONDITION_OCCURRENCE : has
    PERSON ||--o{ DRUG_EXPOSURE : has
    PERSON ||--o{ PROCEDURE_OCCURRENCE : has
    PERSON ||--o{ MEASUREMENT : has
    PERSON ||--o{ OBSERVATION : has
    PERSON ||--o{ DEVICE_EXPOSURE : has
```

## 3. Notes and Specimens

```mermaid
erDiagram
    NOTE {
        bigint note_id PK
        bigint person_id FK
        date note_date
        timestamp note_datetime
        int note_type_concept_id FK
        int note_class_concept_id FK
        string note_title
        string note_text
        int encoding_concept_id FK
        int language_concept_id FK
        bigint provider_id FK
        bigint visit_occurrence_id FK
        string note_source_value
    }

    NOTE_NLP {
        bigint note_nlp_id PK
        bigint note_id FK
        int section_concept_id FK
        string snippet
        string offset
        string lexical_variant
        int note_nlp_concept_id FK
        string nlp_system
        date nlp_date
        string term_exists
        string term_temporal
        string term_modifiers
    }

    SPECIMEN {
        bigint specimen_id PK
        bigint person_id FK
        int specimen_concept_id FK
        int specimen_type_concept_id FK
        date specimen_date
        double quantity
        int unit_concept_id FK
        int anatomic_site_concept_id FK
        int disease_status_concept_id FK
        string specimen_source_value
    }

    PERSON ||--o{ NOTE : has
    PERSON ||--o{ SPECIMEN : has
    NOTE ||--o{ NOTE_NLP : analyzed_by
```

---

## 4. Health System Tables

```mermaid
erDiagram
    LOCATION {
        bigint location_id PK
        string address_1
        string address_2
        string city
        string state
        string zip
        string county
        string location_source_value
        int country_concept_id FK
        double latitude
        double longitude
    }

    CARE_SITE {
        bigint care_site_id PK
        string care_site_name
        int place_of_service_concept_id FK
        bigint location_id FK
        string care_site_source_value
    }

    PROVIDER {
        bigint provider_id PK
        string provider_name
        string npi
        string dea
        int specialty_concept_id FK
        bigint care_site_id FK
        int year_of_birth
        int gender_concept_id FK
        string provider_source_value
        string specialty_source_value
    }

    LOCATION ||--o{ CARE_SITE : location_of
    CARE_SITE ||--o{ PROVIDER : employs
    LOCATION ||--o{ PERSON : residence
    CARE_SITE ||--o{ PERSON : care_site_of
    PROVIDER ||--o{ PERSON : provider_of
```

---

## 5. Vocabulary Tables

The standardized vocabulary system - CONCEPT is the central hub.

```mermaid
erDiagram
    CONCEPT {
        int concept_id PK
        string concept_name
        string domain_id FK
        string vocabulary_id FK
        string concept_class_id FK
        string standard_concept
        string concept_code
        date valid_start_date
        date valid_end_date
        string invalid_reason
    }

    VOCABULARY {
        string vocabulary_id PK
        string vocabulary_name
        string vocabulary_reference
        string vocabulary_version
        int vocabulary_concept_id FK
    }

    DOMAIN {
        string domain_id PK
        string domain_name
        int domain_concept_id FK
    }

    CONCEPT_CLASS {
        string concept_class_id PK
        string concept_class_name
        int concept_class_concept_id FK
    }

    RELATIONSHIP {
        string relationship_id PK
        string relationship_name
        string is_hierarchical
        string defines_ancestry
        string reverse_relationship_id FK
        int relationship_concept_id FK
    }

    CONCEPT_RELATIONSHIP {
        int concept_id_1 FK
        int concept_id_2 FK
        string relationship_id FK
        date valid_start_date
        date valid_end_date
    }

    CONCEPT_SYNONYM {
        int concept_id FK
        string concept_synonym_name
        int language_concept_id FK
    }

    CONCEPT_ANCESTOR {
        int ancestor_concept_id FK
        int descendant_concept_id FK
        int min_levels_of_separation
        int max_levels_of_separation
    }

    VOCABULARY ||--o{ CONCEPT : contains
    DOMAIN ||--o{ CONCEPT : categorizes
    CONCEPT_CLASS ||--o{ CONCEPT : classifies
    CONCEPT ||--o{ CONCEPT_RELATIONSHIP : relates
    CONCEPT ||--o{ CONCEPT_SYNONYM : synonyms
    CONCEPT ||--o{ CONCEPT_ANCESTOR : hierarchy
    RELATIONSHIP ||--o{ CONCEPT_RELATIONSHIP : defines
```

---

## 6. Mapping and Drug Strength Tables

```mermaid
erDiagram
    SOURCE_TO_CONCEPT_MAP {
        string source_code
        int source_concept_id FK
        string source_vocabulary_id
        string source_code_description
        int target_concept_id FK
        string target_vocabulary_id
        date valid_start_date
        date valid_end_date
        string invalid_reason
    }

    DRUG_STRENGTH {
        int drug_concept_id FK
        int ingredient_concept_id FK
        double amount_value
        int amount_unit_concept_id FK
        double numerator_value
        int numerator_unit_concept_id FK
        double denominator_value
        int denominator_unit_concept_id FK
        int box_size
        date valid_start_date
        date valid_end_date
    }

    CONCEPT ||--o{ SOURCE_TO_CONCEPT_MAP : maps_to
    CONCEPT ||--o{ DRUG_STRENGTH : drug_info
```

---

## 7. Derived / Era Tables

Aggregated tables derived from occurrence data.

```mermaid
erDiagram
    CONDITION_ERA {
        bigint condition_era_id PK
        bigint person_id FK
        int condition_concept_id FK
        date condition_era_start_date
        date condition_era_end_date
        int condition_occurrence_count
    }

    DRUG_ERA {
        bigint drug_era_id PK
        bigint person_id FK
        int drug_concept_id FK
        date drug_era_start_date
        date drug_era_end_date
        int drug_exposure_count
        int gap_days
    }

    DOSE_ERA {
        bigint dose_era_id PK
        bigint person_id FK
        int drug_concept_id FK
        int unit_concept_id FK
        double dose_value
        date dose_era_start_date
        date dose_era_end_date
    }

    EPISODE {
        bigint episode_id PK
        bigint person_id FK
        int episode_concept_id FK
        date episode_start_date
        date episode_end_date
        bigint episode_parent_id FK
        int episode_number
        int episode_object_concept_id FK
        int episode_type_concept_id FK
        string episode_source_value
    }

    EPISODE_EVENT {
        bigint episode_id FK
        bigint event_id
        int episode_event_field_concept_id FK
        int episode_event_concept_id FK
    }

    PERSON ||--o{ CONDITION_ERA : has
    PERSON ||--o{ DRUG_ERA : has
    PERSON ||--o{ DOSE_ERA : has
    PERSON ||--o{ EPISODE : has
    EPISODE ||--o{ EPISODE_EVENT : contains
```

---

## 8. Cohort Tables

```mermaid
erDiagram
    COHORT_DEFINITION {
        int cohort_definition_id PK
        string cohort_definition_name
        string cohort_definition_description
        int definition_type_concept_id FK
        string cohort_definition_syntax
        int subject_concept_id FK
    }

    COHORT {
        int cohort_definition_id FK
        bigint subject_id
        date cohort_start_date
        date cohort_end_date
    }

    ATTRIBUTE_DEFINITION {
        int attribute_definition_id PK
        string attribute_name
        string attribute_description
        int attribute_type_concept_id FK
        string attribute_syntax
    }

    COHORT_ATTRIBUTE {
        int cohort_definition_id FK
        bigint subject_id
        date cohort_start_date
        date cohort_end_date
        int attribute_definition_id FK
        double value_as_number
        int value_as_concept_id FK
    }

    COHORT_DEFINITION ||--o{ COHORT : defines
    COHORT_DEFINITION ||--o{ COHORT_ATTRIBUTE : has_attributes
    ATTRIBUTE_DEFINITION ||--o{ COHORT_ATTRIBUTE : defines
```

---

## 9. Cost / Payer Tables

```mermaid
erDiagram
    PAYER_PLAN_PERIOD {
        bigint payer_plan_period_id PK
        bigint person_id FK
        date payer_plan_period_start_date
        date payer_plan_period_end_date
        int payer_concept_id FK
        string payer_source_value
        int plan_concept_id FK
        string plan_source_value
        int sponsor_concept_id FK
        string family_source_value
        int stop_reason_concept_id FK
    }

    COST {
        bigint cost_id PK
        bigint cost_event_id
        string cost_domain_id
        int cost_type_concept_id FK
        int currency_concept_id FK
        double total_charge
        double total_cost
        double total_paid
        double paid_by_payer
        double paid_by_patient
        double paid_patient_copay
        double paid_patient_coinsurance
        double paid_patient_deductible
        bigint payer_plan_period_id FK
        double amount_allowed
        int revenue_code_concept_id FK
        int drg_concept_id FK
    }

    FACT_RELATIONSHIP {
        int domain_concept_id_1 FK
        bigint fact_id_1
        int domain_concept_id_2 FK
        bigint fact_id_2
        int relationship_concept_id FK
    }

    PERSON ||--o{ PAYER_PLAN_PERIOD : has
    PAYER_PLAN_PERIOD ||--o{ COST : covers
```

---

## 10. Metadata Tables

```mermaid
erDiagram
    CDM_SOURCE {
        string cdm_source_name
        string cdm_source_abbreviation
        string cdm_holder
        string source_description
        string source_documentation_reference
        string cdm_etl_reference
        date source_release_date
        date cdm_release_date
        string cdm_version
        int cdm_version_concept_id FK
        string vocabulary_version
    }

    METADATA {
        int metadata_concept_id FK
        int metadata_type_concept_id FK
        string name
        string value_as_string
        int value_as_concept_id FK
        date metadata_date
        timestamp metadata_datetime
    }
```

---

## Table Summary

| Category        | Tables                                                                                                  | Count |
| --------------- | ------------------------------------------------------------------------------------------------------- | ----- |
| Clinical Core   | person, observation_period, visit_occurrence, visit_detail, death                                       | 5     |
| Clinical Events | condition_occurrence, drug_exposure, procedure_occurrence, device_exposure, measurement, observation    | 6     |
| Notes/Specimens | note, note_nlp, specimen                                                                                | 3     |
| Health System   | location, care_site, provider                                                                           | 3     |
| Vocabulary      | concept, vocabulary, domain, concept_class, concept_relationship, relationship, concept_synonym, concept_ancestor | 8     |
| Mapping         | source_to_concept_map, drug_strength                                                                    | 2     |
| Derived/Era     | condition_era, drug_era, dose_era, episode, episode_event                                               | 5     |
| Cohort          | cohort, cohort_definition, cohort_attribute, attribute_definition                                       | 4     |
| Cost/Payer      | cost, payer_plan_period, fact_relationship                                                              | 3     |
| Metadata        | cdm_source, metadata                                                                                    | 2     |
| **Total**       |                                                                                                         | **41** |

---

## High-Level Overview

```mermaid
erDiagram
    PERSON ||--o{ VISIT_OCCURRENCE : has
    PERSON ||--o{ CONDITION_OCCURRENCE : has
    PERSON ||--o{ DRUG_EXPOSURE : has
    PERSON ||--o{ PROCEDURE_OCCURRENCE : has
    PERSON ||--o{ MEASUREMENT : has
    PERSON ||--o{ OBSERVATION : has
    PERSON ||--o{ NOTE : has
    PERSON ||--o{ SPECIMEN : has
    PERSON ||--o| DEATH : has
    PERSON ||--o{ CONDITION_ERA : has
    PERSON ||--o{ DRUG_ERA : has
    PERSON ||--o{ PAYER_PLAN_PERIOD : has

    VISIT_OCCURRENCE ||--o{ VISIT_DETAIL : contains
    VISIT_OCCURRENCE ||--o{ CONDITION_OCCURRENCE : context
    VISIT_OCCURRENCE ||--o{ DRUG_EXPOSURE : context
    VISIT_OCCURRENCE ||--o{ PROCEDURE_OCCURRENCE : context
    VISIT_OCCURRENCE ||--o{ MEASUREMENT : context

    LOCATION ||--o{ CARE_SITE : location_of
    CARE_SITE ||--o{ PROVIDER : employs

    VOCABULARY ||--o{ CONCEPT : contains
    CONCEPT ||--o{ CONCEPT_RELATIONSHIP : relates

    COHORT_DEFINITION ||--o{ COHORT : defines
    PAYER_PLAN_PERIOD ||--o{ COST : covers
```
