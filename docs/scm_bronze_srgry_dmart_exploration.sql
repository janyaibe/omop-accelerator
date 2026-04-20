-- SCM exploration pack for `_exponent`.`_bronze_srgry_dmart`
-- Purpose: identify candidate source tables to unblock drug_exposure,
-- condition_occurrence/condition_era, and episode/episode_event.
--
-- How to run:
-- 1) Execute each section in order inside Databricks SQL or a notebook SQL cell.
-- 2) Save outputs for each section (screenshot or export).
-- 3) Share outputs for OMOP mapping recommendation finalization.

USE CATALOG `_exponent`;
USE SCHEMA `_bronze_srgry_dmart`;

-- ==========================================================
-- Section A: Catalog/schema/table inventory
-- ==========================================================

-- A1. Full table inventory
SHOW TABLES IN `_exponent`.`_bronze_srgry_dmart`;

-- A2. Inventory with rough table size/metadata (if available)
-- (DESCRIBE DETAIL may fail for views; run per candidate table as needed)
-- Example:
-- DESCRIBE DETAIL `_exponent`.`_bronze_srgry_dmart`.`your_table_name`;

-- A3. Candidate table name shortlist by domain keywords
SELECT
  table_schema,
  table_name,
  CASE
    WHEN LOWER(table_name) RLIKE '(drug|med|medication|rx|pharm|order|mar|admin)' THEN 'drug_like'
    WHEN LOWER(table_name) RLIKE '(dx|diag|diagnosis|condition|problem|icd|snomed)' THEN 'condition_like'
    WHEN LOWER(table_name) RLIKE '(episode|encounter|visit|surg|surgery|procedure|case)' THEN 'episode_like'
    ELSE 'other'
  END AS domain_hint
FROM `_exponent`.`information_schema`.`tables`
WHERE table_schema = '_bronze_srgry_dmart'
  AND table_type IN ('BASE TABLE', 'VIEW')
  AND LOWER(table_name) RLIKE '(drug|med|medication|rx|pharm|order|mar|admin|dx|diag|diagnosis|condition|problem|icd|snomed|episode|encounter|visit|surg|surgery|procedure|case)'
ORDER BY domain_hint, table_name;

-- A4. Column inventory for shortlisted candidate tables
-- Adjust this IN list after reviewing A3.
SELECT
  table_name,
  column_name,
  data_type,
  ordinal_position
FROM `_exponent`.`information_schema`.`columns`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(table_name) RLIKE '(drug|med|medication|rx|pharm|order|mar|admin|dx|diag|diagnosis|condition|problem|icd|snomed|episode|encounter|visit|surg|surgery|procedure|case)'
ORDER BY table_name, ordinal_position;

-- ==========================================================
-- Section B: Column-level discovery across candidate domains
-- ==========================================================

-- B1. Detect likely person/patient linkage columns
SELECT
  table_name,
  column_name,
  data_type
FROM `_exponent`.`information_schema`.`columns`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(column_name) RLIKE '(person|patient|client|mrn|empi|enterprise|subject)'
ORDER BY table_name, column_name;

-- B2. Detect likely encounter/visit/episode linkage columns
SELECT
  table_name,
  column_name,
  data_type
FROM `_exponent`.`information_schema`.`columns`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(column_name) RLIKE '(visit|encounter|episode|case|surg|admit|discharge)'
ORDER BY table_name, column_name;

-- B3. Detect likely date/time columns for clinical event timing
SELECT
  table_name,
  column_name,
  data_type
FROM `_exponent`.`information_schema`.`columns`
WHERE table_schema = '_bronze_srgry_dmart'
  AND (
    LOWER(column_name) RLIKE '(date|dtm|datetime|time|start|end|onset|offset|admit|discharge|admin)'
    OR LOWER(data_type) RLIKE '(date|timestamp)'
  )
ORDER BY table_name, column_name;

-- B4. Detect likely code/value system columns
SELECT
  table_name,
  column_name,
  data_type
FROM `_exponent`.`information_schema`.`columns`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(column_name) RLIKE '(code|concept|ndc|rxnorm|atc|gpi|icd|snomed|cpt|hcpcs|loinc|status|route|dose|unit)'
ORDER BY table_name, column_name;

-- ==========================================================
-- Section C: Drug probe pack (drug_exposure readiness)
-- ==========================================================
-- Replace <drug_table>, <person_col>, <drug_code_col>, <event_date_col>, <status_col>, <visit_col>
-- with real columns from Sections A/B.

-- C1. Record volume and person linkage completeness
-- SELECT
--   COUNT(*) AS total_rows,
--   COUNT(DISTINCT <person_col>) AS distinct_persons,
--   SUM(CASE WHEN <person_col> IS NULL THEN 1 ELSE 0 END) AS null_person_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>;

