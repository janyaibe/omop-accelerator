# Databricks notebook source
# =============================================================================
# SCM → OMOP CONDITION MAPPING PIPELINE
# =============================================================================
# First-pass SCM condition mapping workflow sourced from Sunrise document text.
#
# Why this exists:
# - `dbo_cv3clientdocdetail_bkp` exposes diagnosis-like columns, but they are
#   null in the current SCM environment.
# - `dbo_sxacdclientdocdetailtextcur` contains the linked clinical narrative as
#   base64-encoded RTF, which can be decoded and mined for condition phrases.
# - This script mirrors the SCM observation / measurement mapping workflow by
#   producing snapshot, distinct mapping, row-level mapping, review, and final
#   output tables in `_exponent.results_store`.
# =============================================================================

# COMMAND ----------

import base64
import re
from datetime import datetime

import pyspark.sql.functions as F
from pyspark.sql import Window
from pyspark.sql.types import (
    ArrayType,
    DoubleType,
    IntegerType,
    StringType,
    StructField,
    StructType,
)

# --- Source tables ---
SOURCE_TEXT_TABLE = "_exponent._bronze_allscripts_scm_prod_01.dbo_sxacdclientdocdetailtextcur"
SOURCE_DETAIL_TABLE = "_exponent._bronze_allscripts_scm_prod_01.dbo_cv3clientdocdetail_bkp"
SOURCE_DOCUMENT_TABLE = "_exponent._bronze_allscripts_scm_prod_01.dbo_cv3clientdocumentcur"
SOURCE_DOC_DIM_TABLE = "_exponent._bronze_allscripts_scm.dbo_scadocumentdim"

# --- OMOP concepts ---
OMOP_TABLE = "_exponent.omop.concept"

# --- Output tables ---
SOURCE_SNAPSHOT_TABLE = "_exponent.results_store.omop_mapping_scm_condition_source_snapshot_v1"
DISTINCT_RESULTS_TABLE = "_exponent.results_store.omop_mapping_scm_condition_distinct_results_v1"
FINAL_ROW_RESULTS_TABLE = "_exponent.results_store.omop_mapping_scm_condition_row_results_v1"
REVIEW_TABLE = "_exponent.results_store.omop_mapping_scm_condition_review_v1"
FINAL_OUTPUT_TABLE = "_exponent.results_store.omop_mapping_scm_condition_final_output_v1"

# --- Config ---
AUTO_MATCH_THRESHOLD = 0.92
REVIEW_THRESHOLD = 0.65
MIN_TOKEN_LEN = 3
MAX_EXTRACTED_PHRASE_LEN = 180

RUN_ID = f"SCM_OMOP_CONDITION_{datetime.utcnow().strftime('%Y%m%d_%H%M%S')}"
RUN_TIMESTAMP = datetime.utcnow().isoformat(timespec="seconds")

RESULT_SCHEMA = StructType(
    [
        StructField("run_id", StringType(), True),
        StructField("source_value_clean", StringType(), True),
        StructField("source_value", StringType(), True),
        StructField("expanded_source_value", StringType(), True),
        StructField("candidate_count", IntegerType(), True),
        StructField("best_concept_id", StringType(), True),
        StructField("best_concept_name", StringType(), True),
        StructField("best_domain_id", StringType(), True),
        StructField("match_status", StringType(), True),
        StructField("final_status", StringType(), True),
        StructField("confidence", DoubleType(), True),
        StructField("reason", StringType(), True),
        StructField("domain_hint", StringType(), True),
        StructField("mapping_method", StringType(), True),
    ]
)

print(f"Run ID   : {RUN_ID}")
print(f"Timestamp: {RUN_TIMESTAMP}")
print("SCM condition mapping constants loaded.")

# COMMAND ----------

# =============================================================================
# Helper functions
# =============================================================================

DOC_INCLUDE_PATTERN = re.compile(
    r"(h&p|history|patient profile|assessment|plan of care|consult|problem|diagn)",
    re.IGNORECASE,
)
DOC_EXCLUDE_PATTERN = re.compile(
    r"(vital signs|intake & output|vent|flowsheet|education outcome|goal outcome|critical value)",
    re.IGNORECASE,
)

