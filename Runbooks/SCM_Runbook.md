# Allscripts SCM / Sunrise → OMOP Runbook

## 1. Purpose
Defines execution steps to transform Allscripts SCM / Sunrise data into the OMOP Common Data Model (CDM), supporting standardized analytics and research use cases.

This runbook follows a standardized framework applied across multiple source systems (Epic, SCM, TouchWorks) to ensure consistency in transformation logic and execution.

---

## 2. System Flow
Allscripts SCM / Sunrise → Bronze → Mapping Tables → Hydration Notebooks → OMOP Silver → OMOP Final

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
- device_exposure  

### Phase 4 — Lifecycle
- observation_period  
- death  

---

## 4. Record Identification and Linking
Each source record is assigned a consistent identifier using system, table, and source keys.

Mapping tables convert these into OMOP IDs (`person_id`, `visit_occurrence_id`).

This ensures consistent linkage across all domains.

---

## 5. Core Dependencies
- `source_to_person` → provides `person_id` for all downstream domains  
- `source_to_visit_occurrence` → provides encounter linkage across clinical domains  
- `domain_source_to_concept` → standardizes source values to OMOP concepts  

---

## 6. Domain Execution Details

### PERSON
- **Source Tables:** Allscripts SCM patient tables  
- **Key Fields:** ClientGUID and demographic fields  
- **Transformations:**
  - Construct `person_source_value`
  - Derive demographics
  - Deduplicate records  
- **Mapping:** populates `source_to_person`  
- **Dependency:** must run first  

---

### VISIT_OCCURRENCE
- **Source Tables:** SCM encounter tables (e.g., `dbo_cv3clientvisit`)  
- **Key Fields:** ClientGUID, TypeCode, AdmitDtm, DischargeDtm  
- **Transformations:**
  - Map TypeCode → `visit_concept_id`
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
- Unmapped values assigned default concepts  
- Missing end dates default to start date  
- Reviewed via Data Quality Dashboard outputs  

---

## 8. Data Quality Controls
Validated using OHDSI Ares / Data Quality Dashboard (DQD)

Checks include:
- Identity validation  
- Visit validity  
- Mapping completeness  
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
- Clinical failures → result in partial dataset  

---

## 11. Ownership
- **Data Engineering:** execution and monitoring  
- **OMOP SME:** mapping validation and data quality oversight  

---

## 12. Notes and Limitations
- Environment-specific configuration managed within Databricks  
- Runbook focuses on execution flow and domain logic, not full code implementation  
