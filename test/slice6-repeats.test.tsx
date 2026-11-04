import type { PractitionerRole } from 'fhir/r4';
import { act, fireEvent, waitFor } from '@testing-library/react';
import {
  addRepeatGroup,
  removeRepeatGroup,
  addTableRow,
  removeTableRow,
  addRepeatAnswer,
  removeRepeatAnswer,
  inputText
} from '@aehrc/questionnaire-test-toolkit';
import { useFormEnvironment } from './support/environment';
import { requireItem, queryItems } from './support/items';
import { renderGpccmp, selectTab } from './support/form';
import { practitionerRole } from './support/fixtures';
import {
  answers,
  expectAnswers,
  expectGroupCount,
  node,
  nodes,
  saved,
  string,
  sct,
  openGoals
} from './support/slice6';

useFormEnvironment();

test('S6 patient-contacts: add, change, clear and remove preserve the exact sibling', async () => {
  const group = 'patient-contacts',
    field = 'patient-contacts-name';
  const { container } = await renderGpccmp();
  await inputText(requireItem(container, group), field, 'Alice');
  const second = await addRepeatGroup(container, group);
  await inputText(second, field, 'Bob');
  expectAnswers(field, string('Alice'), { [group]: 0 });
  expectAnswers(field, string('Bob'), { [group]: 1 });
  const first = queryItems(container, group)[0]!;
  await inputText(first, field, 'Alice changed');
  expectAnswers(field, string('Alice changed'), { [group]: 0 });
  expectAnswers(field, string('Bob'), { [group]: 1 });
  await inputText(first, field, '');
  expectAnswers(field, [], { [group]: 0 });
  expectAnswers(field, string('Bob'), { [group]: 1 });
  await inputText(first, field, 'Alice restored');
  await removeRepeatGroup(first);
  await waitFor(() => expect(queryItems(container, group)).toHaveLength(1));
  expectAnswers(field, string('Bob'), { [group]: 0 });
  expectGroupCount(group, 1);
});

const editableGroups = [
  [
    'clinicaldetails-problemsdiagnoses-newproblems',
    'clinicaldetails-problemsdiagnoses-newproblems-comment',
    true
  ],
  [
    'clinicaldetails-allergies-newallergies',
    'clinicaldetails-allergies-newallergies-comment',
    false
  ],
  [
    'clinicaldetails-medications-newmedications',
    'clinicaldetails-medications-newmedications-dosage',
    false
  ],
  ['plan-conditions', 'plan-conditions-comments', false],
  [
    'plan-goalstasks-details-goalsetting',
    'plan-goalstasks-details-goalsetting-goals',
    false
  ],
  [
    'plan-goalstasks-details-interventionsactions',
    'plan-goalstasks-details-interventionsactions-owner',
    true
  ],
  [
    'plan-goalstasks-details-servicestreatments',
    'plan-goalstasks-details-servicestreatments-provider',
    true
  ]
] as const;

async function enter(scope: HTMLElement, id: string, value: string) {
  const root = requireItem(scope, id);
  // Option-based open choices show a selected answer as a token beside an empty textbox.
  // Use its Clear control before replacing that token with custom text.
  if (root.querySelector('.MuiAutocomplete-tag')) {
    const clear = root.querySelector<HTMLButtonElement>(
      'button[title="Clear"]'
    );
    if (clear)
      await act(async () => {
        fireEvent.click(clear);
      });
  }
  const input = requireItem(scope, id).querySelector<HTMLInputElement>(
    'input, textarea'
  )!;
  await act(async () => {
    input.focus();
  });
  await inputText(scope, id, value);
  await act(async () => {
    if (input.getAttribute('role') === 'combobox')
      fireEvent.keyDown(input, { key: 'Enter' });
    input.blur();
  });
}
function rows(scope: HTMLElement, group: string, table: boolean) {
  return table
    ? Array.from(
        requireItem(scope, group).querySelectorAll<HTMLElement>('tbody > tr')
      )
    : queryItems(scope, group);
}

