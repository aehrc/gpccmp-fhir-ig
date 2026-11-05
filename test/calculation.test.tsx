import {
  inputDecimal,
  inputInteger,
  selectTab,
  chooseSelectOption
} from '@aehrc/questionnaire-test-toolkit';
import { requireItem } from './support/items';
import { useFormEnvironment } from './support/environment';
import { getInputText, renderGpccmp, answerAt } from './support/form';

useFormEnvironment();

describe('Observation Calculation', () => {
  test('T01 height new result date', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const observationsContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid'
    );
    const dateFieldValueBefore = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-height-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await inputDecimal(
      observationsContainer,
      'clinicaldetails-observations-maingrid-height-newresultvalue',
      170.55
    );
    const dateFieldValueAfter = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-height-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-height'
        ],
        'clinicaldetails-observations-maingrid-height-newresultvalue'
      )
    ).toEqual([{ valueDecimal: 170.55 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-height'
        ],
        'clinicaldetails-observations-maingrid-height-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });

  test('T02 weight new result date', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const observationsContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid'
    );
    const dateFieldValueBefore = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-weight-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await inputDecimal(
      observationsContainer,
      'clinicaldetails-observations-maingrid-weight-newresultvalue',
      70.55
    );
    const dateFieldValueAfter = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-weight-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-weight'
        ],
        'clinicaldetails-observations-maingrid-weight-newresultvalue'
      )
    ).toEqual([{ valueDecimal: 70.55 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-weight'
        ],
        'clinicaldetails-observations-maingrid-weight-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });

  test('T03 BMI calculation', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const observationsContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid'
    );
    await inputDecimal(
      observationsContainer,
      'clinicaldetails-observations-maingrid-height-newresultvalue',
      170.55
    );
    await inputDecimal(
      observationsContainer,
      'clinicaldetails-observations-maingrid-weight-newresultvalue',
      70.32
    );
    const bmiFieldValue = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-bmi-newresultvalue'
    );
    expect(bmiFieldValue).toBe('24.2');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-weight'
        ],
        'clinicaldetails-observations-maingrid-weight-newresultvalue'
      )
    ).toEqual([{ valueDecimal: 70.32 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-height'
        ],
        'clinicaldetails-observations-maingrid-height-newresultvalue'
      )
    ).toEqual([{ valueDecimal: 170.55 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-bmi'
        ],
        'clinicaldetails-observations-maingrid-bmi-newresultvalue'
      )
    ).toEqual([{ valueDecimal: 24.2 }]);
  });

  test('T04 Waist circumference new result date', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const observationsContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid'
    );
    const dateFieldValueBefore = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-waistcircumference-newdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await inputDecimal(
      observationsContainer,
      'clinicaldetails-observations-maingrid-waistcircumference-newresultvalue',
      80.55
    );
    const dateFieldValueAfter = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-waistcircumference-newdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-waistcircumference'
        ],
        'clinicaldetails-observations-maingrid-waistcircumference-newresultvalue'
      )
    ).toEqual([{ valueDecimal: 80.55 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-waistcircumference'
        ],
        'clinicaldetails-observations-maingrid-waistcircumference-newdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });

  test('T05 Pulse rate new result date', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const observationsContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid'
    );
    const dateFieldValueBefore = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-pulserate-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await inputInteger(
      observationsContainer,
      'clinicaldetails-observations-maingrid-pulserate-newresultvalue',
      70
    );
    const dateFieldValueAfter = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-pulserate-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-pulserate'
        ],
        'clinicaldetails-observations-maingrid-pulserate-newresultvalue'
      )
    ).toEqual([{ valueInteger: 70 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-pulserate'
        ],
        'clinicaldetails-observations-maingrid-pulserate-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });

  test('T06 Pulse rhythm new result date', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const observationsContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid'
    );
    const dateFieldValueBefore = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-pulserhythm-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await chooseSelectOption(
      observationsContainer,
      'clinicaldetails-observations-maingrid-pulserhythm-newresultvalue',
      'Pulse regular'
    );
    const dateFieldValueAfter = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-pulserhythm-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-pulserhythm'
        ],
        'clinicaldetails-observations-maingrid-pulserhythm-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });

  test('T07 Oxygen saturation new result date', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const observationsContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid'
    );
    const dateFieldValueBefore = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-oxygensaturation-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await inputDecimal(
      observationsContainer,
      'clinicaldetails-observations-maingrid-oxygensaturation-newresultvalue',
      20
    );
    const dateFieldValueAfter = await getInputText(
      observationsContainer,
      'clinicaldetails-observations-maingrid-oxygensaturation-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-oxygensaturation'
        ],
        'clinicaldetails-observations-maingrid-oxygensaturation-newresultvalue'
      )
    ).toEqual([{ valueInteger: 20 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-oxygensaturation'
        ],
        'clinicaldetails-observations-maingrid-oxygensaturation-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });
});

