# Allscripts TouchWorks → OMOP CDM Mapping Progress

This document shows the current state of ETL mappings from Allscripts TouchWorks source tables to the OMOP Common Data Model via the medallion architecture (Bronze → Silver → Gold).

---

## Architecture Overview

```mermaid
graph TD
    A["<b>Allscripts TouchWorks Bronze Layer</b><br/>25 source tables across<br/>_exponent._bronze_allscripts_tw_works"]
    B["<b>8 Hydration Notebooks</b><br/>PySpark + Spark SQL<br/>omop/hydration/*.ipynb"]
    C["<b>OMOP Silver Layer</b><br/>8 tables populated in<br/>_exponent.omop_silver"]
    D["<b>OMOP Gold Layer</b><br/>8 tables populated in<br/>_exponent.omop"]

    A -->|"Extract & Transform"| B
    B -->|"MERGE INTO"| C
    C -->|"Resolve FK IDs"| D

    style A fill:#CD7F32,stroke:#8B4513,color:#fff
    style B fill:#4169E1,stroke:#1a237e,color:#fff
    style C fill:#A8A9AD,stroke:#708090,color:#000
    style D fill:#FFD700,stroke:#B8860B,color:#000
```

---

## Detailed Mapping Flows

### 1. Person

```mermaid
graph LR
    dbo_person["dbo_person"]
    dbo_person_other["dbo_person_other"]
    dbo_sex_de["dbo_sex_de"]
    dbo_race_de["dbo_race_de"]
    dbo_ethnicity_de["dbo_ethnicity_de"]

    NB["allscripts_touchworks<br/>_person.ipynb"]

    SILVER["omop_silver.person"]
    GOLD["omop.person"]

    dbo_person --> NB
    dbo_person_other --> NB
    dbo_sex_de --> NB
    dbo_race_de --> NB
    dbo_ethnicity_de --> NB
    NB --> SILVER
    SILVER --> GOLD

    classDef bronze fill:#CD7F32,stroke:#8B4513,color:#fff
    classDef notebook fill:#4169E1,stroke:#1a237e,color:#fff
    classDef silver fill:#A8A9AD,stroke:#708090,color:#000
    classDef gold fill:#FFD700,stroke:#B8860B,color:#000

    class dbo_person,dbo_person_other,dbo_sex_de,dbo_race_de,dbo_ethnicity_de bronze
    class NB notebook
    class SILVER silver
    class GOLD gold
```

> **Concept Mappings:** gender via `dbo_sex_de`, race via `dbo_race_de`, ethnicity via `dbo_ethnicity_de`
> **Known Gaps:** `location_id`, `provider_id`, `care_site_id` are NULL (upstream mapping tables pending)

---

### 2. Observation Period

```mermaid
graph LR
    dbo_iaa["dbo_interface_audit<br/>_appointment"]
    dbo_oah["dbo_order_activity<br/>_header"]
    dbo_vi["dbo_vendor_item"]
    dbo_im["dbo_item_medication"]
    dbo_po["dbo_person_other"]

    NB["allscripts_touchworks<br/>_observation_period.ipynb"]

    SILVER["omop_silver<br/>.observation_period"]
    GOLD["omop<br/>.observation_period"]

    dbo_iaa --> NB
    dbo_oah --> NB
    dbo_vi --> NB
    dbo_im --> NB
    dbo_po --> NB
    NB --> SILVER
    SILVER --> GOLD

    classDef bronze fill:#CD7F32,stroke:#8B4513,color:#fff
    classDef notebook fill:#4169E1,stroke:#1a237e,color:#fff
    classDef silver fill:#A8A9AD,stroke:#708090,color:#000
    classDef gold fill:#FFD700,stroke:#B8860B,color:#000

    class dbo_iaa,dbo_oah,dbo_vi,dbo_im,dbo_po bronze
    class NB notebook
    class SILVER silver
    class GOLD gold
```

> **Strategy:** Derives observation period from earliest/latest clinical activity across appointments, orders, conditions, and medications
> **Known Gaps:** None

---

### 3. Visit Occurrence
```mermaid
graph LR
    dbo_visit["dbo_visit"]

    NB["allscripts_touchworks<br/>_visit_occurrence.ipynb"]

    SILVER["omop_silver<br/>.visit_occurrence"]
    GOLD["omop<br/>.visit_occurrence"]

    dbo_visit --> NB
    NB --> SILVER
    SILVER --> GOLD

    classDef bronze fill:#CD7F32,stroke:#8B4513,color:#fff
    classDef notebook fill:#4169E1,stroke:#1a237e,color:#fff
    classDef silver fill:#A8A9AD,stroke:#708090,color:#000
    classDef gold fill:#FFD700,stroke:#B8860B,color:#000

    class dbo_visit bronze
    class NB notebook
    class SILVER silver
    class GOLD gold
```

