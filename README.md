# GP Chronic Condition Management Plan FHIR Implementation Guide

## Linting the Questionnaire

Use the Node.js version specified in `.nvmrc`, then run:

```sh
nvm use
npm ci
npm run lint
```

This compiles the IG with SUSHI and checks the Questionnaire's expressions with
[sdc-questionnaire-lint](https://aehrc.github.io/sdc-questionnaire-lint/) and its
Smart Forms plugin.

CI reports findings as annotations and a job summary. Findings do not fail the
check; installation, compilation and linter setup failures do.
