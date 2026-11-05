import { getResponse } from '@aehrc/smart-forms-renderer';
import type { Patient } from 'fhir/r4';
import { selectTab } from '@aehrc/questionnaire-test-toolkit';
import { requireItem, queryItem } from './support/items';
import { useFormEnvironment } from './support/environment';
import {
  getInputText,
  getRadioValue,
  getCqfText,
  renderGpccmp,
  answerAt,
  homeAddressPath
} from './support/form';
import {
  patient,
  resolvedCondition,
  allergy,
  currentMedication,
  obsBodyHeight,
  obsBodyWeight,
  obsWaistCircumference,
  obsHeartRate,
  obsHeartRhythm,
  obsOxygenSaturation,
  obsBloodPressure,
  obsTobaccoSmokingStatus,
  obsAlcoholConsumption,
  questionnaireResponsePlan,
  questionnaireResponsePlanDraft
} from './support/fixtures';

useFormEnvironment();

describe('Population workflow for', () => {
  test('T25 Patient details', async () => {
    const { container } = await renderGpccmp({ patient });

    await selectTab(container, 'patient');
    const patientAge = await getInputText(container, 'patient-age');
    expect(patientAge).toBe('33');
    expect(getResponse().questionnaire).toBe(
      'http://www.health.gov.au/assessments/GPChronicConditionManagementPlan'
    );

    const patientName = await getInputText(container, 'patient-name');
    expect(patientName).toBe('Snow John');

    const preferredName = await getInputText(
      container,
      'patient-preferredname'
    );
    expect(preferredName).toBe('Johnny');

    const preferredPronouns = await getInputText(
      container,
      'patient-preferredpronouns'
    );
    expect(preferredPronouns).toBe('he/him/his/his/himself');

    const dateOfBirth = await getInputText(container, 'patient-dob');
    expect(dateOfBirth).toBe('16/08/1993');

    const sexAssignedAtBirth = await getInputText(
      container,
      'patient-sexatbirth'
    );
    expect(sexAssignedAtBirth).toBe('Male');

    const genderIdentity = await getInputText(
      container,
      'patient-genderidentity'
    );
    expect(genderIdentity).toBe('Identifies as male gender');

    const aboriginalAndTorresStraitIslanderStatus = await getInputText(
      container,
      'patient-firstnationsstatus'
    );
    expect(aboriginalAndTorresStraitIslanderStatus).toBe(
      'Aboriginal but not Torres Strait Islander origin'
    );

    const closingTheGapRegistration = await getInputText(
      container,
      'patient-ctg'
    );
    expect(closingTheGapRegistration).toBe('true');

    const medicareNumber = requireItem(container, 'patient-medicare');
    const medicareNumberNumber = await getInputText(
      medicareNumber,
      'patient-medicare-number'
    );
    expect(medicareNumberNumber).toBe('1234567890');
    const medicareNumberReferenceNumber = await getInputText(
      medicareNumber,
      'patient-medicare-referencenumber'
    );
    expect(medicareNumberReferenceNumber).toBe('1');
    const medicareNumberExpiry = await getInputText(
      medicareNumber,
      'patient-medicare-expiry'
    );
    expect(medicareNumberExpiry).toBe('2025-12-31');

    const homePhoneNumber = await getInputText(
      container,
      'patient-contact-homephone'
    );
    expect(homePhoneNumber).toBe('0398765432');

    const mobilePhoneNumber = await getInputText(
      container,
      'patient-contact-mobilephone'
    );
    expect(mobilePhoneNumber).toBe('0412345678');

    const emailAddress = await getInputText(container, 'patient-contact-email');
    expect(emailAddress).toBe('john.snow@example.com');

    const homeAddress = requireItem(container, 'patient-contact-homeaddress');
    const streetAddress = await getInputText(
      homeAddress,
      'patient-contact-homeaddress-details-streetaddress'
    );
    expect(streetAddress).toBe('123 Winter Lane');
    const city = await getInputText(
      homeAddress,
      'patient-contact-homeaddress-details-city'
    );
    expect(city).toBe('Melbourne');
    const state = await getInputText(
      homeAddress,
      'patient-contact-homeaddress-details-state'
    );
    expect(state).toBe('Victoria');
    const postalCode = await getInputText(
      homeAddress,
      'patient-contact-homeaddress-details-postcode'
    );
    expect(postalCode).toBe('3000');

    const postalAddress = requireItem(
      container,
      'patient-contact-postaladdress'
    );
    const postalPurpose = await getInputText(
      postalAddress,
      'patient-contact-postaladdress-purpose'
    );
    expect(postalPurpose).toBe('home');
    const postalStreetAddress = await getInputText(
      postalAddress,
      'patient-contact-postaladdress-streetaddress'
    );
    expect(postalStreetAddress).toBe('123 Winter Lane');
    const postalCity = await getInputText(
      postalAddress,
      'patient-contact-postaladdress-city'
    );
    expect(postalCity).toBe('Melbourne');
    const postalState = await getInputText(
      postalAddress,
      'patient-contact-postaladdress-state'
    );
    expect(postalState).toBe('Victoria');
    const postalPostcode = await getInputText(
      postalAddress,
      'patient-contact-postaladdress-postcode'
    );
    expect(postalPostcode).toBe('3000');

    const carersAndKeyContacts = requireItem(container, 'patient-contacts');
    const carersAndKeyContactsName = await getInputText(
      carersAndKeyContacts,
      'patient-contacts-name'
    );
    expect(carersAndKeyContactsName).toBe('Arya Stark');
    const carersAndKeyContactsPhone = await getInputText(
      carersAndKeyContacts,
      'patient-contacts-phone'
    );
    expect(carersAndKeyContactsPhone).toBe('0400000000');
    const carersAndKeyContactsEmail = await getInputText(
      carersAndKeyContacts,
      'patient-contacts-email'
    );
    expect(carersAndKeyContactsEmail).toBe('arya.stark@example.com');
    expect(
      requireItem(carersAndKeyContacts, 'patient-contacts-role').textContent
    ).toContain('Emergency Contact');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(answerAt(['container', 'patient'], 'patient-age')).toEqual([
      { valueInteger: 33 }
    ]);
    expect(answerAt(['container', 'patient'], 'patient-name')).toEqual([
      { valueString: 'Snow John' }
    ]);
    expect(answerAt(['container', 'patient'], 'patient-preferredname')).toEqual(
      [{ valueString: 'Johnny' }]
    );
    expect(
      answerAt(['container', 'patient'], 'patient-preferredpronouns')
    ).toMatchObject([
      { valueCoding: { system: 'http://loinc.org', code: 'LA29518-0' } }
    ]);
    expect(answerAt(['container', 'patient'], 'patient-dob')).toEqual([
      { valueDate: '1993-08-16' }
    ]);
    expect(
      answerAt(['container', 'patient'], 'patient-sexatbirth')
    ).toMatchObject([
      { valueCoding: { system: 'http://snomed.info/sct', code: '248153007' } }
    ]);
    expect(
      answerAt(['container', 'patient'], 'patient-genderidentity')
    ).toMatchObject([
      {
        valueCoding: {
          system: 'http://snomed.info/sct',
          code: '446151000124109'
        }
      }
    ]);
    expect(
      answerAt(['container', 'patient'], 'patient-firstnationsstatus')
    ).toMatchObject([
      {
        valueCoding: {
          system:
            'https://healthterminologies.gov.au/fhir/CodeSystem/australian-indigenous-status-1',
          code: '1'
        }
      }
    ]);
    expect(answerAt(['container', 'patient'], 'patient-ctg')).toEqual([
      { valueBoolean: true }
    ]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-medicare'],
        'patient-medicare-number'
      )
    ).toEqual([{ valueString: '1234567890' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-medicare'],
        'patient-medicare-referencenumber'
      )
    ).toEqual([{ valueString: '1' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-medicare'],
        'patient-medicare-expiry'
      )
    ).toEqual([{ valueString: '2025-12-31' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-contact'],
        'patient-contact-homephone'
      )
    ).toEqual([{ valueString: '0398765432' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-contact'],
        'patient-contact-mobilephone'
      )
    ).toEqual([{ valueString: '0412345678' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-contact'],
        'patient-contact-email'
      )
    ).toEqual([{ valueString: 'john.snow@example.com' }]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-homeaddress',
          'patient-contact-homeaddress-details'
        ],
        'patient-contact-homeaddress-details-streetaddress'
      )
    ).toEqual([{ valueString: '123 Winter Lane' }]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-homeaddress',
          'patient-contact-homeaddress-details'
        ],
        'patient-contact-homeaddress-details-city'
      )
    ).toEqual([{ valueString: 'Melbourne' }]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-homeaddress',
          'patient-contact-homeaddress-details'
        ],
        'patient-contact-homeaddress-details-state'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system:
            'https://healthterminologies.gov.au/fhir/CodeSystem/australian-states-territories-1',
          code: 'VIC'
        }
      }
    ]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-homeaddress',
          'patient-contact-homeaddress-details'
        ],
        'patient-contact-homeaddress-details-postcode'
      )
    ).toEqual([{ valueString: '3000' }]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-postaladdress'
        ],
        'patient-contact-postaladdress-purpose'
      )
    ).toEqual([{ valueString: 'home' }]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-postaladdress'
        ],
        'patient-contact-postaladdress-streetaddress'
      )
    ).toEqual([{ valueString: '123 Winter Lane' }]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-postaladdress'
        ],
        'patient-contact-postaladdress-city'
      )
    ).toEqual([{ valueString: 'Melbourne' }]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-postaladdress'
        ],
        'patient-contact-postaladdress-state'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system:
            'https://healthterminologies.gov.au/fhir/CodeSystem/australian-states-territories-1',
          code: 'VIC'
        }
      }
    ]);
    expect(
      answerAt(
        [
          'container',
          'patient',
          'patient-contact',
          'patient-contact-postaladdress'
        ],
        'patient-contact-postaladdress-postcode'
      )
    ).toEqual([{ valueString: '3000' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-contacts'],
        'patient-contacts-name'
      )
    ).toEqual([{ valueString: 'Arya Stark' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-contacts'],
        'patient-contacts-phone'
      )
    ).toEqual([{ valueString: '0400000000' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-contacts'],
        'patient-contacts-email'
      )
    ).toEqual([{ valueString: 'arya.stark@example.com' }]);
    expect(
      answerAt(
        ['container', 'patient', 'patient-contacts'],
        'patient-contacts-role'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system: 'http://terminology.hl7.org/CodeSystem/v2-0131',
          code: 'C'
        }
      }
    ]);
  });

  test('T26 Patient with no fixed address', async () => {
    const patientNoFixedAddress: Patient = {
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
        },
        ...(patient.address ?? []).filter(
          (address) => address.use === 'home' && address.type === 'postal'
        )
      ]
    };
    const { container } = await renderGpccmp({
      patient: patientNoFixedAddress
    });

    await selectTab(container, 'patient');

    const homeAddress = requireItem(container, 'patient-contact-homeaddress');
    expect(
      requireItem(
        homeAddress,
        'patient-contact-homeaddress-nofixedaddress'
      ).querySelector<HTMLInputElement>('input[type="checkbox"]')?.checked
    ).toBe(true);
    expect(
      queryItem(homeAddress, 'patient-contact-homeaddress-details')
    ).toBeUndefined();
    expect(
      queryItem(
        homeAddress,
        'patient-contact-homeaddress-details-streetaddress'
      )
    ).toBeUndefined();
    expect(
      answerAt(homeAddressPath, 'patient-contact-homeaddress-nofixedaddress')
    ).toEqual([{ valueBoolean: true }]);
    expect(
      answerAt(
        [...homeAddressPath, 'patient-contact-homeaddress-details'],
        'patient-contact-homeaddress-details-streetaddress'
      ) ?? []
    ).toEqual([]);
  });

  test('T27 Practitioner details', async () => {
    const { container } = await renderGpccmp();

    await selectTab(container, 'practitioner');
    const practitionerName = await getInputText(container, 'practitioner-name');
    expect(practitionerName).toBe('Jane Smith');

    const clinicName = await getInputText(
      container,
      'practitioner-clinicdetails-name'
    );
    expect(clinicName).toBe('Clinic Location');

    const streetAddress = await getInputText(
      container,
      'practitioner-clinicdetails-address-streetaddress'
    );
    expect(streetAddress).toBe('1 Clinic Road');
    const city = await getInputText(
      container,
      'practitioner-clinicdetails-address-city'
    );
    expect(city).toBe('Melbourne');
    const state = await getInputText(
      container,
      'practitioner-clinicdetails-address-state'
    );
    expect(state).toBe('Victoria');
    const postalCode = await getInputText(
      container,
      'practitioner-clinicdetails-address-postcode'
    );
    expect(postalCode).toBe('3000');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(['container', 'practitioner'], 'practitioner-name')
    ).toEqual([{ valueString: 'Jane Smith' }]);
    expect(
      answerAt(
        ['container', 'practitioner', 'practitioner-clinicdetails'],
        'practitioner-clinicdetails-name'
      )
    ).toEqual([{ valueString: 'Clinic Location' }]);
    expect(
      answerAt(
        [
          'container',
          'practitioner',
          'practitioner-clinicdetails',
          'practitioner-clinicdetails-address'
        ],
        'practitioner-clinicdetails-address-streetaddress'
      )
    ).toEqual([{ valueString: '1 Clinic Road' }]);
    expect(
      answerAt(
        [
          'container',
          'practitioner',
          'practitioner-clinicdetails',
          'practitioner-clinicdetails-address'
        ],
        'practitioner-clinicdetails-address-city'
      )
    ).toEqual([{ valueString: 'Melbourne' }]);
    expect(
      answerAt(
        [
          'container',
          'practitioner',
          'practitioner-clinicdetails',
          'practitioner-clinicdetails-address'
        ],
        'practitioner-clinicdetails-address-state'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system:
            'https://healthterminologies.gov.au/fhir/CodeSystem/australian-states-territories-1',
          code: 'VIC'
        }
      }
    ]);
    expect(
      answerAt(
        [
          'container',
          'practitioner',
          'practitioner-clinicdetails',
          'practitioner-clinicdetails-address'
        ],
        'practitioner-clinicdetails-address-postcode'
      )
    ).toEqual([{ valueString: '3000' }]);
  });

  test('T28 Conditions', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [resolvedCondition]
    });

    await selectTab(container, 'clinicaldetails');

    const recorderDiagnosis = requireItem(
      container,
      'clinicaldetails-problemsdiagnoses-recordedproblems'
    );
    const recorderDiagnosisName = await getInputText(
      recorderDiagnosis,
      'clinicaldetails-problemsdiagnoses-recordedproblems-condition'
    );
    expect(recorderDiagnosisName).toBe('Resolved condition');
    const recorderDiagnosisClinicalStatus = await getInputText(
      recorderDiagnosis,
      'clinicaldetails-problemsdiagnoses-recordedproblems-clinicalstatus'
    );
    expect(recorderDiagnosisClinicalStatus).toBe('Inactive');
    const recorderDiagnosisOnset = await getInputText(
      recorderDiagnosis,
      'clinicaldetails-problemsdiagnoses-recordedproblems-onsetdate'
    );
    expect(recorderDiagnosisOnset).toBe('10/10/2025');
    const recorderDiagnosisAbatement = await getInputText(
      recorderDiagnosis,
      'clinicaldetails-problemsdiagnoses-recordedproblems-abatementdate'
    );
    expect(recorderDiagnosisAbatement).toBe('10/10/2026');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-problemsdiagnoses',
          'clinicaldetails-problemsdiagnoses-recordedproblems'
        ],
        'clinicaldetails-problemsdiagnoses-recordedproblems-condition'
      )
    ).toMatchObject([
      { valueCoding: { system: 'http://snomed.info/sct', code: '654321' } }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-problemsdiagnoses',
          'clinicaldetails-problemsdiagnoses-recordedproblems'
        ],
        'clinicaldetails-problemsdiagnoses-recordedproblems-clinicalstatus'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system: 'http://terminology.hl7.org/CodeSystem/condition-clinical',
          code: 'inactive'
        }
      }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-problemsdiagnoses',
          'clinicaldetails-problemsdiagnoses-recordedproblems'
        ],
        'clinicaldetails-problemsdiagnoses-recordedproblems-onsetdate'
      )
    ).toEqual([{ valueDate: '2025-10-10' }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-problemsdiagnoses',
          'clinicaldetails-problemsdiagnoses-recordedproblems'
        ],
        'clinicaldetails-problemsdiagnoses-recordedproblems-abatementdate'
      )
    ).toEqual([{ valueDate: '2026-10-10' }]);
  });

  test('T29 Allergies', async () => {
    const { container } = await renderGpccmp({ patient, resources: [allergy] });

    await selectTab(container, 'clinicaldetails');

    const allergies = requireItem(
      container,
      'clinicaldetails-allergies-recordedallergies'
    );
    const allergiesName = await getInputText(
      allergies,
      'clinicaldetails-allergies-recordedallergies-substance'
    );
    expect(allergiesName).toBe('Cashew nut specific IgE');
    const allergiesClinicalStatus = await getInputText(
      allergies,
      'clinicaldetails-allergies-recordedallergies-status'
    );
    expect(allergiesClinicalStatus).toBe('Active');
    const allergiesReaction = await getInputText(
      allergies,
      'clinicaldetails-allergies-recordedallergies-manifestation'
    );
    expect(allergiesReaction).toBe('Rash');
    const allergiesNote = await getInputText(
      allergies,
      'clinicaldetails-allergies-recordedallergies-comment'
    );
    expect(allergiesNote).toBe('Patient experiences rash and swelling');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-allergies',
          'clinicaldetails-allergies-recordedallergies'
        ],
        'clinicaldetails-allergies-recordedallergies-substance'
      )
    ).toMatchObject([
      { valueCoding: { system: 'http://snomed.info/sct', code: '388050007' } }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-allergies',
          'clinicaldetails-allergies-recordedallergies'
        ],
        'clinicaldetails-allergies-recordedallergies-status'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system:
            'http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical',
          code: 'active'
        }
      }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-allergies',
          'clinicaldetails-allergies-recordedallergies'
        ],
        'clinicaldetails-allergies-recordedallergies-manifestation'
      )
    ).toMatchObject([
      { valueCoding: { system: 'http://snomed.info/sct', code: '271807003' } }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-allergies',
          'clinicaldetails-allergies-recordedallergies'
        ],
        'clinicaldetails-allergies-recordedallergies-comment'
      )
    ).toEqual([{ valueString: 'Patient experiences rash and swelling' }]);
  });

  test('T30 Medications', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [currentMedication]
    });

    await selectTab(container, 'clinicaldetails');

    const medications = requireItem(
      container,
      'clinicaldetails-medications-recordedmedications'
    );
    const medicationsName = await getInputText(
      medications,
      'clinicaldetails-medications-recordedmedications-medication'
    );
    expect(medicationsName).toBe('Paracetamol 500 mg tablet');
    const medicationsStatus = await getInputText(
      medications,
      'clinicaldetails-medications-recordedmedications-status'
    );
    expect(medicationsStatus).toBe('Active');
    const medicationsDosage = await getInputText(
      medications,
      'clinicaldetails-medications-recordedmedications-dosage'
    );
    expect(medicationsDosage).toBe('Once daily, 10mg');
    const medicationsReason = await getInputText(
      medications,
      'clinicaldetails-medications-recordedmedications-indication'
    );
    expect(medicationsReason).toBe('Iris tuck');
    const medicationsNote = await getInputText(
      medications,
      'clinicaldetails-medications-recordedmedications-comment'
    );
    expect(medicationsNote).toBe('Patient should take with food');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-medications',
          'clinicaldetails-medications-recordedmedications'
        ],
        'clinicaldetails-medications-recordedmedications-medication'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system: 'http://snomed.info/sct',
          code: '23628011000036109'
        }
      }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-medications',
          'clinicaldetails-medications-recordedmedications'
        ],
        'clinicaldetails-medications-recordedmedications-status'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system: 'http://hl7.org/fhir/CodeSystem/medication-statement-status',
          code: 'active'
        }
      }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-medications',
          'clinicaldetails-medications-recordedmedications'
        ],
        'clinicaldetails-medications-recordedmedications-dosage'
      )
    ).toEqual([{ valueString: 'Once daily, 10mg' }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-medications',
          'clinicaldetails-medications-recordedmedications'
        ],
        'clinicaldetails-medications-recordedmedications-indication'
      )
    ).toMatchObject([
      { valueCoding: { system: 'http://snomed.info/sct', code: '418022001' } }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-medications',
          'clinicaldetails-medications-recordedmedications'
        ],
        'clinicaldetails-medications-recordedmedications-comment'
      )
    ).toEqual([{ valueString: 'Patient should take with food' }]);
  });

  test('T31 Height last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsBodyHeight]
    });

    await selectTab(container, 'clinicaldetails');
    const heightStringContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid-height'
    );
    const lastResultHeight = await getCqfText(
      heightStringContainer,
      'clinicaldetails-observations-maingrid-height-lastresult'
    );
    expect(lastResultHeight).toBe('170 cm ( 20 Nov 2025 )');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-height'
        ],
        'clinicaldetails-observations-maingrid-height-lastresultvalue'
      )
    ).toEqual([{ valueDecimal: 170 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-height'
        ],
        'clinicaldetails-observations-maingrid-height-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-11-20' }]);
  });

  test('T32 Weight last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsBodyWeight]
    });

    await selectTab(container, 'clinicaldetails');
    const weightStringContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid-weight'
    );
    const lastResultWeight = await getCqfText(
      weightStringContainer,
      'clinicaldetails-observations-maingrid-weight-lastresult'
    );
    expect(lastResultWeight).toBe('70 kg ( 21 Nov 2025 )');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-weight'
        ],
        'clinicaldetails-observations-maingrid-weight-lastresultvalue'
      )
    ).toEqual([{ valueDecimal: 70 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-weight'
        ],
        'clinicaldetails-observations-maingrid-weight-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-11-21' }]);
  });

  test('T33 BMI last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsBodyHeight, obsBodyWeight]
    });

    await selectTab(container, 'clinicaldetails');
    const bmiStringContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid-bmi'
    );
    const lastResultBmi = await getCqfText(
      bmiStringContainer,
      'clinicaldetails-observations-maingrid-bmi-lastresult'
    );
    expect(lastResultBmi).toBe('24.2 kg/m2');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-height'
        ],
        'clinicaldetails-observations-maingrid-height-lastresultvalue'
      )
    ).toEqual([{ valueDecimal: 170 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-weight'
        ],
        'clinicaldetails-observations-maingrid-weight-lastresultvalue'
      )
    ).toEqual([{ valueDecimal: 70 }]);
  });

  test('T34 Waist circumference last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsWaistCircumference]
    });
    await selectTab(container, 'clinicaldetails');
    const waistCircumferenceStringContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid-waistcircumference'
    );
    const lastResultWaistCircumference = await getCqfText(
      waistCircumferenceStringContainer,
      'clinicaldetails-observations-maingrid-waistcircumference-lastresult'
    );
    expect(lastResultWaistCircumference).toBe('90 cm ( 23 Nov 2025 )');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-waistcircumference'
        ],
        'clinicaldetails-observations-maingrid-waistcircumference-lastresultvalue'
      )
    ).toEqual([{ valueDecimal: 90 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-waistcircumference'
        ],
        'clinicaldetails-observations-maingrid-waistcircumference-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-11-23' }]);
  });

  test('T35 Pulse rate last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsHeartRate]
    });
    await selectTab(container, 'clinicaldetails');
    const pulseRateStringContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid-pulserate'
    );
    const lastResultPulseRate = await getCqfText(
      pulseRateStringContainer,
      'clinicaldetails-observations-maingrid-pulserate-lastresult'
    );
    expect(lastResultPulseRate).toBe('72 /min ( 4 Dec 2025 )');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-pulserate'
        ],
        'clinicaldetails-observations-maingrid-pulserate-lastresultvalue'
      )
    ).toEqual([{ valueDecimal: 72 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-pulserate'
        ],
        'clinicaldetails-observations-maingrid-pulserate-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-12-04' }]);
  });

  test('T36 Pulse rhythm last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsHeartRhythm]
    });
    await selectTab(container, 'clinicaldetails');
    const pulseRhythmStringContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid-pulserhythm'
    );
    const lastResultPulseRhythm = await getCqfText(
      pulseRhythmStringContainer,
      'clinicaldetails-observations-maingrid-pulserhythm-lastresult'
    );
    expect(lastResultPulseRhythm).toBe('Pulse regular ( 3 Dec 2025 )');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-pulserhythm'
        ],
        'clinicaldetails-observations-maingrid-pulserhythm-lastresultvalue'
      )
    ).toMatchObject([
      {
        valueCoding: {
          system: 'http://snomed.info/sct',
          code: '271636001'
        }
      }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-pulserhythm'
        ],
        'clinicaldetails-observations-maingrid-pulserhythm-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-12-03' }]);
  });

  test('T37 Oxygen saturation last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsOxygenSaturation]
    });
    await selectTab(container, 'clinicaldetails');
    const oxygenSaturationStringContainer = requireItem(
      container,
      'clinicaldetails-observations-maingrid-oxygensaturation'
    );
    const lastResultOxygenSaturation = await getCqfText(
      oxygenSaturationStringContainer,
      'clinicaldetails-observations-maingrid-oxygensaturation-lastresult'
    );
    expect(lastResultOxygenSaturation).toBe('98 % ( 4 Dec 2025 )');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-oxygensaturation'
        ],
        'clinicaldetails-observations-maingrid-oxygensaturation-lastresultvalue'
      )
    ).toEqual([{ valueDecimal: 98 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-maingrid',
          'clinicaldetails-observations-maingrid-oxygensaturation'
        ],
        'clinicaldetails-observations-maingrid-oxygensaturation-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-12-04' }]);
  });

  test('T38 Blood pressure last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsBloodPressure]
    });
    await selectTab(container, 'clinicaldetails');
    const bloodPressureStringContainer = requireItem(
      container,
      'clinicaldetails-observations-bpgrid'
    );
    const lastResultBloodPressure = await getCqfText(
      bloodPressureStringContainer,
      'clinicaldetails-observations-bpgrid-bp-lastresult'
    );
    expect(lastResultBloodPressure).toBe('120 / 80 mm Hg ( 2 Dec 2025 )');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-lastresultvaluesystolic'
      )
    ).toEqual([{ valueDecimal: 120 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-lastresultvaluediastolic'
      )
    ).toEqual([{ valueDecimal: 80 }]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-bpgrid',
          'clinicaldetails-observations-bpgrid-bp'
        ],
        'clinicaldetails-observations-bpgrid-bp-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-12-02' }]);
  });

  test('T39 Smoking status last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsTobaccoSmokingStatus]
    });
    await selectTab(container, 'clinicaldetails');
    const smokingStatusStringContainer = requireItem(
      container,
      'clinicaldetails-observations-substanceusegrid-smokingstatus'
    );
    const lastResultSmokingStatus = await getCqfText(
      smokingStatusStringContainer,
      'clinicaldetails-observations-substanceusegrid-smokingstatus-laststatus'
    );
    expect(lastResultSmokingStatus).toBe('Current smoker ( 1 Dec 2025 )');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-substanceusegrid',
          'clinicaldetails-observations-substanceusegrid-smokingstatus'
        ],
        'clinicaldetails-observations-substanceusegrid-smokingstatus-lastresultvalue'
      )
    ).toMatchObject([
      { valueCoding: { system: 'http://snomed.info/sct', code: '77176002' } }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-substanceusegrid',
          'clinicaldetails-observations-substanceusegrid-smokingstatus'
        ],
        'clinicaldetails-observations-substanceusegrid-smokingstatus-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-12-01' }]);
  });

  test('T40 Alcohol consumption status last result', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [obsAlcoholConsumption]
    });
    await selectTab(container, 'clinicaldetails');
    const alcoholConsumptionStringContainer = requireItem(
      container,
      'clinicaldetails-observations-substanceusegrid-alcoholstatus'
    );
    const lastResultAlcoholConsumption = await getCqfText(
      alcoholConsumptionStringContainer,
      'clinicaldetails-observations-substanceusegrid-alcoholstatus-laststatus'
    );
    expect(lastResultAlcoholConsumption).toBe(
      'Current drinker of alcohol ( 4 Dec 2025 )'
    );

    // Typed answers at full response paths, including hidden observation inputs.
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-substanceusegrid',
          'clinicaldetails-observations-substanceusegrid-alcoholstatus'
        ],
        'clinicaldetails-observations-substanceusegrid-alcoholstatus-lastresultvalue'
      )
    ).toMatchObject([
      { valueCoding: { system: 'http://snomed.info/sct', code: '219006' } }
    ]);
    expect(
      answerAt(
        [
          'container',
          'clinicaldetails',
          'clinicaldetails-observations',
          'clinicaldetails-observations-substanceusegrid',
          'clinicaldetails-observations-substanceusegrid-alcoholstatus'
        ],
        'clinicaldetails-observations-substanceusegrid-alcoholstatus-lastresultdate'
      )
    ).toEqual([{ valueDate: '2025-12-04' }]);
  });

  test('T41 Plan type', async () => {
    const { container } = await renderGpccmp({
      patient,
      resources: [questionnaireResponsePlan, questionnaireResponsePlanDraft]
    });
    await selectTab(container, 'plan');

    const planType = await getRadioValue(container, 'plan-type');
    expect(planType).toBe('Review');

    const lastCompletedDate = await getInputText(
      container,
      'plan-lastcompleteddate'
    );
    expect(lastCompletedDate).toBe('18/02/2026');

    const inProgress = await getRadioValue(container, 'plan-inprogress');
    expect(inProgress).toBe('true');

    // Typed answers at full response paths, including hidden observation inputs.
    expect(answerAt(['container', 'plan'], 'plan-type')).toEqual([
      { valueString: 'Review' }
    ]);
    expect(answerAt(['container', 'plan'], 'plan-lastcompleteddate')).toEqual([
      { valueDate: '2026-02-18' }
    ]);
    expect(answerAt(['container', 'plan'], 'plan-inprogress')).toEqual([
      { valueBoolean: true }
    ]);
  });
});
