import type {
  FhirResource,
  Patient,
  Practitioner,
  PractitionerRole,
  Location,
  Questionnaire,
  QuestionnaireResponse
} from 'fhir/r4';
import { render } from '@testing-library/react';
import { BehavioralTestWrapper } from '@aehrc/questionnaire-test-toolkit';
import {
  getResponse,
  removeEmptyAnswersFromResponse
} from '@aehrc/smart-forms-renderer';
import generated from '../../fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json';
import { createClinicalAdapter } from './clinicalRequests';
import { requireItem, waitForFormReady } from './items';
import { queryResponseItem } from './response';
import {
  patient as defaultPatient,
  practitioner,
  practitionerRole,
  clinicLocation as defaultClinicLocation,
  makeSearchSetBundle
} from './fixtures';

export const patientPath = ['container', 'patient'];
export const homeAddressPath = [
  ...patientPath,
  'patient-contact',
  'patient-contact-homeaddress'
];
export const clinicAddressPath = [
  'container',
  'practitioner',
  'practitioner-clinicdetails',
  'practitioner-clinicdetails-address'
];

/** Parent paths are explicit; repeat occurrence is always selected deliberately. */
export function answerAt(
  parent: readonly string[],
  linkId: string,
  response: QuestionnaireResponse = getResponse(),
  occurrence?: number
) {
  return queryResponseItem(
    [...parent.map((linkId) => ({ linkId })), { linkId, occurrence }],
    response
  )?.answer;
}

/** Independent request contract, with explicit empty searchsets for expected no-data queries.
 * Supplied resources test population, not whether a clinical server implements these searches.
 */
export async function renderGpccmp({
  patient = defaultPatient,
  resources = [],
  user = practitioner,
  role = practitionerRole,
  location = defaultClinicLocation,
  questionnaireResponse
}: {
  patient?: Patient;
  resources?: FhirResource[];
  user?: Practitioner;
  role?: PractitionerRole;
  location?: Location;
  questionnaireResponse?: QuestionnaireResponse;
} = {}) {
  const bundle = (type: string) =>
    makeSearchSetBundle(resources.filter((r) => r.resourceType === type));
  const canonical =
    'http://www.health.gov.au/assessments/GPChronicConditionManagementPlan';
  const id = patient.id;
  if (!id) throw new Error('Population fixtures require a patient ID');
  const plans = resources.filter(
    (r): r is QuestionnaireResponse =>
      r.resourceType === 'QuestionnaireResponse'
  );
  const adapter = createClinicalAdapter([
    [`PractitionerRole/${role.id}`, role],
    [
      `PractitionerRole?_id=${role.id}&_include=PractitionerRole:location`,
      makeSearchSetBundle([role, location])
    ],
    [
      `QuestionnaireResponse?questionnaire=${canonical}&_count=1&_sort=-authored&patient=${id}`,
      makeSearchSetBundle(plans.filter((r) => r.status === 'in-progress'))
    ],
    [
      `QuestionnaireResponse?questionnaire=${canonical}&status=completed,amended&_count=1&_sort=-authored&patient=${id}`,
      makeSearchSetBundle(
        plans.filter((r) => ['completed', 'amended'].includes(r.status))
      )
    ],
    [
      `Condition?patient=${id}&category=http://terminology.hl7.org/CodeSystem/condition-category|problem-list-item`,
      bundle('Condition')
    ],
    [`AllergyIntolerance?patient=${id}`, bundle('AllergyIntolerance')],
    [
      `MedicationStatement?patient=${id}&status=active&_include=MedicationStatement:medication`,
      bundle('MedicationStatement')
    ],
    ...[
      '8302-2',
      '29463-7',
      '8280-0',
      '78564009',
      '364095004',
      '2708-6',
      '85354-9',
      '1747861000168109',
      '897148007'
    ].map((code): [string, FhirResource] => [
      `Observation?code=${code}&_sort=-date&patient=${id}`,
      makeSearchSetBundle(
        resources.filter(
          (r) =>
            r.resourceType === 'Observation' &&
            r.code.coding?.some((c) => c.code === code)
        )
      )
    ])
  ]);
  const rendered = render(
    <BehavioralTestWrapper
      questionnaire={generated as Questionnaire}
      questionnaireResponse={questionnaireResponse}
      patient={patient}
      user={user}
      fhirContext={[
        {
          type: 'PractitionerRole',
          reference: `PractitionerRole/${role.id}`
        }
      ]}
      fetchResourceCallback={adapter.callback}
    />
  );
  await waitForFormReady(rendered.container, ['patient-name', 'patient-age'], {
    timeoutMs: 20000
  });
  if (adapter.requests.some((r) => !r.matched))
    throw new Error('Unmatched clinical requests after initialization');
  return { ...rendered, adapter };
}

/** Read by exact ID and reject ambiguous repeats before using a toolkit getter. */
export async function getInputText(scope: HTMLElement, linkId: string) {
  const item = requireItem(scope, linkId);
  const input = item.querySelector<HTMLInputElement | HTMLTextAreaElement>(
    'input, textarea'
  );
  if (!input) throw new Error(`Expected an input for ${linkId}`);
  return input.value;
}

export async function getRadioValue(scope: HTMLElement, linkId: string) {
  const input = requireItem(scope, linkId).querySelector<HTMLInputElement>(
    'input:checked'
  );
  if (!input) throw new Error(`Expected a selected radio for ${linkId}`);
  return input.value;
}

export async function getCqfText(scope: HTMLElement, linkId: string) {
  const text = requireItem(scope, linkId)
    .textContent?.replace(/\s+/g, ' ')
    .trim();
  if (!text) throw new Error(`Expected display text for ${linkId}`);
  return text;
}

/** Apply the renderer's public response-cleaning policy before host persistence. */
export function responseForPersistence() {
  return removeEmptyAnswersFromResponse(
    generated as Questionnaire,
    getResponse()
  );
}
