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

## CONDITION_OCCURRENCE
- **Source Tables:** PAT_ENC_DX, PROBLEM_LIST, CLARITY_EDG
- **Key Transformations:**
  - Join to clarity_edg to extract ICD-10 codes
  - Map ICD-10CM → SNOMED concepts via concept_relationship
  - Gender/age plausibility filters (exclude males with female-only conditions, age > 120)
- **Visit Linkage:** Date-range matching (condition_date within visit_start_date to visit_end_date)
- **Mapping Rate:** 82.65% have visit linkages
- **Output:** person_id, condition_concept_id, condition_source_value, visit_occurrence_id

---

## PROCEDURE_OCCURRENCE
- **Source Tables:**
  - hsp_acct_cpt_codes (Hospital billing)
  - hsp_transactions (~24.2M records, 14.53% mappable)
  - arpb_transactions (~4.6M records, 44.60% mappable)
  - order_proc (EHR procedure orders, no CPT codes)
  - or_log (Surgical log)
- **Key Transformations:**
  - CPT codes from billing sources → concept_relationship "Maps to" → Procedure concepts
  - EHR procedures use DESCRIPTION (unmapped)
  - Billing source = procedure_type_concept_id 32810; EHR = 32817
- **Visit Linkage:** Date-range matching or encounter ID-based join (hybrid approach)
- **Mapping Rate:** 8.30% have procedure_concept_id (70.27% have visit linkages)
- **Note:** Remaining 91.7% unmapped records ingested with procedure_concept_id = 0 for source fidelity

---

## DRUG_EXPOSURE
- **Source Tables:** ORDER_MED, CLARITY_MEDICATION
- **Key Transformations:**
  - Name-based mapping to RxNorm Ingredient concepts (first word of generic name)
  - Extract sig (patient instructions), refills, quantity, route, dose
  - Plausibility: exclude drugs before birth or after death
- **Visit Linkage:** Date-range matching (drug_exposure_start_date within visit date range)
- **Mapping Rate:** Visit linkage coverage determined by date-range matching algorithm
- **Output:** person_id, drug_concept_id, drug_source_value, visit_occurrence_id

---

## MEASUREMENT
- **Source Tables:** ORDER_RESULTS, CLARITY_COMPONENT, LNC_DB_MAIN
- **Key Transformations:**
  - 3-tier LOINC fallback strategy:
    1. Result-level override (COMPON_LNC_ID in order_results)
    2. Component default (DEFAULT_LNC_ID in clarity_component)
    3. Legacy component LOINC_CODE
  - Map LOINC → standard Measurement concept
  - Map REFERENCE_UNIT → UCUM unit concepts
  - Extract value_as_number, range_low, range_high
- **Visit Linkage:** Hybrid approach - encounter ID join (if available) with date-range fallback
- **Mapping Rate:** 76.77% have visit linkages; ~10% have LOINC concept mapping
- **Note:** 494M unmapped measurements have no LOINC codes in source (text entry, patient-reported)
- **Output:** person_id, measurement_concept_id, value_as_number, unit_concept_id, visit_occurrence_id

---

## OBSERVATION
- **Source Tables:** SOCIAL_HX (tobacco, alcohol, drugs, sexual activity), FAMILY_HX, PATIENT_3 (occupation)
- **Key Transformations:**
  - Standardize yes/no values to concept_ids
  - Extract value_as_string, qualifier_source_value
  - Plausibility: exclude observations after death
- **Visit Linkage:** Date-range matching
- **Mapping Rate:** 100% have visit linkages
- **Output:** person_id, observation_concept_id, value_as_concept_id, visit_occurrence_id

---

## SOURCE VALUE ENHANCEMENTS
All clinical domains now populate:
- `*_source_value`: Human-readable source identifier (e.g., CPT_CODE, COMPONENT_ID with FLO_MEAS_ID)
- `*_source_concept_id`: OMOP concept for source code (e.g., CPT concept, LOINC concept)
- **Visit Linkage Pattern:** Match person_id + event_date within visit_start_date to visit_end_date; if multiple visits same day, pick earliest
- **Encounter-based joins:** Where source has direct encounter ID (PAT_ENC_CSN_ID), use as primary join path; fall back to date-range for legacy records

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

### Notebook Updates (Branch: epic-failures-5-onwards)
**Updated Hydration Notebooks:**
1. `epic_clarity_condition_occurrence.ipynb` — Added visit linkage via date-range matching (Cell-7)
2. `epic_clarity_procedure_occurrence.ipynb` — Added hsp_transactions + arpb_transactions sources (Cell-5), visit linkage (Cell-14)
3. `epic_clarity_drug_exposure.ipynb` — Added visit linkage (Cell-8)
4. `epic_clarity_measurement.ipynb` — 3-tier LOINC fallback (Cell-6), visit linkage hybrid (Cell-9)
5. `epic_clarity_observation.ipynb` — Added visit linkage (Cell-16)

**Validation Results:**
- Procedure concept mapping: 8.30% (up from 0.07% before HSP+ARPB additions)
- Procedure visit linkage: 70.27%
- Measurement visit linkage: 76.77% (hybrid encounter join)
- Condition visit linkage: 82.65%
- Observation visit linkage: 100%
- Data cleanup: 314K orphaned procedure records removed

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

### Current Implementation Status
- **Visit Linkage:** ✅ Implemented across all clinical domains (condition, procedure, drug, measurement, observation)
  - Mapping rates: procedure 70.27%, condition 82.65%, measurement 76.77%, drug (tested), observation 100%
  - Hybrid approach: direct encounter ID join where available, date-range fallback for unmapped

- **Concept Mapping Rates:**
  - Measurement: ~10% (LOINC codes) — 494M records have no LOINC in source
  - Procedure: 8.30% (CPT → Procedure) — remaining records ingested with concept_id = 0
  - Condition: varies by source (pat_enc_dx vs problem_list)
  - Observation: 100% (pre-mapped to observation concepts)
  - Drug: name-based RxNorm mapping (limited by generic_name text quality)

- **Source Fidelity:** All unmapped records ingested with domain_concept_id = 0 to preserve audit trail and enable future backfilling (per client requirements)

- **Data Quality:** Records ingested before birth, after death, or with implausible dates are excluded via plausibility filters

### Known Limitations
- Flowsheet data (IP_FLWSHT_MEAS, 2.2B records) not yet integrated — requires patient/encounter linkage documentation from source system
- Measurement concept mapping limited by availability of LOINC codes in source
- Drug concept mapping relies on generic_name text parsing — incomplete for branded/complex medications
- BDC_LOINC_CODES table empty; alternative procedure tables (AP_CLAIM_*) not yet integrated

### Environment-Specific Configuration
- Managed within Databricks notebooks
- Runbook focuses on execution flow and domain logic, not full code implementation