describe('Blood pressure calculations', () => {
  test('T08 Systolic pressure date performed', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const bloodPressureContainer = requireItem(
      container,
      'clinicaldetails-observations-bpgrid'
    );
    const dateFieldValueBefore = await getInputText(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await inputDecimal(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultsystolic',
      120
    );
    const dateFieldValueAfter = await getInputText(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-newresultsystolic'
      )
    ).toEqual([{ valueInteger: 120 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });

  test('T09 Diastolic pressure date performed', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const bloodPressureContainer = requireItem(
      container,
      'clinicaldetails-observations-bpgrid'
    );
    const dateFieldValueBefore = await getInputText(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await inputDecimal(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultdiastolic',
      80
    );
    const dateFieldValueAfter = await getInputText(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-newresultdiastolic'
      )
    ).toEqual([{ valueInteger: 80 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });

  test('T10 Systolic and diastolic date performed', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const bloodPressureContainer = requireItem(
      container,
      'clinicaldetails-observations-bpgrid'
    );
    const dateFieldValueBefore = await getInputText(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await inputDecimal(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultsystolic',
      120
    );
    await inputDecimal(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultdiastolic',
      80
    );
    const dateFieldValueAfter = await getInputText(
      bloodPressureContainer,
      'clinicaldetails-observations-bpgrid-bp-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-newresultdiastolic'
      )
    ).toEqual([{ valueInteger: 80 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-newresultsystolic'
      )
    ).toEqual([{ valueInteger: 120 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });
});

describe('Substance use calculations', () => {
  test('T11 Smoking new status date', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const substanceUseContainer = requireItem(
      container,
      'clinicaldetails-observations-substanceusegrid'
    );
    const dateFieldValueBefore = await getInputText(
      substanceUseContainer,
      'clinicaldetails-observations-substanceusegrid-smokingstatus-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');

    await chooseSelectOption(
      substanceUseContainer,
      'clinicaldetails-observations-substanceusegrid-smokingstatus-newresultvalue',
      'Current smoker'
    );
    const dateFieldValueAfter = await getInputText(
      substanceUseContainer,
      'clinicaldetails-observations-substanceusegrid-smokingstatus-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-substanceusegrid',
          'clinicaldetails-observations-substanceusegrid-smokingstatus'
        ],
        'clinicaldetails-observations-substanceusegrid-smokingstatus-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });

  test('T12 Alcohol consumption new status date', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'clinicaldetails');
    const substanceUseContainer = requireItem(
      container,
      'clinicaldetails-observations-substanceusegrid'
    );
    const dateFieldValueBefore = await getInputText(
      substanceUseContainer,
      'clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultdate'
    );
    expect(dateFieldValueBefore).toBe('');
    await chooseSelectOption(
      substanceUseContainer,
      'clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultvalue',
      'Current drinker'
    );
    const dateFieldValueAfter = await getInputText(
      substanceUseContainer,
      'clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultdate'
    );
    expect(dateFieldValueAfter).toBe('17/08/2026');
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-substanceusegrid',
          'clinicaldetails-observations-substanceusegrid-alcoholstatus'
        ],
        'clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultdate'
      )
    ).toEqual([{ valueDate: '2026-08-17' }]);
  });
});
