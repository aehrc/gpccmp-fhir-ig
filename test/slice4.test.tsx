import type { Address, Practitioner, PractitionerRole } from 'fhir/r4';
import { vi } from 'vitest';
import {
  act,
  fireEvent,
  waitFor,
  within,
  screen
} from '@testing-library/react';
import {
  inputText,
  chooseSelectOption,
  selectTab
} from '@aehrc/questionnaire-test-toolkit';
import { useFormEnvironment } from './support/environment';
import { queryItem, requireItem } from './support/items';
import {
  answerAt,
  clinicAddressPath,
  responseForPersistence,
  getInputText,
  patientPath,
  renderGpccmp
} from './support/form';
import {
  patient,
  practitioner,
  practitionerRole,
  clinicLocation
} from './support/fixtures';

useFormEnvironment();
const providerSystem =
  'http://ns.electronichealth.net.au/id/medicare-provider-number';

for (const [birthDate, age] of [
  ['1976-08-16', 50],
  ['1976-08-17', 50],
  ['1976-08-18', 49]
] as const) {
  test(`S4 birthday ${birthDate}: age ${age} and My Aged Care`, async () => {
    const { container } = await renderGpccmp({
      patient: { ...patient, birthDate }
    });
    expect(await getInputText(container, 'patient-age')).toBe(String(age));
    expect(answerAt(patientPath, 'patient-age')).toEqual([
      { valueInteger: age }
    ]);
    expect(Boolean(queryItem(container, 'patient-myagedcare'))).toBe(age >= 50);
  });
}

for (const postal of [true, false]) {
  test(`S4 postal context ${postal ? 'present' : 'absent'}`, async () => {
    // Call through: retain every diagnostic while asserting this particular defect is absent.
    const diagnostic = vi.spyOn(console, 'warn');
    const error = vi.spyOn(console, 'error');
    try {
      const { container } = await renderGpccmp({
        patient: {
          ...patient,
          address: postal
            ? [
                {
                  type: 'postal',
                  use: 'home',
                  line: ['PO Box 42'],
                  city: 'Sydney',
                  state: 'NSW',
                  postalCode: '2000'
                }
              ]
            : []
        }
      });
      expect(
        Boolean(queryItem(container, 'patient-contact-postaladdress'))
      ).toBe(postal);
      const path = [
        ...patientPath,
        'patient-contact',
        'patient-contact-postaladdress'
      ];
      expect(
        answerAt(path, 'patient-contact-postaladdress-streetaddress') ?? []
      ).toEqual(postal ? [{ valueString: 'PO Box 42' }] : []);
      if (postal)
        expect(
          await getInputText(
            container,
            'patient-contact-postaladdress-streetaddress'
          )
        ).toBe('PO Box 42');
      for (const [suffix, visible, answer] of [
        ['city', 'Sydney', { valueString: 'Sydney' }],
        [
          'state',
          'New South Wales',
          {
            valueCoding: {
              system:
                'https://healthterminologies.gov.au/fhir/CodeSystem/australian-states-territories-1',
              code: 'NSW',
              display: 'New South Wales'
            }
          }
        ],
        ['postcode', '2000', { valueString: '2000' }]
      ] as const) {
        const id = `patient-contact-postaladdress-${suffix}`;
        expect(answerAt(path, id) ?? []).toEqual(postal ? [answer] : []);
        expect(answerAt(path, id, responseForPersistence()) ?? []).toEqual(
          postal ? [answer] : []
        );
        if (postal) expect(await getInputText(container, id)).toBe(visible);
      }
      expect(
        [...diagnostic.mock.calls, ...error.mock.calls]
          .map((args) => args.map(String).join(' '))
          .filter((s) => s.includes('undefined environment variable:'))
      ).toEqual([]);
    } finally {
      diagnostic.mockRestore();
      error.mockRestore();
    }
  });
}

const main = 'clinicaldetails-observations-maingrid';
const substance = 'clinicaldetails-observations-substanceusegrid';
const bp = 'clinicaldetails-observations-bpgrid-bp';
const observationPath = [
  'container',
  'clinicaldetails',
  'clinicaldetails-observations'
];

