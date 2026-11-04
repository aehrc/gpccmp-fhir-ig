import type {
  Questionnaire,
  QuestionnaireItem,
  QuestionnaireResponse,
  QuestionnaireResponseItem,
  QuestionnaireResponseItemAnswer
} from 'fhir/r4';
import { waitFor } from '@testing-library/react';
import { inputText } from '@aehrc/questionnaire-test-toolkit';
import {
  destroyForm,
  getResponse,
  questionnaireStore
} from '@aehrc/smart-forms-renderer';
import generated from '../fsh-generated/resources/Questionnaire-GPChronicConditionManagementPlan.json';
import { useFormEnvironment } from './support/environment';
import { queryItem, requireItem } from './support/items';
import { queryResponseItem } from './support/response';
import {
  renderGpccmp,
  responseForPersistence,
  selectTab
} from './support/form';
import { patient } from './support/fixtures';

useFormEnvironment();

const q = generated as Questionnaire;
type Node = { item: QuestionnaireItem; path: string[]; protected: boolean };
const nodes: Node[] = [];
function walk(
  items: QuestionnaireItem[],
  parent: string[] = [],
  inherited = false
) {
  for (const item of items) {
    const path = [...parent, item.linkId];
    const protected_ = inherited || item.readOnly === true;
    nodes.push({ item, path, protected: protected_ });
    walk(item.item ?? [], path, protected_);
  }
}
walk(q.item ?? []);
function node(id: string) {
  const found = nodes.find((n) => n.item.linkId === id);
  if (!found) throw new Error(`Unknown generated linkId ${id}`);
  return found;
}
function answers(id: string, response = getResponse()) {
  return (
    queryResponseItem(
      node(id).path.map((linkId) => ({ linkId, occurrence: 0 })),
      response
    )?.answer ?? []
  );
}
function saved(
  values: Record<string, QuestionnaireResponseItemAnswer[]>
): QuestionnaireResponse {
  const item: QuestionnaireResponseItem[] = [];
  for (const [id, answer] of Object.entries(values)) {
    let siblings = item;
    for (const [i, linkId] of node(id).path.entries()) {
      let current = siblings.find((n) => n.linkId === linkId);
      if (!current) {
        current = { linkId };
        siblings.push(current);
      }
      if (i === node(id).path.length - 1) {
        // FHIR JSON omits absent answers; an empty answer array is not a saved value.
        if (answer.length) current.answer = answer;
      } else siblings = current.item ??= [];
    }
  }
  return {
    resourceType: 'QuestionnaireResponse',
    status: 'in-progress',
    ...(item.length ? { item } : {})
  };
}
const targets = [
  [
    'patient-medicare-number',
    'constraint-regex-medicarecardnumber-1',
    '1234567890',
    'Medicare card number must be 10 digits'
  ],
  [
    'patient-medicare-referencenumber',
    'constraint-regex-medicarecardnumber-2',
    '1',
    'Medicare card reference number must be 1 digit'
  ],
  [
    'patient-contact-homeaddress-details-postcode',
    'constraint-regex-home-postcode',
    '3000',
    'Postcode must be 4 digits'
  ],
  [
    'practitioner-clinicdetails-address-postcode',
    'constraint-regex-clinic-postcode',
    '3000',
    'Postcode must be 4 digits'
  ]
] as const;
const validValues = Object.fromEntries(
  targets.map(([id, , value]) => [id, [{ valueString: value }]])
);

async function checkFeedback(container: HTMLElement, invalidId?: string) {
  for (const [id, key, , message] of targets) {
    await selectTab(container, node(id).path[1]);
    await waitFor(() => {
      const constraint = questionnaireStore.getState().targetConstraints[key];
      expect(constraint, key).toBeDefined();
      expect(constraint.isInvalid, id).toBe(id === invalidId);
      const item = requireItem(container, id);
      const feedback = item.querySelector('.MuiFormHelperText-root');
      expect(feedback?.textContent ?? '', id).toBe(
        id === invalidId ? message : ''
      );
      if (id === invalidId) {
        expect(constraint.severityCode).toBe('warning');
        expect(item.querySelector('.Mui-error'), id).toBeNull();
      }
    });
  }
}

