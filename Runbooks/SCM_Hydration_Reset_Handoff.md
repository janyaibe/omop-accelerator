# SCM / Sunrise — Hydration reset, table clears, and handoff

**Audience:** engineers and client operators re-running the Allscripts SCM → OMOP pipeline in Databricks.  
**Catalog:** this repo and notebooks default to **`_exponent`**. If your workspace uses another catalog, replace accordingly.  
**SCM system key:** Staging and mapping deletes are almost always scoped with:

```sql
WHERE source_system = 'allscripts_scm'
```

**Gold slice:** one CDM table per domain in **`_exponent.omop_scm`**. A full “reset that domain for SCM” is usually **three steps**:

1. **`TRUNCATE TABLE _exponent.omop_scm.<domain_table>`** — removes the entire SCM copy in gold (this schema is the SCM product slice only, not a multi-tenant table).
2. **`DELETE` from `_exponent.omop_silver.<domain_table> WHERE source_system = 'allscripts_scm'`** — removes that source’s rows from the shared silver table.
3. **`DELETE` from `_exponent.omop_mapping.source_to_<domain> ... WHERE source_system = 'allscripts_scm'`** (when the mapping table exists) — so surrogate keys are regenerated consistently on the next run.

If you skip (2) or (3) while re-running, you can get **stale rows**, **double loads**, or **person_id / visit_occurrence_id that no longer line up** with a refreshed `source_to_person` or `source_to_visit_occurrence`.

---

## 1. When to clear what (decision guide)

| Situation | What to reset |
|----------|----------------|
| **Person or identity mapping changed** (`source_to_person`, `person` keys, or dedupe rules) | Gold + silver + mapping for **all domains that use `person_id`**, in practice a **full SCM rebuild** (or at minimum: all clinical + visits + derived + `person` + mapping, in a safe order — see section 3). |
| **Visit keys or `source_to_visit_occurrence` changed** | At least **`visit_occurrence`**, **`visit_detail`**, and every clinical table that stores `visit_occurrence_id` + any derived tables. |
| **One domain was wrong (e.g. only procedures)** | That domain’s **gold + silver (scoped) + `source_to_*` mapping** for `allscripts_scm`, then re-run that notebook and downstream if needed. |
| **Only gold MERGE was fixed (logic change), source rows unchanged** | Sometimes **gold-only** re-merge is enough; if silver still has bad `person_id`, clear **silver + mapping + gold** for that domain. |
| **Eras / episode after clinical fixes** | Re-run / reset **`condition_era`**, **`drug_era`**, **`dose_era`**, **`episode`**, **`episode_event`** as needed after `condition_*` or `drug_exposure` are correct. |

---

## 2. Per-domain reference (where resets live in-repo)

> **Important:** In many notebooks the reset SQL is in a **dedicated first cell** but is left **commented** until you intentionally uncomment it (e.g. person, visit, observation). A few pipelines keep reset **uncommented** (e.g. `device_exposure`, `drug_exposure` Sunrise, `procedure_occurrence` cell). **Always open the listed notebook in Databricks and confirm the current state** before a production run.

| Phase | Domain / table (`omop_scm`) | Primary notebook (under `omop/hydration/`) | Typical reset pattern |
|------|-----------------------------|-------------------------------------------|------------------------|
| 1a | `location` | `location/allscripts_scm_location.ipynb` | `TRUNCATE` gold + `DELETE` silver + `DELETE` `source_to_location` (often **commented** in notebook — uncomment to run) |
| 1b | `care_site` | `care_site/allscripts_scm_care_site.ipynb` | same idea + `source_to_care_site` |
| 1c | `provider` | `provider/allscripts_scm_provider.ipynb` | same + `source_to_provider` |
| 1d | `person` | `person/allscripts_scm_person.ipynb` | `TRUNCATE` `omop_scm.person` + `DELETE` silver + `DELETE` `source_to_person` (cells may be **commented** — verify) |
| 2a | `visit_occurrence` | `visit_occurrence/allscripts_sunrise_visit_occurence.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_visit_occurrence` (**commented** in first cell in-repo) |
| 2b | `visit_detail` | `visit_detail/allscripts_scm_visit_detail.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_visit_detail` (often commented) |
| 3a | `condition_occurrence` | `condition_occurrence/allscripts_scm_condition_occurrence_from_text_mapping.ipynb` (and any other SCM condition path you use) | **No standard reset block in-repo** for the text path — if you must full-reload, apply the same **three-step pattern** manually for `condition_occurrence` / `source_to_condition_occurrence`. |
| 3b | `procedure_occurrence` | `procedure_occurrence/allscripts_scm_procedure_occurrence.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_procedure_occurrence` (active in-repo) |
| 3c | `drug_exposure` | `drug_exposure/allscripts_sunrise_drug_exposure.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_drug_exposure` (active) |
| 3d | `measurement` | `measurement/allscripts_scm_measurement.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_measurement` |
| 3e | `observation` | `observation/allscripts_scm_observation.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_observation` (often commented) |
| 3f | `note` | `note/allscripts_scm_note.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_note` (often commented) |
| 3g | `device_exposure` | `device_exposure/allscripts_scm_device_exposure.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_device_exposure` (active) |
| 4a | `observation_period` | `observation_period/allscripts_sunrise_observation_period.ipynb` | `TRUNCATE` + `DELETE` silver + `DELETE` `source_to_observation_period` (reset block at end, may be **commented**) |
| 4b | `death` | `death/allscripts_scm_death.ipynb` | `TRUNCATE` + `DELETE` silver (often commented) |
| 5a | `condition_era` | `condition_era/allscripts_scm_condition_era.ipynb` | `TRUNCATE` `omop_scm.condition_era` (depends on `condition_occurrence`) |
| 5b | `drug_era` | `drug_era/allscripts_scm_drug_era.ipynb` | `TRUNCATE` `omop_scm.drug_era` (depends on `drug_exposure`) |
| 5c | `dose_era` | `dose_era/allscripts_scm_dose_era.ipynb` | `TRUNCATE` `omop_scm.dose_era` |
| 5d | `episode` / `episode_event` | `episode/allscripts_scm_episode.ipynb` | Truncates **`episode_event` then `episode`** in gold in-repo; re-run `episode_event` notebook after, per notebook notes. |
| 5e | `episode_event` (standalone) | `episode_event/allscripts_scm_episode_event.ipynb` | `TRUNCATE` `omop_scm.episode_event` (coordinate with `episode` notebook) |
| — | `fact_relationship` | `fact_relationship/allscripts_scm_fact_relationship.ipynb` | `TRUNCATE` gold only, if used |

