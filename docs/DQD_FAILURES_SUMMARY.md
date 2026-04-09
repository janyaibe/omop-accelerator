# OMOP DQD Failures Summary

Generated: 2026-04-02

## Overview by Source System

| Source System | Total Failures | Resolved | Blocked | Data Limitation | Remaining |
|---------------|----------------|----------|---------|-----------------|-----------|
| Epic Clarity  | 40             | 7        | 2       | 1               | 30        |
| Touchworks    | 77             | 0        | 0       | 0               | 77        |
| SCM/Sunrise   | 15             | 0        | 0       | 0               | 15        |
| **TOTAL**     | **132**        | **7**    | **2**   | **1**           | **122**   |

---

## Epic Clarity Failures (40 total)

### Resolved (7)
| # | Table | Field | Issue | Fix |
|---|-------|-------|-------|-----|
| 1 | OBSERVATION_PERIOD | NA | No records | Case mismatch + simplified query |
| 2 | DRUG_EXPOSURE | NA | No records | Notebook just needed to run |
| 3 | PROCEDURE_OCCURRENCE | NA | No records | Schema mismatch fix |
| 4 | MEASUREMENT | NA | No records | Complete notebook rewrite |
| 10 | DEATH | PERSON_ID | Orphan records | Added person join + cleanup |
| 31 | PERSON | GENDER_CONCEPT_ID | All zeros | Changed SEX to SEX_C + mappings |

### Blocked by Concept Mapping (2)
| # | Table | Field | Issue | Blocker |
|---|-------|-------|-------|---------|
| 6 | DRUG_ERA | NA | No records | drug_concept_id=0 (100%) |
| 7 | CONDITION_ERA | NA | No records | condition_concept_id=0 (100%) |

### Data Limitation (1)
| # | Table | Field | Issue | Notes |
|---|-------|-------|-------|-------|
| 5 | OBSERVATION | NA | No records | Only 43 source records available |

### Remaining (30)
See `docs/epic_failures.csv` for full details.

---

## Touchworks Failures (77 total)

### By Category

| Category | Count | Examples |
|----------|-------|----------|
| Missing Records (No data) | 9 | OBSERVATION_PERIOD, DRUG_EXPOSURE, MEASUREMENT, etc. |
| Type Concept Issues | 11 | *_TYPE_CONCEPT_ID fields with invalid/zero values |
| Invalid Dates (<1950) | 20 | Various date/datetime fields |
| Concept Mapping (0 values) | 18 | *_CONCEPT_ID, *_SOURCE_CONCEPT_ID fields |
| Plausibility | 8 | Visit timing, gender checks, value ranges |
| Other | 11 | DEATH orphans, DRUG_STRENGTH, etc. |

### High Priority (>95% failure rate)
| # | Table | Field | Percent | Records |
|---|-------|-------|---------|---------|
| 1 | OBSERVATION_PERIOD | NA | 100% | 5,589,355 |
| 12-13 | CONDITION_OCCURRENCE | CONDITION_TYPE_CONCEPT_ID | 99.97-99.98% | 91M+ |
| 15 | DRUG_EXPOSURE | DRUG_TYPE_CONCEPT_ID | 100% | 174M |
| 19 | OBSERVATION | OBSERVATION_TYPE_CONCEPT_ID | 100% | 327M |
| 22-24 | DEATH | PERSON_ID, dates | 99.83% | 16,313 |
| 30-31 | NOTE | NOTE_DATE/DATETIME | 99.65% | 2.3M |
| 50 | DRUG_EXPOSURE | DRUG_CONCEPT_ID | 100% | 174M |

See `docs/touchworks_failures.csv` for full details.

---

## SCM/Sunrise Failures (15 total)

See `docs/scm_failures.csv` for full details.

---

## Common Patterns Across Systems

1. **Concept Mapping**: All systems show high rates of unmapped concepts (concept_id=0)
2. **Type Concepts**: Missing or invalid type_concept_id values across clinical tables
3. **ERA Tables**: Blocked by upstream concept mapping issues
4. **Date Validation**: Many records with dates before 1950 (likely NULL/default values)
5. **Referential Integrity**: Death and other tables with orphaned person_ids

## Recommended Priority Order

1. **Person/Death referential integrity** - Quick fixes, foundational
2. **Type concept mappings** - Insert standard type concepts
3. **Date validation** - Filter/fix invalid dates at ETL level
4. **Concept mapping** - Requires vocabulary work, unblocks ERA tables
5. **Plausibility checks** - Lower priority, often data quality issues