for (const [group, field, table] of editableGroups) {
  test(`S6 repeat ${group}: add/change/clear/remove with sibling and parent isolation`, async () => {
    const nested = group.startsWith('plan-goalstasks-');
    const outer = 'plan-goalstasks';
    const { container } = await renderGpccmp({
      questionnaireResponse: nested
        ? saved([
            {
              id: `${outer}-problemneed`,
              answer: string('Parent A'),
              occurrences: { [outer]: 0 }
            },
            {
              id: `${outer}-problemneed`,
              answer: string('Parent B'),
              occurrences: { [outer]: 1 }
            },
            {
              id: field,
              answer: string('Other parent child'),
              occurrences: { [outer]: 1 }
            }
          ])
        : undefined
    });
    await selectTab(container, node(group).path[1]);
    if (nested) await openGoals(container);
    const scope = nested ? queryItems(container, outer)[0]! : container;
    const first = rows(scope, group, table)[0]!;
    const marker = {
      'clinicaldetails-problemsdiagnoses-newproblems':
        'clinicaldetails-problemsdiagnoses-newproblems-condition',
      'clinicaldetails-allergies-newallergies':
        'clinicaldetails-allergies-newallergies-substance',
      'clinicaldetails-medications-newmedications':
        'clinicaldetails-medications-newmedications-medication',
      'plan-conditions': 'plan-conditions-condition',
      'plan-goalstasks-details-goalsetting':
        'plan-goalstasks-details-goalsetting-initiator',
      'plan-goalstasks-details-interventionsactions':
        'plan-goalstasks-details-interventionsactions-comment',
      'plan-goalstasks-details-servicestreatments':
        'plan-goalstasks-details-servicestreatments-comment'
    }[group];
    await enter(first, marker, 'First row association');
    await enter(first, field, 'First instance');
    const second = table
      ? await addTableRow(scope, group)
      : await addRepeatGroup(scope, group);
    await enter(second, marker, 'Second row association');
    await enter(second, field, 'Second instance');
    const check = (firstValue: string | null) => {
      expectAnswers(field, firstValue === null ? [] : string(firstValue), {
        [group]: 0
      });
      expectAnswers(field, string('Second instance'), { [group]: 1 });
      expectAnswers(marker, string('First row association'), { [group]: 0 });
      expectAnswers(marker, string('Second row association'), { [group]: 1 });
      if (nested) {
        expectAnswers(field, string('Other parent child'), { [outer]: 1 });
        expectAnswers(`${outer}-problemneed`, string('Parent A'), {
          [outer]: 0
        });
        expectAnswers(`${outer}-problemneed`, string('Parent B'), {
          [outer]: 1
        });
      }
    };
    check('First instance');
    await enter(first, field, 'Changed instance');
    check('Changed instance');
    await enter(first, field, '');
    check(null);
    await enter(first, field, 'Restored instance');
    if (table) await removeTableRow(first);
    else await removeRepeatGroup(first);
    await waitFor(() => expect(rows(scope, group, table)).toHaveLength(1));
    expectAnswers(field, string('Second instance'));
    expectAnswers(marker, string('Second row association'));
    expectGroupCount(group, 1);
    if (nested)
      expectAnswers(field, string('Other parent child'), { [outer]: 1 });
  });
}