-- C2. Date completeness and range profile
-- SELECT
--   MIN(CAST(<event_date_col> AS DATE)) AS min_event_date,
--   MAX(CAST(<event_date_col> AS DATE)) AS max_event_date,
--   SUM(CASE WHEN <event_date_col> IS NULL THEN 1 ELSE 0 END) AS null_event_date_rows,
--   SUM(CASE WHEN CAST(<event_date_col> AS DATE) < DATE('1950-01-01') THEN 1 ELSE 0 END) AS pre1950_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>;

-- C3. Drug code profile (non-null % and top values)
-- SELECT
--   COUNT(*) AS total_rows,
--   SUM(CASE WHEN <drug_code_col> IS NULL OR TRIM(CAST(<drug_code_col> AS STRING)) = '' THEN 1 ELSE 0 END) AS null_or_blank_drug_code_rows,
--   COUNT(DISTINCT <drug_code_col>) AS distinct_drug_codes
-- FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>;
--
-- SELECT
--   CAST(<drug_code_col> AS STRING) AS drug_code,
--   COUNT(*) AS row_count
-- FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>
-- WHERE <drug_code_col> IS NOT NULL
-- GROUP BY CAST(<drug_code_col> AS STRING)
-- ORDER BY row_count DESC
-- LIMIT 100;

-- C4. Status profile (helps identify administered vs ordered vs canceled)
-- SELECT
--   CAST(<status_col> AS STRING) AS status_value,
--   COUNT(*) AS row_count
-- FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>
-- GROUP BY CAST(<status_col> AS STRING)
-- ORDER BY row_count DESC
-- LIMIT 100;

-- C5. Joinability probe to visit/encounter (if a visit-like key exists)
-- SELECT
--   COUNT(*) AS total_rows,
--   COUNT(DISTINCT <visit_col>) AS distinct_visit_keys,
--   SUM(CASE WHEN <visit_col> IS NULL THEN 1 ELSE 0 END) AS null_visit_key_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>;

-- ==========================================================
-- Section D: Condition probe pack (condition_occurrence/condition_era readiness)
-- ==========================================================
-- Replace <condition_table>, <person_col>, <condition_code_col>, <condition_date_col>, <visit_col>
-- with real columns.

-- D1. Record volume and person completeness
-- SELECT
--   COUNT(*) AS total_rows,
--   COUNT(DISTINCT <person_col>) AS distinct_persons,
--   SUM(CASE WHEN <person_col> IS NULL THEN 1 ELSE 0 END) AS null_person_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<condition_table>;

-- D2. Code quality and cardinality
-- SELECT
--   COUNT(*) AS total_rows,
--   SUM(CASE WHEN <condition_code_col> IS NULL OR TRIM(CAST(<condition_code_col> AS STRING)) = '' THEN 1 ELSE 0 END) AS null_or_blank_condition_code_rows,
--   COUNT(DISTINCT <condition_code_col>) AS distinct_condition_codes
-- FROM `_exponent`.`_bronze_srgry_dmart`.<condition_table>;
--
-- SELECT
--   CAST(<condition_code_col> AS STRING) AS condition_code,
--   COUNT(*) AS row_count
-- FROM `_exponent`.`_bronze_srgry_dmart`.<condition_table>
-- WHERE <condition_code_col> IS NOT NULL
-- GROUP BY CAST(<condition_code_col> AS STRING)
-- ORDER BY row_count DESC
-- LIMIT 100;

-- D3. Date semantics and era feasibility
-- SELECT
--   MIN(CAST(<condition_date_col> AS DATE)) AS min_condition_date,
--   MAX(CAST(<condition_date_col> AS DATE)) AS max_condition_date,
--   SUM(CASE WHEN <condition_date_col> IS NULL THEN 1 ELSE 0 END) AS null_condition_date_rows,
--   SUM(CASE WHEN CAST(<condition_date_col> AS DATE) < DATE('1950-01-01') THEN 1 ELSE 0 END) AS pre1950_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<condition_table>;

-- D4. Repeatability profile for era derivation
-- SELECT
--   person_id_candidate,
--   condition_code_candidate,
--   COUNT(*) AS event_count
-- FROM (
--   SELECT
--     CAST(<person_col> AS STRING) AS person_id_candidate,
--     CAST(<condition_code_col> AS STRING) AS condition_code_candidate
--   FROM `_exponent`.`_bronze_srgry_dmart`.<condition_table>
--   WHERE <person_col> IS NOT NULL AND <condition_code_col> IS NOT NULL
-- ) x
-- GROUP BY person_id_candidate, condition_code_candidate
-- ORDER BY event_count DESC
-- LIMIT 100;

