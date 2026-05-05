# Allscripts → OMOP Runbook

## 1. Purpose
Defines execution steps to transform Allscripts source data into the OMOP Common Data Model (CDM), supporting standardized analytics and research use cases.

Allscripts in this repository includes two source-system tracks:
- Allscripts SCM / Sunrise
- Allscripts TouchWorks

---

## 2. System Flow
Allscripts SCM / Sunrise + Allscripts TouchWorks → Bronze → Mapping Tables → Hydration Notebooks → OMOP Silver → OMOP Final

---

## 3. Execution Order

### Phase 1 — Identity
- location
- care_site
- provider
- person

### Phase 2 — Visit Backbone
- visit_occurrence
- visit_detail

### Phase 3 — Clinical Domains
- condition_occurrence
- procedure_occurrence
- drug_exposure
- measurement
- observation
- note
- device_exposure

### Phase 4 — Lifecycle
- observation_period
- death

### Phase 5 — Derived Domains
- condition_era
- drug_era
- dose_era
- episode
- episode_event

---

## 4. Record Identification and Linking
Each source record is assigned a consistent identifier based on the source system, table, and source key.

SCM / Sunrise identifiers generally follow the Sunrise source tables and keys. TouchWorks identifiers may be derived from multiple source tables when a single stable key is not available.

These identifiers are mapped to OMOP IDs such as `person_id` and `visit_occurrence_id` using mapping tables.

This ensures all data for a patient or visit is consistently linked across both Allscripts tracks and downstream OMOP domains.

---

## 5. Core Dependencies
- `source_to_person` → provides `person_id` for all downstream domains
- `source_to_visit_occurrence` → provides encounter linkage across clinical domains
- `domain_source_to_concept` → standardizes source values to OMOP concepts

---

## 6. Domain Execution Details

### PERSON
- **SCM / Sunrise Notebook:** `omop/hydration/person/allscripts_sunrise_person.ipynb`
- **TouchWorks Notebook:** `omop/hydration/person/allscripts_touchworks_person.ipynb`
- **Key Fields:** source patient identifier, demographic fields
- **Transformations:**
  - Construct `person_source_value`
  - Derive demographics
  - Deduplicate records
- **Mapping:** populates `source_to_person`
- **Dependency:** must run first

---

### LOCATION
- **SCM / Sunrise Notebook:** `omop/hydration/location/allscripts_sunrise_location.ipynb`
- **TouchWorks Notebook:** `omop/hydration/location/allscripts_touchworks_location.ipynb`
- **Transformations:**
  - Normalize source location records
  - Populate OMOP location attributes where available
- **Dependency:** supports care_site and provider attribution

---

### CARE_SITE
- **SCM / Sunrise Notebook:** `omop/hydration/care_site/allscripts_sunrise_care_site.ipynb`
- **TouchWorks Notebook:** `omop/hydration/care_site/allscripts_touchworks_care_site.ipynb`
- **Transformations:**
  - Construct care site records from facility, department, or practice-level source data
  - Link to location where available
- **Dependency:** requires location when source location linkage is present

---

### PROVIDER
- **SCM / Sunrise Notebook:** `omop/hydration/provider/allscripts_sunrise_provider.ipynb`
- **TouchWorks Notebook:** `omop/hydration/provider/allscripts_touchworks_provider.ipynb`
- **Transformations:**
  - Normalize provider identifiers and names
  - Link provider to care_site where available
- **Dependency:** supports visit and clinical attribution

---

### VISIT_OCCURRENCE
- **SCM / Sunrise Notebook:** `omop/hydration/visit_occurrence/allscripts_sunrise_visit_occurrence.ipynb`
- **TouchWorks Notebook:** `omop/hydration/visit_occurrence/allscripts_touchworks_visit_occurrence.ipynb`
- **Key Fields:** patient identifier, encounter identifier, visit type, admit/start date, discharge/end date
- **Transformations:**
  - Construct visit records from source encounter data
  - Map source visit type → `visit_concept_id`
  - Derive visit start and end dates
- **Mapping:**
  - Uses `source_to_person`
  - Uses `domain_source_to_concept`
  - Creates `source_to_visit_occurrence`
- **Dependency:** requires person

---

### VISIT_DETAIL
- **SCM / Sunrise Notebook:** `omop/hydration/visit_detail/allscripts_sunrise_visit_detail.ipynb`
- **TouchWorks Notebook:** `omop/hydration/visit_detail/allscripts_touchworks_visit_detail.ipynb`
- **Purpose:** provides additional encounter granularity below `visit_occurrence`
- **Dependency:** requires `visit_occurrence`

---

