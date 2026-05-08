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
- **Domains:** condition, procedure, drug, measurement, observation, note, device  
- **Pattern:**
  - Join to person and visit  
  - Map concepts  
  - Load to OMOP  
- **Dependencies:**
  - `source_to_person`
  - `source_to_visit_occurrence`
- **Procedure note:** SCM procedure work currently has two source patterns in-repo:
  - OMOP hydration in `allscripts_scm_procedure_occurrence.ipynb` derived from Sunrise `dbo_cv3order` / `dbo_cv3ordertaskoccurrence`
  - client-provided billing extract logic in `(Clone) procedures_SCM.py` derived from Soarian, DSS, and Athena `omny_accounts`
  Reconcile these before treating procedure ARES failures as fully addressed.

---

### OBSERVATION_PERIOD
Defines patient activity window based on visit and clinical data  

---

### DEATH
Captures mortality data linked to `person_id`

---

### DERIVED DOMAINS
- `condition_era` depends on hydrated SCM `condition_occurrence`
- `drug_era` and `dose_era` depend on hydrated SCM `drug_exposure`
- `episode` depends on hydrated SCM `condition_occurrence` and the approved disease-episode concept set
- `episode_event` depends on populated SCM `episode`, `visit_occurrence`, `measurement`, and `drug_exposure`

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

## 8.5. Performance & Incremental Loading (90-Day Window)

**⚠️ Critical for Production:** Due to Allscripts SCM / Sunrise data volume (1.5B+ records) and extremely high cardinality in tables like `device_exposure`, **all hydration notebooks must implement incremental loading via a 90-day rolling window** to prevent memory overload, timeout issues, and excessive compute costs.

### Incremental Strategy

Add WHERE clause filtering to the silver view creation in each notebook:

```sql
WHERE
  <timestamp_column> >= CURRENT_DATE - 90
  AND <timestamp_column> < CURRENT_DATE
```

### Tables Requiring Incremental Filtering
- **device_exposure** (Sunrise) — **extremely high cardinality**, very large volume - **PRIORITY**
- **observation** — numerous lab/result records
- **condition_occurrence** — historical diagnosis data with multiple status changes
- **drug_exposure** — medication history with frequent updates
- **measurement** — lab/vital records

### Implementation Pattern

**Step 1:** Identify the timestamp column (varies by domain and source table)
- condition: `EffectiveDtm` or `CreatedDtm`
- device: `ServiceDtm` or `CreatedDtm`
- drug_exposure: `StartDtm` or `OrderDtm`
- observation: `ResultDtm` or `OrderDtm`

**Step 2:** Add to WHERE clause filter
```sql
WHERE EffectiveDtm >= CURRENT_DATE - 90
  AND EffectiveDtm < CURRENT_DATE
```

**Step 3:** Run on daily/weekly schedule
- MERGE logic handles upserts automatically
- Avoids duplicate processing of entire history

### Benefits
- ✅ Incremental loading without processing entire history
- ✅ Reduced memory footprint per run (~70-80% reduction)
- ✅ Faster execution times (typically 5-10x faster)
- ✅ Prevents resource exhaustion, timeouts, and Spark OOM errors
- ✅ Enables reliable scheduled job automation

### Data Integrity
- MERGE logic ensures no duplicate records
- Already-processed records outside 90-day window remain unchanged
- Full historical backfill completed on initial ETL setup
- Periodic full refreshes recommended quarterly for data reconciliation

---

## 9. Run Instructions
- Execute in Databricks environment  
- Run notebooks sequentially by phase  
- Re-run downstream domains if upstream changes  
- **Table resets and handoff:** for which `_exponent` tables to **truncate** or **delete** (gold vs silver vs mapping), when, and the exact notebook for each domain, see [SCM_Hydration_Reset_Handoff.md](SCM_Hydration_Reset_Handoff.md).  
- For the current SCM tracker baseline, refresh in this order:
  1. `condition_occurrence`
  2. `condition_era`
  3. `episode`
  4. `episode_event`
  5. `observation_period`
  6. `death`
  7. rerun OHDSI Ares / DQD and compare against the latest SCM baseline

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