const editableQuestions = [
  'patient-contacts-role',
  'patient-contacts-phone',
  'patient-contacts-email',
  'clinicaldetails-allergies-newallergies-manifestation',
  'clinicaldetails-medications-newmedications-indication',
  'plan-goalstasks-problemneed',
  'notes-additionalcomments'
];
for (const id of editableQuestions) {
  test(`S6 answers ${id}: distinct values, add/change/clear/remove and sibling scope`, async () => {
    const parent = node(id)
      .path.slice(0, -1)
      .reverse()
      .find((p) => node(p).item.repeats);
    const marker =
      parent === 'patient-contacts'
        ? 'patient-contacts-name'
        : parent === 'plan-goalstasks'
          ? 'plan-goalstasks-details-goalsetting-goals'
          : parent === 'clinicaldetails-allergies-newallergies'
            ? 'clinicaldetails-allergies-newallergies-comment'
            : parent === 'clinicaldetails-medications-newmedications'
              ? 'clinicaldetails-medications-newmedications-dosage'
              : undefined;
    const { container } = await renderGpccmp({
      questionnaireResponse:
        marker && parent
          ? saved([
              { id: marker, answer: string('First parent') },
              {
                id: marker,
                answer: string('Second parent'),
                occurrences: { [parent]: 1 }
              },
              {
                id,
                answer: string('Untouched sibling'),
                occurrences: { [parent]: 1 }
              }
            ])
          : undefined
    });
    await selectTab(container, node(id).path[1]);
    if (id.startsWith('plan-goalstasks')) await openGoals(container);
    const scope = parent ? queryItems(container, parent)[0]! : container;
    await enter(scope, id, 'First answer');
    const second = await addRepeatAnswer(scope, id);
    await enter(second, id, 'Second answer');
    expectAnswers(id, [...string('First answer'), ...string('Second answer')]);
    const collection = requireItem(scope, id);
    const first = collection.querySelector<HTMLElement>('.MuiCollapse-root')!;
    await enter(first, id, 'Changed answer');
    expectAnswers(id, [
      ...string('Changed answer'),
      ...string('Second answer')
    ]);
    await enter(first, id, '');
    expectAnswers(id, string('Second answer'));
    await enter(first, id, 'Restored answer');
    await removeRepeatAnswer(first);
    expectAnswers(id, string('Second answer'));
    if (marker && parent) {
      expectAnswers(id, string('Untouched sibling'), { [parent]: 1 });
      expectAnswers(marker, string('First parent'));
      expectAnswers(marker, string('Second parent'), { [parent]: 1 });
    }
  });
}

const multiRole: PractitionerRole = {
  ...practitionerRole,
  telecom: [
    { system: 'phone', value: '0333333333' },
    { system: 'phone', value: '0344444444' },
    { system: 'email', value: 'clinic1@example.com' },
    { system: 'email', value: 'clinic2@example.com' }
  ],
  identifier: [
    {
      system: 'http://ns.electronichealth.net.au/id/medicare-provider-number',
      value: '1234561A'
    },
    {
      system: 'http://ns.electronichealth.net.au/id/medicare-provider-number',
      value: '2345671B'
    }
  ]
};
const protectedQuestions = [
  ['patient-contact-homephone', string('0311111111'), string('0322222222')],
  ['patient-contact-mobilephone', string('0411111111'), string('0422222222')],
  [
    'patient-contact-email',
    string('first@example.com'),
    string('second@example.com')
  ],
  ['practitioner-phone', string('0333333333'), string('0344444444')],
  [
    'practitioner-email',
    string('clinic1@example.com'),
    string('clinic2@example.com')
  ],
  [
    'practitioner-medicareprovidernumber',
    string('1234561A'),
    string('2345671B')
  ],
  [
    'clinicaldetails-allergies-recordedallergies-manifestation',
    [{ valueCoding: sct('271807003', 'Rash') }],
    [{ valueCoding: sct('422587007', 'Nausea') }]
  ],
  [
    'clinicaldetails-medications-recordedmedications-indication',
    [{ valueCoding: sct('25064002', 'Headache') }],
    [{ valueCoding: sct('386661006', 'Fever') }]
  ]
] as const;
for (const [id, first, second] of protectedQuestions) {
  test(`S6 protected answers ${id}: multiple typed values, actual locks, remount`, async () => {
    const expected = [...first, ...second];
    const response = saved([{ id, answer: expected }]);
    const mount = async () => {
      const rendered = await renderGpccmp({
        questionnaireResponse: response,
        role: multiRole
      });
      await selectTab(rendered.container, node(id).path[1]);
      const root = requireItem(rendered.container, id);
      const controls = Array.from(
        root.querySelectorAll<HTMLInputElement>('input, textarea')
      ).filter((c) => !c.hasAttribute('aria-hidden'));
      expect(controls).toHaveLength(2);
      for (const [index, control] of controls.entries()) {
        expect(control.disabled || control.readOnly).toBe(true);
        const answer = expected[index];
        expect(control.value).toBe(
          'valueString' in answer
            ? answer.valueString
            : answer.valueCoding?.display
        );
      }
      await expect(
        inputText(rendered.container, id, 'Overwrite')
      ).rejects.toThrow(/read.only|disabled/);
      await expect(addRepeatAnswer(rendered.container, id)).rejects.toThrow(
        /disabled|not found/
      );
      await expect(
        removeRepeatAnswer(
          root.querySelector<HTMLElement>('.MuiCollapse-root')!
        )
      ).rejects.toThrow(/disabled/);
      expectAnswers(id, expected);
      return rendered;
    };
    const firstMount = await mount();
    firstMount.unmount();
    // Supported renderer lifecycle, rather than editing its stores or installed internals.
    const { destroyForm } = await import('@aehrc/smart-forms-renderer');
    destroyForm();
    await mount();
  });
}

