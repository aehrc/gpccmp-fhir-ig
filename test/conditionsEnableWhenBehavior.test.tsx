import { checkRadioOption, inputText } from '@aehrc/questionnaire-test-toolkit';
import { useFormEnvironment } from './support/environment';
import { queryItem, requireItem } from './support/items';
import {
  getInputText,
  renderGpccmp,
  answerAt,
  patientPath,
  homeAddressPath,
  clinicAddressPath,
  selectTab
} from './support/form';
import { patient } from './support/fixtures';

useFormEnvironment();

describe('My Aged Care boundary values', () => {
  for (const [id, name, birthDate, age] of [
    ['T19', 'for patients over 50 years of age', '1975-08-16', 51],
    ['T20', 'for patients under 50 years of age', '1977-08-16', 49],
    ['T21', 'for patients aged 50 years', '1976-08-16', 50]
  ] as const) {
    test(`${id} ${name}`, async () => {
      const { container } = await renderGpccmp({
        patient: { ...patient, birthDate }
      });
      expect(await getInputText(container, 'patient-age')).toBe(String(age));
      expect(answerAt(patientPath, 'patient-age')).toEqual([
        { valueInteger: age }
      ]);
      expect(Boolean(queryItem(container, 'patient-myagedcare'))).toBe(
        age >= 50
      );
      if (age >= 50) {
        await checkRadioOption(
          container,
          'patient-myagedcare-registered',
          'Yes'
        );
        await inputText(container, 'patient-myagedcare-number', '1234567890');
        await inputText(
          container,
          'patient-myagedcare-comment',
          'This is a comment'
        );
        expect(await getInputText(container, 'patient-myagedcare-number')).toBe(
          '1234567890'
        );
        expect(
          await getInputText(container, 'patient-myagedcare-comment')
        ).toBe('This is a comment');
        expect(
          answerAt(
            [...patientPath, 'patient-myagedcare'],
            'patient-myagedcare-number'
          )
        ).toEqual([{ valueString: '1234567890' }]);
        expect(
          answerAt(
            [...patientPath, 'patient-myagedcare'],
            'patient-myagedcare-comment'
          )
        ).toEqual([{ valueString: 'This is a comment' }]);
      } else {
        expect(
          answerAt(
            [...patientPath, 'patient-myagedcare'],
            'patient-myagedcare-number'
          ) ?? []
        ).toEqual([]);
      }
    });
  }
});

describe('Home Address', () => {
  test('T22 for patients with a home address', async () => {
    const { container } = await renderGpccmp({
      patient: {
        ...patient,
        address: [
          {
            use: 'home',
            type: 'physical',
            line: ['123 Main St'],
            city: 'Sydney',
            state: 'NSW',
            postalCode: '2000'
          }
        ]
      }
    });
    requireItem(container, 'patient-contact-homeaddress-details');
    for (const [suffix, visible, answer] of [
      ['streetaddress', '123 Main St', { valueString: '123 Main St' }],
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
      const id = `patient-contact-homeaddress-details-${suffix}`;
      expect(await getInputText(container, id)).toBe(visible);
      expect(
        answerAt(
          [...homeAddressPath, 'patient-contact-homeaddress-details'],
          id
        )
      ).toEqual([answer]);
    }
  });

  test('T23 for patients without a home address', async () => {
    const { container } = await renderGpccmp({
      patient: {
        ...patient,
        address: [
          {
            use: 'home',
            type: 'physical',
            extension: [
              {
                url: 'http://hl7.org.au/fhir/StructureDefinition/no-fixed-address',
                valueBoolean: true
              }
            ]
          }
        ]
      }
    });
    requireItem(container, 'patient-contact-homeaddress');
    expect(
      answerAt(homeAddressPath, 'patient-contact-homeaddress-nofixedaddress')
    ).toEqual([{ valueBoolean: true }]);
    expect(
      queryItem(container, 'patient-contact-homeaddress-details')
    ).toBeUndefined();
    for (const suffix of ['streetaddress', 'city', 'state', 'postcode']) {
      const id = `patient-contact-homeaddress-details-${suffix}`;
      expect(queryItem(container, id)).toBeUndefined();
      expect(
        answerAt(
          [...homeAddressPath, 'patient-contact-homeaddress-details'],
          id
        ) ?? []
      ).toEqual([]);
    }
  });
});

describe('Clinic Address', () => {
  test('T24 clinic address', async () => {
    const { container } = await renderGpccmp();
    await selectTab(container, 'practitioner');
    requireItem(container, 'practitioner-clinicdetails-address');
    for (const [suffix, visible, answer] of [
      ['streetaddress', '1 Clinic Road', { valueString: '1 Clinic Road' }],
      ['city', 'Melbourne', { valueString: 'Melbourne' }],
      [
        'state',
        'Victoria',
        {
          valueCoding: {
            system:
              'https://healthterminologies.gov.au/fhir/CodeSystem/australian-states-territories-1',
            code: 'VIC',
            display: 'Victoria'
          }
        }
      ],
      ['postcode', '3000', { valueString: '3000' }]
    ] as const) {
      const id = `practitioner-clinicdetails-address-${suffix}`;
      expect(await getInputText(container, id)).toBe(visible);
      expect(answerAt(clinicAddressPath, id)).toEqual([answer]);
    }
  });
});
