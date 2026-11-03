import { expect, test } from 'vitest';
import { fireEvent, render, waitFor, within } from '@testing-library/react';
import type {
  Questionnaire,
  Patient,
  Practitioner,
  PractitionerRole,
  FhirResource,
  Bundle
} from 'fhir/r4';
import {
  addRepeatGroup,
  BehavioralTestWrapper,
  inputText,
  removeRepeatGroup,
  selectTab
} from '@aehrc/questionnaire-test-toolkit';
import { getResponse } from '@aehrc/smart-forms-renderer';
import generated from '../../fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json';
import { createClinicalAdapter } from '../../test/support/clinicalRequests';
import { useFormEnvironment } from '../../test/support/environment';
import {
  queryItems,
  requireItem,
  waitForFormReady
} from '../../test/support/items';
import { requireResponseItem } from '../../test/support/response';

const questionnaire: Questionnaire = generated as Questionnaire;
const patient: Patient = {
  resourceType: 'Patient',
  id: 'patient-123',
  birthDate: '1993-08-16',
  name: [{ use: 'official', given: ['John'], family: 'Snow' }]
};
const user: Practitioner = {
  resourceType: 'Practitioner',
  id: 'practitioner-456',
  name: [{ use: 'official', given: ['Jane'], family: 'Smith' }]
};
const role: PractitionerRole = {
  resourceType: 'PractitionerRole',
  id: 'role-1',
  practitioner: { reference: 'Practitioner/practitioner-456' },
  location: [{ reference: 'Location/clinic-1' }]
};
const context = [
  { type: 'PractitionerRole', reference: 'PractitionerRole/role-1' }
];
const empty: Bundle = { resourceType: 'Bundle', type: 'searchset', entry: [] };
// Independently stated GP CCMP request contract. Never generated from Questionnaire expressions.
function fixtures(): [string, FhirResource][] {
  const canonical =
    'http://www.health.gov.au/assessments/GPChronicConditionManagementPlan';
  return [
    ['PractitionerRole/role-1', role],
    [
      'PractitionerRole?_id=role-1&_include=PractitionerRole:location',
      {
        resourceType: 'Bundle',
        type: 'searchset',
        entry: [
          { resource: role },
          {
            resource: {
              resourceType: 'Location',
              id: 'clinic-1',
              name: 'Clinic',
              address: {
                line: ['1 Clinic Road'],
                city: 'Melbourne',
                state: 'VIC',
                postalCode: '3000'
              }
            }
          }
        ]
      }
    ],
    [
      `QuestionnaireResponse?questionnaire=${canonical}&_count=1&_sort=-authored&patient=patient-123`,
      empty
    ],
    [
      `QuestionnaireResponse?questionnaire=${canonical}&status=completed,amended&_count=1&_sort=-authored&patient=patient-123`,
      empty
    ],
    [
      'Condition?patient=patient-123&category=http://terminology.hl7.org/CodeSystem/condition-category|problem-list-item',
      empty
    ],
    ['AllergyIntolerance?patient=patient-123', empty],
    [
      'MedicationStatement?patient=patient-123&status=active&_include=MedicationStatement:medication',
      empty
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
      `Observation?code=${code}&_sort=-date&patient=patient-123`,
      empty
    ])
  ];
}
const patientPath = [{ linkId: 'container' }, { linkId: 'patient' }];
const contactPath = [
  ...patientPath,
  { linkId: 'patient-contacts', occurrence: 0 }
];

useFormEnvironment();

test('the packed wrapper mounts the generated form; edits and repeats share the public response state', async () => {
  const { container } = render(
    <BehavioralTestWrapper questionnaire={questionnaire} />
  );
  await waitForFormReady(container, ['patient-name']);
  await inputText(container, 'patient-contacts-name', 'First contact');
  const second = await addRepeatGroup(container, 'patient-contacts');
  await inputText(second, 'patient-contacts-name', 'Second contact');
  await waitFor(() =>
    expect(
      requireResponseItem([
        ...patientPath,
        { linkId: 'patient-contacts', occurrence: 1 },
        { linkId: 'patient-contacts-name' }
      ]).answer
    ).toEqual([{ valueString: 'Second contact' }])
  );
  expect(
    requireResponseItem([...contactPath, { linkId: 'patient-contacts-name' }])
      .answer
  ).toEqual([{ valueString: 'First contact' }]);
  await removeRepeatGroup(queryItems(container, 'patient-contacts')[0]);
  await waitFor(() =>
    expect(
      requireResponseItem([...contactPath, { linkId: 'patient-contacts-name' }])
        .answer
    ).toEqual([{ valueString: 'Second contact' }])
  );
});