-- ==========================================================
-- Section E: Episode probe pack (episode/episode_event readiness)
-- ==========================================================
-- Replace <episode_table>, <person_col>, <episode_id_col>, <episode_start_col>, <episode_end_col>, <event_link_col>
-- with real columns.

-- E1. Episode ID quality and uniqueness
-- SELECT
--   COUNT(*) AS total_rows,
--   COUNT(DISTINCT <episode_id_col>) AS distinct_episode_ids,
--   SUM(CASE WHEN <episode_id_col> IS NULL THEN 1 ELSE 0 END) AS null_episode_id_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<episode_table>;

-- E2. Episode timeline quality
-- SELECT
--   SUM(CASE WHEN <episode_start_col> IS NULL THEN 1 ELSE 0 END) AS null_start_rows,
--   SUM(CASE WHEN <episode_end_col> IS NULL THEN 1 ELSE 0 END) AS null_end_rows,
--   SUM(
--     CASE
--       WHEN <episode_start_col> IS NOT NULL
--        AND <episode_end_col> IS NOT NULL
--        AND CAST(<episode_start_col> AS DATE) > CAST(<episode_end_col> AS DATE)
--       THEN 1 ELSE 0
--     END
--   ) AS start_after_end_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<episode_table>;

-- E3. Episode/person linkability
-- SELECT
--   COUNT(*) AS total_rows,
--   COUNT(DISTINCT <person_col>) AS distinct_persons,
--   SUM(CASE WHEN <person_col> IS NULL THEN 1 ELSE 0 END) AS null_person_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<episode_table>;

-- E4. Episode-to-event linkage readiness
-- SELECT
--   COUNT(*) AS total_rows,
--   COUNT(DISTINCT <event_link_col>) AS distinct_event_links,
--   SUM(CASE WHEN <event_link_col> IS NULL THEN 1 ELSE 0 END) AS null_event_link_rows
-- FROM `_exponent`.`_bronze_srgry_dmart`.<episode_table>;

-- ==========================================================
-- Section F: Cross-table overlap checks (person/visit/episode linkage)
-- ==========================================================
-- Use discovered candidate tables and keys.

-- F1. Person overlap check between drug and condition candidates
-- SELECT
--   COUNT(DISTINCT d.person_key) AS drug_persons,
--   COUNT(DISTINCT c.person_key) AS condition_persons,
--   COUNT(DISTINCT CASE WHEN c.person_key IS NOT NULL THEN d.person_key END) AS overlap_persons
-- FROM (
--   SELECT CAST(<drug_person_col> AS STRING) AS person_key
--   FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>
--   WHERE <drug_person_col> IS NOT NULL
-- ) d
-- LEFT JOIN (
--   SELECT DISTINCT CAST(<condition_person_col> AS STRING) AS person_key
--   FROM `_exponent`.`_bronze_srgry_dmart`.<condition_table>
--   WHERE <condition_person_col> IS NOT NULL
-- ) c
--   ON d.person_key = c.person_key;

-- F2. Visit/encounter overlap check between drug and episode candidates
-- SELECT
--   COUNT(DISTINCT d.visit_key) AS drug_visit_keys,
--   COUNT(DISTINCT e.visit_key) AS episode_visit_keys,
--   COUNT(DISTINCT CASE WHEN e.visit_key IS NOT NULL THEN d.visit_key END) AS overlap_visit_keys
-- FROM (
--   SELECT CAST(<drug_visit_col> AS STRING) AS visit_key
--   FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>
--   WHERE <drug_visit_col> IS NOT NULL
-- ) d
-- LEFT JOIN (
--   SELECT DISTINCT CAST(<episode_visit_col> AS STRING) AS visit_key
--   FROM `_exponent`.`_bronze_srgry_dmart`.<episode_table>
--   WHERE <episode_visit_col> IS NOT NULL
-- ) e
--   ON d.visit_key = e.visit_key;

-- ==========================================================
-- Section G: OMOP fitness scoring template
-- ==========================================================
-- Fill this scoring table manually after running probes.
-- Score each dimension from 0 (bad) to 3 (strong).
--
-- Candidate table scoring dimensions:
-- - key_completeness: person/visit/episode linkage key null rates
-- - temporal_completeness: date coverage and logical consistency
-- - code_system_compatibility: ability to map to RxNorm/ICD/SNOMED/CPT/etc
-- - cross_domain_joinability: overlap with other candidate tables
--
-- Recommendation rule of thumb:
-- - 10-12: primary source
-- - 7-9: fallback/source augmentation
-- - <=6: not suitable without additional client source access
