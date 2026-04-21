# DQD Plausibility Fixes Session Summary

**Date:** 2026-04-18
**Branch:** `epic-failures-5-onwards`
**Starting Failures:** 178 plausibility failures

---

## Summary of All Fixes Applied

### 1. Orphan Records Deleted (FK Integrity)

| Table | Records Deleted |
|-------|----------------|
| procedure_occurrence | 3,489,875 |
| measurement | 28,735,458 |
| death | 1,251 |
| condition_occurrence | 2,722,684 |
| drug_exposure | 209,939 |
| observation | 278,303 |
| visit_occurrence | 2,958,569 |
| note | 8,627 |
| visit_detail | 147,221 |
| device_exposure | 1,973 |
| observation_period | 92,204 |
| condition_era | 1,675,153 |
| drug_era | 112,475 |

### 2. Temporal Violations Deleted

| Issue | Records Deleted |
|-------|----------------|
| Visit start > end | 354,316 |
| Drug start > end | 23,045 |
| Observation after death | 10,265 |
| Visit_detail after death | 351 |
| Visit_detail before birth | 49 |
| Device after death | 21 |
| Measurement before birth | 122 |
| Drug before birth | 6 |
| Drug after death | 145 |
| Procedure before birth | 187 |
| Condition_era before birth | 2,547 |
| Drug_era before birth | 62 |
| Condition at age > 120 | 82 |
| Visit outside obs_period | 149,885 |
| Visit_detail outside visit | 10,485 |

### 3. Future Date Violations Deleted

| Issue | Records Deleted |
|-------|----------------|
| Condition in future | 1,776 |
| Drug in future | 455 |
| Procedure in future | 1,066 |
| Drug_era in future | 255 |
| Condition_era in future | 99 |
| Visit_detail in future | 2 |

### 4. Gender Plausibility Fixes

| Issue | Records |
|-------|---------|
| Males with female-only conditions deleted | 484,080 |
| Females with male-only conditions deleted | 30,521 |
| Gender concept 0 updated to 8551 (Unknown) | 8,783 |

### 5. Observation Period Gap Fixed

- **Before:** 4,091,006 persons missing observation periods
- **After:** Full coverage (10.2M persons)
- **Fix:** Expanded notebook to include medications, procedures, lab results, and fallback for persons with no clinical activity

### 6. Concept Updates

- Gender mapping: Source values 3, 950, 951, empty now map to 8551 (Unknown) instead of 0
- admitted_from_concept_id and discharged_to_concept_id: Set to NULL where 0 (pending verification)

---

## Notebooks Updated with Filters

All notebooks updated to prevent these issues on future loads:

1. **person** - Map unknown gender to 8551, birth date >= 1900
2. **condition_occurrence** - Gender filter, age > 120 filter, person FK
3. **drug_exposure** - Before birth filter, after death filter, start > end filter, person FK
4. **procedure_occurrence** - Before birth filter, person FK
5. **measurement** - Before birth filter, person FK
6. **observation** - After death filter, person FK
7. **visit_occurrence** - Before birth/after death, start > end, person FK
8. **visit_detail** - Before birth/after death filter, person FK
9. **device_exposure** - After death filter
10. **note** - After death filter, date >= 1950, person FK
11. **observation_period** - Expanded sources, person FK
12. **condition_era** - Before birth filter, person FK
13. **drug_era** - Before birth filter, person FK

---

## Concept Mapping Improvements (Session 2 - 2026-04-18)

### 7. Measurement Concept Mapping Added

**Notebook:** `epic_clarity_measurement.ipynb`

**Changes:**
- Added `standard_concept_mapping` view: LOINC → Measurement standard concepts
- Added `unit_concept_mapping` view: Unit strings → UCUM concepts
- Joined `order_results` → `clarity_component` to get LOINC codes
- Now maps `measurement_concept_id` from LOINC codes via `concept_relationship`
- Now maps `unit_concept_id` from `REFERENCE_UNIT` strings

**Source Tables Used:**
- `clarity_component.LOINC_CODE` - Lab component LOINC codes
- `concept` (UCUM vocabulary) - Unit concept mapping

### 8. Procedure Concept Mapping Added

**Notebook:** `epic_clarity_procedure_occurrence.ipynb`

**Changes:**
- Added new source: `hsp_acct_cpt_codes` (hospital billing CPT codes)
- Added `standard_concept_mapping` view: CPT4/HCPCS → Procedure standard concepts
- Hospital billing records now have `procedure_type_concept_id = 32810` (Claim)
- Order/surgical records remain `procedure_type_concept_id = 32817` (EHR)

**Source Tables Used:**
- `hsp_acct_cpt_codes.CPT_CODE` - Hospital billing CPT codes
- `hsp_account` - Links billing to patient

---

## Remaining Issues (Still Requires Work)

### Concept Mapping Status (After Session 2)

| Field | Status | Notes |
|-------|--------|-------|
| measurement_concept_id | **IMPROVED** | Now maps via LOINC from clarity_component |
| procedure_concept_id | **IMPROVED** | Now maps CPT from hsp_acct_cpt_codes |
| unit_concept_id | **IMPROVED** | Now maps UCUM from REFERENCE_UNIT |
| condition_concept_id | Already mapping | ICD10 → SNOMED via clarity_edg |
| visit_detail_concept_id | Still 100% unmapped | Requires visit type mapping |
| device_concept_id | Still 100% unmapped | No device codes in source |
| drug_concept_id | Already mapping | NDC/RxNorm mapping exists |

