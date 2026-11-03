import type {
  Bundle,
  Location,
  Patient,
  Practitioner,
  PractitionerRole,
  Condition,
  FhirResource,
  AllergyIntolerance,
  MedicationStatement,
  Observation,
  QuestionnaireResponse
} from 'fhir/r4';

export const patient: Patient = {
  resourceType: 'Patient',
  id: 'patient-123',
  name: [
    {
      use: 'official',
      family: 'John',
      given: ['Snow']
    },
    {
      use: 'usual',
      given: ['Johnny']
    }
  ],
  birthDate: '1993-08-16',
  gender: 'male',
  extension: [
    {
      url: 'http://hl7.org/fhir/StructureDefinition/individual-pronouns',
      extension: [
        {
          url: 'value',
          valueCodeableConcept: {
            coding: [
              {
                system: 'http://loinc.org',
                code: 'LA29518-0',
                display: 'he/him/his/his/himself'
              }
            ]
          }
        }
      ]
    },
    {
      url: 'http://hl7.org/fhir/StructureDefinition/individual-recordedSexOrGender',
      extension: [
        {
          url: 'type',
          valueCodeableConcept: {
            coding: [
              {
                system: 'http://snomed.info/sct',
                code: '1515311000168102',
                display: 'Sex at Birth'
              }
            ]
          }
        },
        {
          url: 'value',
          valueCodeableConcept: {
            coding: [
              {
                system: 'http://snomed.info/sct',
                code: '248153007',
                display: 'Male'
              }
            ]
          }
        },
        {
          url: 'effectivePeriod',
          valuePeriod: {
            start: '2020-01-01'
          }
        }
      ]
    },
    {
      url: 'http://hl7.org/fhir/StructureDefinition/individual-genderIdentity',
      extension: [
        {
          url: 'value',
          valueCodeableConcept: {
            coding: [
              {
                system: 'http://snomed.info/sct',
                code: '446151000124109',
                display: 'Identifies as male gender'
              }
            ]
          }
        }
      ]
    },
    {
      url: 'http://hl7.org.au/fhir/StructureDefinition/indigenous-status',
      valueCoding: {
        system:
          'https://healthterminologies.gov.au/fhir/CodeSystem/australian-indigenous-status-1',
        code: '1',
        display: 'Aboriginal but not Torres Strait Islander origin'
      }
    },
    {
      url: 'http://hl7.org.au/fhir/StructureDefinition/closing-the-gap-registration',
      valueBoolean: true
    }
  ],
  identifier: [
    {
      type: {
        coding: [
          {
            system: 'http://terminology.hl7.org/CodeSystem/v2-0203',
            code: 'MC',
            display: "Patient's Medicare number"
          }
        ]
      },
      value: '12345678901',
      period: {
        end: '2025-12-31'
      }
    }
  ],
  telecom: [
    {
      system: 'phone',
      value: '0398765432',
      use: 'home'
    },
    {
      system: 'phone',
      value: '0412345678',
      use: 'mobile'
    },
    {
      system: 'email',
      value: 'john.snow@example.com',
      use: 'home'
    }
  ],
  address: [
    {
      use: 'home',
      type: 'physical',
      line: ['123 Winter Lane'],
      city: 'Melbourne',
      state: 'VIC',
      postalCode: '3000'
    },
    {
      use: 'home',
      type: 'postal',
      line: ['123 Winter Lane'],
      city: 'Melbourne',
      state: 'VIC',
      postalCode: '3000'
    }
  ],
  contact: [
    {
      relationship: [
        {
          coding: [
            {
              system: 'http://terminology.hl7.org/CodeSystem/v2-0131',
              code: 'C',
              display: 'Emergency Contact'
            }
          ]
        }
      ],
      name: {
        family: 'Stark',
        given: ['Arya']
      },
      telecom: [
        {
          system: 'phone',
          value: '0400000000'
        },
        {
          system: 'email',
          value: 'arya.stark@example.com'
        }
      ]
    }
  ]
};

export const practitioner: Practitioner = {
  resourceType: 'Practitioner',
  id: 'practitioner-456',
  name: [
    {
      use: 'official',
      family: 'Smith',
      given: ['Jane']
    }
  ],
  address: [
    {
      use: 'work',
      type: 'both',
      line: ['1 Clinic Road'],
      city: 'Melbourne',
      state: 'VIC',
      postalCode: '3000'
    }
  ]
};

