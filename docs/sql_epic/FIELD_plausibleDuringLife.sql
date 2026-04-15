WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the CONDITION_ERA_START_DATE field of the CONDITION_ERA table that occurs after death.' as check_description
 ,'CONDITION_ERA' as cdm_table_name
 ,'CONDITION_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_condition_era_condition_era_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_ERA.CONDITION_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.CONDITION_ERA cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CONDITION_ERA cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the CONDITION_END_DATE field of the CONDITION_OCCURRENCE table that occurs after death.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_condition_occurrence_condition_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the CONDITION_END_DATETIME field of the CONDITION_OCCURRENCE table that occurs after death.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_condition_occurrence_condition_end_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the CONDITION_START_DATE field of the CONDITION_OCCURRENCE table that occurs after death.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_condition_occurrence_condition_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the CONDITION_START_DATETIME field of the CONDITION_OCCURRENCE table that occurs after death.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_condition_occurrence_condition_start_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DEVICE_EXPOSURE_END_DATE field of the DEVICE_EXPOSURE table that occurs after death.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_device_exposure_device_exposure_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DEVICE_EXPOSURE_END_DATETIME field of the DEVICE_EXPOSURE table that occurs after death.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_device_exposure_device_exposure_end_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DEVICE_EXPOSURE_START_DATE field of the DEVICE_EXPOSURE table that occurs after death.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_device_exposure_device_exposure_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DEVICE_EXPOSURE_START_DATETIME field of the DEVICE_EXPOSURE table that occurs after death.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_device_exposure_device_exposure_start_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DOSE_ERA_START_DATE field of the DOSE_ERA table that occurs after death.' as check_description
 ,'DOSE_ERA' as cdm_table_name
 ,'DOSE_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_dose_era_dose_era_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DOSE_ERA.DOSE_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DOSE_ERA cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DOSE_ERA cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DRUG_ERA_START_DATE field of the DRUG_ERA table that occurs after death.' as check_description
 ,'DRUG_ERA' as cdm_table_name
 ,'DRUG_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_drug_era_drug_era_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_ERA.DRUG_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DRUG_ERA cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_ERA cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DRUG_EXPOSURE_END_DATE field of the DRUG_EXPOSURE table that occurs after death.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_drug_exposure_drug_exposure_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DRUG_EXPOSURE_END_DATETIME field of the DRUG_EXPOSURE table that occurs after death.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_drug_exposure_drug_exposure_end_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DRUG_EXPOSURE_START_DATE field of the DRUG_EXPOSURE table that occurs after death.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_drug_exposure_drug_exposure_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the DRUG_EXPOSURE_START_DATETIME field of the DRUG_EXPOSURE table that occurs after death.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_drug_exposure_drug_exposure_start_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VERBATIM_END_DATE field of the DRUG_EXPOSURE table that occurs after death.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'VERBATIM_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_drug_exposure_verbatim_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.VERBATIM_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the EPISODE_END_DATE field of the EPISODE table that occurs after death.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_episode_episode_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.EPISODE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.EPISODE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the EPISODE_END_DATETIME field of the EPISODE table that occurs after death.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_episode_episode_end_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.EPISODE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.EPISODE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the EPISODE_START_DATE field of the EPISODE table that occurs after death.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_episode_episode_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.EPISODE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.EPISODE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the EPISODE_START_DATETIME field of the EPISODE table that occurs after death.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_episode_episode_start_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.EPISODE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.EPISODE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the OBSERVATION_PERIOD_END_DATE field of the OBSERVATION_PERIOD table that occurs after death.' as check_description
 ,'OBSERVATION_PERIOD' as cdm_table_name
 ,'OBSERVATION_PERIOD_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_observation_period_observation_period_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.OBSERVATION_PERIOD cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.OBSERVATION_PERIOD cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the OBSERVATION_PERIOD_START_DATE field of the OBSERVATION_PERIOD table that occurs after death.' as check_description
 ,'OBSERVATION_PERIOD' as cdm_table_name
 ,'OBSERVATION_PERIOD_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_observation_period_observation_period_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.OBSERVATION_PERIOD cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.OBSERVATION_PERIOD cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the PROCEDURE_DATE field of the PROCEDURE_OCCURRENCE table that occurs after death.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_procedure_occurrence_procedure_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the PROCEDURE_DATETIME field of the PROCEDURE_OCCURRENCE table that occurs after death.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_procedure_occurrence_procedure_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the PROCEDURE_END_DATE field of the PROCEDURE_OCCURRENCE table that occurs after death.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_procedure_occurrence_procedure_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the PROCEDURE_END_DATETIME field of the PROCEDURE_OCCURRENCE table that occurs after death.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_procedure_occurrence_procedure_end_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VISIT_DETAIL_END_DATE field of the VISIT_DETAIL table that occurs after death.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_visit_detail_visit_detail_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VISIT_DETAIL_END_DATETIME field of the VISIT_DETAIL table that occurs after death.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_visit_detail_visit_detail_end_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VISIT_DETAIL_START_DATE field of the VISIT_DETAIL table that occurs after death.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_visit_detail_visit_detail_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VISIT_DETAIL_START_DATETIME field of the VISIT_DETAIL table that occurs after death.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_visit_detail_visit_detail_start_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VISIT_END_DATE field of the VISIT_OCCURRENCE table that occurs after death.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_visit_occurrence_visit_end_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VISIT_END_DATETIME field of the VISIT_OCCURRENCE table that occurs after death.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_visit_occurrence_visit_end_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VISIT_START_DATE field of the VISIT_OCCURRENCE table that occurs after death.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_visit_occurrence_visit_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleDuringLife' as check_name
 ,'FIELD' as check_level
 ,'If yes, the number and percent of records with a date value in the VISIT_START_DATETIME field of the VISIT_OCCURRENCE table that occurs after death.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_during_life.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleduringlife_visit_occurrence_visit_start_datetime' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 1 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 1 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,1 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 JOIN _exponent.omop_epic.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(IF(IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)))) > DATEADD(day, 60, IF(IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE))) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)) IS NULL, to_date(cast(de.death_date AS STRING), 'yyyyMMdd'), IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM _exponent.omop_epic.death)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
