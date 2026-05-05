# OMOP Hydration Runbooks

This repository contains execution runbooks for transforming source EHR systems into the OMOP Common Data Model (CDM).

## Systems

- [Epic Clarity](./Epic_Runbook.md)
- [Allscripts](./Allscripts_Runbook.md)

## Allscripts Index

Use the Allscripts runbooks as separate tracks because SCM / Sunrise and TouchWorks hydrate from different source systems and notebooks:

- **Combined Allscripts:** [Allscripts_Runbook.md](./Allscripts_Runbook.md)
- **SCM / Sunrise:** [SCM_Runbook.md](./SCM_Runbook.md)
- **TouchWorks:** [TW_Runbook.md](./TW_Runbook.md)
- **SCM reset handoff:** [SCM_Hydration_Reset_Handoff.md](./SCM_Hydration_Reset_Handoff.md)

## Notes
All runbooks follow a standardized execution framework:
- Identity → Visit → Clinical → Lifecycle
- Shared dependency structure
- Consistent mapping and validation approach