### CLINICAL DOMAINS
- **Domains:** condition, procedure, drug, measurement, observation, note, device
- **Pattern:**
  - Join to person
  - Join to visit when an encounter key or date-range match is available
  - Map concepts
  - Load to OMOP
- **Dependencies:**
  - `source_to_person`
  - `source_to_visit_occurrence`

---

## CONDITION_OCCURRENCE
- **SCM / Sunrise Notebook:** `omop/hydration/condition_occurrence/allscripts_sunrise_condition_occurrence.ipynb`
- **TouchWorks Notebook:** `omop/hydration/condition_occurrence/allscripts_touchworks_condition_occurrence.ipynb`
- **Key Transformations:**
  - Normalize coded diagnosis/problem source values
  - Map condition source values to OMOP condition concepts where available
  - Preserve unmapped records with default concept handling
- **Visit Linkage:** uses encounter linkage or patient/date matching depending on available source fields
- **Output:** `person_id`, `condition_concept_id`, `condition_source_value`, `visit_occurrence_id`

---

## PROCEDURE_OCCURRENCE
- **SCM / Sunrise Notebook:** `omop/hydration/procedure_occurrence/allscripts_sunrise_procedure_occurrence.ipynb`
- **TouchWorks Notebook:** `omop/hydration/procedure_occurrence/allscripts_touchworks_procedure_occurrence.ipynb`
- **Key Transformations:**
  - Normalize source procedure records and procedure dates
  - Map coded procedure values to standard OMOP concepts where available
  - Preserve source fidelity for unmapped procedure records
- **Visit Linkage:** uses encounter linkage or patient/date matching depending on available source fields
- **Output:** `person_id`, `procedure_concept_id`, `procedure_source_value`, `visit_occurrence_id`

---

## DRUG_EXPOSURE
- **SCM / Sunrise Notebook:** `omop/hydration/drug_exposure/allscripts_sunrise_drug_exposure.ipynb`
- **TouchWorks Notebook:** `omop/hydration/drug_exposure/allscripts_touchworks_drug_exposure.ipynb`
- **Key Transformations:**
  - Normalize medication orders, administrations, or medication history records
  - Map drug source values to RxNorm concepts where available
  - Derive exposure start and end dates
- **Visit Linkage:** uses encounter linkage or patient/date matching depending on available source fields
- **Output:** `person_id`, `drug_concept_id`, `drug_source_value`, `visit_occurrence_id`

---

## MEASUREMENT
- **SCM / Sunrise Notebook:** `omop/hydration/measurement/allscripts_sunrise_measurement.ipynb`
- **TouchWorks Notebook:** `omop/hydration/measurement/allscripts_touchworks_measurement.ipynb`
- **Key Transformations:**
  - Normalize lab or measurement source records
  - Map measurement source values to standard Measurement concepts where available
  - Extract numeric values, units, reference ranges, and result dates
- **Visit Linkage:** uses encounter linkage or patient/date matching depending on available source fields
- **Output:** `person_id`, `measurement_concept_id`, `value_as_number`, `unit_concept_id`, `visit_occurrence_id`

---

## OBSERVATION
- **SCM / Sunrise Notebook:** `omop/hydration/observation/allscripts_sunrise_observation.ipynb`
- **TouchWorks Notebook:** `omop/hydration/observation/allscripts_touchworks_observation.ipynb`
- **Key Transformations:**
  - Normalize non-measurement clinical facts into OMOP observation
  - Map source values to observation concepts where available
  - Preserve string or concept-valued results
- **Visit Linkage:** uses encounter linkage or patient/date matching depending on available source fields
- **Output:** `person_id`, `observation_concept_id`, `value_as_concept_id`, `value_as_string`, `visit_occurrence_id`

---

## NOTE
- **SCM / Sunrise Notebook:** `omop/hydration/note/allscripts_sunrise_note.ipynb`
- **TouchWorks Notebook:** `omop/hydration/note/allscripts_touchworks_note.ipynb`
- **TouchWorks Note NLP Notebook:** `omop/hydration/note_nlp/allscripts_touchworks_note_nlp.ipynb`
- **Key Transformations:**
  - Normalize clinical note source records
  - Link notes to person and visit where available
  - Populate note text, note date, and note type/source values

---

## DEVICE_EXPOSURE
- **SCM / Sunrise Notebook:** `omop/hydration/device_exposure/allscripts_sunrise_device_exposure.ipynb`
- **TouchWorks Notebook:** `omop/hydration/device_exposure/allscripts_touchworks_device_exposure.ipynb`
- **Key Transformations:**
  - Normalize device source records
  - Map device source values to OMOP concepts where available
  - Link device records to person and visit

---