**Other:** `drug_strength` may be loaded with **overwrite** from `omop/hydration/drug_strength/drug_strength.ipynb` — follow that notebook, not the usual MERGE pattern.

---

## 3. Suggested order for a **full** SCM re-load

Run **after** you have executed the **reset** cells (or manual SQL) for the tables you are rebuilding.

1. **Phase 1 — Identity:** `location` → `care_site` → `provider` → `person` (per [SCM_Runbook.md](SCM_Runbook.md)).
2. **Phase 2 — Visits:** `visit_occurrence` → `visit_detail`.
3. **Phase 3 — Clinical:** e.g. `condition_occurrence` → `procedure_occurrence` → `drug_exposure` → `measurement` → `observation` → `note` → `device_exposure` (exact order can follow your job dependencies; if one domain is independent, keep it after `person` / visits as in the runbook).
4. **Phase 4 —** `observation_period`, `death`.
5. **Phase 5 — Derived:** `condition_era` → `drug_era` / `dose_era` → `episode` (and `episode_event`).

For a **teardown** (clearing tables only), a practical rule is: **clear derived and dependent domains first** (episodes, eras, then clinical facts, then visits, then person and reference tables), to avoid leaving obviously inconsistent gold — though Delta may not enforce FKs. Align with the **reverse** of the load order above if you are scripting a full wipe.

**Tracker baseline** (from [SCM_Runbook.md](SCM_Runbook.md)): after major SCM refreshes, the team has used an order such as: condition → `condition_era` → `episode` → `episode_event` → `observation_period` → `death` → then Ares / DQD.

---

## 4. Handoff checklist (copy/paste for tickets)

- [ ] **Catalog** confirmed (`_exponent` or other).
- [ ] **`source_system = 'allscripts_scm'`** used on all silver and mapping `DELETE` statements (never delete other sources’ rows).
- [ ] For each domain, **gold `TRUNCATE` + silver `DELETE` + mapping `DELETE`** completed or confirmed unnecessary.
- [ ] **Notebook reset cells** reviewed (commented vs active).
- [ ] **Execution order** matches [SCM_Runbook.md](SCM_Runbook.md) phases.
- [ ] **Post-run:** row counts / DQD (or Ares) for the domains touched; note **“population = patients who made it through person”** if identity work is still in progress.
- [ ] **Change log** one-liner: what was truncated, which notebooks were run, and date.

---

## 5. TouchWorks (not SCM)

For **Allscripts TouchWorks** (`_exponent.omop_tw` and `source_system = 'allscripts_tw'`), use the same *ideas* (gold truncate + silver delete scoped + mapping delete) but a **different** notebook set. See [TW_Runbook.md](TW_Runbook.md) and the `allscripts_touchworks_*.ipynb` notebooks. A dedicated “reset per table” addendum for TW can be added the same way if the client also needs that handoff.

---

## 6. Related

- [SCM_Runbook.md](SCM_Runbook.md) — purpose, phase order, and domain dependencies.
- [TW_Runbook.md](TW_Runbook.md) — TouchWorks parallel.
- Pipelines: `omop/hydration/**/allscripts_scm_*.ipynb` and `allscripts_sunrise_*.ipynb` as listed above.
