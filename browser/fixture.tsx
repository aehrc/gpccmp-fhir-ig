import React from 'react';
import { createRoot } from 'react-dom/client';
import type { Questionnaire } from 'fhir/r4';
import { BehavioralTestWrapper } from '@aehrc/questionnaire-test-toolkit';
import {
  getResponse,
  removeEmptyAnswersFromResponse
} from '@aehrc/smart-forms-renderer';
import generated from '../fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json';
import { gpccmpClinicalAdapter } from '../test/support/gpccmpClinical';
import {
  patient,
  practitioner,
  practitionerRole,
  resolvedCondition,
  obsBodyHeight,
  obsBodyWeight,
  obsBloodPressure,
  obsAlcoholConsumption
} from '../test/support/fixtures';

const questionnaire = generated as Questionnaire;
const adapter = gpccmpClinicalAdapter({
  resources: [
    resolvedCondition,
    obsBodyHeight,
    obsBodyWeight,
    obsBloodPressure,
    obsAlcoholConsumption
  ]
});
// Only public response APIs are exposed to the browser assertions. No renderer stores.
declare global {
  interface Window {
    gpccmp: {
      response: typeof getResponse;
      cleanedResponse: () => ReturnType<typeof getResponse>;
      clinicalRequests: typeof adapter.requests;
    };
  }
}
window.gpccmp = {
  response: getResponse,
  cleanedResponse: () =>
    removeEmptyAnswersFromResponse(questionnaire, getResponse()),
  clinicalRequests: adapter.requests
};

createRoot(document.getElementById('root')!).render(
  <BehavioralTestWrapper
    questionnaire={questionnaire}
    patient={patient}
    user={practitioner}
    fhirContext={[
      {
        type: 'PractitionerRole',
        reference: `PractitionerRole/${practitionerRole.id}`
      }
    ]}
    fetchResourceCallback={adapter.callback}
  />
);
