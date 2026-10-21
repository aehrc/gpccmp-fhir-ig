# GP Chronic Condition Management Plan FHIR Implementation Guide

## Questionnaire tests

Use Node.js 24 (`nvm use`) and npm:

```sh
npm ci
npm run typecheck
npm test
```

Both typechecking and testing first run the pinned SUSHI compiler against this repository's FSH.
The generated file `fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json`
is the form under test. Generated files are ignored; a separate Questionnaire snapshot is not
needed. Generation clears previous SUSHI output and stops on compiler errors or missing/invalid
Questionnaire JSON. Java and the IG Publisher are not required for these tests.

To run one file, use `npm test -- test/population.test.tsx`. To generate without running tests,
use `npm run generate`.

The 25 tests in `test/` cover existing calculations, conditional behaviour and patient-age
population in the Smart Forms renderer. They use the published
`@aehrc/questionnaire-test-toolkit@0.1.0`; no Smart Forms source checkout or library builds are
required. The renderer and SDC operation versions are pinned for a reproducible starting point;
update these deliberately together with the lockfile and rerun the suite.

Installation and SUSHI's initial FHIR package downloads require network access. Test execution
runs offline: `fhirclient` is mocked using the three vendored expansions in `test/terminology/`,
and direct `fetch` and XMLHttpRequest calls throw. See
[fixture provenance](test/terminology/PROVENANCE.md) for copyrights, sources and refresh commands.
An unrecognised terminology request currently receives an empty result, so a new terminology
dependency requires a fixture and assertions. Tests run one file at a time with the Sydney
timezone; the clock is not frozen.

This migration preserves the original assertions and their limitations. Some helpers use
`fireEvent`, which can change disabled/read-only fields: the age conditional tests and the
"with a home address" case include such interactions. Some positive cases only exercise helpers,
and negative checks wait for lookup failure. These tests provide limited regression coverage,
not complete conformance or coverage of the form's FHIR queries, constraints, repeats and layout.
Strengthening those assertions and adding integration scenarios are follow-up work. The workflow
in `.github/workflows/questionnaire-tests.yml` runs generation, typechecking and all tests on
pushes and pull requests.

Population currently supplies only patient launch data and empty responses for the form's FHIR
queries. The renderer and population library consequently log unresolved-variable and constraint
diagnostics for missing clinical/practitioner data. These inherited diagnostics remain visible;
passing the age test does not verify those population paths.