// Literal inputs/answers: no expected value is evaluated from the form's expressions.
for (const [grid, row, dateSuffix, first, changed, type] of [
  [main, 'height', 'newresultdate', 170.55, 180, 'valueDecimal'],
  [main, 'weight', 'newresultdate', 70.32, 80, 'valueDecimal'],
  [main, 'waistcircumference', 'newdate', 80.55, 90, 'valueDecimal'],
  [main, 'pulserate', 'newresultdate', 70, 80, 'valueInteger'],
  [main, 'oxygensaturation', 'newresultdate', 95, 98, 'valueInteger']
] as const) {
  test(`S4 date ${row}: empty/set/change/clear/reset`, async () => {
    const { container } = await renderGpccmp();
    await selectTab(container, 'clinicaldetails');
    const parent = `${grid}-${row}`;
    const source = `${parent}-newresultvalue`;
    const date = `${parent}-${dateSuffix}`;
    const path = [...observationPath, grid, parent];
    await expectDate(container, path, date, false);
    for (const value of [first, changed, '', first]) {
      await inputText(container, source, String(value));
      await waitFor(() =>
        expect(answerAt(path, source) ?? []).toEqual(
          value === '' ? [] : [{ [type]: value }]
        )
      );
      await expectDate(container, path, date, value !== '');
    }
  });
}

for (const [grid, row, first, changed, firstCode, changedCode] of [
  [
    main,
    'pulserhythm',
    'Pulse regular',
    'Pulse irregular',
    '271636001',
    '61086009'
  ],
  [
    substance,
    'smokingstatus',
    'Current smoker',
    'Former smoker',
    '77176002',
    '8517006'
  ],
  [
    substance,
    'alcoholstatus',
    'Current drinker',
    'Former drinker',
    '219006',
    '82581004'
  ]
] as const) {
  test(`S4 date ${row}: coded set/change/clear/reset`, async () => {
    const { container } = await renderGpccmp();
    await selectTab(container, 'clinicaldetails');
    const parent = `${grid}-${row}`;
    const source = `${parent}-newresultvalue`;
    const date = `${parent}-newresultdate`;
    const path = [...observationPath, grid, parent];
    await expectDate(container, path, date, false);
    await waitFor(
      () =>
        expect(
          requireItem(container, source).querySelector('input, textarea')
        ).not.toBeNull(),
      { timeout: 10000 }
    );
    for (const [label, code] of [
      [first, firstCode],
      [changed, changedCode]
    ] as const) {
      if (label === first) {
        await chooseSelectOption(container, source, label);
      } else {
        await act(async () => {
          fireEvent.click(
            within(requireItem(container, source)).getByRole('button', {
              name: 'Open'
            })
          );
        });
        const option = await screen.findByRole('option', {
          name: label
        });
        await act(async () => {
          fireEvent.click(option);
        });
      }
      await waitFor(() =>
        expect(answerAt(path, source)).toEqual([
          {
            valueCoding: {
              system: 'http://snomed.info/sct',
              code,
              display: label
            }
          }
        ])
      );
      await expectDate(container, path, date, true);
    }
    // MUI's real clear button, within the exact editable item, clears the coding.
    const clear = within(requireItem(container, source)).getByRole('button', {
      name: 'Clear'
    });
    expect(clear.hasAttribute('disabled')).toBe(false);
    await act(async () => {
      fireEvent.click(clear);
    });
    await waitFor(() => expect(answerAt(path, source) ?? []).toEqual([]));
    await expectDate(container, path, date, false);
    await chooseSelectOption(container, source, first);
    await expectDate(container, path, date, true);
  });
}

async function expectDate(
  container: HTMLElement,
  path: string[],
  id: string,
  present: boolean
) {
  await waitFor(async () => {
    expect(await getInputText(container, id)).toBe(present ? '17/08/2026' : '');
    expect(answerAt(path, id) ?? []).toEqual(
      present ? [{ valueDate: '2026-08-17' }] : []
    );
  });
}

test('S4 BP: neither/systolic/both/diastolic/neither/change/reset', async () => {
  const { container } = await renderGpccmp();
  await selectTab(container, 'clinicaldetails');
  const path = [...observationPath, 'clinicaldetails-observations-bpgrid', bp];
  const date = `${bp}-newresultdate`;
  await expectDate(container, path, date, false);
  for (const [systolic, diastolic] of [
    [120, ''],
    [120, 80],
    ['', 80],
    ['', ''],
    ['', 85],
    [130, 85],
    [130, ''],
    ['', '']
  ] as const) {
    await inputText(container, `${bp}-newresultsystolic`, String(systolic));
    await inputText(container, `${bp}-newresultdiastolic`, String(diastolic));
    await waitFor(() => {
      expect(answerAt(path, `${bp}-newresultsystolic`) ?? []).toEqual(
        systolic === '' ? [] : [{ valueInteger: systolic }]
      );
      expect(answerAt(path, `${bp}-newresultdiastolic`) ?? []).toEqual(
        diastolic === '' ? [] : [{ valueInteger: diastolic }]
      );
    });
    await expectDate(
      container,
      path,
      date,
      systolic !== '' || diastolic !== ''
    );
  }
});