test('a protected GP CCMP field rejects edits without changing the response', async () => {
  const { container } = render(
    <BehavioralTestWrapper questionnaire={questionnaire} />
  );
  await waitForFormReady(container, ['patient-name']);
  const field = within(requireItem(container, 'patient-name')).getByRole(
    'textbox'
  );
  expect(
    field.matches(':disabled, [readonly]') ||
      Boolean(field.closest('fieldset:disabled'))
  ).toBe(true);
  const before = getResponse();
  await expect(
    inputText(container, 'patient-name', 'Impossible edit')
  ).rejects.toThrow('cannot be interacted with');
  expect(getResponse()).toEqual(before);
});

test('strict clinical fixtures populate protected values through the candidate callback seam', async () => {
  const adapter = createClinicalAdapter(fixtures());
  const { container } = render(
    <BehavioralTestWrapper
      questionnaire={questionnaire}
      patient={patient}
      user={user}
      fhirContext={context}
      fetchResourceCallback={adapter.callback}
    />
  );
  await waitForFormReady(container, ['patient-name'], { timeoutMs: 20000 });
  expect(
    within(requireItem(container, 'patient-name')).getByRole('textbox')
  ).toHaveProperty('value', 'John Snow');
  expect(
    requireResponseItem([...patientPath, { linkId: 'patient-age' }]).answer
  ).toEqual([{ valueInteger: 33 }]);
  expect(adapter.requests.length).toBeGreaterThan(0);
  expect(adapter.requests.every((r) => r.matched)).toBe(true);
  expect(
    adapter.requests.some((r) => r.query === 'PractitionerRole/role-1')
  ).toBe(true);
});

test('an unmatched clinical request fails readiness with its query context', async () => {
  const adapter = createClinicalAdapter(
    fixtures().filter(([query]) => query !== 'PractitionerRole/role-1')
  );
  const { container } = render(
    <BehavioralTestWrapper
      questionnaire={questionnaire}
      patient={patient}
      user={user}
      fhirContext={context}
      fetchResourceCallback={adapter.callback}
    />
  );
  await expect(
    waitForFormReady(container, ['patient-name'], { timeoutMs: 20000 })
  ).rejects.toThrow(
    'Unexpected clinical request (http://mock.example): PractitionerRole'
  );
  expect(container.querySelector('[data-testid="save-button"]')).toBeNull();
  expect(
    adapter.requests.some(
      (r) => !r.matched && r.query === 'PractitionerRole/role-1'
    )
  ).toBe(true);
});

test('table rows expose row-scoped controls for later IG helpers', async () => {
  const { container } = render(
    <BehavioralTestWrapper questionnaire={questionnaire} />
  );
  await waitForFormReady(container, ['patient']);
  await selectTab(container, 'clinicaldetails');
  const table = requireItem(
    container,
    'clinicaldetails-problemsdiagnoses-newproblems'
  );
  const first = within(table)
    .getAllByRole('row')
    .find((row) => row.querySelector('textarea'));
  expect(first).toBeDefined();
  if (!first) throw new Error('Expected a new-problem data row');
  await inputText(
    first,
    'clinicaldetails-problemsdiagnoses-newproblems-comment',
    'First row'
  );
  const add = table.querySelector<HTMLButtonElement>(
    '[data-test="button-add-repeat-item"]'
  );
  expect(add?.disabled).toBe(false);
  // Full table add/remove/coding acceptance belongs to Slice 6.
});

test('repeated questions expose a collection Add control and individual answer controls', async () => {
  const { container } = render(
    <BehavioralTestWrapper questionnaire={questionnaire} />
  );
  await waitForFormReady(container, ['patient']);
  await selectTab(container, 'plan');
  await inputText(container, 'notes-additionalcomments', 'First note');
  const collection = container.querySelector<HTMLElement>(
    '[data-test="q-item-repeat-box"][data-linkid="notes-additionalcomments"]'
  );
  if (!collection)
    throw new Error('Expected the additional-notes answer collection');
  expect(within(collection).getAllByRole('textbox')).toHaveLength(1);
  const add = collection.querySelector<HTMLButtonElement>(
    '[data-test="button-add-repeat-item"]'
  );
  if (!add) throw new Error('Expected the additional-notes Add button');
  expect(add.disabled).toBe(false);
  fireEvent.click(add);
  await waitFor(() =>
    expect(within(collection).getAllByRole('textbox')).toHaveLength(2)
  );
});
