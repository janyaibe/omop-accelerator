# Allscripts TouchWorks → OMOP Runbook

> **Standardized Runbook Framework**  
> This document follows a consistent execution model across all source systems (Epic, SCM, TouchWorks) to support maintainability and scalability.

---

## 1. Purpose
Defines execution steps to transform Allscripts TouchWorks data into the OMOP Common Data Model (CDM), supporting standardized analytics and research use cases.

---

## 2. System Flow
TouchWorks → Bronze → Mapping Tables → Hydration Notebooks → OMOP Silver → OMOP Final

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
Each source record is assigned a consistent identifier, sometimes derived from multiple source tables when a single key is not available.

Identifiers are constructed using system, table, and source keys.

Mapping tables convert these into OMOP IDs (`person_id`, `visit_occurrence_id`), ensuring consistent linkage across all domains.

---

## 5. Core Dependencies
- `source_to_person` → provides `person_id` for all downstream domains  
- `source_to_visit_occurrence` → provides encounter linkage across clinical domains  
- `domain_source_to_concept` → standardizes source values to OMOP concepts  

---

## 6. Domain Execution Details

### PERSON
- **Source Tables:** TouchWorks patient-related tables (multiple sources)  
- **Transformations:**
  - Construct `person_source_value` from composite keys  
  - Derive demographics  
  - Deduplicate records  
- **Mapping:** populates `source_to_person`  
- **Dependency:** must run first  

---

### VISIT_OCCURRENCE
- **Source Tables:** TouchWorks encounter data (derived across tables)  
- **Transformations:**
  - Construct visit records from multiple inputs  
  - Map to `visit_concept_id`  
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
- **Note:** sourcing may be indirect or derived across multiple tables  
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
- Unmapped values are assigned default concept IDs to preserve record continuity  
- Missing end dates default to start date where applicable  
- These records are expected to be reviewed through Data Quality Dashboard outputs  

---

## 8. Data Quality Controls
Validated using OHDSI Ares / Data Quality Dashboard (DQD)

Checks include:
- Identity uniqueness
- Visit validity
- Mapping completeness
- Temporal consistency

---

## 8.5. Performance & Incremental Loading (90-Day Window)

**⚠️ Critical for Production:** Due to TouchWorks data volume (1.5B+ records) and high cardinality in tables like `device_exposure`, **all hydration notebooks must implement incremental loading via a 90-day rolling window** to prevent memory overload, timeout issues, and excessive compute costs.

### Incremental Strategy

Add WHERE clause filtering to the silver view creation in each notebook:

```sql
WHERE
  <timestamp_column> >= CURRENT_DATE - 90
  AND <timestamp_column> < CURRENT_DATE
```

### Tables Requiring Incremental Filtering
- **device_exposure** — high cardinality, very large volume
- **observation** — numerous lab/result records
- **condition_occurrence** — historical diagnosis data
- **drug_exposure** — medication history
- **measurement** — lab/vital records

### Implementation Pattern

**Step 1:** Identify the timestamp column (varies by domain)
- observation: `order_activity_date`
- condition: `status_date` or `entry_date`
- drug_exposure: `medication_start_date`
- device: `device_date`

**Step 2:** Add to WHERE clause filter
```sql
WHERE order_activity_date >= CURRENT_DATE - 90
  AND order_activity_date < CURRENT_DATE
```

**Step 3:** Run on daily/weekly schedule
- MERGE logic handles upserts automatically
- Avoids duplicate processing of entire history

### Benefits
- ✅ Incremental loading without processing entire history
- ✅ Reduced memory footprint per run
- ✅ Faster execution times
- ✅ Prevents resource exhaustion and timeouts
- ✅ Enables scheduled job automation

### Data Integrity
- MERGE logic ensures no duplicate records
- Already-processed records outside 90-day window remain unchanged
- Full historical backfill completed on initial ETL setup

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
