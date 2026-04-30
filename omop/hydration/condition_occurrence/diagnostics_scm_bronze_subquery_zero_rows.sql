-- Ad-hoc: troubleshoot zero-row bronze subqueries for SCM conditions.
-- Use the same Databricks catalog / warehouse as `allscripts_sunrise_condition_occurrence`
-- (e.g. Unity Catalog for `_exponent`; wrong default catalog can show empty tables or 0 joined rows).
--
-- Optional: `SELECT current_catalog(), current_schema();` then un-comment counts below.
--
-- -------------------------------------------------------------------------
-- 0) Base table row counts
-- -------------------------------------------------------------------------
-- SELECT count(*) AS n_detail_only FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocdetail_bkp`;
-- SELECT count(*) AS n_doc_only FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocumentcur`;
--
-- -------------------------------------------------------------------------
-- 1) Single-row scoreboard (inner join, coded fields, then full filter stack)
-- -------------------------------------------------------------------------
SELECT
  (SELECT count(*) FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocdetail_bkp`) AS n_detail,
  (SELECT count(*) FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocumentcur`) AS n_doc,
  (SELECT count(*)
   FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocdetail_bkp` d
   INNER JOIN `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocumentcur` doc
     ON d.ClientDocumentGUID = doc.GUID
  ) AS n_inner_join_no_filters,
  (SELECT count(*)
   FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocdetail_bkp` d
   INNER JOIN `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocumentcur` doc
     ON d.ClientDocumentGUID = doc.GUID
   WHERE d.CodingScheme IS NOT NULL
     AND d.CodingSchemeCode IS NOT NULL
     AND TRIM(d.CodingSchemeCode) != ''
     AND d.ClientGUID IS NOT NULL
  ) AS n_after_coded_fields,
  (SELECT count(*)
   FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocdetail_bkp` d
   INNER JOIN `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocumentcur` doc
     ON d.ClientDocumentGUID = doc.GUID
   WHERE d.Active = TRUE
     AND doc.Active = TRUE
     AND doc.IsCanceled = FALSE
     AND d.CodingScheme IS NOT NULL
     AND d.CodingSchemeCode IS NOT NULL
     AND TRIM(d.CodingSchemeCode) != ''
     AND d.ClientGUID IS NOT NULL
     AND COALESCE(doc.AuthoredDtm, doc.ServiceDtmUTC, doc.Entered, d.CreatedWhen) IS NOT NULL
  ) AS n_full_user_where
;

-- -------------------------------------------------------------------------
-- 2) Boolean / flag column shapes (if n_full is 0 but n_after_coded is high)
-- -------------------------------------------------------------------------
-- SELECT
--   sum(CASE WHEN d.Active = true THEN 1 ELSE 0 END) AS n_detail_active_eq_true,
--   sum(CASE WHEN d.Active IN (1, '1', 'true', 'Y', 'T') THEN 1 ELSE 0 END) AS n_detail_active_loose,
--   sum(CASE WHEN d.Active IS NULL THEN 1 ELSE 0 END) AS n_detail_active_null
-- FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocdetail_bkp` d;
--
-- -------------------------------------------------------------------------
-- 3) If n_inner_join_no_filters = 0: orphan details (no parent document row)
-- -------------------------------------------------------------------------
-- SELECT
--   (SELECT count(*)
--    FROM `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocdetail_bkp` d
--    LEFT JOIN `_exponent`.`_bronze_allscripts_scm_prod_01`.`dbo_cv3clientdocumentcur` doc
--      ON d.ClientDocumentGUID = doc.GUID
--    WHERE doc.GUID IS NULL
--   ) AS n_detail_with_no_parent_doc
-- ;