test('S4 BMI: missing/zero/change/clear and protected result', async () => {
  const { container } = await renderGpccmp();
  await selectTab(container, 'clinicaldetails');
  const path = [...observationPath, main, `${main}-bmi`];
  const result = `${main}-bmi-newresultvalue`;
  const check = async (expected?: number) => {
    await waitFor(async () => {
      expect(await getInputText(container, result)).toBe(
        expected === undefined ? '' : String(expected)
      );
      expect(answerAt(path, result) ?? []).toEqual(
        expected === undefined ? [] : [{ valueDecimal: expected }]
      );
    });
  };
  await check();
  await inputText(container, `${main}-weight-newresultvalue`, '70.32');
  await check();
  await inputText(container, `${main}-height-newresultvalue`, '0');
  await check();
  await inputText(container, `${main}-height-newresultvalue`, '170.55');
  await check(24.2);
  await inputText(container, `${main}-weight-newresultvalue`, '0');
  await check(0);
  await inputText(container, `${main}-weight-newresultvalue`, '80');
  await check(27.5);
  await inputText(container, `${main}-height-newresultvalue`, '200');
  await check(20);
  await inputText(container, `${main}-weight-newresultvalue`, '');
  await check();
  await inputText(container, `${main}-height-newresultvalue`, '');
  await check();
  await inputText(container, `${main}-height-newresultvalue`, '170.55');
  await check();
  await inputText(container, `${main}-weight-newresultvalue`, '70.32');
  await check(24.2);
  await expect(inputText(container, result, '99')).rejects.toThrow(
    /read.only|disabled|protected/i
  );
  await check(24.2);
});

for (const [name, user, role, expectedName, phones, emails, providers] of [
  [
    'missing',
    { ...practitioner, name: [] },
    { ...practitionerRole, telecom: [], identifier: [] },
    '',
    [],
    [],
    []
  ],
  [
    'single',
    practitioner,
    {
      ...practitionerRole,
      telecom: [
        { system: 'phone', value: '0311111111' },
        { system: 'email', value: 'one@example.com' }
      ],
      identifier: [{ system: providerSystem, value: '1234561A' }]
    },
    'Jane Smith',
    ['0311111111'],
    ['one@example.com'],
    ['1234561A']
  ],
  [
    'multiple official preferred',
    {
      ...practitioner,
      name: [
        { use: 'usual', text: 'Usual Name' },
        { use: 'official', given: ['Ada', 'Jane'], family: 'Jones' },
        { use: 'official', text: 'Later Official' }
      ]
    },
    {
      ...practitionerRole,
      telecom: [
        { system: 'phone', value: '0311111111' },
        { system: 'phone', value: '0322222222' },
        { system: 'email', value: 'one@example.com' },
        { system: 'email', value: 'two@example.com' },
        { system: 'fax', value: '0399999999' }
      ],
      identifier: [
        { system: providerSystem, value: '1234561A' },
        { system: providerSystem, value: '2345672B' },
        { system: 'urn:other', value: 'exclude-me' }
      ]
    },
    'Ada Jane Jones',
    ['0311111111', '0322222222'],
    ['one@example.com', 'two@example.com'],
    ['1234561A', '2345672B']
  ],
  [
    'fallback text',
    {
      ...practitioner,
      name: [{ use: 'usual', text: 'Dr Alex Lee' }, { text: 'Later Name' }]
    },
    practitionerRole,
    'Dr Alex Lee',
    [],
    [],
    []
  ]
] satisfies readonly [
  string,
  Practitioner,
  PractitionerRole,
  string,
  string[],
  string[],
  string[]
][]) {
  test(`S4 practitioner calculations ${name}`, async () => {
    const { container } = await renderGpccmp({ user, role });
    await selectTab(container, 'practitioner');
    expect(await getInputText(container, 'practitioner-name')).toBe(
      expectedName
    );
    expect(
      answerAt(['container', 'practitioner'], 'practitioner-name') ?? []
    ).toEqual(expectedName ? [{ valueString: expectedName }] : []);
    for (const [id, values] of [
      ['practitioner-phone', phones],
      ['practitioner-email', emails],
      ['practitioner-medicareprovidernumber', providers]
    ] as const) {
      expect(answerAt(['container', 'practitioner'], id) ?? []).toEqual(
        values.map((valueString) => ({ valueString }))
      );
      const item = requireItem(container, id);
      const inputs = within(item)
        .getAllByRole('textbox')
        .map(
          (input) => (input as HTMLInputElement | HTMLTextAreaElement).value
        );
      expect(inputs.filter(Boolean)).toEqual(values);
    }
  });
}