SECTION_PATTERNS = [
    re.compile(r"problems?/complications?\s*:\s*([^\n\r]{3,300})", re.IGNORECASE),
    re.compile(r"complications?\s*:\s*([^\n\r]{3,300})", re.IGNORECASE),
    re.compile(r"condition\s*:\s*([^\n\r]{3,120})", re.IGNORECASE),
    re.compile(r"reason for (?:infant'?s )?admission\s*:\s*([^\n\r]{3,240})", re.IGNORECASE),
    re.compile(r"assessment(?: and plan)?\s*:\s*([^\n\r]{3,360})", re.IGNORECASE),
]

GENERIC_REJECT_PATTERN = re.compile(
    r"^(stable|fair|normal|yes|no|npo|none|male|female|live born|good|poor|regular|intact)$",
    re.IGNORECASE,
)

CONDITION_HINT_PATTERN = re.compile(
    r"(distress|syndrome|labor|gestation|pregnan|prematur|preterm|respiratory|sepsis|"
    r"asthma|diabetes|hypertension|obesity|hypothyroid|anxiety|depression|gbs|"
    r"pneumonia|apnea|infection|fistula|entanglement|multiple gestation)",
    re.IGNORECASE,
)


def _decode_base64_rtf(value):
    """Decode base64-wrapped RTF from Spark BINARY / Python bytes-like types.

    PySpark passes BINARY columns to Python UDFs as ``bytearray``; treating that
    as ``str(value)`` breaks base64 decoding. Accept bytes, bytearray, memoryview,
    and unicode strings.
    """
    if value is None:
        return None

    try:
        if isinstance(value, (bytes, bytearray, memoryview)):
            blob = bytes(value)
            # Most rows store ASCII base64; ``b64decode`` accepts bytes directly.
            decoded_bytes = base64.b64decode(blob, validate=False)
        else:
            raw_value = str(value).strip()
            decoded_bytes = base64.b64decode(raw_value, validate=False)

        decoded = decoded_bytes.decode("utf-8", "ignore")
    except Exception:
        return None

    # Convert RTF paragraph markers to newlines before stripping control words.
    text = decoded.replace("\\par", "\n")
    text = re.sub(r"\\'[0-9a-fA-F]{2}", " ", text)
    text = re.sub(r"\\[a-zA-Z]+-?\d*\s?", " ", text)
    text = text.replace("{", " ").replace("}", " ")
    # Preserve line breaks so section headers like "Assessment:" stay matchable.
    text = re.sub(r"[^\S\n]+", " ", text)
    text = re.sub(r"[ \t]*\n[ \t]*", "\n", text)
    return text.strip() or None


def _extract_condition_phrases(decoded_text, patcare_doc_name, document_name):
    if not decoded_text:
        return []

    source_label = " ".join(
        [
            patcare_doc_name or "",
            document_name or "",
        ]
    ).strip()

    if source_label:
        if not DOC_INCLUDE_PATTERN.search(source_label):
            return []
        if DOC_EXCLUDE_PATTERN.search(source_label):
            return []

    working_text = decoded_text.replace(";", "\n")
    phrases = []

    for pattern in SECTION_PATTERNS:
        for match in pattern.finditer(working_text):
            phrases.append(match.group(1))

    extracted = []
    seen = set()

    for raw_phrase in phrases:
        # Split broad sections into smaller candidate phrases.
        parts = re.split(r"[;,]|\band\b", raw_phrase)
        for part in parts:
            cleaned = re.sub(r"\s+", " ", part).strip(" .:-")
            if not cleaned:
                continue
            if len(cleaned) < MIN_TOKEN_LEN or len(cleaned) > MAX_EXTRACTED_PHRASE_LEN:
                continue
            if GENERIC_REJECT_PATTERN.match(cleaned):
                continue

            # Prefer phrases that contain an obvious condition-like cue or
            # contain multiple alphabetic tokens.
            alpha_tokens = re.findall(r"[A-Za-z]{3,}", cleaned)
            if not CONDITION_HINT_PATTERN.search(cleaned) and len(alpha_tokens) < 2:
                continue

            key = cleaned.lower()
            if key not in seen:
                seen.add(key)
                extracted.append(cleaned)

    return extracted


