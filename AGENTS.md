# Project Rules

## Databricks Reset Cells

For every hydration notebook in this repo, split reset logic into DBX-safe cells:

1. One `%sql` cell for `TRUNCATE TABLE ...`
2. One `%sql` cell for `DELETE FROM _exponent.omop_silver...`
3. One `%sql` cell for `DELETE FROM _exponent.omop_mapping...`

Rules:

- Exactly one SQL statement per `%sql` cell.
- Preserve current order: gold truncate, then silver delete, then mapping delete.
- Keep existing `source_system` filters unchanged.
- Do not combine statements with semicolons in one cell.
- Rename reset cell titles if useful: `Reset Gold`, `Reset Silver`, `Reset Mapping`.
- Do not change non-reset logic when applying this rule.
