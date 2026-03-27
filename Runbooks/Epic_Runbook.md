# Epic Clarity → OMOP Runbook

## 1. Purpose
Defines execution steps to transform Epic Clarity data into the OMOP Common Data Model (CDM), supporting standardized analytics and research use cases.

This runbook follows a standardized framework applied across multiple source systems (Epic, SCM, TouchWorks) to ensure consistency in transformation logic and execution.

---

## 2. System Flow
Epic Clarity → Bronze → Mapping Tables → Hydration Notebooks → OMOP Silver → OMOP Final

---

## 3. Execution Order

### Phase 1 — Identity
- location  
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
- device_exposure  

### Phase 4 — Lifecycle
- observation_period  
- death  

---

## 4. Record Identification and Linking
Each source record (e.g., patient or encounter) is assigned a consistent identifier based on the source system, table, and key.

These identifiers are mapped to OMOP IDs (e.g., `person_id`, `visit_occurrence_id`) using mapping tables.

This ensures all data for a patient or visit is consistently linked across domains and source systems.

---

## 5. Core Dependencies
- `source_to_person` → provides `person_id` for all downstream domains  
- `source_to_visit_occurrence` → provides encounter linkage across clinical domains  
- `domain_source_to_concept` → standardizes source values to OMOP concepts  

---

## 6. Domain Execution Details

### PERSON
- **Source Tables:** PATIENT, PATIENT_4, PATIENT_RACE  
- **Key Fields:** PAT_ID, BIRTH_DATE, SEX, RACE  
- **Transformations:**
  - Construct `person_source_value`
  - Derive demographics
  - Deduplicate records  
- **Mapping:** populates `source_to_person`  
- **Dependency:** must run first  

---

### VISIT_OCCURRENCE
- **Source Tables:** Epic encounter tables  
- **Key Fields:** PAT_ID, ENC_TYPE, CONTACT_DATE, DISCHARGE_DATE  
- **Transformations:**
  - Map ENC_TYPE → `visit_concept_id`
  - Derive visit dates  
- **Mapping:**
  - Uses `source_to_person`
  - Uses `domain_source_to_concept`
  - Creates `source_to_visit_occurrence`  
- **Dependency:** requires person  

---

### VISIT_DETAIL
Provides additional encounter granularity  
- **Dependency:** requires `visit_occurrence`

---

### CLINICAL DOMAINS
- **Domains:** condition, procedure, drug, measurement, observation, device  
- **Pattern:**
  - Join to person and visit  
  - Map concepts  
  - Load to OMOP  
- **Dependencies:**
  - `source_to_person`
  - `source_to_visit_occurrence`

---

### OBSERVATION_PERIOD
Defines patient activity window based on visit and clinical data  

---

### DEATH
Captures mortality data linked to `person_id`

---

## 7. Default Handling
- Unmapped source values are assigned default concept IDs to preserve record continuity  
- Missing end dates default to start date where applicable  
- These records should be reviewed via Data Quality Dashboard outputs  

---

## 8. Data Quality Controls
Validated using OHDSI Ares / Data Quality Dashboard (DQD)

Checks include:
- Identity uniqueness  
- Visit validity  
- Concept mapping completeness  
- Temporal consistency  

---

## 9. Run Instructions
- Execute in Databricks environment  
- Run notebooks sequentially by phase  
- Re-run downstream domains if upstream changes  

---

## 10. Failure Impact
- Person failure → impacts entire pipeline  
- Visit failure → impacts all clinical domains  
- Clinical domain failures → result in partial dataset  

---

## 11. Ownership
- **Data Engineering:** execution and monitoring  
- **OMOP SME:** mapping validation and data quality oversight  

---

## 12. Notes and Limitations
- Environment-specific configuration managed within Databricks  
- Runbook focuses on execution flow and domain logic, not full code implementation  
