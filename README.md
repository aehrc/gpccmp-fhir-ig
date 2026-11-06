# GP Chronic Condition Management Plan FHIR Implementation Guide

## Linting the Questionnaire

The Questionnaire's FHIRPath and x-fhir-query expressions are checked with
[sdc-questionnaire-lint](https://aehrc.github.io/sdc-questionnaire-lint/) and its
Smart Forms plugin. With the Node version in `.nvmrc`:

```sh
nvm use
npm ci
npm run lint
```

`npm run lint` deletes `fsh-generated/`, compiles the IG with SUSHI and lints the
compiled Questionnaire. Findings are reported against the FSH source lines in
`input/fsh/`. Locally, the command exits `1` if there are any errors and `2` if the
lint could not run (for example, an invalid config or no compiled Questionnaire).

In CI, the `Questionnaire lint` workflow is report-only: findings appear as
annotations on the run (and on changed lines of a pull request) and in the job
summary, but do not fail the job. Installation, SUSHI compilation and linter setup
failures do fail it.

The Smart Forms plugin checks against the newest Smart Forms versions that the
installed plugin release has verified, which can be older than the version that
renders the form. The job summary and the end of the local output list the versions
used. Upgrading the plugin moves the target; see
[compatibility](https://aehrc.github.io/sdc-questionnaire-lint/docs/plugin-smart-forms/entry-and-compat).

Fix findings in the FSH. If a finding is a false positive, suppress that specific
expression with a reason, as described in the
[suppression guide](https://aehrc.github.io/sdc-questionnaire-lint/docs/suppression).
Linting does not replace behavioural testing of the form or IG Publisher validation.
