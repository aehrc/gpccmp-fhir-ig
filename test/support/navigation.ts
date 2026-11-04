/** Exact section/answer fixtures shared by mounted and real-browser navigation checks. */
export const navigationScenarios = [
  {
    section: 'patient',
    field: 'patient-additionalinformation',
    value: 'S7 patient note',
    editable: true
  },
  {
    section: 'practitioner',
    field: 'practitioner-name',
    value: 'Jane Smith',
    editable: false
  },
  {
    section: 'clinicaldetails',
    field: 'clinicaldetails-observations-additionalinformation',
    value: 'S7 clinical note',
    editable: true
  },
  {
    section: 'plan',
    field: 'plan-conditions-comments',
    value: 'S7 plan comment',
    editable: true
  }
] as const;

export const sections = navigationScenarios.map((scenario) => scenario.section);