decode_base64_rtf_udf = F.udf(_decode_base64_rtf, StringType())
extract_condition_phrases_udf = F.udf(_extract_condition_phrases, ArrayType(StringType()))

# COMMAND ----------

# =============================================================================
# Reset output tables
# =============================================================================
for tbl in [
    SOURCE_SNAPSHOT_TABLE,
    DISTINCT_RESULTS_TABLE,
    FINAL_ROW_RESULTS_TABLE,
    REVIEW_TABLE,
    FINAL_OUTPUT_TABLE,
]:
    spark.sql(f"DROP TABLE IF EXISTS {tbl}")
    print(f"  Dropped {tbl}")
print("All output tables dropped.")

# COMMAND ----------

# =============================================================================
# Load, join, decode, and extract source phrases
# =============================================================================
df_source_joined = (
    spark.table(SOURCE_TEXT_TABLE).alias("txt")
    .join(
        spark.table(SOURCE_DETAIL_TABLE).alias("detail"),
        F.col("txt.ClientDocDetailGUID") == F.col("detail.GUID"),
        "inner",
    )
    .join(
        spark.table(SOURCE_DOCUMENT_TABLE).alias("doc"),
        F.col("detail.ClientDocumentGUID") == F.col("doc.GUID"),
        "left",
    )
    .join(
        spark.table(SOURCE_DOC_DIM_TABLE).alias("dim"),
        F.col("doc.PatCareDocGUID").cast("string") == F.col("dim.PatCareDocGUID").cast("string"),
        "left",
    )
    .select(
        F.col("detail.GUID").cast("string").alias("detail_guid"),
        F.col("detail.ClientDocumentGUID").cast("string").alias("client_document_guid"),
        F.col("detail.ClientGUID").cast("string").alias("client_guid"),
        F.col("doc.ClientVisitGUID").cast("string").alias("client_visit_guid"),
        F.col("doc.AuthoredDtm").alias("authored_dtm"),
        F.col("doc.DocumentName").alias("document_name"),
        F.col("dim.PatCareDocName").alias("patcare_doc_name"),
        F.col("txt.CreatedWhen").alias("detail_created_when"),
        F.col("txt.DetailText").alias("detail_text_b64"),
    )
)

# Quick decode sanity check (first few non-null DetailText rows).
_preview_rows = (
    df_source_joined.filter(F.col("detail_text_b64").isNotNull())
    .select(decode_base64_rtf_udf(F.col("detail_text_b64")).alias("preview_decoded"))
    .limit(5)
    .collect()
)
print("Decode preview (first non-null DetailText rows, truncated):")
for i, prow in enumerate(_preview_rows):
    ptxt = prow["preview_decoded"]
    if ptxt:
        snippet = ptxt[:480] + "…" if len(ptxt) > 480 else ptxt
        print(f"  [{i}] len={len(ptxt)} preview={snippet!r}")
    else:
        print(f"  [{i}] decoded=None (still failing — check column type / payload)")

df_source_decoded = (
    df_source_joined
    .withColumn("detail_text_decoded", decode_base64_rtf_udf(F.col("detail_text_b64")))
    .filter(F.col("detail_text_decoded").isNotNull())
    .withColumn(
        "source_phrases",
        extract_condition_phrases_udf(
            F.col("detail_text_decoded"),
            F.col("patcare_doc_name"),
            F.col("document_name"),
        ),
    )
    .filter(F.size(F.col("source_phrases")) > 0)
    .withColumn("source_value", F.explode(F.col("source_phrases")))
    .withColumn("source_value_clean", F.lower(F.trim(F.col("source_value"))))
    .withColumn("source_id", F.sha2(F.concat_ws("||", F.col("detail_guid"), F.col("source_value_clean")), 256))
    .withColumn("domain_hint", F.lit("Condition"))
    .dropDuplicates(["source_id"])
)