export const clinicLocation: Location = {
  resourceType: 'Location',
  id: 'clinic-location-1',
  name: 'Clinic Location',
  address: practitioner.address?.[0]
};

export const practitionerRole: PractitionerRole = {
  resourceType: 'PractitionerRole',
  id: 'practitioner-role-1',
  practitioner: {
    reference: `Practitioner/${practitioner.id}`
  },
  location: [
    {
      reference: `Location/${clinicLocation.id}`
    }
  ]
};

export const practitionerRoleLocationBundle: Bundle = {
  resourceType: 'Bundle',
  type: 'searchset',
  entry: [{ resource: practitionerRole }, { resource: clinicLocation }]
};

export const resolvedCondition: Condition = {
  resourceType: 'Condition',
  id: 'resolved-condition',
  subject: { reference: `Patient/${patient.id}` },
  onsetDateTime: '2025-10-10',
  abatementDateTime: '2026-10-10',
  code: {
    coding: [
      {
        system: 'http://snomed.info/sct',
        code: '654321',
        display: 'Resolved condition'
      }
    ]
  },
  clinicalStatus: {
    coding: [
      {
        system: 'http://terminology.hl7.org/CodeSystem/condition-clinical',
        code: 'inactive'
      }
    ]
  },
  verificationStatus: {
    coding: [
      {
        code: 'confirmed'
      }
    ]
  },
  category: [
    {
      coding: [
        {
          system: 'http://terminology.hl7.org/CodeSystem/condition-category',
          code: 'problem-list-item'
        }
      ]
    }
  ]
};

export const allergy: AllergyIntolerance = {
  resourceType: 'AllergyIntolerance',
  id: 'allergy',
  patient: { reference: `Patient/${patient.id}` },
  code: {
    coding: [
      {
        system: 'http://snomed.info/sct',
        code: '388050007',
        display: 'Cashew nut specific IgE'
      }
    ]
  },
  clinicalStatus: {
    coding: [
      {
        system:
          'http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical',
        code: 'active'
      }
    ]
  },
  reaction: [
    {
      manifestation: [
        {
          coding: [
            {
              system: 'http://snomed.info/sct',
              code: '271807003',
              display: 'Rash'
            }
          ]
        }
      ]
    }
  ],
  note: [
    {
      text: 'Patient experiences rash and swelling'
    }
  ]
};

export const currentMedication: MedicationStatement = {
  resourceType: 'MedicationStatement',
  id: 'current-medication',
  subject: { reference: `Patient/${patient.id}` },
  dateAsserted: '2026-03-01',
  medicationCodeableConcept: {
    coding: [
      {
        code: '23628011000036109',
        display: 'Paracetamol 500 mg tablet',
        system: 'http://snomed.info/sct'
      }
    ]
  },
  status: 'active',
  dosage: [
    {
      text: 'Once daily, 10mg'
    }
  ],
  reasonCode: [
    {
      coding: [
        {
          system: 'http://snomed.info/sct',
          code: '418022001',
          display: 'Iris tuck'
        }
      ]
    }
  ],
  note: [
    {
      text: 'Patient should take with food'
    }
  ]
};

export const obsBodyHeight: Observation = {
  resourceType: 'Observation',
  id: 'obs-body-height',
  status: 'final',
  subject: { reference: `Patient/${patient.id}` },
  category: [
    {
      coding: [
        {
          system: 'http://terminology.hl7.org/CodeSystem/observation-category',
          code: 'vital-signs'
        }
      ]
    }
  ],
  code: {
    coding: [
      { system: 'http://loinc.org', code: '8302-2' },
      { system: 'http://snomed.info/sct', code: '50373000' }
    ],
    text: 'Height'
  },
  effectiveDateTime: '2025-11-20',
  valueQuantity: {
    value: 170,
    unit: 'cm',
    system: 'http://unitsofmeasure.org',
    code: 'cm'
  }
};

