# OMOP Hydration Runbooks

This repository contains execution runbooks for transforming source EHR systems into the OMOP Common Data Model (CDM).

## Systems

- [Epic Clarity](./epic/epic_runbook.md)
- [Allscripts SCM / Sunrise](./scm/scm_runbook.md)
- [Allscripts TouchWorks](./touchworks/touchworks_runbook.md)

## Notes
All runbooks follow a standardized execution framework:
- Identity → Visit → Clinical → Lifecycle
- Shared dependency structure
- Consistent mapping and validation approach