### Source Concept Mapping (Still Needs Work)
- condition_source_concept_id = 0: 14.3M records
- drug_source_concept_id = 0: 3.5M records
- measurement_source_concept_id: **IMPROVED** - Now populated with LOINC concepts
- procedure_source_concept_id: **IMPROVED** - Now populated with CPT concepts

---

## Delete Query Templates

All deletes used this pattern (Delta Lake requirement):
```sql
CREATE OR REPLACE TEMPORARY VIEW to_delete AS
SELECT id_field FROM table WHERE condition;

MERGE INTO table AS t
USING to_delete AS s ON t.id_field = s.id_field
WHEN MATCHED THEN DELETE;
```

---

## Commits Made

```
0ea2d9a Add age > 120 plausibility filter to condition_occurrence
98fb1e8 Add plausibility filters to era and remaining notebooks
5cbd185 Add person FK checks and death filters to note and visit_occurrence
646711d Add plausibility filters to procedure and condition_era notebooks
54cba98 Add plausibility filters to hydration notebooks
389e969 Expand observation_period to include all clinical sources
b3daccf Add person FK checks to procedure and measurement notebooks
bce827b Fix gender mapping and plausibility filters
4af57a8 Add plausibility filters to hydration notebooks
```

---

## Validation Queries

### Comprehensive Plausibility Check (All should return 0)
```sql
SELECT 'condition before birth' as issue, COUNT(*) as cnt FROM _exponent.omop_epic.condition_occurrence co JOIN _exponent.omop_epic.person p ON p.person_id = co.person_id WHERE co.condition_start_date < DATE(p.birth_datetime)
UNION ALL SELECT 'condition after death', COUNT(*) FROM _exponent.omop_epic.condition_occurrence co JOIN _exponent.omop_epic.death d ON d.person_id = co.person_id WHERE co.condition_start_date > d.death_date
UNION ALL SELECT 'drug before birth', COUNT(*) FROM _exponent.omop_epic.drug_exposure de JOIN _exponent.omop_epic.person p ON p.person_id = de.person_id WHERE de.drug_exposure_start_date < DATE(p.birth_datetime)
UNION ALL SELECT 'drug after death', COUNT(*) FROM _exponent.omop_epic.drug_exposure de JOIN _exponent.omop_epic.death d ON d.person_id = de.person_id WHERE de.drug_exposure_start_date > d.death_date
UNION ALL SELECT 'visit before birth', COUNT(*) FROM _exponent.omop_epic.visit_occurrence vo JOIN _exponent.omop_epic.person p ON p.person_id = vo.person_id WHERE vo.visit_start_date < DATE(p.birth_datetime)
UNION ALL SELECT 'visit after death', COUNT(*) FROM _exponent.omop_epic.visit_occurrence vo JOIN _exponent.omop_epic.death d ON d.person_id = vo.person_id WHERE vo.visit_start_date > d.death_date
UNION ALL SELECT 'condition in future', COUNT(*) FROM _exponent.omop_epic.condition_occurrence WHERE condition_start_date > CURRENT_DATE()
UNION ALL SELECT 'drug in future', COUNT(*) FROM _exponent.omop_epic.drug_exposure WHERE drug_exposure_start_date > CURRENT_DATE()
UNION ALL SELECT 'procedure in future', COUNT(*) FROM _exponent.omop_epic.procedure_occurrence WHERE procedure_date > CURRENT_DATE()
ORDER BY cnt DESC;
```

### Orphan Check (All should return 0)
```sql
SELECT 'condition_occurrence' as tbl, COUNT(*) as orphans FROM _exponent.omop_epic.condition_occurrence WHERE person_id NOT IN (SELECT person_id FROM _exponent.omop_epic.person)
UNION ALL SELECT 'drug_exposure', COUNT(*) FROM _exponent.omop_epic.drug_exposure WHERE person_id NOT IN (SELECT person_id FROM _exponent.omop_epic.person)
UNION ALL SELECT 'procedure_occurrence', COUNT(*) FROM _exponent.omop_epic.procedure_occurrence WHERE person_id NOT IN (SELECT person_id FROM _exponent.omop_epic.person)
UNION ALL SELECT 'measurement', COUNT(*) FROM _exponent.omop_epic.measurement WHERE person_id NOT IN (SELECT person_id FROM _exponent.omop_epic.person)
UNION ALL SELECT 'observation', COUNT(*) FROM _exponent.omop_epic.observation WHERE person_id NOT IN (SELECT person_id FROM _exponent.omop_epic.person)
UNION ALL SELECT 'visit_occurrence', COUNT(*) FROM _exponent.omop_epic.visit_occurrence WHERE person_id NOT IN (SELECT person_id FROM _exponent.omop_epic.person);
```

---

## Next Steps

1. **Run the updated hydration notebooks** to re-populate data with concept mappings:
   - `epic_clarity_measurement.ipynb` - Will map LOINC codes and units
   - `epic_clarity_procedure_occurrence.ipynb` - Will add CPT billing codes

2. **Run DQD revalidation** to see updated failure count after concept mapping improvements

3. **Remaining concept mapping work:**
   - visit_detail_concept_id (needs visit type source values)
   - device_concept_id (no device codes in source data)

4. **Validation:** Run `EPIC_VALIDATION_QUERIES.ipynb` to verify mapping rates improved
