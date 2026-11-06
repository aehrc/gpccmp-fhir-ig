import { defineConfig } from '@aehrc/sdc-questionnaire-lint';
import smartForms from '@aehrc/sdc-questionnaire-lint-plugin-smart-forms';

export default defineConfig({
  plugins: [smartForms]
});
