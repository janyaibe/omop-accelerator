# OMOP CDM v5.4 Entity Relationship Diagrams

This document contains ERDs for the OMOP Common Data Model v5.4, organized by category for easier viewing.

---

## 1. Clinical Data Tables (Core)

The central tables for patient clinical data, with PERSON as the root entity.

```mermaid
erDiagram
    PERSON {
        bigint person_id PK
        int gender_concept_id FK
        int year_of_birth
        int month_of_birth
        int day_of_birth
        timestamp birth_datetime
        int race_concept_id FK
        int ethnicity_concept_id FK
        bigint location_id FK
        bigint provider_id FK
        bigint care_site_id FK
        string person_source_value
        string gender_source_value
        int gender_source_concept_id FK
        string race_source_value
        int race_source_concept_id FK
        string ethnicity_source_value
        int ethnicity_source_concept_id FK
    }

    OBSERVATION_PERIOD {
        bigint observation_period_id PK
        bigint person_id FK
        date observation_period_start_date
        date observation_period_end_date
        int period_type_concept_id FK
    }

    VISIT_OCCURRENCE {
        bigint visit_occurrence_id PK
        bigint person_id FK
        int visit_concept_id FK
        date visit_start_date
        timestamp visit_start_datetime
        date visit_end_date
        timestamp visit_end_datetime
        int visit_type_concept_id FK
        bigint provider_id FK
        bigint care_site_id FK
        string visit_source_value
        int visit_source_concept_id FK
        int admitted_from_concept_id FK
        int discharged_to_concept_id FK
        bigint preceding_visit_occurrence_id FK
    }

    VISIT_DETAIL {
        bigint visit_detail_id PK
        bigint person_id FK
        int visit_detail_concept_id FK
        date visit_detail_start_date
        date visit_detail_end_date
        int visit_detail_type_concept_id FK
        bigint provider_id FK
        bigint care_site_id FK
        bigint preceding_visit_detail_id FK
        bigint parent_visit_detail_id FK
        bigint visit_occurrence_id FK
    }

    DEATH {
        bigint person_id PK
        date death_date
        timestamp death_datetime
        int death_type_concept_id FK
        int cause_concept_id FK
        string cause_source_value
    }

    PERSON ||--o{ OBSERVATION_PERIOD : has
    PERSON ||--o{ VISIT_OCCURRENCE : has
    PERSON ||--o| DEATH : has
    VISIT_OCCURRENCE ||--o{ VISIT_DETAIL : contains
```

---

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

---

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
