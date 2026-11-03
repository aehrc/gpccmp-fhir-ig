import { checkRadioOption, inputText } from '@aehrc/questionnaire-test-toolkit';
import { waitFor } from '@testing-library/react';
import { useFormEnvironment } from './support/environment';
import { queryItem, requireItem } from './support/items';
import {
  getInputText,
  getRadioValue,
  answerAt,
  patientPath,
  renderGpccmp,
  responseForPersistence
} from './support/form';
import { patient } from './support/fixtures';

useFormEnvironment();

// Literal DOBs avoid the separately tracked exact-birthday defect (FORM-02).
for (const [group, prefix, birthDate, age, first] of [
  ['My Aged Care question', 'patient-myagedcare', '1975-08-16', 51, 13],
  [
    'National Disability Insurance Scheme question',
    'patient-ndis',
    '2002-08-16',
    24,
    16
  ]
] as const) {
  describe(group, () => {
    for (const [index, option, code] of [
      [0, 'Yes', 'Y'],
      [1, 'No', 'N'],
      [2, 'Pending', 'NAV']
    ] as const) {
      test(`T${first + index} for ${option}`, async () => {
        const { container } = await renderGpccmp({
          patient: { ...patient, birthDate }
        });
        expect(await getInputText(container, 'patient-age')).toBe(String(age));
        expect(answerAt(patientPath, 'patient-age')).toEqual([
          { valueInteger: age }
        ]);
        const path = [...patientPath, prefix];
        requireItem(container, prefix);
        // Establish a positive state before each negative branch, so absence has a known cause.
        await checkRadioOption(container, `${prefix}-registered`, 'Yes');
        await inputText(container, `${prefix}-number`, '1234567890');
        expect(await getInputText(container, `${prefix}-number`)).toBe(
          '1234567890'
        );
        expect(answerAt(path, `${prefix}-number`)).toEqual([
          { valueString: '1234567890' }
        ]);
        if (option !== 'Yes')
          await checkRadioOption(container, `${prefix}-registered`, option);
        await waitFor(() => {
          expect(answerAt(path, `${prefix}-registered`)).toEqual([
            {
              valueCoding: {
                system: 'http://terminology.hl7.org/CodeSystem/v2-0532',
                code,
                display: option
              }
            }
          ]);
          expect(Boolean(queryItem(container, `${prefix}-number`))).toBe(
            option === 'Yes'
          );
        });
        expect(await getRadioValue(container, `${prefix}-registered`)).toBe(
          code
        );
        await inputText(container, `${prefix}-comment`, 'This is a comment');
        expect(await getInputText(container, `${prefix}-comment`)).toBe(
          'This is a comment'
        );
        expect(answerAt(path, `${prefix}-comment`)).toEqual([
          { valueString: 'This is a comment' }
        ]);
        // The renderer retains disabled answers in its public unfiltered response.
        expect(answerAt(path, `${prefix}-number`)).toEqual([
          { valueString: '1234567890' }
        ]);
        expect(
          answerAt(path, `${prefix}-number`, responseForPersistence()) ?? []
        ).toEqual(option === 'Yes' ? [{ valueString: '1234567890' }] : []);
      });
    }
  });
}