(
    df_source_decoded.write.mode("overwrite")
    .option("overwriteSchema", "true")
    .saveAsTable(SOURCE_SNAPSHOT_TABLE)
)

df_source = spark.table(SOURCE_SNAPSHOT_TABLE)

source_rows = df_source.count()
distinct_phrases = df_source.select("source_value_clean").distinct().count()

print(f"SCM condition source rows extracted: {source_rows:,}")
print(f"Distinct extracted source phrases   : {distinct_phrases:,}")
print(f"Source snapshot saved → {SOURCE_SNAPSHOT_TABLE}")
display(df_source.limit(20))

# COMMAND ----------

# =============================================================================
# Load and filter OMOP Condition concepts
# =============================================================================
df_omop = (
    spark.table(OMOP_TABLE)
    .filter("standard_concept = 'S' AND invalid_reason IS NULL AND domain_id = 'Condition'")
    .select("concept_id", "concept_name", "domain_id", "vocabulary_id", "concept_class_id")
    .filter(F.col("concept_name").isNotNull())
    .withColumn("concept_name_lower", F.lower(F.trim(F.col("concept_name"))))
)

omop_count = df_omop.count()
print(f"OMOP standard valid Condition concepts: {omop_count:,}")
display(df_omop.limit(20))

# COMMAND ----------

# =============================================================================
# Tokenize and build candidate pairs in Spark
# =============================================================================
STOPWORDS = [
    "the", "and", "for", "with", "without", "from", "that", "this", "were",
    "been", "into", "onto", "baby", "adult", "nicu", "note", "plan", "care",
    "patient", "record", "profile", "status", "stable", "fair", "normal",
]
STOPWORDS_DF = spark.createDataFrame([(w,) for w in STOPWORDS], ["token"])

df_distinct = (
    df_source.groupBy("source_value_clean")
    .agg(
        F.first("source_value").alias("source_value"),
        F.first("document_name").alias("document_name"),
        F.first("patcare_doc_name").alias("patcare_doc_name"),
        F.first("domain_hint").alias("domain_hint"),
    )
    .withColumn("expanded_source_value", F.col("source_value"))
)

df_source_tokens = (
    df_distinct
    .withColumn(
        "token",
        F.explode(
            F.split(
                F.regexp_replace(F.col("source_value_clean"), r"[^a-z0-9]+", " "),
                r"\s+",
            )
        ),
    )
    .filter(F.length(F.col("token")) >= MIN_TOKEN_LEN)
    .join(STOPWORDS_DF, on="token", how="left_anti")
)

df_source_token_counts = (
    df_source_tokens.groupBy("source_value_clean")
    .agg(F.countDistinct("token").alias("src_token_count"))
)

df_omop_tokens = (
    df_omop
    .withColumn(
        "token",
        F.explode(
            F.split(
                F.regexp_replace(F.col("concept_name_lower"), r"[^a-z0-9]+", " "),
                r"\s+",
            )
        ),
    )
    .filter(F.length(F.col("token")) >= MIN_TOKEN_LEN)
    .join(STOPWORDS_DF, on="token", how="left_anti")
)

df_omop_token_counts = (
    df_omop_tokens.groupBy("concept_id")
    .agg(F.countDistinct("token").alias("concept_token_count"))
)