## SOURCE VALUE ENHANCEMENTS
All Allscripts clinical domains should populate source audit fields wherever possible:
- `*_source_value`: human-readable source identifier or source code
- `*_source_concept_id`: OMOP concept for the source code when available
- `visit_occurrence_id`: preferred direct encounter mapping with patient/date fallback where needed
- `source_system`: preserved so SCM / Sunrise and TouchWorks records remain distinguishable in shared OMOP tables

---

### OBSERVATION_PERIOD
- **SCM / Sunrise Notebook:** `omop/hydration/observation_period/allscripts_sunrise_observation_period.ipynb`
- **TouchWorks Notebook:** `omop/hydration/observation_period/allscripts_touchworks_observation_period.ipynb`
- **Purpose:** defines patient activity windows based on visit and clinical data

---

### DEATH
- **SCM / Sunrise Notebook:** `omop/hydration/death/allscripts_sunrise_death.ipynb`
- **TouchWorks Notebook:** `omop/hydration/death/allscripts_touchworks_death.ipynb`
- **Purpose:** captures mortality data linked to `person_id`

---

### DERIVED DOMAINS
- **Condition Era:** `allscripts_sunrise_condition_era.ipynb`, `allscripts_touchworks_condition_era.ipynb`
- **Drug Era:** `allscripts_sunrise_drug_era.ipynb`, `allscripts_touchworks_drug_era.ipynb`
- **Dose Era:** `allscripts_sunrise_dose_era.ipynb`, `allscripts_touchworks_dose_era.ipynb`
- **Episode:** `allscripts_sunrise_episode.ipynb`, `allscripts_touchworks_episode.ipynb`
- **Episode Event:** `allscripts_sunrise_episode_event.ipynb`, `allscripts_touchworks_episode_event.ipynb`

Derived domains must run after their source clinical domains have been hydrated and validated.

---

## 7. Default Handling
- Unmapped source values are assigned default concept IDs to preserve record continuity
- Missing end dates default to start date where applicable
- Records with defaulted or unmapped concepts should be reviewed through OHDSI Ares / Data Quality Dashboard outputs

---

## 8. Data Quality Controls
Validated using OHDSI Ares / Data Quality Dashboard (DQD).

Checks include:
- Identity uniqueness
- Visit validity
- Concept mapping completeness
- Temporal consistency
- Required field completeness
- Foreign key consistency across person, visit, provider, care_site, and domain tables

---

## 9. Run Instructions
- Execute in Databricks environment
- Run notebooks sequentially by phase
- Run SCM / Sunrise and TouchWorks as separate source-system tracks
- Re-run downstream domains if upstream identity, visit, or concept mapping logic changes
- Re-run OHDSI Ares / DQD after each track refresh and compare against the latest Allscripts baseline

### Notebook Tracks
**SCM / Sunrise Hydration Notebooks:**
- `omop/hydration/*/allscripts_sunrise_*.ipynb`

**TouchWorks Hydration Notebooks:**
- `omop/hydration/*/allscripts_touchworks_*.ipynb`

**Supporting Runbooks:**
- `Runbooks/SCM_Runbook.md`
- `Runbooks/TW_Runbook.md`
- `Runbooks/SCM_Hydration_Reset_Handoff.md`

---

## 10. Failure Impact
- Person failure → impacts the entire affected Allscripts track
- Visit failure → impacts all clinical domains for that track
- Mapping failure → impacts concept completeness while preserving source records when default handling is used
- Clinical domain failures → result in partial Allscripts dataset coverage
- Derived domain failures → affect era and episode outputs but do not invalidate the base clinical domain tables

---

## 11. Ownership
- **Data Engineering:** execution and monitoring
- **OMOP SME:** mapping validation and data quality oversight
- **Source SMEs:** SCM / Sunrise and TouchWorks source interpretation where source-specific logic differs

---

## 12. Notes and Limitations

### Current Implementation Status
- **SCM / Sunrise:** implemented through `allscripts_sunrise_*` hydration notebooks for core identity, visit, clinical, lifecycle, and derived domains.
- **TouchWorks:** implemented through `allscripts_touchworks_*` hydration notebooks, with broader support for administrative/supporting OMOP domains such as cohort, metadata, source_to_concept_map, specimen, cost, and payer_plan_period.
- **Shared Tables:** both tracks load into shared OMOP structures and must preserve source-system identifiers for traceability.

### Known Considerations
- SCM / Sunrise and TouchWorks should not be treated as interchangeable source systems even though both are Allscripts.
- Source values may be indirect or derived across multiple tables, especially in TouchWorks.
- Concept mapping rates should be evaluated separately for SCM / Sunrise and TouchWorks before rolling up to an Allscripts-level quality summary.
- Unmapped records are retained with default concept handling to preserve audit trail and support future backfill.
