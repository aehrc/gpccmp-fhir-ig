import type { QuestionnaireResponseItemAnswer } from 'fhir/r4';

const string = (valueString: string): QuestionnaireResponseItemAnswer[] => [
  { valueString }
];
const coding = (
  system: string,
  code: string,
  display: string
): QuestionnaireResponseItemAnswer[] => [
  { valueCoding: { system, code, display } }
];
const sct = 'http://snomed.info/sct';
const states =
  'https://healthterminologies.gov.au/fhir/CodeSystem/australian-states-territories-1';
const main = 'clinicaldetails-observations-maingrid';
const substance = 'clinicaldetails-observations-substanceusegrid';
const bp = 'clinicaldetails-observations-bpgrid-bp';

// Literal expected answers, independent of Questionnaire expression evaluation.
export const protectedAnswers: Record<
  string,
  QuestionnaireResponseItemAnswer[]
> = {
  'patient-name': string('Snow John'),
  'patient-preferredname': string('Johnny'),
  'patient-preferredpronouns': coding(
    'http://loinc.org',
    'LA29518-0',
    'he/him/his/his/himself'
  ),
  'patient-dob': [{ valueDate: '1993-08-16' }],
  'patient-age': [{ valueInteger: 33 }],
  'patient-sexatbirth': coding(sct, '248153007', 'Male'),
  'patient-genderidentity': coding(
    sct,
    '446151000124109',
    'Identifies as male gender'
  ),
  'patient-firstnationsstatus': coding(
    'https://healthterminologies.gov.au/fhir/CodeSystem/australian-indigenous-status-1',
    '1',
    'Aboriginal but not Torres Strait Islander origin'
  ),
  'patient-ctg': [{ valueBoolean: true }],
  'patient-medicare-number': string('1234567890'),
  'patient-medicare-referencenumber': string('1'),
  'patient-medicare-expiry': string('12/2025'),
  'patient-contact-homephone': string('0398765432'),
  'patient-contact-mobilephone': string('0412345678'),
  'patient-contact-email': string('john.snow@example.com'),
  'patient-contact-homeaddress-nofixedaddress': [{ valueBoolean: false }],
  'patient-contact-homeaddress-details-streetaddress':
    string('123 Winter Lane'),
  'patient-contact-homeaddress-details-city': string('Melbourne'),
  'patient-contact-homeaddress-details-state': coding(
    states,
    'VIC',
    'Victoria'
  ),
  'patient-contact-homeaddress-details-postcode': string('3000'),
  'patient-contact-postaladdress-purpose': string('home'),
  'patient-contact-postaladdress-streetaddress': string('PO Box 42'),
  'patient-contact-postaladdress-city': string('Melbourne'),
  'patient-contact-postaladdress-state': coding(states, 'VIC', 'Victoria'),
  'patient-contact-postaladdress-postcode': string('3000'),
  'practitioner-name': string('Jane Smith'),
  'practitioner-phone': string('0311111111'),
  'practitioner-email': string('one@example.com'),
  'practitioner-medicareprovidernumber': string('1234561A'),
  'practitioner-clinicdetails-name': string('Clinic Location'),
  'practitioner-clinicdetails-address-streetaddress': string('1 Clinic Road'),
  'practitioner-clinicdetails-address-city': string('Melbourne'),
  'practitioner-clinicdetails-address-state': coding(states, 'VIC', 'Victoria'),
  'practitioner-clinicdetails-address-postcode': string('3000'),
  'practitioner-clinicdetails-addresstext': string('Clinic written address'),
  'clinicaldetails-problemsdiagnoses-recordedproblems-condition': coding(
    sct,
    '654321',
    'Resolved condition'
  ),
  'clinicaldetails-problemsdiagnoses-recordedproblems-onsetdate': [
    { valueDate: '2025-10-10' }
  ],
  'clinicaldetails-allergies-recordedallergies-substance': coding(
    sct,
    '388050007',
    'Cashew nut specific IgE'
  ),
  'clinicaldetails-allergies-recordedallergies-manifestation': coding(
    sct,
    '271807003',
    'Rash'
  ),
  'clinicaldetails-medications-recordedmedications-medication': coding(
    sct,
    '23628011000036109',
    'Paracetamol 500 mg tablet'
  ),
  'clinicaldetails-medications-recordedmedications-indication': coding(
    sct,
    '418022001',
    'Iris tuck'
  ),
  [`${main}-bmi-newresultvalue`]: [{ valueDecimal: 24.2 }],
  'plan-lastcompleteddate': [{ valueDate: '2026-02-18' }],
  'plan-inprogress': [{ valueBoolean: true }]
};

export const hiddenAnswers: Record<string, QuestionnaireResponseItemAnswer[]> =
  {
    [`${main}-height-lastresultvalue`]: [{ valueDecimal: 170 }],
    [`${main}-height-lastresultdate`]: [{ valueDate: '2025-11-20' }],
    [`${main}-weight-lastresultvalue`]: [{ valueDecimal: 70 }],
    [`${main}-weight-lastresultdate`]: [{ valueDate: '2025-11-21' }],
    [`${main}-bmi-lastresultvalue`]: [{ valueDecimal: 24.2 }],
    [`${main}-waistcircumference-lastresultvalue`]: [{ valueDecimal: 90 }],
    [`${main}-waistcircumference-lastresultdate`]: [
      { valueDate: '2025-11-23' }
    ],
    [`${main}-pulserate-lastresultvalue`]: [{ valueDecimal: 72 }],
    [`${main}-pulserate-lastresultdate`]: [{ valueDate: '2025-12-04' }],
    [`${main}-pulserhythm-lastresultvalue`]: coding(
      sct,
      '271636001',
      'Pulse regular'
    ),
    [`${main}-pulserhythm-lastresultdate`]: [{ valueDate: '2025-12-03' }],
    [`${main}-oxygensaturation-lastresultvalue`]: [{ valueDecimal: 98 }],
    [`${main}-oxygensaturation-lastresultdate`]: [{ valueDate: '2025-12-04' }],
    [`${bp}-lastresultvaluesystolic`]: [{ valueDecimal: 120 }],
    [`${bp}-lastresultvaluediastolic`]: [{ valueDecimal: 80 }],
    [`${bp}-lastresultdate`]: [{ valueDate: '2025-12-02' }],
    [`${substance}-smokingstatus-lastresultvalue`]: coding(
      sct,
      '77176002',
      'Current smoker'
    ),
    [`${substance}-smokingstatus-lastresultdate`]: [
      { valueDate: '2025-12-01' }
    ],
    [`${substance}-alcoholstatus-lastresultvalue`]: coding(
      sct,
      '219006',
      'Current drinker of alcohol'
    ),
    [`${substance}-alcoholstatus-lastresultdate`]: [{ valueDate: '2025-12-04' }]
  };