export const obsBodyWeight: Observation = {
  resourceType: 'Observation',
  id: 'obs-body-weight',
  status: 'final',
  category: [
    {
      coding: [
        {
          system: 'http://terminology.hl7.org/CodeSystem/observation-category',
          code: 'vital-signs'
        }
      ]
    }
  ],
  subject: { reference: `Patient/${patient.id}` },
  code: {
    coding: [
      { system: 'http://loinc.org', code: '29463-7' },
      { system: 'http://snomed.info/sct', code: '27113001' }
    ],
    text: 'Weight'
  },
  effectiveDateTime: '2025-11-21',
  valueQuantity: {
    value: 70,
    unit: 'kg',
    system: 'http://unitsofmeasure.org',
    code: 'kg'
  }
};

export const obsWaistCircumference: Observation = {
  resourceType: 'Observation',
  id: 'obs-waist-circumference',
  status: 'final',
  subject: { reference: `Patient/${patient.id}` },
  category: [
    {
      coding: [
        {
          code: 'vital-signs',
          system: 'http://terminology.hl7.org/CodeSystem/observation-category'
        }
      ]
    }
  ],
  code: {
    coding: [
      { system: 'http://loinc.org', code: '8280-0' },
      { system: 'http://snomed.info/sct', code: '276361009' }
    ],
    text: 'Waist circumference'
  },
  effectiveDateTime: '2025-11-23',
  valueQuantity: {
    value: 90,
    unit: 'cm',
    system: 'http://unitsofmeasure.org',
    code: 'cm'
  }
};

export const obsHeartRate: Observation = {
  resourceType: 'Observation',
  id: 'obs-heart-rate',
  status: 'final',
  subject: { reference: `Patient/${patient.id}` },
  category: [
    {
      coding: [
        {
          code: 'vital-signs',
          system: 'http://terminology.hl7.org/CodeSystem/observation-category'
        }
      ]
    }
  ],
  code: {
    coding: [
      { system: 'http://loinc.org', code: '78564009' },
      { system: 'http://snomed.info/sct', code: '364075005' }
    ],
    text: 'Heart rate'
  },
  effectiveDateTime: '2025-12-04',
  valueQuantity: {
    value: 72,
    unit: '/min',
    system: 'http://unitsofmeasure.org',
    code: '/min'
  }
};

export const obsHeartRhythm: Observation = {
  resourceType: 'Observation',
  id: 'obs-heart-rhythm',
  status: 'final',
  subject: { reference: `Patient/${patient.id}` },
  category: [
    {
      coding: [
        {
          code: 'vital-signs',
          system: 'http://terminology.hl7.org/CodeSystem/observation-category'
        }
      ]
    }
  ],
  code: {
    coding: [
      { system: 'http://loinc.org', code: '364095004' },
      { system: 'http://snomed.info/sct', code: '364074009' }
    ],
    text: 'Heart rhythm'
  },
  effectiveDateTime: '2025-12-03',
  valueCodeableConcept: {
    coding: [
      {
        system: 'http://snomed.info/sct',
        code: '271636001',
        display: 'Pulse regular'
      }
    ]
  }
};

export const obsOxygenSaturation: Observation = {
  resourceType: 'Observation',
  id: 'obs-oxygen-saturation',
  status: 'final',
  subject: { reference: `Patient/${patient.id}` },
  category: [
    {
      coding: [
        {
          code: 'vital-signs',
          system: 'http://terminology.hl7.org/CodeSystem/observation-category'
        }
      ]
    }
  ],
  code: {
    coding: [
      {
        system: 'http://loinc.org',
        code: '2708-6',
        display: 'Oxygen saturation in Arterial blood'
      },
      {
        system: 'http://loinc.org',
        code: '59408-5',
        display: 'Oxygen saturation in Arterial blood by Pulse oximetry'
      },
      {
        system: 'http://snomed.info/sct',
        code: '103228002',
        display: 'Oxygen saturation'
      }
    ],
    text: 'Oxygen saturation'
  },
  effectiveDateTime: '2025-12-04',
  valueQuantity: {
    value: 98,
    unit: '%',
    system: 'http://unitsofmeasure.org',
    code: '%'
  }
};

