import type {
  FhirResource,
  Patient,
  PractitionerRole,
  Location,
  QuestionnaireResponse
} from 'fhir/r4';
import { createClinicalAdapter } from './clinicalRequests';
import {
  patient as defaultPatient,
  practitionerRole,
  clinicLocation,
  makeSearchSetBundle
} from './fixtures';

/** Shared strict clinical fixture contract for mounted and real-browser form tests. */
export function gpccmpClinicalAdapter({
  patient = defaultPatient,
  resources = [],
  role = practitionerRole,
  location = clinicLocation
}: {
  patient?: Patient;
  resources?: FhirResource[];
  role?: PractitionerRole;
  location?: Location;
} = {}) {
  const bundle = (type: string) =>
    makeSearchSetBundle(resources.filter((r) => r.resourceType === type));
  const canonical =
    'http://www.health.gov.au/assessments/GPChronicConditionManagementPlan';
  const id = patient.id;
  if (!id) throw new Error('Population fixtures require a patient ID');
  const plans = resources.filter(
    (r): r is QuestionnaireResponse =>
      r.resourceType === 'QuestionnaireResponse'
  );
  return createClinicalAdapter([
    [`PractitionerRole/${role.id}`, role],
    [
      `PractitionerRole?_id=${role.id}&_include=PractitionerRole:location`,
      makeSearchSetBundle([role, location])
    ],
    [
      `QuestionnaireResponse?questionnaire=${canonical}&_count=1&_sort=-authored&patient=${id}`,
      makeSearchSetBundle(plans.filter((r) => r.status === 'in-progress'))
    ],
    [
      `QuestionnaireResponse?questionnaire=${canonical}&status=completed,amended&_count=1&_sort=-authored&patient=${id}`,
      makeSearchSetBundle(
        plans.filter((r) => ['completed', 'amended'].includes(r.status))
      )
    ],
    [
      `Condition?patient=${id}&category=http://terminology.hl7.org/CodeSystem/condition-category|problem-list-item`,
      bundle('Condition')
    ],
    [`AllergyIntolerance?patient=${id}`, bundle('AllergyIntolerance')],
    [
      `MedicationStatement?patient=${id}&status=active&_include=MedicationStatement:medication`,
      bundle('MedicationStatement')
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
      `Observation?code=${code}&_sort=-date&patient=${id}`,
      makeSearchSetBundle(
        resources.filter(
          (r) =>
            r.resourceType === 'Observation' &&
            r.code.coding?.some((c) => c.code === code)
        )
      )
    ])
  ]);
}
