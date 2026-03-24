# OMOP CDM v5.4 Entity Relationship Diagrams

This document contains ERDs for the OMOP Common Data Model v5.4, organized by category for easier viewing.

---

## 0. Databricks Hydration Flow (Source → OMOP)

```mermaid
flowchart LR

%% ======================
%% 1. CORE TABLES
%% ======================

subgraph Source_Systems
    tw_person[TW PERSON]
    scm_person[SCM PERSON]
    epic_person[EPIC PERSON]

    tw_visit[TW VISIT]
    scm_visit[SCM VISIT]
    epic_visit[EPIC VISIT]
end

subgraph Mapping_Tables
    map_person[PERSON MAPPING]
    map_domain[DOMAIN MAPPING]
end

subgraph Notebooks
    nb_person[nb_person]
    nb_visit[nb_visit]
    nb_obs[nb_observation]
    nb_drug[nb_drug_exposure]
    nb_proc[nb_procedure_occurrence]
    nb_meas[nb_measurement]
    nb_device[nb_device_exposure]
    nb_death[nb_death]
    nb_note[nb_note]
    nb_provider[nb_provider]
    nb_location[nb_location]
end

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
end

%% ======================
%% PERSON
%% ======================

tw_person --> nb_person
scm_person --> nb_person
epic_person --> nb_person
map_person --> nb_person
nb_person --> PERSON

%% ======================
%% VISIT
%% ======================

tw_visit --> nb_visit
scm_visit --> nb_visit
epic_visit --> nb_visit
nb_visit --> VISIT_OCCURRENCE
nb_visit --> VISIT_DETAIL

%% ======================
%% OBSERVATION
%% ======================

tw_visit --> nb_obs
scm_visit --> nb_obs
epic_visit --> nb_obs
map_domain --> nb_obs
nb_obs --> OBSERVATION

%% ======================
%% DRUG EXPOSURE
%% ======================

%% -------- TW --------
tw_med[TW dbo_medication]
tw_med_de[TW dbo_medication_de]
tw_item_med[TW dbo_item_medication]

tw_med --> nb_drug
tw_med_de --> nb_drug
tw_item_med --> nb_drug

%% -------- SCM --------
scm_order[SCM dbo_cv3order - Medication]
scm_medext[SCM dbo_cv3medicationextension]
scm_generic[SCM dbo_sxammgenericitem - RxNorm]

scm_order --> nb_drug
scm_medext --> nb_drug
scm_generic --> nb_drug

%% -------- EPIC --------
epic_order_med[EPIC ORDER_MED]
epic_med_sig[EPIC ORDER_MED_SIG]
epic_med_master[EPIC CLARITY_MEDICATION]

epic_order_med --> nb_drug
epic_med_sig --> nb_drug
epic_med_master --> nb_drug

%% -------- MAPPING --------
map_domain --> nb_drug
map_person --> nb_drug

%% -------- OUTPUT --------
nb_drug --> DRUG_EXPOSURE

%% ======================
%% PROCEDURE OCCURRENCE
%% ======================

%% -------- TW --------
tw_charge[TW dbo_charge]
tw_charge_code[TW dbo_charge_code_de]
tw_item_result[TW dbo_item_result]
tw_order_activity[TW dbo_order_activity_header]

tw_charge --> nb_proc
tw_charge_code --> nb_proc
tw_item_result --> nb_proc
tw_order_activity --> nb_proc

%% -------- EPIC --------
epic_order_proc[EPIC order_proc]
epic_or_log[EPIC or_log]

epic_order_proc --> nb_proc
epic_or_log --> nb_proc

%% -------- SCM --------
scm_proc_placeholder[SCM procedure tables - not available]

scm_proc_placeholder --> nb_proc

%% -------- MAPPING --------
map_domain --> nb_proc
map_person --> nb_proc

%% -------- OUTPUT --------
nb_proc --> PROCEDURE_OCCURRENCE

%% ======================
%% MEASUREMENT
%% ======================

%% -------- TW --------
tw_item_result[TW dbo_item_result]
tw_result[TW dbo_result]
tw_order_activity[TW dbo_order_activity_header]

tw_item_result --> nb_meas
tw_result --> nb_meas
tw_order_activity --> nb_meas

%% -------- SCM --------
scm_obs[SCM dbo_cv3observationcur]
scm_order_task[SCM dbo_cv3ordertaskoccurrence]

scm_obs --> nb_meas
scm_order_task --> nb_meas

%% -------- EPIC --------
epic_order_results[EPIC order_results]
epic_flowsheet[EPIC V_EHI_FLO_MEAS_EDITED]

epic_order_results --> nb_meas
epic_flowsheet --> nb_meas

%% -------- MAPPING --------
map_domain --> nb_meas
map_person --> nb_meas

%% -------- OUTPUT --------
nb_meas --> MEASUREMENT

%% ======================
%% DEVICE EXPOSURE
%% ======================

%% -------- TW --------
tw_charge_device[TW dbo_charge]
tw_charge_code_device[TW dbo_charge_code_de]
tw_visit_device[TW dbo_visit]

tw_charge_device --> nb_device
tw_charge_code_device --> nb_device
tw_visit_device --> nb_device

%% -------- SCM --------
scm_device_placeholder[SCM device exposure - not provided yet]

scm_device_placeholder --> nb_device

%% -------- EPIC --------
epic_or_imp[EPIC or_imp]

epic_or_imp --> nb_device

%% -------- MAPPING --------
map_domain --> nb_device
map_person --> nb_device

%% -------- OUTPUT --------
nb_device --> DEVICE_EXPOSURE

%% ======================
%% DEATH
%% ======================

%% -------- TW --------
tw_person[TW dbo_person]
tw_person_other[TW dbo_person_other]

tw_person --> nb_death
tw_person_other --> nb_death

%% -------- SCM --------
scm_client[SCM dbo_cv3client]

scm_client --> nb_death

%% -------- EPIC --------
epic_patient[EPIC patient]

epic_patient --> nb_death

%% -------- MAPPING --------
map_person --> nb_death

%% -------- OUTPUT --------
nb_death --> DEATH

%% ======================
%% NOTE
%% ======================

%% -------- TW --------
tw_oah[TW dbo_order_activity_header]
tw_order_mapper[TW dbo_order_result_mapper]
tw_result_text[TW dbo_result_text]

tw_oah --> nb_note
tw_order_mapper --> nb_note
tw_result_text --> nb_note

%% -------- SCM --------
scm_obs_note[SCM dbo_scaobservation]
scm_doc[SCM dbo_scadocument]
scm_docdim[SCM dbo_scadocumentdim]
scm_client_note[SCM dbo_cv3client]

scm_obs_note --> nb_note
scm_doc --> nb_note
scm_docdim --> nb_note
scm_client_note --> nb_note

%% -------- EPIC --------
epic_hno[EPIC hno_info]
epic_note_type[EPIC zc_note_type_ip]

epic_hno --> nb_note
epic_note_type --> nb_note

%% -------- MAPPING --------
map_person --> nb_note

%% -------- OUTPUT --------
nb_note --> NOTE

%% ======================
%% PROVIDER
%% ======================

%% -------- TW --------
tw_provider[TW dbo_provider]
tw_person_provider[TW dbo_person]
tw_sex[TW dbo_sex_de]
tw_specialty[TW dbo_specialty_de]

tw_provider --> nb_provider
tw_person_provider --> nb_provider
tw_sex --> nb_provider
tw_specialty --> nb_provider

%% -------- SCM --------
scm_careprovider[SCM dbo_cv3careprovider]
scm_careproviderid[SCM dbo_cv3careproviderid]

scm_careprovider --> nb_provider
scm_careproviderid --> nb_provider

%% -------- EPIC --------
epic_clarity_ser[EPIC clarity_ser]

epic_clarity_ser --> nb_provider

%% -------- MAPPING --------
map_domain --> nb_provider

%% -------- OUTPUT --------
nb_provider --> PROVIDER

%% ======================
%% LOCATION
%% ======================

%% -------- TW --------
tw_person_address[TW dbo_person_address]

tw_person_address --> nb_location

%% -------- SCM --------
scm_address[SCM dbo_cv3address]

scm_address --> nb_location

%% -------- EPIC --------
epic_patient_addr[EPIC patient]

epic_patient_addr --> nb_location

%% -------- MAPPING --------
map_domain --> nb_location

%% -------- OUTPUT --------
nb_location --> LOCATION
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