test('S5 four distinct constraints survive collection; valid initialization has no expression diagnostics', async () => {
  const { container } = await renderGpccmp();
  expect(
    Object.keys(questionnaireStore.getState().targetConstraints).sort()
  ).toEqual(targets.map((t) => t[1]).sort());
  await checkFeedback(container);
});

test('S5 empty response initialization: optional constraints have no format warnings or expression errors', async () => {
  const { container } = await renderGpccmp({
    questionnaireResponse: saved({})
  });
  await checkFeedback(container);
  for (const [id] of targets) expect(answers(id)).toEqual([]);
});

for (const [id, , valid] of targets) {
  for (const [label, value] of [
    ['valid', valid],
    ['short', valid.slice(1)],
    ['long', valid + '0'],
    ['alphabetic', 'A'.repeat(valid.length)],
    ['empty', '']
  ]) {
    test(`S5 constraint ${id}: ${label}, then supported correction`, async () => {
      const values = {
        ...validValues,
        [id]: value ? [{ valueString: value }] : []
      };
      const mounted = await renderGpccmp({
        questionnaireResponse: saved(values)
      });
      expect(answers(id)).toEqual(value ? [{ valueString: value }] : []);
      // Optional empty answers do not produce a format warning (including one-digit short = empty).
      await checkFeedback(
        mounted.container,
        value && value !== valid ? id : undefined
      );
      expect(answers(id, responseForPersistence())).toEqual(
        value ? [{ valueString: value }] : []
      );
      mounted.unmount();
      destroyForm();
      // Saved response through the wrapper lifecycle; protected inputs are never edited.
      const corrected = await renderGpccmp({
        questionnaireResponse: saved(validValues)
      });
      await checkFeedback(corrected.container);
      expect(answers(id)).toEqual([{ valueString: valid }]);
    });
  }
}

for (const value of ['3000', '300', '30000', 'ABCD', '']) {
  test(`S5 postal regex through Patient population: ${value || 'empty'}`, async () => {
    const { container } = await renderGpccmp({
      patient: {
        ...patient,
        address: [
          {
            use: 'home',
            type: 'postal',
            line: ['PO Box 42'],
            city: 'Melbourne',
            state: 'VIC',
            postalCode: value
          }
        ]
      }
    });
    const id = 'patient-contact-postaladdress-postcode';
    const item = requireItem(container, id);
    const invalid = value !== '' && value !== '3000';
    await waitFor(() =>
      expect(
        item.querySelector('.MuiFormHelperText-root')?.textContent ?? ''
      ).toBe(
        invalid ? 'Input should match the specified regex: /^[0-9]{4}$/' : ''
      )
    );
    expect(answers(id)).toEqual(value ? [{ valueString: value }] : []);
    expect(answers(id, responseForPersistence())).toEqual(
      value ? [{ valueString: value }] : []
    );
    await expect(inputText(container, id, '9999')).rejects.toThrow(
      /read.only|disabled|protected/i
    );
    expect(answers(id)).toEqual(value ? [{ valueString: value }] : []);
  });
}

