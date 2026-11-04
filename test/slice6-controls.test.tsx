import type { Coding } from 'fhir/r4';
import {
  act,
  fireEvent,
  waitFor,
  within,
  screen
} from '@testing-library/react';
import {
  chooseSelectOption,
  addRepeatAnswer,
  removeRepeatAnswer,
  checkRadioOption,
  inputText
} from '@aehrc/questionnaire-test-toolkit';
import { destroyForm } from '@aehrc/smart-forms-renderer';
import { patient } from './support/fixtures';
import { useFormEnvironment } from './support/environment';
import { requireItem, queryItems } from './support/items';
import { renderGpccmp, selectTab } from './support/form';
import {
  answers,
  expectAnswers,
  node,
  nodes,
  saved,
  sct,
  string,
  openGoals
} from './support/slice6';

useFormEnvironment();

const terminology = {
  condition: ['195967001', 'Asthma', '71892000', 'Cardiac asthma'],
  substance: ['764146007', 'Penicillin', '373291007', 'Natural penicillin'],
  manifestation: ['271807003', 'Rash', '64144002', 'Pruritic rash'],
  medication: ['90332006', 'Paracetamol', '412556009', 'Paracetamol + codeine'],
  indication: ['25064002', 'Headache', '193031009', 'Cluster headache'],
  procedure: ['409063005', 'Counselling', '737375007', 'Group counselling'],
  service: [
    '788007007',
    'General practice service',
    '1782161000168105',
    'Rural general practice service'
  ]
} as const;
const autocompletes = [
  ['clinicaldetails-problemsdiagnoses-newproblems-condition', 'condition'],
  ['clinicaldetails-allergies-newallergies-substance', 'substance'],
  ['clinicaldetails-allergies-newallergies-manifestation', 'manifestation'],
  ['clinicaldetails-medications-newmedications-medication', 'medication'],
  ['clinicaldetails-medications-newmedications-indication', 'indication'],
  ['plan-conditions-condition', 'condition'],
  ['plan-goalstasks-problemneed', 'condition'],
  [
    'plan-goalstasks-details-interventionsactions-interventionsactions',
    'procedure'
  ],
  ['plan-goalstasks-details-servicestreatments-servicestreatments', 'service'],
  ['plan-goalstasks-details-servicestreatments-activity', 'procedure']
] as const;

/** Resolve by system/code identity; terminology errors and missing members fail explicitly. */
async function liveCoding(
  id: string,
  code: string,
  filter: string
): Promise<Coding> {
  const url = new URL('https://tx.ontoserver.csiro.au/fhir/ValueSet/$expand');
  url.searchParams.set('url', node(id).item.answerValueSet!);
  url.searchParams.set('filter', filter);
  url.searchParams.set('count', '100');
  const response = await fetch(url);
  if (!response.ok)
    throw new Error(`Terminology ${id}: HTTP ${response.status}`);
  const expansion = (await response.json()) as {
    expansion?: { contains?: Coding[] };
  };
  const coding = expansion.expansion?.contains?.find(
    (c) => c.system === 'http://snomed.info/sct' && c.code === code
  );
  if (!coding?.display)
    throw new Error(`Terminology ${id}: missing SNOMED ${code}`);
  return { system: coding.system, code: coding.code, display: coding.display };
}

async function keyboardSelect(scope: HTMLElement, id: string, display: string) {
  const input = requireItem(scope, id).querySelector<HTMLInputElement>(
    'input[role="combobox"]'
  )!;
  expect(input.tagName).toBe('INPUT');
  await act(async () => {
    input.focus();
    fireEvent.change(input, { target: { value: display } });
  });
  const option = await screen.findByRole(
    'option',
    { name: display },
    { timeout: 10000 }
  );
  // Navigate by the requested option identity, independently of live expansion ordering.
  for (let step = 0; step <= screen.getAllByRole('option').length; step++) {
    if (input.getAttribute('aria-activedescendant') === option.id) break;
    await act(async () => {
      fireEvent.keyDown(input, { key: 'ArrowDown' });
    });
  }
  expect(input.getAttribute('aria-activedescendant')).toBe(option.id);
  // Step to a neighbouring option and back, staying inside the list wherever
  // the live expansion places the requested option.
  const options = screen.getAllByRole('option');
  expect(options.length).toBeGreaterThan(1);
  const [away, back] =
    options[0] === option ? ['ArrowDown', 'ArrowUp'] : ['ArrowUp', 'ArrowDown'];
  await act(async () => {
    fireEvent.keyDown(input, { key: away });
  });
  const neighbour = input.getAttribute('aria-activedescendant');
  expect(neighbour).not.toBeNull();
  expect(neighbour).not.toBe(option.id);
  await act(async () => {
    fireEvent.keyDown(input, { key: back });
  });
  expect(input.getAttribute('aria-activedescendant')).toBe(option.id);
  await act(async () => {
    fireEvent.keyDown(input, { key: 'Enter' });
  });
}

