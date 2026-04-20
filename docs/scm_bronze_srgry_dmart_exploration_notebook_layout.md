# SCM surgery datamart notebook layout

Copy each block into a separate Databricks notebook cell.

## Cell 1

```sql
%sql
USE CATALOG `_exponent`;
USE SCHEMA `_bronze_srgry_dmart`;
```

## Cell 2 - Section A inventory

```sql
%sql
SHOW TABLES IN `_exponent`.`_bronze_srgry_dmart`;
```

## Cell 3 - Section A domain-hinted table shortlist

```sql
%sql
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
```

## Cell 4 - Section B person key discovery

```sql
%sql
SELECT table_name, column_name, data_type
FROM `_exponent`.`information_schema`.`columns`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(column_name) RLIKE '(person|patient|client|mrn|empi|enterprise|subject)'
ORDER BY table_name, column_name;
```

## Cell 5 - Section B visit/episode key discovery

```sql
%sql
SELECT table_name, column_name, data_type
FROM `_exponent`.`information_schema`.`columns`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(column_name) RLIKE '(visit|encounter|episode|case|surg|admit|discharge)'
ORDER BY table_name, column_name;
```

## Cell 6 - Section B temporal column discovery

```sql
%sql
SELECT table_name, column_name, data_type
FROM `_exponent`.`information_schema`.`columns`
WHERE table_schema = '_bronze_srgry_dmart'
  AND (
    LOWER(column_name) RLIKE '(date|dtm|datetime|time|start|end|onset|offset|admit|discharge|admin)'
    OR LOWER(data_type) RLIKE '(date|timestamp)'
  )
ORDER BY table_name, column_name;
```

## Cell 7 - Section C opinionated drug candidate table check

```sql
%sql
SELECT table_name
FROM `_exponent`.`information_schema`.`tables`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(table_name) RLIKE '(cv3order|med|medication|sxammgenericitem|sxammproduct|sxammproductpackage|drug|rx)'
ORDER BY table_name;
```

## Cell 8 - Section C drug readiness metrics template

```sql
%sql
-- Replace placeholders from discovered columns.
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT <person_col>) AS distinct_persons,
  SUM(CASE WHEN <person_col> IS NULL THEN 1 ELSE 0 END) AS null_person_rows,
  SUM(CASE WHEN <drug_code_col> IS NULL OR TRIM(CAST(<drug_code_col> AS STRING)) = '' THEN 1 ELSE 0 END) AS null_or_blank_drug_code_rows,
  SUM(CASE WHEN <event_date_col> IS NULL THEN 1 ELSE 0 END) AS null_event_date_rows,
  COUNT(DISTINCT <visit_col>) AS distinct_visit_keys,
  SUM(CASE WHEN <visit_col> IS NULL THEN 1 ELSE 0 END) AS null_visit_key_rows
FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>;
```

## Cell 9 - Section D condition candidate table check

```sql
%sql
SELECT table_name
FROM `_exponent`.`information_schema`.`tables`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(table_name) RLIKE '(dx|diag|diagnosis|condition|problem|icd|snomed)'
ORDER BY table_name;
```

## Cell 10 - Section D condition readiness metrics template

```sql
%sql
-- Replace placeholders from discovered columns.
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT <person_col>) AS distinct_persons,
  SUM(CASE WHEN <person_col> IS NULL THEN 1 ELSE 0 END) AS null_person_rows,
  SUM(CASE WHEN <condition_code_col> IS NULL OR TRIM(CAST(<condition_code_col> AS STRING)) = '' THEN 1 ELSE 0 END) AS null_or_blank_condition_code_rows,
  SUM(CASE WHEN <condition_date_col> IS NULL THEN 1 ELSE 0 END) AS null_condition_date_rows,
  COUNT(DISTINCT <condition_code_col>) AS distinct_condition_codes
FROM `_exponent`.`_bronze_srgry_dmart`.<condition_table>;
```

## Cell 11 - Section E episode candidate table check

```sql
%sql
SELECT table_name
FROM `_exponent`.`information_schema`.`tables`
WHERE table_schema = '_bronze_srgry_dmart'
  AND LOWER(table_name) RLIKE '(episode|encounter|visit|surg|surgery|case|event)'
ORDER BY table_name;
```

## Cell 12 - Section E episode readiness metrics template

```sql
%sql
-- Replace placeholders from discovered columns.
SELECT
  COUNT(*) AS total_rows,
  COUNT(DISTINCT <episode_id_col>) AS distinct_episode_ids,
  SUM(CASE WHEN <episode_id_col> IS NULL THEN 1 ELSE 0 END) AS null_episode_id_rows,
  SUM(CASE WHEN <person_col> IS NULL THEN 1 ELSE 0 END) AS null_person_rows,
  SUM(CASE WHEN <episode_start_col> IS NULL THEN 1 ELSE 0 END) AS null_start_rows,
  SUM(CASE WHEN <episode_end_col> IS NULL THEN 1 ELSE 0 END) AS null_end_rows,
  SUM(CASE WHEN <event_link_col> IS NULL THEN 1 ELSE 0 END) AS null_event_link_rows
FROM `_exponent`.`_bronze_srgry_dmart`.<episode_table>;
```

## Cell 13 - Section F cross-domain overlap template

```sql
%sql
-- Replace placeholders from chosen candidates.
SELECT
  COUNT(DISTINCT d.person_key) AS drug_persons,
  COUNT(DISTINCT c.person_key) AS condition_persons,
  COUNT(DISTINCT CASE WHEN c.person_key IS NOT NULL THEN d.person_key END) AS overlap_persons
FROM (
  SELECT CAST(<drug_person_col> AS STRING) AS person_key
  FROM `_exponent`.`_bronze_srgry_dmart`.<drug_table>
  WHERE <drug_person_col> IS NOT NULL
) d
LEFT JOIN (
  SELECT DISTINCT CAST(<condition_person_col> AS STRING) AS person_key
  FROM `_exponent`.`_bronze_srgry_dmart`.<condition_table>
  WHERE <condition_person_col> IS NOT NULL
) c ON d.person_key = c.person_key;
```

## Output capture

- Paste key results into `docs/scm_bronze_srgry_dmart_result_template.md`.
- If medication candidates still lack usable keys/codes, keep `drug_exposure` blocked pending missing prescription-source exposure.