import { hiddenAnswers, protectedAnswers } from './support/slice5-fixtures';
import {
  allergy,
  currentMedication,
  resolvedCondition,
  practitionerRole,
  clinicLocation,
  obsBodyHeight,
  obsBodyWeight,
  obsWaistCircumference,
  obsHeartRate,
  obsHeartRhythm,
  obsOxygenSaturation,
  obsBloodPressure,
  obsTobaccoSmokingStatus,
  obsAlcoholConsumption
} from './support/fixtures';
const main = 'clinicaldetails-observations-maingrid';
const clinicalResources = [
  allergy,
  currentMedication,
  resolvedCondition,
  obsBodyHeight,
  obsBodyWeight,
  obsWaistCircumference,
  obsHeartRate,
  obsHeartRhythm,
  obsOxygenSaturation,
  obsBloodPressure,
  obsTobaccoSmokingStatus,
  obsAlcoholConsumption
];
const populatedRole = {
  ...practitionerRole,
  telecom: [
    { system: 'phone' as const, value: '0311111111' },
    { system: 'email' as const, value: 'one@example.com' }
  ],
  identifier: [
    {
      system: 'http://ns.electronichealth.net.au/id/medicare-provider-number',
      value: '1234561A'
    }
  ]
};

test('S5 all 20 hidden items: clinical population, DOM absence, exact typed raw and cleaned retention', async () => {
  const hidden = nodes.filter((n) =>
    n.item.extension?.some(
      (e) => e.url.endsWith('/questionnaire-hidden') && e.valueBoolean
    )
  );
  expect(hidden).toHaveLength(20);
  expect(hidden.map((n) => n.item.linkId).sort()).toEqual(
    Object.keys(hiddenAnswers).sort()
  );
  const { container } = await renderGpccmp({ resources: clinicalResources });

  function assertHiddenItemsRetained() {
    for (const { item } of hidden) {
      expect(queryItem(container, item.linkId), item.linkId).toBeUndefined();
      expect(answers(item.linkId), item.linkId).toEqual(
        hiddenAnswers[item.linkId]
      );
      expect(
        answers(item.linkId, responseForPersistence()),
        item.linkId
      ).toEqual(hiddenAnswers[item.linkId]);
    }
  }

  await selectTab(container, 'clinicaldetails');
  assertHiddenItemsRetained();
  await inputText(container, `${main}-height-newresultvalue`, '180');
  await waitFor(() =>
    expect(answers(`${main}-height-newresultvalue`)).toEqual([
      { valueDecimal: 180 }
    ])
  );
  assertHiddenItemsRetained();
});

const structuralIds = [
  'patient-medicare',
  'patient-contact-homeaddress',
  'patient-contact-homeaddress-details',
  'patient-contact-postaladdress',
  'practitioner-clinicdetails',
  'practitioner-clinicdetails-address',
  `${main}-bmi-newresult-unit`
];
test('S5 protection inventory accounts for all 51 nodes, 30 explicit declarations and inherited descendants', () => {
  expect(nodes.filter((n) => n.item.readOnly)).toHaveLength(30);
  const protectedNodes = nodes.filter((n) => n.protected);
  expect(protectedNodes).toHaveLength(51);
  expect(protectedNodes.map((n) => n.item.linkId).sort()).toEqual(
    [...Object.keys(protectedAnswers), ...structuralIds].sort()
  );
});