for (const [id, term] of autocompletes) {
  test(`S6 autocomplete ${id}: live coding identity, change, clear and scoped saved values`, async () => {
    const terms = terminology[term];
    const first = await liveCoding(id, terms[0], terms[1]);
    const second = await liveCoding(id, terms[2], terms[3]);
    const repeatParents = node(id)
      .path.slice(0, -1)
      .filter((p) => node(p).item.type === 'group' && node(p).item.repeats);
    const parent = repeatParents[repeatParents.length - 1]!;
    const marker = id.startsWith('plan-goalstasks-details-interventionsactions')
      ? 'plan-goalstasks-details-interventionsactions-owner'
      : id.startsWith('plan-goalstasks-details-servicestreatments')
        ? 'plan-goalstasks-details-servicestreatments-provider'
        : id.startsWith('plan-goalstasks')
          ? 'plan-goalstasks-details-goalsetting-goals'
          : id.startsWith('plan-conditions')
            ? 'plan-conditions-comments'
            : id.startsWith('clinicaldetails-problemsdiagnoses')
              ? 'clinicaldetails-problemsdiagnoses-newproblems-comment'
              : id.startsWith('clinicaldetails-allergies')
                ? 'clinicaldetails-allergies-newallergies-comment'
                : 'clinicaldetails-medications-newmedications-dosage';
    const { container } = await renderGpccmp({
      questionnaireResponse: saved([
        { id: marker, answer: string('Target row association') },
        {
          id: marker,
          answer: string('Sibling row association'),
          occurrences: { [parent]: 1 }
        },
        {
          id,
          answer: string('Sibling retained'),
          occurrences: { [parent]: 1 }
        }
      ])
    });
    await selectTab(container, node(id).path[1]);
    if (id.startsWith('plan-goalstasks')) await openGoals(container);
    const table = node(parent).item.extension?.some((e) =>
      e.valueCodeableConcept?.coding?.some((c) => c.code === 'gtable')
    );
    const scope = table
      ? requireItem(container, parent).querySelector<HTMLElement>('tbody > tr')!
      : queryItems(container, parent)[0]!;
    const checkSibling = () => {
      expectAnswers(id, string('Sibling retained'), { [parent]: 1 });
      expectAnswers(marker, string('Target row association'));
      expectAnswers(marker, string('Sibling row association'), { [parent]: 1 });
    };
    if (id === 'clinicaldetails-problemsdiagnoses-newproblems-condition')
      await keyboardSelect(scope, id, first.display!);
    else await chooseSelectOption(scope, id, first.display!);
    await waitFor(() => expectAnswers(id, [{ valueCoding: first }]));
    expect(
      requireItem(scope, id).querySelector<HTMLInputElement>('input')!.value
    ).toBe(first.display);
    checkSibling();
    if (node(id).item.repeats) {
      const added = await addRepeatAnswer(scope, id);
      await chooseSelectOption(added, id, second.display!);
      await waitFor(() =>
        expectAnswers(id, [{ valueCoding: first }, { valueCoding: second }])
      );
      const collection = requireItem(scope, id);
      const firstAnswer =
        collection.querySelector<HTMLElement>('.MuiCollapse-root')!;
      const clear = firstAnswer.querySelector<HTMLButtonElement>(
        'button[title="Clear"]'
      )!;
      await act(async () => {
        fireEvent.click(clear);
      });
      await waitFor(() => expectAnswers(id, [{ valueCoding: second }]));
      checkSibling();
      await chooseSelectOption(firstAnswer, id, first.display!);
      await waitFor(() =>
        expectAnswers(id, [{ valueCoding: first }, { valueCoding: second }])
      );
      await removeRepeatAnswer(firstAnswer);
      expectAnswers(id, [{ valueCoding: second }]);
      checkSibling();
      return;
    }
    await chooseSelectOption(scope, id, second.display!);
    await waitFor(() => expectAnswers(id, [{ valueCoding: second }]));
    checkSibling();
    const clear = requireItem(scope, id).querySelector<HTMLButtonElement>(
      'button[title="Clear"]'
    );
    expect(clear).not.toBeNull();
    await act(async () => {
      fireEvent.click(clear!);
    });
    await waitFor(() => expectAnswers(id, []));
    checkSibling();
  }, 90000);
}