for (const [group, field, first, second] of [
  ['patient-medicare', 'patient-medicare-number', '1234567890', '2345678901'],
  [
    'patient-contact-homeaddress-details',
    'patient-contact-homeaddress-details-streetaddress',
    '1 First Street',
    '2 Second Street'
  ],
  [
    'patient-contact-postaladdress',
    'patient-contact-postaladdress-streetaddress',
    'PO Box 10',
    'PO Box 20'
  ]
] as const) {
  test(`S6 protected group ${group}: two saved instances, locks and reload retention`, async () => {
    const response = saved([
      { id: field, answer: string(first), occurrences: { [group]: 0 } },
      { id: field, answer: string(second), occurrences: { [group]: 1 } }
    ]);
    for (let load = 0; load < 2; load++) {
      const rendered = await renderGpccmp({ questionnaireResponse: response });
      const instances = queryItems(rendered.container, group);
      expect(instances).toHaveLength(2);
      for (const [index, instance] of instances.entries()) {
        const control = requireItem(
          instance,
          field
        ).querySelector<HTMLInputElement>('input, textarea')!;
        expect(control.value).toBe(index === 0 ? first : second);
        expect(control.disabled || control.readOnly).toBe(true);
        await expect(inputText(instance, field, 'Overwrite')).rejects.toThrow(
          /read.only|disabled/
        );
        await expect(removeRepeatGroup(instance)).rejects.toThrow(
          /disabled|not found/
        );
      }
      await expect(addRepeatGroup(rendered.container, group)).rejects.toThrow(
        /disabled|not found/
      );
      expectAnswers(field, string(first), { [group]: 0 });
      expectAnswers(field, string(second), { [group]: 1 });
      rendered.unmount();
      const { destroyForm } = await import('@aehrc/smart-forms-renderer');
      destroyForm();
    }
  });
}

for (const [group, protectedField, coding, field, table] of [
  [
    'clinicaldetails-problemsdiagnoses-recordedproblems',
    'clinicaldetails-problemsdiagnoses-recordedproblems-condition',
    sct('195967001', 'Asthma'),
    'clinicaldetails-problemsdiagnoses-recordedproblems-clinicalstatus',
    true
  ],
  [
    'clinicaldetails-allergies-recordedallergies',
    'clinicaldetails-allergies-recordedallergies-substance',
    sct('764146007', 'Penicillin'),
    'clinicaldetails-allergies-recordedallergies-comment',
    false
  ],
  [
    'clinicaldetails-medications-recordedmedications',
    'clinicaldetails-medications-recordedmedications-medication',
    sct('23628011000036109', 'Paracetamol 500 mg tablet'),
    'clinicaldetails-medications-recordedmedications-dosage',
    false
  ]
] as const) {
  test(`S6 recorded ${group}: protected row identity, editable changes and scoped removal`, async () => {
    const { chooseSelectOption } = await import(
      '@aehrc/questionnaire-test-toolkit'
    );
    const { container } = await renderGpccmp({
      questionnaireResponse: saved([
        {
          id: protectedField,
          answer: [{ valueCoding: coding }],
          occurrences: { [group]: 0 }
        },
        {
          id: protectedField,
          answer: string('Second recorded identity'),
          occurrences: { [group]: 1 }
        },
        ...(!table
          ? [
              {
                id: field,
                answer: string('First recorded value'),
                occurrences: { [group]: 0 }
              },
              {
                id: field,
                answer: string('Second recorded value'),
                occurrences: { [group]: 1 }
              }
            ]
          : [])
      ])
    });
    await selectTab(container, 'clinicaldetails');
    let instances = rows(container, group, table);
    expect(instances).toHaveLength(2);
    if (table) {
      await chooseSelectOption(instances[0]!, field, 'Active');
      await chooseSelectOption(instances[1]!, field, 'Resolved');
      await waitFor(() =>
        expectAnswers(field, [
          {
            valueCoding: {
              system:
                'http://terminology.hl7.org/CodeSystem/condition-clinical',
              code: 'active',
              display: 'Active'
            }
          }
        ])
      );
      expectAnswers(
        field,
        [
          {
            valueCoding: {
              system:
                'http://terminology.hl7.org/CodeSystem/condition-clinical',
              code: 'resolved',
              display: 'Resolved'
            }
          }
        ],
        { [group]: 1 }
      );
    } else {
      await enter(instances[0]!, field, 'Changed recorded value');
      expectAnswers(field, string('Changed recorded value'));
      expectAnswers(field, string('Second recorded value'), { [group]: 1 });
      await enter(instances[0]!, field, '');
      expectAnswers(field, []);
      expectAnswers(field, string('Second recorded value'), { [group]: 1 });
      await enter(instances[0]!, field, 'Restored recorded value');
    }
    expectAnswers(protectedField, [{ valueCoding: coding }]);
    expectAnswers(protectedField, string('Second recorded identity'), {
      [group]: 1
    });
    await expect(
      inputText(instances[0]!, protectedField, 'Overwrite')
    ).rejects.toThrow(/disabled|read.only/);
    if (table)
      await expect(addTableRow(container, group)).rejects.toThrow(/not found/);
    else
      await expect(addRepeatGroup(container, group)).rejects.toThrow(
        /not found/
      );
    if (table) await removeTableRow(instances[0]!);
    else await removeRepeatGroup(instances[0]!);
    await waitFor(() => expect(rows(container, group, table)).toHaveLength(1));
    expectAnswers(protectedField, string('Second recorded identity'));
    expectGroupCount(group, 1);
    if (!table) expectAnswers(field, string('Second recorded value'));
  });
}

