# SCM `_bronze_srgry_dmart` Exploration Results Template

Use this template to summarize DBX outputs from `docs/scm_bronze_srgry_dmart_exploration.sql`.

## 1) Candidate source inventory

- **Drug-like tables (top 2-3):**
  - `<table_name>`: key cols `<...>`, code cols `<...>`, date cols `<...>`
  - `<table_name>`: key cols `<...>`, code cols `<...>`, date cols `<...>`
- **Condition-like tables (top 1-2):**
  - `<table_name>`: key cols `<...>`, code cols `<...>`, date cols `<...>`
- **Episode/event-like tables (top 1-2):**
  - `<table_name>`: key cols `<...>`, episode cols `<...>`, date cols `<...>`

## 2) Domain readiness metrics

### Drug (`drug_exposure`)
- Candidate table: `<table_name>`
- Row count: `<...>`
- Null person key %: `<...>`
- Null/blank drug code %: `<...>`
- Null event date %: `<...>`
- Code system hints found (NDC/RxNorm/etc): `<...>`
- Status fields available: `<...>`
- Visit/encounter link field: `<...>`

### Condition (`condition_occurrence` / `condition_era`)
- Candidate table: `<table_name>`
- Row count: `<...>`
- Null person key %: `<...>`
- Null/blank condition code %: `<...>`
- Null condition date %: `<...>`
- Coding hints found (ICD/SNOMED/etc): `<...>`
- Repeatability profile summary for era derivation: `<...>`

### Episode (`episode` / `episode_event`)
- Candidate table: `<table_name>`
- Row count: `<...>`
- Null episode ID %: `<...>`
- Null start/end date %: `<...>`
- Start-after-end count: `<...>`
- Event link field quality: `<...>`

## 3) OMOP fitness scoring

Score each dimension 0-3.

| candidate_table | target_domain | key_completeness | temporal_completeness | code_system_compatibility | cross_domain_joinability | total_score | decision |
|---|---|---:|---:|---:|---:|---:|---|
| `<table_name>` | drug_exposure | `<0-3>` | `<0-3>` | `<0-3>` | `<0-3>` | `<0-12>` | primary/fallback/reject |
| `<table_name>` | condition | `<0-3>` | `<0-3>` | `<0-3>` | `<0-3>` | `<0-12>` | primary/fallback/reject |
| `<table_name>` | episode | `<0-3>` | `<0-3>` | `<0-3>` | `<0-3>` | `<0-12>` | primary/fallback/reject |

## 4) Recommended mapping path

- **Primary `drug_exposure` source:** `<table_name>`
- **Fallback `drug_exposure` source:** `<table_name or N/A>`
- **Primary `condition_occurrence` source:** `<table_name>`
- **Primary `episode` source:** `<table_name>`
- **Primary `episode_event` linkage basis:** `<field + join rule>`

## 5) Remaining client asks/blockers

- Missing source element: `<...>`
- Why still needed: `<...>`
- Affected OMOP targets: `<...>`