const dropdowns = [
  [
    'clinicaldetails-problemsdiagnoses-recordedproblems-clinicalstatus',
    'Active',
    'active',
    'Resolved',
    'resolved',
    'http://terminology.hl7.org/CodeSystem/condition-clinical'
  ],
  [
    'clinicaldetails-allergies-recordedallergies-status',
    'Active',
    'active',
    'Resolved',
    'resolved',
    'http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical'
  ],
  [
    'clinicaldetails-observations-maingrid-pulserhythm-newresultvalue',
    'Pulse regular',
    '271636001',
    'Pulse irregular',
    '61086009',
    'http://snomed.info/sct'
  ],
  [
    'clinicaldetails-observations-substanceusegrid-smokingstatus-newresultvalue',
    'Current smoker',
    '77176002',
    'Former smoker',
    '8517006',
    'http://snomed.info/sct'
  ],
  [
    'clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultvalue',
    'Current drinker',
    '219006',
    'Former drinker',
    '82581004',
    'http://snomed.info/sct'
  ],
  [
    'plan-goalstasks-details-interventionsactions-status',
    'Planned',
    'not-started',
    'In Progress',
    'in-progress',
    'http://hl7.org/fhir/care-plan-activity-status'
  ]
] as const;
for (const [id, first, firstCode, second, secondCode, system] of dropdowns) {
  test(`S6 drop-down ${id}: rendered change/clear and exact typed coding`, async () => {
    const { container } = await renderGpccmp({
      questionnaireResponse: saved([
        {
          id: 'clinicaldetails-problemsdiagnoses-recordedproblems-condition',
          answer: [{ valueCoding: sct('195967001', 'Asthma') }]
        },
        {
          id: 'clinicaldetails-allergies-recordedallergies-substance',
          answer: [{ valueCoding: sct('764146007', 'Penicillin') }]
        },
        {
          id: 'plan-goalstasks-details-interventionsactions-owner',
          answer: string('Retained owner')
        }
      ])
    });
    await selectTab(container, node(id).path[1]);
    if (id.startsWith('plan-goalstasks')) await openGoals(container);
    for (const [display, code] of [
      [first, firstCode],
      [second, secondCode]
    ]) {
      if (display === first) await chooseSelectOption(container, id, display);
      else {
        const open = within(requireItem(container, id)).getByRole('button', {
          name: 'Open'
        });
        await act(async () => {
          fireEvent.click(open);
        });
        const option = await screen.findByRole('option', { name: display });
        await act(async () => {
          fireEvent.click(option);
        });
      }
      await waitFor(() =>
        expectAnswers(id, [{ valueCoding: { system, code, display } }])
      );
      expect(
        requireItem(container, id).querySelector<HTMLInputElement>('input')!
          .value
      ).toBe(display);
    }
    const clear = requireItem(container, id).querySelector<HTMLButtonElement>(
      'button[title="Clear"]'
    );
    expect(clear).not.toBeNull();
    await act(async () => {
      fireEvent.click(clear!);
    });
    await waitFor(() => expectAnswers(id, []));
  });
}

