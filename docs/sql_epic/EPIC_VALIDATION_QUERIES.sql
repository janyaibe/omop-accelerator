-- ============================================================================
-- EPIC OMOP DATA QUALITY VALIDATION QUERIES
-- Run these in Databricks to validate omop_epic tables
-- ============================================================================

-- ============================================================================
-- PERSON TABLE
-- ============================================================================

-- Check gender_concept_id is standard valid concept
SELECT 'PERSON.GENDER_CONCEPT_ID' as check_field,
       COUNT(*) as total_records,
       SUM(CASE WHEN p.gender_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       SUM(CASE WHEN c.standard_concept != 'S' OR c.standard_concept IS NULL THEN 1 ELSE 0 END) as non_standard
FROM _exponent.omop_epic.person p
LEFT JOIN _exponent.omop.concept c ON p.gender_concept_id = c.concept_id;

-- Check race_concept_id is standard valid concept
SELECT 'PERSON.RACE_CONCEPT_ID' as check_field,
       COUNT(*) as total_records,
       SUM(CASE WHEN p.race_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       SUM(CASE WHEN c.standard_concept != 'S' OR c.standard_concept IS NULL THEN 1 ELSE 0 END) as non_standard
FROM _exponent.omop_epic.person p
LEFT JOIN _exponent.omop.concept c ON p.race_concept_id = c.concept_id;

-- Check ethnicity_concept_id is standard valid concept
SELECT 'PERSON.ETHNICITY_CONCEPT_ID' as check_field,
       COUNT(*) as total_records,
       SUM(CASE WHEN p.ethnicity_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       SUM(CASE WHEN c.standard_concept != 'S' OR c.standard_concept IS NULL THEN 1 ELSE 0 END) as non_standard
FROM _exponent.omop_epic.person p
LEFT JOIN _exponent.omop.concept c ON p.ethnicity_concept_id = c.concept_id;

-- Check birth_datetime is reasonable (not before 1900)
SELECT 'PERSON.BIRTH_DATETIME' as check_field,
       COUNT(*) as total_records,
       SUM(CASE WHEN year(birth_datetime) < 1900 THEN 1 ELSE 0 END) as before_1900,
       SUM(CASE WHEN birth_datetime > current_date() THEN 1 ELSE 0 END) as future_dates
FROM _exponent.omop_epic.person;

-- ============================================================================
-- OBSERVATION_PERIOD TABLE
-- ============================================================================

-- Check all persons have observation period
SELECT 'OBSERVATION_PERIOD coverage' as check_field,
       (SELECT COUNT(DISTINCT person_id) FROM _exponent.omop_epic.person) as total_persons,
       (SELECT COUNT(DISTINCT person_id) FROM _exponent.omop_epic.observation_period) as persons_with_obs_period,
       (SELECT COUNT(DISTINCT person_id) FROM _exponent.omop_epic.person) -
       (SELECT COUNT(DISTINCT person_id) FROM _exponent.omop_epic.observation_period) as persons_missing_obs_period;

-- Check period_type_concept_id is valid
SELECT 'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID' as check_field,
       period_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.observation_period op
LEFT JOIN _exponent.omop.concept c ON op.period_type_concept_id = c.concept_id
GROUP BY period_type_concept_id, c.concept_name, c.domain_id, c.standard_concept;

-- Check start_date <= end_date
SELECT 'OBSERVATION_PERIOD date ordering' as check_field,
       COUNT(*) as total_records,
       SUM(CASE WHEN observation_period_start_date > observation_period_end_date THEN 1 ELSE 0 END) as start_after_end
FROM _exponent.omop_epic.observation_period;

-- ============================================================================
-- VISIT_OCCURRENCE TABLE
-- ============================================================================

-- Check visit_concept_id is standard valid concept
SELECT 'VISIT_OCCURRENCE.VISIT_CONCEPT_ID' as check_field,
       visit_concept_id,
       c.concept_name,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.visit_occurrence vo
LEFT JOIN _exponent.omop.concept c ON vo.visit_concept_id = c.concept_id
GROUP BY visit_concept_id, c.concept_name, c.standard_concept
ORDER BY cnt DESC
LIMIT 20;

-- Check visit_type_concept_id is valid Type Concept
SELECT 'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID' as check_field,
       visit_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.visit_occurrence vo
LEFT JOIN _exponent.omop.concept c ON vo.visit_type_concept_id = c.concept_id
GROUP BY visit_type_concept_id, c.concept_name, c.domain_id, c.standard_concept
ORDER BY cnt DESC;

-- Check admitted_from_concept_id
SELECT 'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN admitted_from_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       SUM(CASE WHEN admitted_from_concept_id IS NULL THEN 1 ELSE 0 END) as null_concept
FROM _exponent.omop_epic.visit_occurrence;

-- Check discharged_to_concept_id
SELECT 'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN discharged_to_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       SUM(CASE WHEN discharged_to_concept_id IS NULL THEN 1 ELSE 0 END) as null_concept
FROM _exponent.omop_epic.visit_occurrence;

-- Check visit dates are plausible (after birth, before death)
SELECT 'VISIT_OCCURRENCE dates vs DEATH' as check_field,
       COUNT(*) as visits_after_death
FROM _exponent.omop_epic.visit_occurrence vo
JOIN _exponent.omop_epic.death d ON vo.person_id = d.person_id
WHERE vo.visit_start_date > d.death_date;

-- Check person_id exists in person table
SELECT 'VISIT_OCCURRENCE.PERSON_ID FK' as check_field,
       COUNT(*) as orphan_records
FROM _exponent.omop_epic.visit_occurrence vo
WHERE NOT EXISTS (SELECT 1 FROM _exponent.omop_epic.person p WHERE p.person_id = vo.person_id);

-- ============================================================================
-- CONDITION_OCCURRENCE TABLE
-- ============================================================================

-- Check condition_concept_id distribution
SELECT 'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN condition_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN condition_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.condition_occurrence;

-- Check condition_type_concept_id is valid Type Concept
SELECT 'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID' as check_field,
       condition_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.condition_occurrence co
LEFT JOIN _exponent.omop.concept c ON co.condition_type_concept_id = c.concept_id
GROUP BY condition_type_concept_id, c.concept_name, c.domain_id, c.standard_concept
ORDER BY cnt DESC;

-- Check condition_source_concept_id
SELECT 'CONDITION_OCCURRENCE.CONDITION_SOURCE_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN condition_source_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN condition_source_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.condition_occurrence;

-- Check person_id exists in person table
SELECT 'CONDITION_OCCURRENCE.PERSON_ID FK' as check_field,
       COUNT(*) as orphan_records
FROM _exponent.omop_epic.condition_occurrence co
WHERE NOT EXISTS (SELECT 1 FROM _exponent.omop_epic.person p WHERE p.person_id = co.person_id);

-- ============================================================================
-- DRUG_EXPOSURE TABLE
-- ============================================================================

-- Check drug_concept_id distribution
SELECT 'DRUG_EXPOSURE.DRUG_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN drug_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN drug_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.drug_exposure;

-- Check drug_type_concept_id is valid Type Concept
SELECT 'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID' as check_field,
       drug_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.drug_exposure de
LEFT JOIN _exponent.omop.concept c ON de.drug_type_concept_id = c.concept_id
GROUP BY drug_type_concept_id, c.concept_name, c.domain_id, c.standard_concept
ORDER BY cnt DESC;

-- Check drug dates less than 1950
SELECT 'DRUG_EXPOSURE dates < 1950' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN drug_exposure_start_date < '1950-01-01' THEN 1 ELSE 0 END) as start_before_1950,
       SUM(CASE WHEN drug_exposure_end_date < '1950-01-01' THEN 1 ELSE 0 END) as end_before_1950
FROM _exponent.omop_epic.drug_exposure;

-- Check person_id exists in person table
SELECT 'DRUG_EXPOSURE.PERSON_ID FK' as check_field,
       COUNT(*) as orphan_records
FROM _exponent.omop_epic.drug_exposure de
WHERE NOT EXISTS (SELECT 1 FROM _exponent.omop_epic.person p WHERE p.person_id = de.person_id);

-- ============================================================================
-- PROCEDURE_OCCURRENCE TABLE
-- ============================================================================

-- Check procedure_concept_id distribution
SELECT 'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN procedure_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN procedure_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.procedure_occurrence;

-- Check procedure_type_concept_id is valid Type Concept
SELECT 'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID' as check_field,
       procedure_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.procedure_occurrence po
LEFT JOIN _exponent.omop.concept c ON po.procedure_type_concept_id = c.concept_id
GROUP BY procedure_type_concept_id, c.concept_name, c.domain_id, c.standard_concept
ORDER BY cnt DESC;

-- Check person_id exists in person table
SELECT 'PROCEDURE_OCCURRENCE.PERSON_ID FK' as check_field,
       COUNT(*) as orphan_records
FROM _exponent.omop_epic.procedure_occurrence po
WHERE NOT EXISTS (SELECT 1 FROM _exponent.omop_epic.person p WHERE p.person_id = po.person_id);

-- ============================================================================
-- MEASUREMENT TABLE
-- ============================================================================

-- Check measurement_concept_id distribution
SELECT 'MEASUREMENT.MEASUREMENT_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN measurement_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN measurement_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.measurement;

-- Check measurement_type_concept_id is valid Type Concept
SELECT 'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID' as check_field,
       measurement_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.measurement m
LEFT JOIN _exponent.omop.concept c ON m.measurement_type_concept_id = c.concept_id
GROUP BY measurement_type_concept_id, c.concept_name, c.domain_id, c.standard_concept
ORDER BY cnt DESC;

-- Check unit_concept_id
SELECT 'MEASUREMENT.UNIT_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN unit_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN unit_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.measurement;

-- Check for implausibly high values (> 1 billion)
SELECT 'MEASUREMENT.VALUE_AS_NUMBER > 1B' as check_field,
       COUNT(*) as records_over_1B
FROM _exponent.omop_epic.measurement
WHERE value_as_number > 1000000000;

-- Check person_id exists in person table
SELECT 'MEASUREMENT.PERSON_ID FK' as check_field,
       COUNT(*) as orphan_records
FROM _exponent.omop_epic.measurement m
WHERE NOT EXISTS (SELECT 1 FROM _exponent.omop_epic.person p WHERE p.person_id = m.person_id);

-- ============================================================================
-- OBSERVATION TABLE
-- ============================================================================

-- Check observation_concept_id distribution
SELECT 'OBSERVATION.OBSERVATION_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN observation_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN observation_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.observation;

-- Check observation_type_concept_id is valid Type Concept
SELECT 'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID' as check_field,
       observation_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.observation o
LEFT JOIN _exponent.omop.concept c ON o.observation_type_concept_id = c.concept_id
GROUP BY observation_type_concept_id, c.concept_name, c.domain_id, c.standard_concept
ORDER BY cnt DESC;

-- ============================================================================
-- DEATH TABLE
-- ============================================================================

-- Check person_id exists in person table
SELECT 'DEATH.PERSON_ID FK' as check_field,
       COUNT(*) as orphan_records
FROM _exponent.omop_epic.death d
WHERE NOT EXISTS (SELECT 1 FROM _exponent.omop_epic.person p WHERE p.person_id = d.person_id);

-- Check death_date is reasonable
SELECT 'DEATH.DEATH_DATE' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN death_date < '1950-01-01' THEN 1 ELSE 0 END) as before_1950,
       SUM(CASE WHEN death_date > current_date() THEN 1 ELSE 0 END) as future_dates
FROM _exponent.omop_epic.death;

-- Check death_type_concept_id
SELECT 'DEATH.DEATH_TYPE_CONCEPT_ID' as check_field,
       death_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.death d
LEFT JOIN _exponent.omop.concept c ON d.death_type_concept_id = c.concept_id
GROUP BY death_type_concept_id, c.concept_name, c.domain_id, c.standard_concept;

-- ============================================================================
-- NOTE TABLE
-- ============================================================================

-- Check note_class_concept_id
SELECT 'NOTE.NOTE_CLASS_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN note_class_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN note_class_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.note;

-- Check note_type_concept_id
SELECT 'NOTE.NOTE_TYPE_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN note_type_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN note_type_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.note;

-- Check note_date is reasonable
SELECT 'NOTE.NOTE_DATE' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN note_date < '1950-01-01' THEN 1 ELSE 0 END) as before_1950
FROM _exponent.omop_epic.note;