> **Concept Mappings:** Visit type mapped via `domain_source_to_concept`
> **Known Gaps:** `provider_id`, `care_site_id`, `admitted_from_concept_id`, `discharged_to_concept_id` are NULL

---

### 4. Condition Occurrence

```mermaid
graph LR
    dbo_vi["dbo_vendor_item"]

    NB["allscripts_touchworks<br/>_condition_occurrence.ipynb"]

    SILVER["omop_silver<br/>.condition_occurrence"]
    GOLD["omop<br/>.condition_occurrence"]

    dbo_vi --> NB
    NB --> SILVER
    SILVER --> GOLD

    classDef bronze fill:#CD7F32,stroke:#8B4513,color:#fff
    classDef notebook fill:#4169E1,stroke:#1a237e,color:#fff
    classDef silver fill:#A8A9AD,stroke:#708090,color:#000
    classDef gold fill:#FFD700,stroke:#B8860B,color:#000

    class dbo_vi bronze
    class NB notebook
    class SILVER silver
    class GOLD gold
```

> **Concept Mappings:** SNOMED code → standard OMOP concept via vocabulary; StatusQualifier → `condition_status_concept_id` via `domain_source_to_concept`
> **Known Gaps:** `provider_id`, `visit_occurrence_id`, `visit_detail_id` are NULL

---

### 5. Drug Exposure

```mermaid
graph LR
    dbo_med["dbo_medication"]
    dbo_med_de["dbo_medication_de"]
    dbo_im["dbo_item_medication"]

    NB["allscripts_touchworks<br/>_drug_exposure.ipynb"]

    SILVER["omop_silver<br/>.drug_exposure"]
    GOLD["omop<br/>.drug_exposure"]

    dbo_med --> NB
    dbo_med_de --> NB
    dbo_im --> NB
    NB --> SILVER
    SILVER --> GOLD

    classDef bronze fill:#CD7F32,stroke:#8B4513,color:#fff
    classDef notebook fill:#4169E1,stroke:#1a237e,color:#fff
    classDef silver fill:#A8A9AD,stroke:#708090,color:#000
    classDef gold fill:#FFD700,stroke:#B8860B,color:#000

    class dbo_med,dbo_med_de,dbo_im bronze
    class NB notebook
    class SILVER silver
    class GOLD gold
```

> **Concept Mappings:** Drug codes mapped to OMOP standard concepts via vocabulary tables
> **Known Gaps:** `provider_id`, `visit_occurrence_id`, `visit_detail_id` are NULL

---

### 6. Observation

```mermaid
graph LR
    dbo_ir["dbo_item_result"]
    dbo_r["dbo_result"]
    dbo_oah["dbo_order_activity<br/>_header"]

    NB["allscripts_touchworks<br/>_observation.ipynb"]

    SILVER["omop_silver<br/>.observation"]
    GOLD["omop<br/>.observation"]

    dbo_ir --> NB
    dbo_r --> NB
    dbo_oah --> NB
    NB --> SILVER
    SILVER --> GOLD

    classDef bronze fill:#CD7F32,stroke:#8B4513,color:#fff
    classDef notebook fill:#4169E1,stroke:#1a237e,color:#fff
    classDef silver fill:#A8A9AD,stroke:#708090,color:#000
    classDef gold fill:#FFD700,stroke:#B8860B,color:#000

    class dbo_ir,dbo_r,dbo_oah bronze
    class NB notebook
    class SILVER silver
    class GOLD gold
```

> **Concept Mappings:** Results and findings mapped to OMOP observation concepts
> **Known Gaps:** `value_as_concept_id`, `unit_concept_id`, `provider_id`, `visit_detail_id` are NULL

---

### 7. Location

```mermaid
graph LR
    dbo_pa["dbo_person_address"]

    NB["allscripts_touchworks<br/>_location.ipynb"]

    SILVER["omop_silver<br/>.location"]
    GOLD["omop<br/>.location"]

    dbo_pa --> NB
    NB --> SILVER
    SILVER --> GOLD

    classDef bronze fill:#CD7F32,stroke:#8B4513,color:#fff
    classDef notebook fill:#4169E1,stroke:#1a237e,color:#fff
    classDef silver fill:#A8A9AD,stroke:#708090,color:#000
    classDef gold fill:#FFD700,stroke:#B8860B,color:#000

    class dbo_pa bronze
    class NB notebook
    class SILVER silver
    class GOLD gold
```