for (const [id, first, second, firstAnswer, secondAnswer] of [
  [
    'patient-myagedcare-registered',
    'Yes',
    'No',
    {
      valueCoding: {
        system: 'http://terminology.hl7.org/CodeSystem/v2-0532',
        code: 'Y',
        display: 'Yes'
      }
    },
    {
      valueCoding: {
        system: 'http://terminology.hl7.org/CodeSystem/v2-0532',
        code: 'N',
        display: 'No'
      }
    }
  ],
  [
    'patient-ndis-registered',
    'Yes',
    'No',
    {
      valueCoding: {
        system: 'http://terminology.hl7.org/CodeSystem/v2-0532',
        code: 'Y',
        display: 'Yes'
      }
    },
    {
      valueCoding: {
        system: 'http://terminology.hl7.org/CodeSystem/v2-0532',
        code: 'N',
        display: 'No'
      }
    }
  ],
  [
    'patient-contacts-present',
    'Yes',
    'No',
    {
      valueCoding: {
        system: 'http://terminology.hl7.org/CodeSystem/v2-0532',
        code: 'Y',
        display: 'Yes'
      }
    },
    {
      valueCoding: {
        system: 'http://terminology.hl7.org/CodeSystem/v2-0532',
        code: 'N',
        display: 'No'
      }
    }
  ],
  [
    'plan-type',
    'New',
    'Review',
    { valueString: 'New' },
    { valueString: 'Review' }
  ],
  [
    'completion-review-appointmentstatus',
    'Booked',
    'Proposed',
    {
      valueCoding: {
        system: 'http://hl7.org/fhir/appointmentstatus',
        code: 'booked',
        display: 'Booked'
      }
    },
    {
      valueCoding: {
        system: 'http://hl7.org/fhir/appointmentstatus',
        code: 'proposed',
        display: 'Proposed'
      }
    }
  ],
  [
    'completion-copyoffered',
    'Yes, copy provided',
    'Yes, but declined',
    { valueString: 'Yes, copy provided' },
    { valueString: 'Yes, but declined' }
  ]
] as const) {
  test(`S6 radio-button ${id}: checked selection and typed change`, async () => {
    const { container } = await renderGpccmp({
      patient: { ...patient, birthDate: '1976-08-17' }
    });
    await selectTab(container, node(id).path[1]);
    for (const [label, answer] of [
      [first, firstAnswer],
      [second, secondAnswer]
    ] as const) {
      await checkRadioOption(container, id, label);
      expect(
        (
          within(requireItem(container, id)).getByRole('radio', {
            name: label
          }) as HTMLInputElement
        ).checked
      ).toBe(true);
      await waitFor(() => expectAnswers(id, [answer]));
    }
  });
}

const units = [
  [
    'clinicaldetails-observations-maingrid-height-newresultvalue-unit',
    'clinicaldetails-observations-maingrid-height-newresultvalue',
    'cm',
    'valueDecimal',
    180
  ],
  [
    'clinicaldetails-observations-maingrid-weight-newresultvalue-unit',
    'clinicaldetails-observations-maingrid-weight-newresultvalue',
    'kg',
    'valueDecimal',
    81
  ],
  [
    'clinicaldetails-observations-maingrid-bmi-newresult-unit',
    'clinicaldetails-observations-maingrid-bmi-newresultvalue',
    'kg/m',
    'valueDecimal',
    25
  ],
  [
    'clinicaldetails-observations-maingrid-waistcircumference-newresultvalue-unit',
    'clinicaldetails-observations-maingrid-waistcircumference-newresultvalue',
    'cm',
    'valueDecimal',
    90
  ],
  [
    'clinicaldetails-observations-maingrid-pulserate-newresultvalue-unit',
    'clinicaldetails-observations-maingrid-pulserate-newresultvalue',
    '/min',
    'valueInteger',
    72
  ],
  [
    'clinicaldetails-observations-maingrid-oxygensaturation-newresultvalue-unit',
    'clinicaldetails-observations-maingrid-oxygensaturation-newresultvalue',
    '%',
    'valueInteger',
    98
  ],
  [
    'clinicaldetails-observations-bpgrid-bp-newresultsystolic-unit',
    'clinicaldetails-observations-bpgrid-bp-newresultsystolic',
    'mm Hg',
    'valueInteger',
    120
  ],
  [
    'clinicaldetails-observations-bpgrid-bp-newresultdiastolic-unit',
    'clinicaldetails-observations-bpgrid-bp-newresultdiastolic',
    'mm Hg',
    'valueInteger',
    80
  ]
] as const;
test('S6 all eight units belong to their exact typed values and three grids preserve row associations', async () => {
  const { container } = await renderGpccmp({
    questionnaireResponse: saved([
      { id: units[2][1], answer: [{ valueDecimal: 25 }] }
    ])
  });
  await selectTab(container, 'clinicaldetails');
  for (const [id, owner, label, type, value] of units) {
    expect(node(id).item.type).toBe('display');
    expect(requireItem(container, owner).textContent).toContain(label);
    expect(answers(id)).toEqual([]);
    if (owner !== units[2][1]) await inputText(container, owner, String(value));
    await waitFor(() => expectAnswers(owner, [{ [type]: value }]));
  }
  // BMI recalculates from 180cm/81kg; the protected owner remains a decimal in the same row.
  expectAnswers(units[2][1], [{ valueDecimal: 25 }]);
  for (const [, owner, , type, value] of units)
    expectAnswers(owner, [{ [type]: value }]);
  for (const id of [
    'clinicaldetails-observations-maingrid',
    'clinicaldetails-observations-bpgrid',
    'clinicaldetails-observations-substanceusegrid'
  ])
    expect(requireItem(container, id)).toBeDefined();
});