df_candidate_pairs = (
    df_source_tokens.alias("src")
    .join(df_omop_tokens.alias("omop"), on="token", how="inner")
    .groupBy(
        F.col("src.source_value_clean"),
        F.col("src.source_value"),
        F.col("src.expanded_source_value"),
        F.col("src.domain_hint"),
        F.col("omop.concept_id"),
        F.col("omop.concept_name"),
        F.col("omop.domain_id"),
        F.col("omop.vocabulary_id"),
        F.col("omop.concept_class_id"),
        F.col("omop.concept_name_lower"),
    )
    .agg(F.countDistinct("token").alias("matched_token_count"))
    .join(df_source_token_counts, on="source_value_clean", how="left")
    .join(df_omop_token_counts, on="concept_id", how="left")
    .withColumn(
        "token_overlap",
        F.col("matched_token_count") / F.col("src_token_count"),
    )
    .withColumn(
        "concept_overlap",
        F.col("matched_token_count") / F.col("concept_token_count"),
    )
    .withColumn(
        "contains_bonus",
        F.when(F.col("concept_name_lower") == F.col("source_value_clean"), F.lit(0.35))
        .when(F.col("concept_name_lower").contains(F.col("source_value_clean")), F.lit(0.18))
        .when(F.col("source_value_clean").contains(F.col("concept_name_lower")), F.lit(0.12))
        .otherwise(F.lit(0.0)),
    )
    .withColumn(
        "confidence",
        F.least(
            F.lit(1.0),
            F.greatest(F.col("token_overlap"), F.col("concept_overlap") * F.lit(0.65)) + F.col("contains_bonus"),
        ),
    )
)

candidate_count = df_candidate_pairs.count()
print(f"Candidate source/concept pairs built: {candidate_count:,}")
display(
    df_candidate_pairs.orderBy(F.desc("confidence"), F.desc("matched_token_count")).limit(20)
)

# COMMAND ----------

# =============================================================================
# Choose best concept per distinct extracted phrase
# =============================================================================
window_best = Window.partitionBy("source_value_clean").orderBy(
    F.desc("confidence"),
    F.desc("matched_token_count"),
    F.asc("concept_token_count"),
    F.asc("concept_id"),
)

df_ranked = (
    df_candidate_pairs
    .withColumn("candidate_count", F.count("*").over(Window.partitionBy("source_value_clean")))
    .withColumn("rn", F.row_number().over(window_best))
)

df_best = (
    df_ranked.filter(F.col("rn") == 1)
    .withColumn(
        "match_status",
        F.when(F.col("confidence") >= F.lit(AUTO_MATCH_THRESHOLD), F.lit("AUTO_MATCH"))
        .when(F.col("confidence") >= F.lit(REVIEW_THRESHOLD), F.lit("REVIEW_REQUIRED"))
        .otherwise(F.lit("NO_MATCH")),
    )
    .withColumn("final_status", F.col("match_status"))
    .withColumn(
        "reason",
        F.when(F.col("final_status") == "AUTO_MATCH", F.lit("High-confidence concept match from decoded SCM note text"))
        .when(F.col("final_status") == "REVIEW_REQUIRED", F.lit("Moderate-confidence concept candidate from decoded SCM note text"))
        .otherwise(F.lit("Low-confidence match; review or alternate structured source needed"))
    )
    .withColumn("mapping_method", F.lit("TEXT_EXTRACTION_TOKEN_MATCH"))
    .select(
        F.lit(RUN_ID).alias("run_id"),
        "source_value_clean",
        "source_value",
        "expanded_source_value",
        "candidate_count",
        F.col("concept_id").cast("string").alias("best_concept_id"),
        F.col("concept_name").alias("best_concept_name"),
        F.col("domain_id").alias("best_domain_id"),
        "match_status",
        "final_status",
        F.round(F.col("confidence"), 4).alias("confidence"),
        "reason",
        "domain_hint",
        "mapping_method",
    )
)

df_no_match = (
    df_distinct.alias("src")
    .join(df_best.select("source_value_clean"), on="source_value_clean", how="left_anti")
    .select(
        F.lit(RUN_ID).alias("run_id"),
        F.col("source_value_clean"),
        F.col("source_value"),
        F.col("expanded_source_value"),
        F.lit(0).alias("candidate_count"),
        F.lit(None).cast(StringType()).alias("best_concept_id"),
        F.lit(None).cast(StringType()).alias("best_concept_name"),
        F.lit(None).cast(StringType()).alias("best_domain_id"),
        F.lit("NO_MATCH").alias("match_status"),
        F.lit("NO_MATCH").alias("final_status"),
        F.lit(0.0).alias("confidence"),
        F.lit("No OMOP Condition candidate passed the token match thresholds").alias("reason"),
        F.col("domain_hint"),
        F.lit("TEXT_EXTRACTION_TOKEN_MATCH").alias("mapping_method"),
    )
)

