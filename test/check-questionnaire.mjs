import { readFileSync } from 'node:fs';

const path = 'fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json';

try {
  const questionnaire = JSON.parse(readFileSync(path, 'utf8'));
  if (questionnaire.resourceType !== 'Questionnaire' || !questionnaire.item?.length) {
    throw new Error('Expected a Questionnaire with items');
  }
} catch (error) {
  console.error(`Cannot test the generated Questionnaire at ${path}: ${error.message}`);
  process.exit(1);
}