test('S6 protected checkbox: true and false remain boolean and reject user changes', async () => {
  const id = 'patient-contact-homeaddress-nofixedaddress';
  for (const valueBoolean of [true, false]) {
    const rendered = await renderGpccmp({
      questionnaireResponse: saved([{ id, answer: [{ valueBoolean }] }])
    });
    const input = requireItem(
      rendered.container,
      id
    ).querySelector<HTMLInputElement>('input[type="checkbox"]')!;
    expect(input.checked).toBe(valueBoolean);
    expect(input.disabled || input.readOnly).toBe(true);
    const { checkCheckBox } = await import('@aehrc/questionnaire-test-toolkit');
    await expect(checkCheckBox(rendered.container, id)).rejects.toThrow(
      /disabled|read.only/
    );
    expectAnswers(id, [{ valueBoolean }]);
    rendered.unmount();
    destroyForm();
  }
});

const protectedControls = [
  'patient-preferredpronouns',
  'patient-sexatbirth',
  'patient-genderidentity',
  'patient-firstnationsstatus',
  'patient-contact-homeaddress-details-state',
  'patient-contact-postaladdress-state',
  'practitioner-clinicdetails-address-state',
  'clinicaldetails-problemsdiagnoses-recordedproblems-condition',
  'clinicaldetails-allergies-recordedallergies-substance',
  'clinicaldetails-allergies-recordedallergies-manifestation',
  'clinicaldetails-medications-recordedmedications-medication',
  'clinicaldetails-medications-recordedmedications-indication'
];
// The Slice 5 mounted protected-tab cases directly assert these visible labels, typed
// saved coding identities and lock refusals; the fresh full run retains those scenarios.
test('S6 control ledger accounts for all 51 declarations and their layout disposition', () => {
  const radioIds = [
    'patient-myagedcare-registered',
    'patient-ndis-registered',
    'patient-contacts-present',
    'plan-type',
    'completion-review-appointmentstatus',
    'completion-copyoffered'
  ];
  const structuralIds = [
    'container',
    'clinicaldetails-observations-maingrid',
    'clinicaldetails-observations-bpgrid',
    'clinicaldetails-observations-substanceusegrid',
    'clinicaldetails-problemsdiagnoses-recordedproblems',
    'clinicaldetails-problemsdiagnoses-newproblems',
    'plan-goalstasks-details-interventionsactions',
    'plan-goalstasks-details-servicestreatments'
  ];
  const expected = [
    ...autocompletes.map(([id]) => id),
    ...dropdowns.map(([id]) => id),
    ...radioIds,
    ...units.map(([id]) => id),
    ...protectedControls,
    'patient-contact-homeaddress-nofixedaddress',
    ...structuralIds
  ];
  const declared = nodes.filter((n) =>
    n.item.extension?.some((e) => e.url.endsWith('questionnaire-itemControl'))
  );
  expect(declared).toHaveLength(51);
  expect(declared.map((n) => n.item.linkId).sort()).toEqual(expected.sort());
  // Layout/navigation and actual geometry remain Slice 7, including the tab-container.
});