df_distinct_results = df_best.unionByName(df_no_match)
(
    df_distinct_results.write.mode("overwrite")
    .option("overwriteSchema", "true")
    .saveAsTable(DISTINCT_RESULTS_TABLE)
)

print(f"Saved distinct mapping results → {DISTINCT_RESULTS_TABLE}")
display(spark.table(DISTINCT_RESULTS_TABLE).limit(20))

# COMMAND ----------

# =============================================================================
# Build row-level mapping output
# =============================================================================
df_final = (
    df_source.alias("src")
    .join(
        spark.table(DISTINCT_RESULTS_TABLE).alias("mapped"),
        on="source_value_clean",
        how="left",
    )
    .select(
        F.col("src.source_id"),
        F.col("src.detail_guid"),
        F.col("src.client_document_guid"),
        F.col("src.client_guid"),
        F.col("src.client_visit_guid"),
        F.col("src.authored_dtm"),
        F.col("src.document_name"),
        F.col("src.patcare_doc_name"),
        F.col("src.detail_created_when"),
        F.col("src.source_value"),
        F.col("src.detail_text_decoded"),
        F.col("mapped.best_concept_id").cast("int").alias("omop_concept_id"),
        F.col("mapped.best_concept_name").alias("omop_concept_name"),
        F.col("mapped.best_domain_id").alias("omop_domain_id"),
        F.col("mapped.final_status"),
        F.col("mapped.confidence"),
        F.col("mapped.reason"),
        F.col("mapped.domain_hint"),
        F.col("mapped.mapping_method"),
        F.lit(RUN_ID).alias("run_id"),
    )
)

df_final.write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(FINAL_ROW_RESULTS_TABLE)
df_review = df_final.filter(F.col("final_status").isin("REVIEW_REQUIRED", "NO_MATCH"))
df_review.write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(REVIEW_TABLE)

df_output = df_final.select(
    "source_id",
    F.col("source_value").alias("source_value"),
    "omop_concept_id",
    "omop_concept_name",
    "omop_domain_id",
    "final_status",
    "confidence",
    "reason",
    "mapping_method",
    "document_name",
    "patcare_doc_name",
    "detail_guid",
    "client_document_guid",
    "client_guid",
    "client_visit_guid",
    "authored_dtm",
)
df_output.write.mode("overwrite").option("overwriteSchema", "true").saveAsTable(FINAL_OUTPUT_TABLE)

print(f"Saved row-level mapping results → {FINAL_ROW_RESULTS_TABLE}")
print(f"Saved review queue             → {REVIEW_TABLE}")
print(f"Saved final output             → {FINAL_OUTPUT_TABLE}")

# COMMAND ----------

# =============================================================================
# Validation summary
# =============================================================================
status_summary = df_final.groupBy("final_status").count().orderBy("final_status")
display(status_summary)

auto_match_count = df_final.filter(F.col("final_status") == "AUTO_MATCH").count()
review_count = df_final.filter(F.col("final_status") == "REVIEW_REQUIRED").count()
no_match_count = df_final.filter(F.col("final_status") == "NO_MATCH").count()

print("Summary")
print("-------")
print(f"Auto matched rows    : {auto_match_count:,}")
print(f"Review required rows : {review_count:,}")
print(f"No match rows        : {no_match_count:,}")
print("")
print("Output tables")
print("-------------")
print(f"  {SOURCE_SNAPSHOT_TABLE}")
print(f"  {DISTINCT_RESULTS_TABLE}")
print(f"  {FINAL_ROW_RESULTS_TABLE}")
print(f"  {REVIEW_TABLE}")
print(f"  {FINAL_OUTPUT_TABLE}")

display(spark.table(FINAL_OUTPUT_TABLE).limit(20))