test('S6 plan-goalstasks: add and remove a parent retains its nested goals and neighboring parent associations', async () => {
  const outer = 'plan-goalstasks',
    field = 'plan-goalstasks-details-goalsetting-goals';
  const { container } = await renderGpccmp({
    questionnaireResponse: saved([
      { id: `${outer}-problemneed`, answer: string('First problem') },
      { id: field, answer: string('First goal') }
    ])
  });
  await selectTab(container, 'plan');
  await openGoals(container);
  const second = await addRepeatGroup(container, outer);
  await enter(second, `${outer}-problemneed`, 'Second problem');
  await enter(
    second,
    'plan-goalstasks-details-goalsetting-initiator',
    'Second nested owner'
  );
  await enter(second, field, 'Second goal');
  expectAnswers(field, string('First goal'));
  expectAnswers(field, string('Second goal'), { [outer]: 1 });
  await enter(second, field, 'Second goal changed');
  expectAnswers(field, string('First goal'));
  expectAnswers(field, string('Second goal changed'), { [outer]: 1 });
  await enter(second, field, '');
  expectAnswers(field, [], { [outer]: 1 });
  expectAnswers(field, string('First goal'));
  await enter(second, field, 'Second goal restored');
  await removeRepeatGroup(queryItems(container, outer)[0]!);
  await waitFor(() => expect(queryItems(container, outer)).toHaveLength(1));
  expectAnswers(`${outer}-problemneed`, string('Second problem'));
  expectAnswers(field, string('Second goal restored'));
  expectGroupCount(outer, 1);
});

test('S6 scenario inventory covers every repeated group and question', () => {
  const groups = [
    ...editableGroups.map(([id]) => id),
    'patient-contacts',
    'patient-medicare',
    'patient-contact-homeaddress-details',
    'patient-contact-postaladdress',
    'clinicaldetails-problemsdiagnoses-recordedproblems',
    'clinicaldetails-allergies-recordedallergies',
    'clinicaldetails-medications-recordedmedications',
    'plan-goalstasks'
  ];
  expect(
    nodes
      .filter((n) => n.item.repeats && n.item.type === 'group')
      .map((n) => n.item.linkId)
      .sort()
  ).toEqual(groups.sort());
  expect(
    nodes
      .filter((n) => n.item.repeats && n.item.type !== 'group')
      .map((n) => n.item.linkId)
      .sort()
  ).toEqual(
    [...editableQuestions, ...protectedQuestions.map(([id]) => id)].sort()
  );
});
