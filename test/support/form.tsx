import type {
  FhirResource,
  Patient,
  Practitioner,
  PractitionerRole,
  Location,
  Questionnaire,
  QuestionnaireResponse
} from 'fhir/r4';
import { render, waitFor } from '@testing-library/react';
import {
  BehavioralTestWrapper,
  selectTab as toolkitSelectTab
} from '@aehrc/questionnaire-test-toolkit';
import {
  getResponse,
  removeEmptyAnswersFromResponse
} from '@aehrc/smart-forms-renderer';
import generated from '../../fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json';
import { gpccmpClinicalAdapter } from './gpccmpClinical';
import { requireItem, waitForFormReady } from './items';
import { queryResponseItem } from './response';
import {
  patient as defaultPatient,
  practitioner,
  practitionerRole,
  clinicLocation as defaultClinicLocation
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
  const adapter = gpccmpClinicalAdapter({ patient, resources, role, location });
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

/**
 * Select a section, then wait for the renderer's own tab-switch outcome. A desktop tab click
 * focuses the selected panel's first heading after a 100 ms delay (FormBodySingleTab). A control
 * focused before then would lose focus, which closes an open autocomplete popup.
 */
export async function selectTab(container: HTMLElement, linkId: string) {
  await toolkitSelectTab(container, linkId);
  const tab = Array.from(
    container.querySelectorAll<HTMLElement>(
      '[data-test="renderer-tab-list"] [data-linkid]'
    )
  )
    .find((entry) => entry.getAttribute('data-linkid') === linkId)
    ?.querySelector<HTMLElement>('[id^="tab-"]');
  // Small-screen sections expand in place and do not move focus.
  if (!tab || !/^tab-\d+$/.test(tab.id)) return;
  const panel = container.querySelector(`#tabpanel-${tab.id.slice(4)}`);
  await waitFor(() => {
    const heading = panel?.querySelector('h1, h2, h3, h4, h5, h6');
    expect(heading, `${linkId} panel heading`).toBeTruthy();
    expect(document.activeElement).toBe(heading);
  });
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