export const obsBloodPressure: Observation = {
  resourceType: 'Observation',
  id: 'obs-blood-pressure',
  status: 'final',
  subject: { reference: `Patient/${patient.id}` },
  category: [
    {
      coding: [
        {
          system: 'http://terminology.hl7.org/CodeSystem/observation-category',
          code: 'vital-signs'
        }
      ]
    }
  ],
  code: {
    coding: [
      {
        system: 'http://loinc.org',
        code: '85354-9'
      },
      {
        code: '75367002',
        system: 'http://snomed.info/sct'
      }
    ],
    text: 'Blood pressure'
  },
  effectiveDateTime: '2025-12-02',
  component: [
    {
      code: {
        coding: [
          {
            system: 'http://loinc.org',
            code: '8480-6'
          },
          {
            code: '271649006',
            system: 'http://snomed.info/sct'
          }
        ],
        text: 'Systolic'
      },
      valueQuantity: {
        value: 120,
        unit: 'mm[Hg]',
        system: 'http://unitsofmeasure.org',
        code: 'mm[Hg]'
      }
    },
    {
      code: {
        coding: [
          {
            system: 'http://loinc.org',
            code: '8462-4'
          },
          {
            code: '271650006',
            system: 'http://snomed.info/sct'
          }
        ],
        text: 'Diastolic'
      },
      valueQuantity: {
        value: 80,
        unit: 'mm[Hg]',
        system: 'http://unitsofmeasure.org',
        code: 'mm[Hg]'
      }
    }
  ]
};

export const obsTobaccoSmokingStatus: Observation = {
  resourceType: 'Observation',
  id: 'obs-tobacco-smoking-status',
  status: 'final',
  subject: { reference: `Patient/${patient.id}` },
  category: [
    {
      coding: [
        {
          system: 'http://terminology.hl7.org/CodeSystem/observation-category',
          code: 'social-history'
        }
      ]
    }
  ],
  code: {
    coding: [
      {
        system: 'http://snomed.info/sct',
        code: '1747861000168109'
      },
      {
        code: '72166-2',
        system: 'http://loinc.org'
      }
    ],
    text: 'Smoking status'
  },
  effectiveDateTime: '2025-12-01',
  valueCodeableConcept: {
    coding: [
      {
        system: 'http://snomed.info/sct',
        code: '77176002',
        display: 'Current smoker'
      }
    ]
  }
};

export const obsAlcoholConsumption: Observation = {
  resourceType: 'Observation',
  id: 'obs-alcohol-consumption',
  status: 'final',
  subject: { reference: `Patient/${patient.id}` },
  category: [
    {
      coding: [
        {
          code: 'social-history',
          system: 'http://terminology.hl7.org/CodeSystem/observation-category'
        }
      ]
    }
  ],
  code: {
    coding: [
      {
        system: 'http://loinc.org',
        code: '897148007',
        display: 'History of Alcohol use'
      },
      {
        system: 'http://snomed.info/sct',
        code: '228273003',
        display: 'Finding relating to alcohol drinking behavior'
      }
    ],
    text: 'Alcohol consumption status'
  },
  effectiveDateTime: '2025-12-04',
  valueCodeableConcept: {
    coding: [
      {
        system: 'http://snomed.info/sct',
        code: '219006',
        display: 'Current drinker of alcohol'
      }
    ],
    text: 'Current drinker'
  }
};

// Literal dates relative to the anchored 17 August 2026 clinical calendar.
export const completedPlanAuthoredDate = '2026-02-18';

export const questionnaireResponsePlan: QuestionnaireResponse = {
  resourceType: 'QuestionnaireResponse',
  id: 'questionnaire-response-plan',
  questionnaire:
    'http://www.health.gov.au/assessments/GPChronicConditionManagementPlan',
  status: 'completed',
  subject: { reference: `Patient/${patient.id}` },
  authored: `${completedPlanAuthoredDate}T10:00:00Z`,
  item: [
    {
      linkId: 'plan-type',
      text: 'New plan or a review of an existing plan?',
      answer: [{ valueCoding: { code: 'review', display: 'Review' } }]
    }
  ]
};

export const questionnaireResponsePlanDraft: QuestionnaireResponse = {
  resourceType: 'QuestionnaireResponse',
  id: 'questionnaire-response-plan-draft',
  questionnaire:
    'http://www.health.gov.au/assessments/GPChronicConditionManagementPlan',
  status: 'in-progress',
  subject: { reference: `Patient/${patient.id}` },
  authored: '2026-01-10T10:00:00Z'
};

export function makeSearchSetBundle(resources: FhirResource[]): Bundle {
  return {
    resourceType: 'Bundle',
    type: 'searchset',
    entry: resources.map((resource) => ({
      resource: resource
    }))
  };
}
