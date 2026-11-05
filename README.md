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

The 41 tests in `test/` were migrated from Smart Forms source revision
`3073a6addbb0b108d511d7c79b351f9c1a789dfd`. They cover calculations, conditional behaviour and 17
population scenarios and require the exact `@aehrc/questionnaire-test-toolkit@0.1.1` release; no
Smart Forms source checkout or library builds are required. The renderer and SDC operation versions are pinned
for reproducibility and should be updated deliberately with the lockfile and a complete suite run.

Installation and SUSHI's initial FHIR package downloads require network access. Test execution
also requires network access: the questionnaire's `choice` items resolve their external
`answerValueSet`s against the public Ontoserver at `https://r4.ontoserver.csiro.au/fhir`. The
suite uses the real browser entry point of `fhirclient` (configured in `vitest.config.ts`); there
are no vendored expansions, terminology mocks or network guards. When the terminology server is
unreachable, the renderer can still render the form, but externally backed choices have no options
and the terminology-dependent tests fail.

Patient, practitioner, PractitionerRole, Location and clinical FHIR responses are supplied through
ordered toolkit request definitions. Specific searches must remain before broader matches because
the first match wins. These mocked responses demonstrate Questionnaire population against supplied
data; they do not test a clinical server's search behaviour, persistence or SMART launch. Tests run
one file at a time with the Sydney timezone; the clock is not frozen. The completed-plan fixture is
derived relative to execution time so it stays inside the form's 12-month Review window.

Population coverage includes patient details and addresses, practitioner details, conditions,
allergies, medications, vital signs, smoking and alcohol status, and one recent completed-plan plus
existing-draft path. The plan case does not cover every selection branch. The migration otherwise
preserves the original assertions and their limitations: some helpers use `fireEvent`, which can
change disabled/read-only fields; some positive conditional cases only exercise helpers; and
negative checks wait for lookup failure. This is focused regression coverage, not complete clinical,
FHIR server or form conformance testing. The workflow in
`.github/workflows/questionnaire-tests.yml` runs generation, typechecking and all tests on pushes
and pull requests.
