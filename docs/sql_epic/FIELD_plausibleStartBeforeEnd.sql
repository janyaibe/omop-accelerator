WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the SOURCE_RELEASE_DATE field of the CDM_SOURCE that occurs after the date in the SOURCE_RELEASE_DATE.' as check_description
 ,'CDM_SOURCE' as cdm_table_name
 ,'SOURCE_RELEASE_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_cdm_source_source_release_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,0 as threshold_value
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
 'CDM_SOURCE.SOURCE_RELEASE_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.CDM_SOURCE cdmTable
 WHERE cdmTable.SOURCE_RELEASE_DATE IS NOT NULL 
 AND cdmTable.SOURCE_RELEASE_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CDM_SOURCE cdmTable
 WHERE cdmTable.SOURCE_RELEASE_DATE IS NOT NULL 
 AND cdmTable.SOURCE_RELEASE_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the CONDITION_ERA_START_DATE field of the CONDITION_ERA that occurs after the date in the CONDITION_ERA_END_DATE.' as check_description
 ,'CONDITION_ERA' as cdm_table_name
 ,'CONDITION_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_condition_era_condition_era_start_date' as checkid
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
 WHERE cdmTable.CONDITION_ERA_START_DATE IS NOT NULL 
 AND cdmTable.CONDITION_ERA_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CONDITION_ERA cdmTable
 WHERE cdmTable.CONDITION_ERA_START_DATE IS NOT NULL 
 AND cdmTable.CONDITION_ERA_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the CONDITION_START_DATE field of the CONDITION_OCCURRENCE that occurs after the date in the CONDITION_END_DATE.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_condition_occurrence_condition_start_date' as checkid
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
 WHERE cdmTable.CONDITION_START_DATE IS NOT NULL 
 AND cdmTable.CONDITION_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_START_DATE IS NOT NULL 
 AND cdmTable.CONDITION_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the CONDITION_START_DATETIME field of the CONDITION_OCCURRENCE that occurs after the date in the CONDITION_END_DATETIME.' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_condition_occurrence_condition_start_datetime' as checkid
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
 WHERE cdmTable.CONDITION_START_DATETIME IS NOT NULL 
 AND cdmTable.CONDITION_END_DATETIME IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_START_DATETIME IS NOT NULL 
 AND cdmTable.CONDITION_END_DATETIME IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the DEVICE_EXPOSURE_START_DATE field of the DEVICE_EXPOSURE that occurs after the date in the DEVICE_EXPOSURE_END_DATE.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_device_exposure_device_exposure_start_date' as checkid
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
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NOT NULL 
 AND cdmTable.DEVICE_EXPOSURE_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATE IS NOT NULL 
 AND cdmTable.DEVICE_EXPOSURE_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the DEVICE_EXPOSURE_START_DATETIME field of the DEVICE_EXPOSURE that occurs after the date in the DEVICE_EXPOSURE_END_DATETIME.' as check_description
 ,'DEVICE_EXPOSURE' as cdm_table_name
 ,'DEVICE_EXPOSURE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_device_exposure_device_exposure_start_datetime' as checkid
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
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATETIME IS NOT NULL 
 AND cdmTable.DEVICE_EXPOSURE_END_DATETIME IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATETIME IS NOT NULL 
 AND cdmTable.DEVICE_EXPOSURE_END_DATETIME IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the DOSE_ERA_START_DATE field of the DOSE_ERA that occurs after the date in the DOSE_ERA_END_DATE.' as check_description
 ,'DOSE_ERA' as cdm_table_name
 ,'DOSE_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_dose_era_dose_era_start_date' as checkid
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
 WHERE cdmTable.DOSE_ERA_START_DATE IS NOT NULL 
 AND cdmTable.DOSE_ERA_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DOSE_ERA cdmTable
 WHERE cdmTable.DOSE_ERA_START_DATE IS NOT NULL 
 AND cdmTable.DOSE_ERA_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the DRUG_ERA_START_DATE field of the DRUG_ERA that occurs after the date in the DRUG_ERA_END_DATE.' as check_description
 ,'DRUG_ERA' as cdm_table_name
 ,'DRUG_ERA_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_drug_era_drug_era_start_date' as checkid
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
 WHERE cdmTable.DRUG_ERA_START_DATE IS NOT NULL 
 AND cdmTable.DRUG_ERA_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_ERA cdmTable
 WHERE cdmTable.DRUG_ERA_START_DATE IS NOT NULL 
 AND cdmTable.DRUG_ERA_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the DRUG_EXPOSURE_START_DATE field of the DRUG_EXPOSURE that occurs after the date in the DRUG_EXPOSURE_END_DATE.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_drug_exposure_drug_exposure_start_date' as checkid
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
 WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NOT NULL 
 AND cdmTable.DRUG_EXPOSURE_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_EXPOSURE_START_DATE IS NOT NULL 
 AND cdmTable.DRUG_EXPOSURE_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the DRUG_EXPOSURE_START_DATETIME field of the DRUG_EXPOSURE that occurs after the date in the DRUG_EXPOSURE_END_DATETIME.' as check_description
 ,'DRUG_EXPOSURE' as cdm_table_name
 ,'DRUG_EXPOSURE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_drug_exposure_drug_exposure_start_datetime' as checkid
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
 WHERE cdmTable.DRUG_EXPOSURE_START_DATETIME IS NOT NULL 
 AND cdmTable.DRUG_EXPOSURE_END_DATETIME IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_EXPOSURE_START_DATETIME IS NOT NULL 
 AND cdmTable.DRUG_EXPOSURE_END_DATETIME IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the VALID_START_DATE field of the DRUG_STRENGTH that occurs after the date in the VALID_END_DATE.' as check_description
 ,'DRUG_STRENGTH' as cdm_table_name
 ,'VALID_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_drug_strength_valid_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,0 as threshold_value
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
 'DRUG_STRENGTH.VALID_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.DRUG_STRENGTH cdmTable
 WHERE cdmTable.VALID_START_DATE IS NOT NULL 
 AND cdmTable.VALID_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VALID_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VALID_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VALID_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VALID_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VALID_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VALID_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.DRUG_STRENGTH cdmTable
 WHERE cdmTable.VALID_START_DATE IS NOT NULL 
 AND cdmTable.VALID_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the EPISODE_START_DATE field of the EPISODE that occurs after the date in the EPISODE_END_DATE.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_episode_episode_start_date' as checkid
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
 WHERE cdmTable.EPISODE_START_DATE IS NOT NULL 
 AND cdmTable.EPISODE_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.EPISODE cdmTable
 WHERE cdmTable.EPISODE_START_DATE IS NOT NULL 
 AND cdmTable.EPISODE_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the EPISODE_START_DATETIME field of the EPISODE that occurs after the date in the EPISODE_END_DATETIME.' as check_description
 ,'EPISODE' as cdm_table_name
 ,'EPISODE_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_episode_episode_start_datetime' as checkid
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
 WHERE cdmTable.EPISODE_START_DATETIME IS NOT NULL 
 AND cdmTable.EPISODE_END_DATETIME IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.EPISODE cdmTable
 WHERE cdmTable.EPISODE_START_DATETIME IS NOT NULL 
 AND cdmTable.EPISODE_END_DATETIME IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the OBSERVATION_PERIOD_START_DATE field of the OBSERVATION_PERIOD that occurs after the date in the OBSERVATION_PERIOD_END_DATE.' as check_description
 ,'OBSERVATION_PERIOD' as cdm_table_name
 ,'OBSERVATION_PERIOD_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_observation_period_observation_period_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,0 as threshold_value
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
 WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NOT NULL 
 AND cdmTable.OBSERVATION_PERIOD_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.OBSERVATION_PERIOD cdmTable
 WHERE cdmTable.OBSERVATION_PERIOD_START_DATE IS NOT NULL 
 AND cdmTable.OBSERVATION_PERIOD_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the PAYER_PLAN_PERIOD_START_DATE field of the PAYER_PLAN_PERIOD that occurs after the date in the PAYER_PLAN_PERIOD_END_DATE.' as check_description
 ,'PAYER_PLAN_PERIOD' as cdm_table_name
 ,'PAYER_PLAN_PERIOD_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_payer_plan_period_payer_plan_period_start_date' as checkid
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
 FROM _exponent.omop_epic.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NOT NULL 
 AND cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.PAYER_PLAN_PERIOD_START_DATE IS NOT NULL 
 AND cdmTable.PAYER_PLAN_PERIOD_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the PROCEDURE_DATE field of the PROCEDURE_OCCURRENCE that occurs after the date in the PROCEDURE_END_DATE.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_procedure_occurrence_procedure_date' as checkid
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
 WHERE cdmTable.PROCEDURE_DATE IS NOT NULL 
 AND cdmTable.PROCEDURE_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_DATE IS NOT NULL 
 AND cdmTable.PROCEDURE_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the PROCEDURE_DATETIME field of the PROCEDURE_OCCURRENCE that occurs after the date in the PROCEDURE_END_DATETIME.' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_procedure_occurrence_procedure_datetime' as checkid
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
 WHERE cdmTable.PROCEDURE_DATETIME IS NOT NULL 
 AND cdmTable.PROCEDURE_END_DATETIME IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_DATETIME IS NOT NULL 
 AND cdmTable.PROCEDURE_END_DATETIME IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the VALID_START_DATE field of the SOURCE_TO_CONCEPT_MAP that occurs after the date in the VALID_END_DATE.' as check_description
 ,'SOURCE_TO_CONCEPT_MAP' as cdm_table_name
 ,'VALID_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_source_to_concept_map_valid_start_date' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 0 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 0 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,0 as threshold_value
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
 'SOURCE_TO_CONCEPT_MAP.VALID_START_DATE' AS violating_field, 
 cdmTable.*
 FROM _exponent.omop_epic.SOURCE_TO_CONCEPT_MAP cdmTable
 WHERE cdmTable.VALID_START_DATE IS NOT NULL 
 AND cdmTable.VALID_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VALID_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VALID_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VALID_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VALID_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VALID_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VALID_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.SOURCE_TO_CONCEPT_MAP cdmTable
 WHERE cdmTable.VALID_START_DATE IS NOT NULL 
 AND cdmTable.VALID_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the VISIT_DETAIL_START_DATE field of the VISIT_DETAIL that occurs after the date in the VISIT_DETAIL_END_DATE.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_visit_detail_visit_detail_start_date' as checkid
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
 WHERE cdmTable.VISIT_DETAIL_START_DATE IS NOT NULL 
 AND cdmTable.VISIT_DETAIL_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 WHERE cdmTable.VISIT_DETAIL_START_DATE IS NOT NULL 
 AND cdmTable.VISIT_DETAIL_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the VISIT_DETAIL_START_DATETIME field of the VISIT_DETAIL that occurs after the date in the VISIT_DETAIL_END_DATETIME.' as check_description
 ,'VISIT_DETAIL' as cdm_table_name
 ,'VISIT_DETAIL_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_visit_detail_visit_detail_start_datetime' as checkid
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
 WHERE cdmTable.VISIT_DETAIL_START_DATETIME IS NOT NULL 
 AND cdmTable.VISIT_DETAIL_END_DATETIME IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_DETAIL cdmTable
 WHERE cdmTable.VISIT_DETAIL_START_DATETIME IS NOT NULL 
 AND cdmTable.VISIT_DETAIL_END_DATETIME IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the VISIT_START_DATE field of the VISIT_OCCURRENCE that occurs after the date in the VISIT_END_DATE.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_START_DATE' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_visit_occurrence_visit_start_date' as checkid
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
 WHERE cdmTable.VISIT_START_DATE IS NOT NULL 
 AND cdmTable.VISIT_END_DATE IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_START_DATE IS NOT NULL 
 AND cdmTable.VISIT_END_DATE IS NOT NULL
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
 ,'plausibleStartBeforeEnd' as check_name
 ,'FIELD' as check_level
 ,'The number and percent of records with a value in the VISIT_START_DATETIME field of the VISIT_OCCURRENCE that occurs after the date in the VISIT_END_DATETIME.' as check_description
 ,'VISIT_OCCURRENCE' as cdm_table_name
 ,'VISIT_START_DATETIME' as cdm_field_name
 ,'NA' as concept_id
 ,'NA' as unit_concept_id
 ,'field_plausible_start_before_end.sql' as sql_file
 ,'Plausibility' as category
 ,'Temporal' as subcategory
 ,'Verification' as context
 ,'' as warning
 ,'' as error
 ,'field_plausiblestartbeforeend_visit_occurrence_visit_start_datetime' as checkid
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
 WHERE cdmTable.VISIT_START_DATETIME IS NOT NULL 
 AND cdmTable.VISIT_END_DATETIME IS NOT NULL 
 AND IF(IF(IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)))) > IF(IF(IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE))) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME AS STRING), 'yyyyMMdd'), IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE))))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_epic.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_START_DATETIME IS NOT NULL 
 AND cdmTable.VISIT_END_DATETIME IS NOT NULL
) denominator
) cte
)
INSERT INTO northwell_dev.omop_epic_quality.dqdashboard_results
SELECT *
FROM cte_all;