for (const [variant, address, structured, text] of [
  [
    'lines only',
    {
      line: ['1 Clinic Road', 'Suite 2'],
      city: 'Melbourne',
      postalCode: '3000'
    },
    true,
    false
  ],
  ['text only', { text: 'Clinic written address' }, false, true],
  [
    'both',
    {
      line: ['1 Clinic Road', 'Suite 2'],
      text: 'Clinic written address',
      city: 'Melbourne',
      postalCode: '3000'
    },
    false,
    true
  ],
  ['neither', {}, true, false]
] satisfies readonly [string, Address, boolean, boolean][]) {
  test(`S4 clinic address ${variant}`, async () => {
    const { container } = await renderGpccmp({
      location: { ...clinicLocation, address }
    });
    await selectTab(container, 'practitioner');
    expect(
      Boolean(queryItem(container, 'practitioner-clinicdetails-address'))
    ).toBe(structured);
    expect(
      Boolean(queryItem(container, 'practitioner-clinicdetails-addresstext'))
    ).toBe(text);
    const expectedLines = address.line
      ? [{ valueString: '1 Clinic Road, Suite 2' }]
      : [];
    const textPath = [
      'container',
      'practitioner',
      'practitioner-clinicdetails'
    ];
    // Raw population may retain disabled alternatives. Persistence follows enabled precedence.
    expect(
      answerAt(
        clinicAddressPath,
        'practitioner-clinicdetails-address-streetaddress'
      ) ?? []
    ).toEqual(expectedLines);
    expect(
      answerAt(textPath, 'practitioner-clinicdetails-addresstext') ?? []
    ).toEqual(address.text ? [{ valueString: 'Clinic written address' }] : []);
    expect(
      answerAt(
        clinicAddressPath,
        'practitioner-clinicdetails-address-streetaddress',
        responseForPersistence()
      ) ?? []
    ).toEqual(structured ? expectedLines : []);
    expect(
      answerAt(
        textPath,
        'practitioner-clinicdetails-addresstext',
        responseForPersistence()
      ) ?? []
    ).toEqual(text ? [{ valueString: 'Clinic written address' }] : []);
    if (structured)
      expect(
        await getInputText(
          container,
          'practitioner-clinicdetails-address-streetaddress'
        )
      ).toBe(address.line ? '1 Clinic Road, Suite 2' : '');
    if (text)
      expect(
        await getInputText(container, 'practitioner-clinicdetails-addresstext')
      ).toBe('Clinic written address');
  });
}

for (const fixed of [true, false, undefined]) {
  test(`S4 home address no-fixed flag ${String(fixed)}: visibility and cleanup`, async () => {
    const { container } = await renderGpccmp({
      patient: {
        ...patient,
        address: [
          {
            use: 'home',
            type: 'physical',
            line: ['9 Home Road'],
            city: 'Sydney',
            state: 'NSW',
            postalCode: '2000',
            ...(fixed === undefined
              ? {}
              : {
                  extension: [
                    {
                      url: 'http://hl7.org.au/fhir/StructureDefinition/no-fixed-address',
                      valueBoolean: fixed
                    }
                  ]
                })
          }
        ]
      }
    });
    const details = 'patient-contact-homeaddress-details';
    const path = [
      ...patientPath,
      'patient-contact',
      'patient-contact-homeaddress',
      details
    ];
    expect(Boolean(queryItem(container, details))).toBe(fixed !== true);
    expect(answerAt(path, `${details}-streetaddress`)).toEqual([
      { valueString: '9 Home Road' }
    ]);
    expect(
      answerAt(path, `${details}-streetaddress`, responseForPersistence()) ?? []
    ).toEqual(fixed === true ? [] : [{ valueString: '9 Home Road' }]);
    if (fixed !== true)
      expect(await getInputText(container, `${details}-streetaddress`)).toBe(
        '9 Home Road'
      );
    await expect(
      inputText(
        container,
        'patient-contact-homeaddress-nofixedaddress',
        'false'
      )
    ).rejects.toThrow(/read.only|disabled|protected/i);
    expect(Boolean(queryItem(container, details))).toBe(fixed !== true);
  });
}