-- ============================================================================
-- VISIT_DETAIL TABLE
-- ============================================================================

-- Check visit_detail_concept_id
SELECT 'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID' as check_field,
       COUNT(*) as total,
       SUM(CASE WHEN visit_detail_concept_id = 0 THEN 1 ELSE 0 END) as zero_concept,
       ROUND(SUM(CASE WHEN visit_detail_concept_id = 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as pct_zero
FROM _exponent.omop_epic.visit_detail;

-- Check visit_detail_type_concept_id
SELECT 'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID' as check_field,
       visit_detail_type_concept_id,
       c.concept_name,
       c.domain_id,
       c.standard_concept,
       COUNT(*) as cnt
FROM _exponent.omop_epic.visit_detail vd
LEFT JOIN _exponent.omop.concept c ON vd.visit_detail_type_concept_id = c.concept_id
GROUP BY visit_detail_type_concept_id, c.concept_name, c.domain_id, c.standard_concept
ORDER BY cnt DESC;

-- ============================================================================
-- ERA TABLES (DRUG_ERA, CONDITION_ERA)
-- ============================================================================

-- Check drug_era has records
SELECT 'DRUG_ERA' as check_table,
       COUNT(*) as total_records,
       COUNT(DISTINCT person_id) as distinct_persons
FROM _exponent.omop_epic.drug_era;

-- Check condition_era has records
SELECT 'CONDITION_ERA' as check_table,
       COUNT(*) as total_records,
       COUNT(DISTINCT person_id) as distinct_persons
FROM _exponent.omop_epic.condition_era;

-- ============================================================================
-- SUMMARY: Record counts per table
-- ============================================================================

SELECT 'PERSON' as table_name, COUNT(*) as record_count FROM _exponent.omop_epic.person
UNION ALL SELECT 'OBSERVATION_PERIOD', COUNT(*) FROM _exponent.omop_epic.observation_period
UNION ALL SELECT 'VISIT_OCCURRENCE', COUNT(*) FROM _exponent.omop_epic.visit_occurrence
UNION ALL SELECT 'VISIT_DETAIL', COUNT(*) FROM _exponent.omop_epic.visit_detail
UNION ALL SELECT 'CONDITION_OCCURRENCE', COUNT(*) FROM _exponent.omop_epic.condition_occurrence
UNION ALL SELECT 'DRUG_EXPOSURE', COUNT(*) FROM _exponent.omop_epic.drug_exposure
UNION ALL SELECT 'PROCEDURE_OCCURRENCE', COUNT(*) FROM _exponent.omop_epic.procedure_occurrence
UNION ALL SELECT 'MEASUREMENT', COUNT(*) FROM _exponent.omop_epic.measurement
UNION ALL SELECT 'OBSERVATION', COUNT(*) FROM _exponent.omop_epic.observation
UNION ALL SELECT 'DEATH', COUNT(*) FROM _exponent.omop_epic.death
UNION ALL SELECT 'NOTE', COUNT(*) FROM _exponent.omop_epic.note
UNION ALL SELECT 'DRUG_ERA', COUNT(*) FROM _exponent.omop_epic.drug_era
UNION ALL SELECT 'CONDITION_ERA', COUNT(*) FROM _exponent.omop_epic.condition_era
ORDER BY table_name;
