import { defineConfig } from '@aehrc/sdc-questionnaire-lint';
import smartForms from '@aehrc/sdc-questionnaire-lint-plugin-smart-forms';

export default defineConfig({
  plugins: [smartForms],
  // Lint target verified by plugin 0.1.0, not the newer runtime used by PR #8.
  // Update after aehrc/sdc-questionnaire-lint#7 is resolved in a release.
  compat: { 'smart-forms': { renderer: '1.4.0', populate: '4.7.1' } }
});
