WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the CONDITION_ERA_END_DATE field of the CONDITION_ERA table that occurs prior to birth.' as check_description
 ,'CONDITION_ERA' as cdm_table_name
 ,'CONDITION_ERA_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_condition_era_condition_era_end_date' as checkid
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
 'CONDITION_ERA.CONDITION_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.CONDITION_ERA cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.CONDITION_ERA_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.CONDITION_ERA cdmTable
 WHERE cdmTable.CONDITION_ERA_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the CONDITION_ERA_START_DATE field of the CONDITION_ERA table that occurs prior to birth.' as check_description
 ,'CONDITION_ERA' as cdm_table_name
 ,'CONDITION_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_condition_era_condition_era_start_date' as checkid
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
 FROM _exponent.omop_tw.CONDITION_ERA cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.CONDITION_ERA_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.CONDITION_ERA cdmTable
 WHERE cdmTable.CONDITION_ERA_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the CONDITION_END_DATE field of the CONDITION_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_condition_occurrence_condition_end_date' as checkid
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
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.CONDITION_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the CONDITION_END_DATETIME field of the CONDITION_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_condition_occurrence_condition_end_datetime' as checkid
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
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.CONDITION_END_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_END_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the CONDITION_START_DATE field of the CONDITION_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_condition_occurrence_condition_start_date' as checkid
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
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.CONDITION_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the CONDITION_START_DATETIME field of the CONDITION_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_condition_occurrence_condition_start_datetime' as checkid
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
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.CONDITION_START_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_START_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DEATH_DATE field of the DEATH table that occurs prior to birth.' as check_description
 ,'DEATH' as cdm_table_name
 ,'DEATH_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_death_death_date' as checkid
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
 'DEATH.DEATH_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.DEATH cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DEATH_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DEATH_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEATH_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEATH_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DEATH_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEATH_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEATH_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEATH_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DEATH cdmTable
 WHERE cdmTable.DEATH_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DEATH_DATETIME field of the DEATH table that occurs prior to birth.' as check_description
 ,'DEATH' as cdm_table_name
 ,'DEATH_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_death_death_datetime' as checkid
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
 'DEATH.DEATH_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.DEATH cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DEATH_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DEATH_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEATH_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEATH_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEATH_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DEATH cdmTable
 WHERE cdmTable.DEATH_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DEVICE_EXPOSURE_END_DATE field of the DEVICE_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_device_exposure_device_exposure_end_date' as checkid
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
 FROM _exponent.omop_tw.DEVICE_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DEVICE_EXPOSURE_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_EXPOSURE_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DEVICE_EXPOSURE_END_DATETIME field of the DEVICE_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_device_exposure_device_exposure_end_datetime' as checkid
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
 FROM _exponent.omop_tw.DEVICE_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DEVICE_EXPOSURE_END_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_EXPOSURE_END_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DEVICE_EXPOSURE_START_DATE field of the DEVICE_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_device_exposure_device_exposure_start_date' as checkid
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
 FROM _exponent.omop_tw.DEVICE_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DEVICE_EXPOSURE_START_DATETIME field of the DEVICE_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_device_exposure_device_exposure_start_datetime' as checkid
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
 FROM _exponent.omop_tw.DEVICE_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DOSE_ERA_END_DATE field of the DOSE_ERA table that occurs prior to birth.' as check_description
 ,'DOSE_ERA' as cdm_table_name
 ,'DOSE_ERA_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_dose_era_dose_era_end_date' as checkid
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
 'DOSE_ERA.DOSE_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.DOSE_ERA cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DOSE_ERA_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DOSE_ERA cdmTable
 WHERE cdmTable.DOSE_ERA_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DOSE_ERA_START_DATE field of the DOSE_ERA table that occurs prior to birth.' as check_description
 ,'DOSE_ERA' as cdm_table_name
 ,'DOSE_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_dose_era_dose_era_start_date' as checkid
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
 FROM _exponent.omop_tw.DOSE_ERA cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DOSE_ERA_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DOSE_ERA cdmTable
 WHERE cdmTable.DOSE_ERA_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DRUG_ERA_END_DATE field of the DRUG_ERA table that occurs prior to birth.' as check_description
 ,'DRUG_ERA' as cdm_table_name
 ,'DRUG_ERA_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_drug_era_drug_era_end_date' as checkid
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
 'DRUG_ERA.DRUG_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.DRUG_ERA cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DRUG_ERA_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DRUG_ERA cdmTable
 WHERE cdmTable.DRUG_ERA_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DRUG_ERA_START_DATE field of the DRUG_ERA table that occurs prior to birth.' as check_description
 ,'DRUG_ERA' as cdm_table_name
 ,'DRUG_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_drug_era_drug_era_start_date' as checkid
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
 FROM _exponent.omop_tw.DRUG_ERA cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DRUG_ERA_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DRUG_ERA cdmTable
 WHERE cdmTable.DRUG_ERA_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DRUG_EXPOSURE_END_DATE field of the DRUG_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_drug_exposure_drug_exposure_end_date' as checkid
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
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DRUG_EXPOSURE_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_EXPOSURE_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DRUG_EXPOSURE_END_DATETIME field of the DRUG_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_drug_exposure_drug_exposure_end_datetime' as checkid
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
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DRUG_EXPOSURE_END_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_EXPOSURE_END_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DRUG_EXPOSURE_START_DATE field of the DRUG_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_drug_exposure_drug_exposure_start_date' as checkid
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
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the DRUG_EXPOSURE_START_DATETIME field of the DRUG_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_drug_exposure_drug_exposure_start_datetime' as checkid
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
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.DRUG_EXPOSURE_START_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_EXPOSURE_START_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VERBATIM_END_DATE field of the DRUG_EXPOSURE table that occurs prior to birth.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'VERBATIM_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_drug_exposure_verbatim_end_date' as checkid
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
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VERBATIM_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.VERBATIM_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the EPISODE_END_DATE field of the EPISODE table that occurs prior to birth.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_episode_episode_end_date' as checkid
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
 FROM _exponent.omop_tw.EPISODE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.EPISODE_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.EPISODE cdmTable
 WHERE cdmTable.EPISODE_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the EPISODE_END_DATETIME field of the EPISODE table that occurs prior to birth.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_episode_episode_end_datetime' as checkid
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
 FROM _exponent.omop_tw.EPISODE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.EPISODE_END_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.EPISODE cdmTable
 WHERE cdmTable.EPISODE_END_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the EPISODE_START_DATE field of the EPISODE table that occurs prior to birth.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_episode_episode_start_date' as checkid
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
 FROM _exponent.omop_tw.EPISODE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.EPISODE_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.EPISODE cdmTable
 WHERE cdmTable.EPISODE_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the EPISODE_START_DATETIME field of the EPISODE table that occurs prior to birth.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_episode_episode_start_datetime' as checkid
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
 FROM _exponent.omop_tw.EPISODE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.EPISODE_START_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.EPISODE cdmTable
 WHERE cdmTable.EPISODE_START_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the MEASUREMENT_DATE field of the MEASUREMENT table that occurs prior to birth.' as check_description
 ,'MEASUREMENT' as cdm_table_name
 ,'MEASUREMENT_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_measurement_measurement_date' as checkid
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
 'MEASUREMENT.MEASUREMENT_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.MEASUREMENT cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.MEASUREMENT_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.MEASUREMENT_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.MEASUREMENT_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.MEASUREMENT_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.MEASUREMENT_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.MEASUREMENT cdmTable
 WHERE cdmTable.MEASUREMENT_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the MEASUREMENT_DATETIME field of the MEASUREMENT table that occurs prior to birth.' as check_description
 ,'MEASUREMENT' as cdm_table_name
 ,'MEASUREMENT_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_measurement_measurement_datetime' as checkid
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
 'MEASUREMENT.MEASUREMENT_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.MEASUREMENT cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.MEASUREMENT_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.MEASUREMENT cdmTable
 WHERE cdmTable.MEASUREMENT_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the NOTE_DATE field of the NOTE table that occurs prior to birth.' as check_description
 ,'NOTE' as cdm_table_name
 ,'NOTE_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_note_note_date' as checkid
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
 'NOTE.NOTE_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.NOTE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.NOTE_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.NOTE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.NOTE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.NOTE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.NOTE_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.NOTE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.NOTE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.NOTE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.NOTE cdmTable
 WHERE cdmTable.NOTE_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the NOTE_DATETIME field of the NOTE table that occurs prior to birth.' as check_description
 ,'NOTE' as cdm_table_name
 ,'NOTE_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_note_note_datetime' as checkid
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
 'NOTE.NOTE_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.NOTE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.NOTE_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.NOTE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.NOTE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.NOTE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.NOTE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.NOTE cdmTable
 WHERE cdmTable.NOTE_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the OBSERVATION_DATE field of the OBSERVATION table that occurs prior to birth.' as check_description
 ,'OBSERVATION' as cdm_table_name
 ,'OBSERVATION_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_observation_observation_date' as checkid
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
 'OBSERVATION.OBSERVATION_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.OBSERVATION cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.OBSERVATION_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.OBSERVATION_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.OBSERVATION_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.OBSERVATION cdmTable
 WHERE cdmTable.OBSERVATION_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the OBSERVATION_DATETIME field of the OBSERVATION table that occurs prior to birth.' as check_description
 ,'OBSERVATION' as cdm_table_name
 ,'OBSERVATION_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_observation_observation_datetime' as checkid
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
 'OBSERVATION.OBSERVATION_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.OBSERVATION cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.OBSERVATION_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.OBSERVATION cdmTable
 WHERE cdmTable.OBSERVATION_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the OBSERVATION_PERIOD_END_DATE field of the OBSERVATION_PERIOD table that occurs prior to birth.' as check_description
 ,'OBSERVATION_PERIOD' as cdm_table_name
 ,'OBSERVATION_PERIOD_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_observation_period_observation_period_end_date' as checkid
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
 FROM _exponent.omop_tw.OBSERVATION_PERIOD cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.OBSERVATION_PERIOD_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.OBSERVATION_PERIOD cdmTable
 WHERE cdmTable.OBSERVATION_PERIOD_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the OBSERVATION_PERIOD_START_DATE field of the OBSERVATION_PERIOD table that occurs prior to birth.' as check_description
 ,'OBSERVATION_PERIOD' as cdm_table_name
 ,'OBSERVATION_PERIOD_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_observation_period_observation_period_start_date' as checkid
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
 FROM _exponent.omop_tw.OBSERVATION_PERIOD cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.OBSERVATION_PERIOD cdmTable
 WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the PAYER_PLAN_PERIOD_END_DATE field of the PAYER_PLAN_PERIOD table that occurs prior to birth.' as check_description
 ,'PAYER_PLAN_PERIOD' as cdm_table_name
 ,'PAYER_PLAN_PERIOD_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_payer_plan_period_payer_plan_period_end_date' as checkid
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
 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.PAYER_PLAN_PERIOD cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the PAYER_PLAN_PERIOD_START_DATE field of the PAYER_PLAN_PERIOD table that occurs prior to birth.' as check_description
 ,'PAYER_PLAN_PERIOD' as cdm_table_name
 ,'PAYER_PLAN_PERIOD_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_payer_plan_period_payer_plan_period_start_date' as checkid
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
 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.PAYER_PLAN_PERIOD cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the PROCEDURE_DATE field of the PROCEDURE_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_procedure_occurrence_procedure_date' as checkid
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
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.PROCEDURE_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the PROCEDURE_DATETIME field of the PROCEDURE_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_procedure_occurrence_procedure_datetime' as checkid
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
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.PROCEDURE_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the PROCEDURE_END_DATE field of the PROCEDURE_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_procedure_occurrence_procedure_end_date' as checkid
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
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.PROCEDURE_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the PROCEDURE_END_DATETIME field of the PROCEDURE_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_procedure_occurrence_procedure_end_datetime' as checkid
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
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.PROCEDURE_END_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_END_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the SPECIMEN_DATE field of the SPECIMEN table that occurs prior to birth.' as check_description
 ,'SPECIMEN' as cdm_table_name
 ,'SPECIMEN_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_specimen_specimen_date' as checkid
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
 'SPECIMEN.SPECIMEN_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.SPECIMEN cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.SPECIMEN_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.SPECIMEN_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.SPECIMEN_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.SPECIMEN_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.SPECIMEN_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.SPECIMEN cdmTable
 WHERE cdmTable.SPECIMEN_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the SPECIMEN_DATETIME field of the SPECIMEN table that occurs prior to birth.' as check_description
 ,'SPECIMEN' as cdm_table_name
 ,'SPECIMEN_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_specimen_specimen_datetime' as checkid
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
 'SPECIMEN.SPECIMEN_DATETIME' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_tw.SPECIMEN cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.SPECIMEN_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.SPECIMEN cdmTable
 WHERE cdmTable.SPECIMEN_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VISIT_DETAIL_END_DATE field of the VISIT_DETAIL table that occurs prior to birth.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_visit_detail_visit_detail_end_date' as checkid
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
 FROM _exponent.omop_tw.VISIT_DETAIL cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VISIT_DETAIL_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.VISIT_DETAIL cdmTable
 WHERE cdmTable.VISIT_DETAIL_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VISIT_DETAIL_END_DATETIME field of the VISIT_DETAIL table that occurs prior to birth.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_visit_detail_visit_detail_end_datetime' as checkid
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
 FROM _exponent.omop_tw.VISIT_DETAIL cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VISIT_DETAIL_END_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.VISIT_DETAIL cdmTable
 WHERE cdmTable.VISIT_DETAIL_END_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VISIT_DETAIL_START_DATE field of the VISIT_DETAIL table that occurs prior to birth.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_visit_detail_visit_detail_start_date' as checkid
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
 FROM _exponent.omop_tw.VISIT_DETAIL cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VISIT_DETAIL_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.VISIT_DETAIL cdmTable
 WHERE cdmTable.VISIT_DETAIL_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VISIT_DETAIL_START_DATETIME field of the VISIT_DETAIL table that occurs prior to birth.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_visit_detail_visit_detail_start_datetime' as checkid
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
 FROM _exponent.omop_tw.VISIT_DETAIL cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VISIT_DETAIL_START_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.VISIT_DETAIL cdmTable
 WHERE cdmTable.VISIT_DETAIL_START_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VISIT_END_DATE field of the VISIT_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_END_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_visit_occurrence_visit_end_date' as checkid
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
 FROM _exponent.omop_tw.VISIT_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VISIT_END_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_END_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VISIT_END_DATETIME field of the VISIT_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_END_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_visit_occurrence_visit_end_datetime' as checkid
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
 FROM _exponent.omop_tw.VISIT_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VISIT_END_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_END_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VISIT_START_DATE field of the VISIT_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_visit_occurrence_visit_start_date' as checkid
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
 FROM _exponent.omop_tw.VISIT_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VISIT_START_DATE IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_START_DATE IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleAfterBirth' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a date value in the VISIT_START_DATETIME field of the VISIT_OCCURRENCE table that occurs prior to birth.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_after_birth.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausibleafterbirth_visit_occurrence_visit_start_datetime' as checkid
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
 FROM _exponent.omop_tw.VISIT_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p 
 ON cdmTable.person_id = p.person_id
 WHERE cdmTable.VISIT_START_DATETIME IS NOT NULL AND 
 IF(IF(IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)))) < COALESCE(
 IF(IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE))) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)) IS NULL, to_date(cast(p.birth_datetime AS STRING), 'yyyyMMdd'), IF(try_cast(p.birth_datetime  AS DATE) IS NULL, to_date(cast(p.birth_datetime  AS STRING), 'yyyyMMdd'), try_cast(p.birth_datetime  AS DATE)))), 
 IF(IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE)) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 ) AS STRING), 'yyyyMMdd'), IF(try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE) IS NULL, to_date(cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(
 p.year_of_birth,
 COALESCE(
 RIGHT('0' || CAST(p.month_of_birth AS STRING), 2),
 '01'
 ),
 COALESCE(
 RIGHT('0' || CAST(p.day_of_birth AS STRING), 2),
 '01'
 )
 )  AS DATE))))
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_START_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