> **Strategy:** Maps patient addresses to OMOP location table
> **Planned Expansion:** `dbo_pharmacy_de` and `dbo_site_de` are documented as future sources but not yet in the transformation SQL
> **Known Gaps:** None

---

### 8. Provider

```mermaid
graph LR
    dbo_prov["dbo_provider"]
    dbo_per["dbo_person"]
    dbo_spec["dbo_specialty_de"]
    dbo_pl["dbo_prescriber_license"]
    dbo_res["dbo_resource_de"]
    dbo_svc["dbo_service_de"]
    dbo_sex["dbo_sex_de"]
    dbo_loc["dbo_location_de"]
    dbo_lt["dbo_location_type_de"]
    dbo_pt["dbo_provider_type_de"]

    NB["allscripts_touchworks<br/>_provider.ipynb"]

    SILVER["omop_silver<br/>.provider"]
    GOLD["omop<br/>.provider"]

    dbo_prov --> NB
    dbo_per --> NB
    dbo_spec --> NB
    dbo_pl --> NB
    dbo_res --> NB
    dbo_svc --> NB
    dbo_sex --> NB
    dbo_loc --> NB
    dbo_lt --> NB
    dbo_pt --> NB
    NB --> SILVER
    SILVER --> GOLD

    classDef bronze fill:#CD7F32,stroke:#8B4513,color:#fff
    classDef notebook fill:#4169E1,stroke:#1a237e,color:#fff
    classDef silver fill:#A8A9AD,stroke:#708090,color:#000
    classDef gold fill:#FFD700,stroke:#B8860B,color:#000

    class dbo_prov,dbo_per,dbo_spec,dbo_pl,dbo_res,dbo_svc,dbo_sex,dbo_loc,dbo_lt,dbo_pt bronze
    class NB notebook
    class SILVER silver
    class GOLD gold
```

> **Concept Mappings:** Specialty mapped via `domain_source_to_concept`; gender via `dbo_sex_de`
> **Known Gaps:** `care_site_id` is NULL (care_site hydration not yet implemented)

---

## Mapping Status Summary

| OMOP Target Table | Source Table Count | Hydration Notebook | Status | Known FK Gaps |
|---|---|---|---|---|
| person | 5 | allscripts_touchworks_person.ipynb | Complete | location_id, provider_id, care_site_id |
| observation_period | 5 | allscripts_touchworks_observation_period.ipynb | Complete | None |
| visit_occurrence | 1 | allscripts_touchworks_visit_occurrence.ipynb | Complete | provider_id, care_site_id |
| condition_occurrence | 1 | allscripts_touchworks_condition_occurrence.ipynb | Complete | provider_id, visit_occurrence_id, visit_detail_id |
| drug_exposure | 3 | allscripts_touchworks_drug_exposure.ipynb | Complete | provider_id, visit_occurrence_id, visit_detail_id |
| observation | 3 | allscripts_touchworks_observation.ipynb | Complete | value_as_concept_id, unit_concept_id, provider_id |
| location | 1 | allscripts_touchworks_location.ipynb | Complete | None |
| provider | 10 | allscripts_touchworks_provider.ipynb | Complete | care_site_id |

---

## Shared Source Tables

Several Allscripts TouchWorks bronze tables feed into multiple OMOP targets:

| Bronze Source Table | Feeds Into |
|---|---|
| dbo_vendor_item | condition_occurrence, observation_period |
| dbo_person_other | person, observation_period |
| dbo_order_activity_header | observation, observation_period |
| dbo_item_medication | drug_exposure, observation_period |
| dbo_person | person, provider |
| dbo_sex_de | person, provider |
| dbo_site_de | provider |

---

## Tables Not Yet Mapped

The following OMOP CDM tables do not yet have Allscripts TouchWorks hydration logic:

| Category | Tables Pending |
|---|---|
| Clinical Core | visit_detail, death |
| Clinical Events | procedure_occurrence, measurement, device_exposure |
| Notes / Specimens | note, note_nlp, specimen |
| Health System | care_site |
| Derived / Era | condition_era, drug_era, dose_era, episode, episode_event |
| Cohort | cohort, cohort_definition, cohort_attribute, attribute_definition |
| Cost / Payer | cost, payer_plan_period, fact_relationship |
| Metadata | cdm_source, metadata |
| Mapping | source_to_concept_map |

> **Note:** Vocabulary tables (concept, concept_class, concept_relationship, concept_synonym, domain, drug_strength, relationship, vocabulary) are loaded separately from OMOP Athena CSV files and are not part of the Allscripts TouchWorks mapping scope.