for (const tab of ['patient', 'practitioner', 'clinicaldetails', 'plan']) {
  test(`S5 protected ${tab}: actual locks, refused edits, unchanged typed answers, editable neighbours`, async () => {
    const response = saved({
      ...protectedAnswers,
      [`${main}-height-newresultvalue`]: [{ valueDecimal: 170 }],
      [`${main}-weight-newresultvalue`]: [{ valueDecimal: 70 }]
    });
    const { container } = await renderGpccmp({
      questionnaireResponse: response,
      role: populatedRole
    });
    await selectTab(container, tab);
    const applicable = nodes.filter((n) => n.protected && n.path[1] === tab);
    for (const { item, path } of applicable) {
      const id = item.linkId;
      // The mutually exclusive clinic text alternative is exercised in its enabled branch below.
      if (id === 'practitioner-clinicdetails-addresstext') {
        expect(queryItem(container, id)).toBeUndefined();
        expect(answers(id)).toEqual(protectedAnswers[id]);
        expect(answers(id, responseForPersistence())).toEqual([]);
        continue;
      }
      if (item.type === 'group') {
        expect(requireItem(container, id)).toBeDefined();
        const descendants = applicable.filter(
          (n) =>
            n.path.includes(id) &&
            n.item.type !== 'group' &&
            n.item.type !== 'display'
        );
        expect(descendants.length, id).toBeGreaterThan(0);
        for (const descendant of descendants)
          expect(
            answers(descendant.item.linkId),
            descendant.path.join('/')
          ).toEqual(protectedAnswers[descendant.item.linkId]);
        continue;
      }
      if (item.type === 'display') {
        // A unit is static text, rendered as an adornment on the protected BMI input.
        expect(
          requireItem(container, `${main}-bmi-newresultvalue`).textContent
        ).toContain('kg/m');
        expect(answers(id)).toEqual([]);
        continue;
      }
      const root = requireItem(container, id);
      const controls = Array.from(
        root.querySelectorAll<HTMLInputElement | HTMLTextAreaElement>(
          'input:not([type="hidden"]), textarea'
        )
      ).filter((c) => !c.hasAttribute('aria-hidden'));
      expect(controls.length, id).toBeGreaterThan(0);
      for (const control of controls)
        expect(
          control.disabled || control.readOnly,
          `${id}: ${control.outerHTML}`
        ).toBe(true);
      expect(answers(id), path.join('/')).toEqual(protectedAnswers[id]);
      await expect(
        inputText(container, id, 'attempted overwrite')
      ).rejects.toThrow(/read.only|disabled|protected/i);
      expect(answers(id), id).toEqual(protectedAnswers[id]);
      expect(answers(id, responseForPersistence()), id).toEqual(
        protectedAnswers[id]
      );
    }
    const neighbours: Record<string, string> = {
      patient: 'patient-additionalinformation',
      practitioner: '',
      clinicaldetails: 'clinicaldetails-medications-recordedmedications-dosage',
      plan: 'plan-conditions-comments'
    };
    // Practitioner is an entirely protected tab; patient/clinical/plan have editable neighbours.
    const id = neighbours[tab];
    if (id) {
      await inputText(container, id, 'Editable neighbour');
      await waitFor(() =>
        expect(answers(id)).toEqual([{ valueString: 'Editable neighbour' }])
      );
      for (const { item } of applicable.filter(
        (n) => n.item.type !== 'group' && n.item.type !== 'display'
      ))
        expect(answers(item.linkId), item.linkId).toEqual(
          protectedAnswers[item.linkId]
        );
    }
  });
}

test('S5 protected clinic text alternative: enabled lock, raw alternatives and cleaned precedence', async () => {
  const { container } = await renderGpccmp({
    questionnaireResponse: saved(protectedAnswers),
    role: populatedRole,
    location: { ...clinicLocation, address: { text: 'Clinic written address' } }
  });
  await selectTab(container, 'practitioner');
  const id = 'practitioner-clinicdetails-addresstext';
  const input = requireItem(container, id).querySelector<
    HTMLInputElement | HTMLTextAreaElement
  >('input, textarea')!;
  expect(input.readOnly || input.disabled).toBe(true);
  await expect(inputText(container, id, 'attempted overwrite')).rejects.toThrow(
    /read.only|disabled|protected/i
  );
  expect(answers(id)).toEqual(protectedAnswers[id]);
  expect(answers(id, responseForPersistence())).toEqual(protectedAnswers[id]);
  expect(
    queryItem(container, 'practitioner-clinicdetails-address')
  ).toBeUndefined();
  for (const suffix of ['streetaddress', 'city', 'state', 'postcode']) {
    const child = `practitioner-clinicdetails-address-${suffix}`;
    expect(answers(child)).toEqual(protectedAnswers[child]);
    expect(answers(child, responseForPersistence())).toEqual([]);
  }
});
