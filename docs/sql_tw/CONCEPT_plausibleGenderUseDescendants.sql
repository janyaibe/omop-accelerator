WITH cte_all  AS (SELECT cte.num_violated_rows
 ,cte.pct_violated_rows
 ,cte.num_denominator_rows
 , CAST('' as STRING) as execution_time
 ,'' as query_text
 ,'plausibleGenderUseDescendants' as check_name
 ,'CONCEPT' as check_level
 ,'For descendants of CONCEPT_ID 4090861, 4025213 (MALE GENITALIA FINDING, MALE REPRODUCTIVE FINDING), the number and percent of records associated with patients with an implausible gender (correct gender = MALE).' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_CONCEPT_ID' as cdm_field_name
 ,'4090861, 4025213' as concept_id
 ,'NA' as unit_concept_id
 ,'concept_plausible_gender_use_descendants.sql' as sql_file
 ,'Plausibility' as category
 ,'Atemporal' as subcategory
 ,'Validation' as context
 ,'' as warning
 ,'' as error
 ,'concept_plausiblegenderusedescendants_condition_occurrence_condition_concept_id_4090861,4025213' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 2 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 2 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,2 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT cdmTable.* 
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p
 ON cdmTable.person_id = p.person_id
 JOIN _exponent.omop_tw.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.CONDITION_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4090861, 4025213)
 AND p.gender_concept_id <> 8507 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.CONDITION_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4090861, 4025213)
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
 ,'plausibleGenderUseDescendants' as check_name
 ,'CONCEPT' as check_level
 ,'For descendants of CONCEPT_ID 4095793 , 443343, 4024004 , 4172857, 444094 , 197810, 4158481 (FEMALE GENITALIA FINDING, DISORDER OF INTRAUTERINE CONTRACEPTIVE DEVICE, MENOPAUSE FINDING, DISORDER OF FEMALE GENITAL SYSTEM, MALIGNANT NEOPLASM OF UTERINE ADNEXA, FINDING RELATED TO PREGNANCY, FEMALE REPRODUCTIVE FINDING), the number and percent of records associated with patients with an implausible gender (correct gender = FEMALE).' as check_description
 ,'CONDITION_OCCURRENCE' as cdm_table_name
 ,'CONDITION_CONCEPT_ID' as cdm_field_name
 ,'4095793 , 443343, 4024004 , 4172857, 444094 , 197810, 4158481' as concept_id
 ,'NA' as unit_concept_id
 ,'concept_plausible_gender_use_descendants.sql' as sql_file
 ,'Plausibility' as category
 ,'Atemporal' as subcategory
 ,'Validation' as context
 ,'' as warning
 ,'' as error
 ,'concept_plausiblegenderusedescendants_condition_occurrence_condition_concept_id_4095793,443343,4024004,4172857,444094,197810,4158481' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 2 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 2 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,2 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT cdmTable.* 
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p
 ON cdmTable.person_id = p.person_id
 JOIN _exponent.omop_tw.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.CONDITION_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4095793 , 443343, 4024004 , 4172857, 444094 , 197810, 4158481)
 AND p.gender_concept_id <> 8532 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.CONDITION_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.CONDITION_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4095793 , 443343, 4024004 , 4172857, 444094 , 197810, 4158481)
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
 ,'plausibleGenderUseDescendants' as check_name
 ,'CONCEPT' as check_level
 ,'For descendants of CONCEPT_ID 4041261 (PROCEDURE ON FEMALE GENITAL SYSTEM), the number and percent of records associated with patients with an implausible gender (correct gender = FEMALE).' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_CONCEPT_ID' as cdm_field_name
 ,'4041261' as concept_id
 ,'NA' as unit_concept_id
 ,'concept_plausible_gender_use_descendants.sql' as sql_file
 ,'Plausibility' as category
 ,'Atemporal' as subcategory
 ,'Validation' as context
 ,'' as warning
 ,'' as error
 ,'concept_plausiblegenderusedescendants_procedure_occurrence_procedure_concept_id_4041261' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 2 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 2 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,2 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT cdmTable.* 
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p
 ON cdmTable.person_id = p.person_id
 JOIN _exponent.omop_tw.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.PROCEDURE_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4041261)
 AND p.gender_concept_id <> 8532 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.PROCEDURE_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4041261)
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
 ,'plausibleGenderUseDescendants' as check_name
 ,'CONCEPT' as check_level
 ,'For descendants of CONCEPT_ID 4250917, 4077750, 4043199, 4040577 (OPERATION ON PROSTATE, OPERATION ON SCROTUM, PROCEDURE ON PENIS, PROCEDURE ON TESTIS), the number and percent of records associated with patients with an implausible gender (correct gender = MALE).' as check_description
 ,'PROCEDURE_OCCURRENCE' as cdm_table_name
 ,'PROCEDURE_CONCEPT_ID' as cdm_field_name
 ,'4250917, 4077750, 4043199, 4040577' as concept_id
 ,'NA' as unit_concept_id
 ,'concept_plausible_gender_use_descendants.sql' as sql_file
 ,'Plausibility' as category
 ,'Atemporal' as subcategory
 ,'Validation' as context
 ,'' as warning
 ,'' as error
 ,'concept_plausiblegenderusedescendants_procedure_occurrence_procedure_concept_id_4250917,4077750,4043199,4040577' as checkid
 ,0 as is_error
 ,0 as not_applicable
 ,CASE WHEN (cte.pct_violated_rows * 100) > 2 THEN 1 ELSE 0 END as failed
 ,CASE WHEN (cte.pct_violated_rows * 100) <= 2 THEN 1 ELSE 0 END as passed
 ,NULL as not_applicable_reason
 ,2 as threshold_value
 ,NULL as notes_value
FROM (
 SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT cdmTable.* 
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.person p
 ON cdmTable.person_id = p.person_id
 JOIN _exponent.omop_tw.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.PROCEDURE_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4250917, 4077750, 4043199, 4040577)
 AND p.gender_concept_id <> 8507 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM _exponent.omop_tw.PROCEDURE_OCCURRENCE cdmTable
 JOIN _exponent.omop_tw.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.PROCEDURE_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4250917, 4077750, 4043199, 4040577)
) denominator
) cte
)
INSERT INTO northwell_dev.omop_tw_quality.dqdashboard_results
SELECT *
FROM cte_all;
