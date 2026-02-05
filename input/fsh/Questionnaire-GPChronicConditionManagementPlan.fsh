Alias: $LNC = http://loinc.org
Alias: $SCT = http://snomed.info/sct
Alias: $UCUM = http://unitsofmeasure.org
Alias: $questionnaire-item-control = http://hl7.org/fhir/questionnaire-item-control

Instance: GPChronicConditionManagementPlan
InstanceOf: Questionnaire
Usage: #definition
Title: "GP Chronic Condition Management Plan"
Description: "GP Chronic Condition Management Plan"

* contained[+] = YesNoNA
//* contained[+] = YesNo

//launch context
* extension[sdc-questionnaire-launchContext][+].extension[name].valueCoding = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext#patient
* extension[sdc-questionnaire-launchContext][=].extension[type].valueCode = #Patient
* extension[sdc-questionnaire-launchContext][=].extension[description].valueString = "The patient that is to be used to pre-populate the form. This is the subject of the form."
* extension[sdc-questionnaire-launchContext][+].extension[name].valueCoding = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext#user
* extension[sdc-questionnaire-launchContext][=].extension[type].valueCode = #Practitioner
* extension[sdc-questionnaire-launchContext][=].extension[description].valueString = "The practitioner user that is to be used to pre-populate the form. This is the user that is filling out the form."
* extension[sdc-questionnaire-launchContext][+].extension[name].valueCoding = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext#encounter
* extension[sdc-questionnaire-launchContext][=].extension[type].valueCode = #Encounter
* extension[sdc-questionnaire-launchContext][=].extension[description].valueString = "The encounter that is to be used to pre-populate the form. This is the encounter during which the form is being filled out."
* extension[sdc-questionnaire-launchContext][+].extension[name].valueCoding = LaunchContextExtended#gpccmppractitionerrole
* extension[sdc-questionnaire-launchContext][=].extension[type].valueCode = #PractitionerRole
* extension[sdc-questionnaire-launchContext][=].extension[description].valueString = "The practitioner role that is to be used to pre-populate the form. This is the practitioner role of the user that is filling out the form."

//fhir query variables
* extension[variable][+].valueExpression.name = "GPCCMPLatest"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "QuestionnaireResponse?questionnaire=http://www.health.gov.au/assessments/GPChronicConditionManagementPlan&_count=1&_sort=-authored&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "GPCCMPLatestCompleted"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "QuestionnaireResponse?questionnaire=http://www.health.gov.au/assessments/GPChronicConditionManagementPlan&status=completed&_count=1&_sort=-authored&patient={{%patient.id}}"

// This needs to be removed once support for PractitionerRole launch context is supported. This is a workaround, however, it could lead to issues if the user has multiple PractitionerRoles.
* extension[variable][+].valueExpression.name = "PractitionerRole"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "PractitionerRole?practitioner={{%user.id}}"

* extension[variable][+].valueExpression.name = "Condition"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Condition?patient={{%patient.id}}&category=http://terminology.hl7.org/CodeSystem/condition-category|problem-list-item"

* extension[variable][+].valueExpression.name = "AllergyIntolerance"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "AllergyIntolerance?patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "MedicationStatement"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "MedicationStatement?patient={{%patient.id}}&status=active&_include=MedicationStatement:medication"

* extension[variable][+].valueExpression.name = "ObsBodyHeight"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=8302-2&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsBodyWeight"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=29463-7&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsWaistCircumference"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=8280-0&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsHeartRate"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=8867-4&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsHeartRhythm"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=364074009&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsOxygenSaturation"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=2708-6&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsBloodPressure"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=85354-9&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsSmokingStatus"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=1747861000168109&_sort=-date&patient={{%patient.id}}"


//fhirpath variables
* extension[variable][+].valueExpression.name = "age"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "repeat(item).where(linkId='patient-age').answer.value"
    //BMI calculation variables
* extension[variable][+].valueExpression.name = "weight"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "repeat(item).where(linkId='clinicaldetails-observations-maingrid-weight-value').answer.value"

* extension[variable][+].valueExpression.name = "height"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "repeat(item).where(linkId='clinicaldetails-observations-maingrid-height-value').answer.value"
    //Medications variables
* extension[variable][+].valueExpression.name = "medicationsFromContained"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%MedicationStatement.entry.resource.contained.ofType(Medication).where(id in %MedicationStatement.entry.resource.medication.select(reference.replace('#', '')))"

* extension[variable][+].valueExpression.name = "medicationsFromRef"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%MedicationStatement.entry.resource.ofType(Medication).where(id in %MedicationStatement.entry.resource.medication.select(reference.replace('Medication/', '')))"
    //client side filtering on Observations
* extension[variable][+].valueExpression.name = "ObsBodyHeightLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBodyHeight.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsBodyWeightLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBodyWeight.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsWaistCircumferenceLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsWaistCircumference.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsHeartRateLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsHeartRate.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsHeartRhythmLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsHeartRhythm.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsOxygenSaturationLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsOxygenSaturation.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsBloodPressureLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBloodPressure.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsSmokingStatusLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsSmokingStatus.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

//R5 preadoption extensions
* extension[+].url = "http://hl7.org/fhir/5.0/StructureDefinition/extension-Questionnaire.versionAlgorithm[x]"
* extension[=].valueCoding = http://hl7.org/fhir/version-algorithm#semver

//Questionnaire metadata
* meta.profile[+] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-render"
* meta.profile[+] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-pop-exp"
* url = "http://www.health.gov.au/assessments/GPChronicConditionManagementPlan"
* name = "GPChronicConditionManagementPlan"
* title = "GP Chronic Condition Management Plan"
* status = #draft
* experimental = false
* subjectType[+] = #Patient
* date = "2025-12-05"
* jurisdiction.coding = urn:iso:std:iso:3166#AU

//Container
* item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#tab-container
* item[=].linkId = "container"
* item[=].type = #group
* item[=].repeats = false
//Patient details
* item[=].item[+].linkId = "patient"
* item[=].item[=].text = "Patient details"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
* item[=].item[=].item[+].linkId = "patient-instructions"
* item[=].item[=].item[=].text = "This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record."
* item[=].item[=].item[=].text.extension[rendering-xhtml].valueString = "<div xmlns=\"http://www.w3.org/1999/xhtml\">
    <p><em>This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record.</em></p></div>"
* item[=].item[=].item[=].type = #display
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "(%patient.name.where(use='official').select((given.join(' ') | family).join(' ') | text) | %patient.name.select((given.join(' ') | family).join(' ') | text)).first()"
* item[=].item[=].item[=].linkId = "patient-name"
* item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "(%patient.name.where(use='usual').select((given.join(' ') | family).join(' ') | text)).first()"
* item[=].item[=].item[=].linkId = "patient-preferredname"
* item[=].item[=].item[=].text = "Preferred name"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(exists(url='http://hl7.org/fhir/StructureDefinition/individual-pronouns') and extension.where(url='period').value.end.empty()).extension.where(url='value').value.coding"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].linkId = "patient-preferredpronouns"
* item[=].item[=].item[=].text = "Preferred pronouns"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-pronouns-1"
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.birthDate"
* item[=].item[=].item[=].linkId = "patient-dob"
* item[=].item[=].item[=].text = "Date of birth"
* item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "iif(today().toString().select(substring(5,2) & substring(8,2)).toInteger() > %patient.birthDate.toString().select(substring(5,2) & substring(8,2)).toInteger(), today().toString().substring(0,4).toInteger() - %patient.birthDate.toString().substring(0,4).toInteger(), today().toString().substring(0,4).toInteger() - %patient.birthDate.toString().substring(0,4).toInteger() - 1)"
* item[=].item[=].item[=].linkId = "patient-age"
* item[=].item[=].item[=].text = "Age"
* item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(exists(url='http://hl7.org/fhir/StructureDefinition/individual-recordedSexOrGender' and extension.where(exists(url='type' and value.coding.code='1515311000168102')) and extension.where(url='effectivePeriod').value.end.empty())).extension.where(url='value').value.coding"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].linkId = "patient-sexatbirth"
* item[=].item[=].item[=].text = "Sex assigned at birth"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/biological-sex-1"
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(exists(url='http://hl7.org/fhir/StructureDefinition/individual-genderIdentity') and extension.where(url='period').value.end.empty()).extension.where(url='value').value.coding"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].linkId = "patient-genderidentity"
* item[=].item[=].item[=].text = "Gender identity"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/gender-identity-response-1"
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(url='http://hl7.org.au/fhir/StructureDefinition/indigenous-status').value"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].linkId = "patient-firstnationsstatus"
* item[=].item[=].item[=].text = "Aboriginal and/or Torres Strait Islander status"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-indigenous-status-1"
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(url='http://hl7.org.au/fhir/StructureDefinition/closing-the-gap-registration').value"
* item[=].item[=].item[=].linkId = "patient-ctg"
* item[=].item[=].item[=].text = "Registered for Closing the Gap PBS Co-payment Measure (CTG)"
* item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-enableWhenExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-enableWhenExpression].valueExpression.expression = "%age >= 50"
* item[=].item[=].item[=].linkId = "patient-myagedcare"
* item[=].item[=].item[=].text = "My Aged Care"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].item[=].extension[questionnaire-choiceOrientation].valueCode = #horizontal
* item[=].item[=].item[=].item[=].linkId = "patient-myagedcare-registered"
* item[=].item[=].item[=].item[=].text = "Registered for My Aged Care"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "#YesNoNA"
* item[=].item[=].item[=].item[+].linkId = "patient-myagedcare-number"
* item[=].item[=].item[=].item[=].text = "My Aged Care Number"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-myagedcare-registered"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].linkId = "patient-ndis"
* item[=].item[=].item[=].text = "National Disability Insurance Scheme"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].item[=].extension[questionnaire-choiceOrientation].valueCode = #horizontal
* item[=].item[=].item[=].item[=].linkId = "patient-ndis-registered"
* item[=].item[=].item[=].item[=].text = "Registered for NDIS"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "#YesNoNA"
* item[=].item[=].item[=].item[+].linkId = "patient-ndis-number"
* item[=].item[=].item[=].item[=].text = "NDIS Number"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-ndis-registered"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "MedicareNumberArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.identifier.where(type.coding.exists(system='http://terminology.hl7.org/CodeSystem/v2-0203' and code='MC'))"
* item[=].item[=].item[=].linkId = "patient-medicare"
* item[=].item[=].item[=].text = "Medicare number"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%MedicareNumberArray.value.substring(0,10)"
* item[=].item[=].item[=].item[=].extension[regex].valueString = "matches('^[0-9]{10}$')"
* item[=].item[=].item[=].item[=].linkId = "patient-medicare-number"
* item[=].item[=].item[=].item[=].text = "Number"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%MedicareNumberArray.value.substring(10,1)"
* item[=].item[=].item[=].item[=].extension[regex].valueString = "matches('^[0-9]{1}$')"
* item[=].item[=].item[=].item[=].linkId = "patient-medicare-referencenumber"
* item[=].item[=].item[=].item[=].text = "Reference number"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%MedicareNumberArray.period.end.toString()"
* item[=].item[=].item[=].item[=].linkId = "patient-medicare-expiry"
* item[=].item[=].item[=].item[=].text = "Expiry"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
    // Contact information
* item[=].item[=].item[+].linkId = "patient-contact"
* item[=].item[=].item[=].text = "Contact information"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false 
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.telecom.where(system = 'phone' and use = 'home').value"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-homephone"
* item[=].item[=].item[=].item[=].text = "Home phone"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.telecom.where(system = 'phone' and use = 'mobile').value"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-mobilephone"
* item[=].item[=].item[=].item[=].text = "Mobile phone"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.telecom.where(all(system = 'email' and (use.empty() or use = 'home'))).value"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-email"
* item[=].item[=].item[=].item[=].text = "Email"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "HomeAddressArray"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.address.where(all(use='home' and (type.empty() or type!='postal')))"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-homeaddress"
* item[=].item[=].item[=].item[=].text = "Home address"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%HomeAddressArray.extension('http://hl7.org.au/fhir/StructureDefinition/no-fixed-address').value"
* item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#check-box
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-homeaddress-nofixedaddress"
* item[=].item[=].item[=].item[=].item[=].text = "No fixed address"
* item[=].item[=].item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "patient-contact-homeaddress-details"
* item[=].item[=].item[=].item[=].item[=].text = "Home address"
* item[=].item[=].item[=].item[=].item[=].text.extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/QuestionnaireItemTextHidden"
* item[=].item[=].item[=].item[=].item[=].text.extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-contact-homeaddress-nofixedaddress"
* item[=].item[=].item[=].item[=].item[=].enableWhen[=].operator = #!=
* item[=].item[=].item[=].item[=].item[=].enableWhen[=].answerBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%HomeAddressArray.select(line.join(', '))"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-homeaddress-details-streetaddress"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Street address"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%HomeAddressArray.city"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-homeaddress-details-city"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "City"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%HomeAddressArray.state"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-homeaddress-details-state"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "State"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-states-territories-2"
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%HomeAddressArray.postalCode"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[regex].valueString = "matches('^[0-9]{4}$')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[entryFormat].valueString = "####"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-homeaddress-details-postcode"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Postcode"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "PostalAddressArray"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.address.where(type='postal')"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-enableWhenExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-enableWhenExpression].valueExpression.expression = "%PostalAddressArray.exists()"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-postaladdress"
* item[=].item[=].item[=].item[=].text = "Postal address"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PostalAddressArray.use"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-postaladdress-purpose"
* item[=].item[=].item[=].item[=].item[=].text = "Purpose of use"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PostalAddressArray.select(line.join(', '))"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-postaladdress-streetaddress"
* item[=].item[=].item[=].item[=].item[=].text = "Street address"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PostalAddressArray.city"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-postaladdress-city"
* item[=].item[=].item[=].item[=].item[=].text = "City"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PostalAddressArray.state"
* item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-postaladdress-state"
* item[=].item[=].item[=].item[=].item[=].text = "State"
* item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-states-territories-2"
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PostalAddressArray.postalCode"
* item[=].item[=].item[=].item[=].item[=].extension[regex].valueString = "matches('^[0-9]{4}$')"
* item[=].item[=].item[=].item[=].item[=].extension[entryFormat].valueString = "####"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-postaladdress-postcode"
* item[=].item[=].item[=].item[=].item[=].text = "Postcode"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false  
    // Carer information
* item[=].item[=].item[+].linkId = "patient-carerdetails"
* item[=].item[=].item[=].text = "Carer information"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].item[=].extension[questionnaire-choiceOrientation].valueCode = #horizontal
* item[=].item[=].item[=].item[=].linkId = "patient-carerinformation-hascarer"
* item[=].item[=].item[=].item[=].text = "Do you have a carer?"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "#YesNoNA"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "CarerContactArray"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.contact.where(relationship.coding.exists(code = '133932002' and system = 'http://snomed.info/sct'))"
* item[=].item[=].item[=].item[=].linkId = "patient-carerinformation-contact"
* item[=].item[=].item[=].item[=].text = "Carer contact"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-carerinformation-hascarer"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%CarerContactArray.name.select((given.join(' ') | family).join(' ') | text)"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-carerinformation-contact-name"
* item[=].item[=].item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%CarerContactArray.telecom.where(system = 'phone').value"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-carerinformation-contact-phone"
* item[=].item[=].item[=].item[=].item[=].text = "Phone"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%CarerContactArray.telecom.where(system = 'email').value"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-carerinformation-contact-email"
* item[=].item[=].item[=].item[=].item[=].text = "Email"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].linkId = "patient-carerinformation-additionaldetails"
* item[=].item[=].item[=].item[=].text = "Additional details"
* item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-carerinformation-hascarer"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].item[=].extension[questionnaire-choiceOrientation].valueCode = #horizontal
* item[=].item[=].item[=].item[=].linkId = "patient-carerinformation-present"
* item[=].item[=].item[=].item[=].text = "Carer present at appointment"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-carerinformation-hascarer"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "#YesNoNA"
    // Third party contacts
* item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "ThirdPartyContactArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.contact.where(relationship.coding.exists(code = 'C' or code = '1072531000168103' or code = '394619001' or code = '1155871000168103' or code = '1620171000168100' or code = 'CP' or code = 'EP' or code = 'N'))"
* item[=].item[=].item[=].linkId = "patient-thirdpartycontacts"
* item[=].item[=].item[=].text = "Third party contacts"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ThirdPartyContactArray.relationship.coding"
* item[=].item[=].item[=].item[=].linkId = "patient-thirdpartycontacts-type"
* item[=].item[=].item[=].item[=].text = "Type"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://snomed.info/sct#1072531000168103
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://snomed.info/sct#394619001
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://snomed.info/sct#1155871000168103
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://snomed.info/sct#1620171000168100
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://terminology.hl7.org/CodeSystem/v2-0131#C
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://terminology.hl7.org/CodeSystem/v2-0131#CP
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://terminology.hl7.org/CodeSystem/v2-0131#EP
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://terminology.hl7.org/CodeSystem/v2-0131#N
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ThirdPartyContactArray.name.select((given.join(' ') | family).join(' ') | text)"
* item[=].item[=].item[=].item[=].linkId = "patient-thirdpartycontacts-name"
* item[=].item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ThirdPartyContactArray.telecom.where(system = 'phone').value"
* item[=].item[=].item[=].item[=].linkId = "patient-thirdpartycontacts-phone"
* item[=].item[=].item[=].item[=].text = "Phone"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ThirdPartyContactArray.telecom.where(system = 'email').value"
* item[=].item[=].item[=].item[=].linkId = "patient-thirdpartycontacts-email"
* item[=].item[=].item[=].item[=].text = "Email"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
// this is a user entered field and is not equivalent to the relationship coding in the FHIR resource
* item[=].item[=].item[=].item[+].linkId = "patient-thirdpartycontacts-relationship"
* item[=].item[=].item[=].item[=].text = "Relationship to patient"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "patient-thirdpartycontacts-additionalinformation"
* item[=].item[=].item[=].item[=].text = "Additional information"
* item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].repeats = false


//Practitioner details
* item[=].item[+].linkId = "practitioner"
* item[=].item[=].text = "Practitioner details"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
* item[=].item[=].item[+].linkId = "practitioner-instructions"
* item[=].item[=].item[=].text = "This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record."
* item[=].item[=].item[=].text.extension[rendering-xhtml].valueString = "<div xmlns=\"http://www.w3.org/1999/xhtml\">
    <p><em>This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record.</em></p></div>"
* item[=].item[=].item[=].type = #display
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "(%user.name.where(use='official').select((given.join(' ') | family).join(' ') | text) | %user.name.select((given.join(' ') | family).join(' ') | text)).first()"
* item[=].item[=].item[=].linkId = "practitioner-name"
* item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PractitionerRole.entry.resource.telecom.where(system = 'phone').value"
* item[=].item[=].item[=].linkId = "practitioner-phone"
* item[=].item[=].item[=].text = "Phone"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PractitionerRole.entry.resource.telecom.where(system = 'email').value"
* item[=].item[=].item[=].linkId = "practitioner-email"
* item[=].item[=].item[=].text = "Email"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PractitionerRole.entry.resource.identifier.where(system = 'http://ns.electronichealth.net.au/id/medicare-provider-number').value"
* item[=].item[=].item[=].linkId = "practitioner-providernumber"
* item[=].item[=].item[=].text = "Provider number"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].readOnly = true

//Clinical details
* item[=].item[+].linkId = "clinicaldetails"
* item[=].item[=].text = "Clinical details"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
* item[=].item[=].item[+].linkId = "clinicaldetails-instructions"
* item[=].item[=].item[=].text = "This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record."
* item[=].item[=].item[=].text.extension[rendering-xhtml].valueString = "<div xmlns=\"http://www.w3.org/1999/xhtml\">
    <p><em>This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record.</em></p></div>"
* item[=].item[=].item[=].type = #display
    //Problems/Diagnoses
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "ConditionArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%Condition.entry.resource.where(verificationStatus.coding.all(code.empty() or code='confirmed'))"
* item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses"
* item[=].item[=].item[=].text = "Problems/Diagnoses"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-width].valueQuantity = 40 '%'
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-condition"
* item[=].item[=].item[=].item[=].text = "Condition"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.clinicalStatus.coding"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-clinicalstatus"
* item[=].item[=].item[=].item[=].text = "Clinical status"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].answerValueSet = "http://hl7.org/fhir/ValueSet/condition-clinical|4.0.1"
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.onset.ofType(dateTime).toDate()"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-onsetdate"
* item[=].item[=].item[=].item[=].text = "Onset date"
* item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.abatement.ofType(dateTime).toDate()"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-abatementdate"
* item[=].item[=].item[=].item[=].text = "Abatement date"
* item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
    //Adverse reaction risk
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][+].valueExpression[+].name = "AllergyIntoleranceArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].expression = "%AllergyIntolerance.entry.resource.where(clinicalStatus.coding.exists(code='active')).where(verificationStatus.coding.all(code.empty() or code='confirmed'))"
* item[=].item[=].item[=].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].linkId = "clinicaldetails-allergy"
* item[=].item[=].item[=].text = "Adverse reaction risk"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergy-substance"
* item[=].item[=].item[=].item[=].text = "Substance"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/adverse-reaction-agent-1"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.reaction.manifestation.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergy-manifestation"
* item[=].item[=].item[=].item[=].text = "Manifestation"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-finding-1"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
//possible to support repeating comments. Needs nested itemPopulationContext which may not yet be supported. Needs investigation.
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.note[0].text"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergy-comment"
* item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
    // Medications
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][+].valueExpression[+].name = "MedicationStatementArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].expression = "%MedicationStatement.entry.resource.ofType(MedicationStatement)"
* item[=].item[=].item[=].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].linkId = "clinicaldetails-medications"
* item[=].item[=].item[=].text = "Medications"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
/*
  This expression selects the SNOMED coding from MedicationStatements.
  In some cases, medication.reference may be a reference to a contained Medication resource or an external Medication resource.
  %medicationsFromContained and %medicationsFromRef contains a list of contained Medication resources and externally referenced Medication resources respectively.

  Step 1: Check if the medication.reference is a contained resource (starts with '#') and if its ID is in %medicationsFromContained.
  Step 2: If it is, use the ID to find the corresponding Medication resource in %medicationsFromContained and select its SNOMED coding.
  Step 3: Otherwise, check if the medication.reference is an external resource (starts with 'Medication/') and if its ID is in %medicationsFromRef.
  Step 4: If it is, use the ID to find the corresponding Medication resource in %medicationsFromRef and select its SNOMED coding.
  Step 5: Otherwise, use the SNOMED coding from MedicationStatement.medication (medicationCodeableConcept to be specific).
*/
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "iif(%MedicationStatementArray.medication.reference.replace('#', '') in %medicationsFromContained.id, %medicationsFromContained.where(id = %MedicationStatementArray.medication.reference.replace('#', '')).code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first()), iif(%MedicationStatementArray.medication.reference.replace('Medication/', '') in %medicationsFromRef.id , %medicationsFromRef.where(id = %MedicationStatementArray.medication.reference.replace('Medication/', '')).code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first()), %MedicationStatementArray.medication.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())))"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-medication"
* item[=].item[=].item[=].item[=].text = "Medication"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-medication-1"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.dosage.text"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-dosage"
* item[=].item[=].item[=].item[=].text = "Dosage"
* item[=].item[=].item[=].item[=].type = #text
//do we need to support repeats for dosage?
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.reasonCode.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-indication"
* item[=].item[=].item[=].item[=].text = "Indication"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/medication-reason-taken-1"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.note.text"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-comment"
* item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].type = #text
//do we need to support repeats for comments?
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true

// Observations
    // Main table
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].linkId = "clinicaldetails-observations"
* item[=].item[=].item[=].text = "Observations"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#grid
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid"
* item[=].item[=].item[=].item[=].type = #group 
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-height"
* item[=].item[=].item[=].item[=].item[=].text = "Height"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBodyHeightLatest.value.value"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#cm
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-height-value"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Value"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-height-value-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "cm"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBodyHeightLatest.effective"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-height-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-weight"
* item[=].item[=].item[=].item[=].item[=].text = "Weight"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBodyWeightLatest.value.value"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#kg
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-weight-value"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Value"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-weight-value-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "kg"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBodyWeightLatest.effective"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-weight-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-bmi"
* item[=].item[=].item[=].item[=].item[=].text = "BMI"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.description = "BMI calculation"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "(%weight/((%height/100).power(2))).round(1)"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#kg/m2
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-bmi-value"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Value"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-bmi-value-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "kg/m2"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-waistcircumference"
* item[=].item[=].item[=].item[=].item[=].text = "Waist circumference"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsWaistCircumferenceLatest.value.value"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#cm
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-waistcircumference-value"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Value"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-waistcircumference-value-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "cm"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsWaistCircumferenceLatest.effective"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-waistcircumference-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-heartrate"
* item[=].item[=].item[=].item[=].item[=].text = "Heart rate"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsHeartRateLatest.value.value"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#/min
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-heartrate-value"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Value"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-heartrate-value-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "/min"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsHeartRateLatest.effective"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-heartrate-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-heartrhythm"
* item[=].item[=].item[=].item[=].item[=].text = "Heart rhythm"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsHeartRhythmLatest.value.coding.where(system='http://snomed.info/sct').first()"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-heartrhythm-value"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Value"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerOption[+].valueCoding = $SCT#933506231000036108 "Regular heart rhythm"
* item[=].item[=].item[=].item[=].item[=].item[=].answerOption[+].valueCoding = $SCT#361137007 "Irregular heart rhythm"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsHeartRhythmLatest.effective"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-heartrhythm-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-oxygensaturation"
* item[=].item[=].item[=].item[=].item[=].text = "Oxygen saturation"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsOxygenSaturationLatest.value.value"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#%
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-value"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Value"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-value-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "%"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsOxygenSaturationLatest.effective"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-smokingstatus"
* item[=].item[=].item[=].item[=].item[=].text = "Smoking status"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsSmokingStatusLatest.value.coding.where(system='http://snomed.info/sct').first()"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-smokingstatus-value"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Value"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/smoking-status-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsSmokingStatusLatest.effective"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-smokingstatus-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

    // Blood pressure table
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#grid
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid"
* item[=].item[=].item[=].item[=].type = #group 
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-bpgrid-bloodpressure"
* item[=].item[=].item[=].item[=].item[=].text = "Blood pressure"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBloodPressureLatest.component.where(code.coding.exists(code='8480-6')).value.value"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#mm[Hg]
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bloodpressure-systolic"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Systolic"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bloodpressure-systolic-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "mm Hg"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBloodPressureLatest.component.where(code.coding.exists(code='8462-4')).value.value"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#mm[Hg]
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bloodpressure-diastolic"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Diastolic"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bloodpressure-diastolic-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "mm Hg"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBloodPressureLatest.effective"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bloodpressure-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

//Management plan
* item[=].item[+].linkId = "plan"
* item[=].item[=].text = "Plan"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
    //Management plan details
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "today()"
* item[=].item[=].item[=].linkId = "plandetails-commenceddate"
* item[=].item[=].item[=].text = "Date this plan commenced"
* item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%GPCCMPLatest.entry.resource.where(status='in-progress').exists()"
* item[=].item[=].item[=].linkId = "plandetails-inprogress"
* item[=].item[=].item[=].text = "Incomplete draft plan already exists?"
* item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%GPCCMPLatestCompleted.entry.resource.authored"
* item[=].item[=].item[=].linkId = "plandetails-lastcompleteddate"
* item[=].item[=].item[=].text = "Date of last completed plan"
* item[=].item[=].item[=].type = #dateTime
* item[=].item[=].item[=].repeats = false
    //Chronic condition
* item[=].item[=].item[+].linkId = "plan-conditions"
* item[=].item[=].item[=].text = "Conditions addressed by this plan"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].linkId = "plan-conditions-condition"
* item[=].item[=].item[=].item[=].text = "Condition"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[+].linkId = "plan-conditions-onsetdate"
* item[=].item[=].item[=].item[=].text = "Onset date"
* item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "plan-conditions-comments"
* item[=].item[=].item[=].item[=].text = "Comments"
* item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].repeats = false
    // Goals and tasks group
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].linkId = "plan-goalstasks"
* item[=].item[=].item[=].text = "Goals and tasks"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-problemneed"
* item[=].item[=].item[=].item[=].text = "Problem/Need"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting"
* item[=].item[=].item[=].item[=].text = "Goal setting"
* item[=].item[=].item[=].item[=].text.extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/QuestionnaireItemTextHidden"
* item[=].item[=].item[=].item[=].text.extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 70 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting-goals"
* item[=].item[=].item[=].item[=].item[=].text = "Goals"
* item[=].item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 30 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting-targetdate"
* item[=].item[=].item[=].item[=].item[=].text = "Target date"
* item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-interventionsactions"
* item[=].item[=].item[=].item[=].text = "Interventions and actions"
* item[=].item[=].item[=].item[=].text.extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/QuestionnaireItemTextHidden"
* item[=].item[=].item[=].item[=].text.extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 28 '%'
* item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-interventionsactions-interventionsactions"
* item[=].item[=].item[=].item[=].item[=].text = "Interventions/Actions"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/procedure-1"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 24 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-interventionsactions-owner"
* item[=].item[=].item[=].item[=].item[=].text = "Owner"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 17 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-interventionsactions-duedate"
* item[=].item[=].item[=].item[=].item[=].text = "Due date"
* item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 31 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-interventionsactions-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-servicestreatments"
* item[=].item[=].item[=].item[=].text = "Services and treatments"
* item[=].item[=].item[=].item[=].text.extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/QuestionnaireItemTextHidden"
* item[=].item[=].item[=].item[=].text.extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 23 '%'
* item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-servicestreatments-servicestreatments"
* item[=].item[=].item[=].item[=].item[=].text = "Required services and treatments"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/service-type-1"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 23 '%'
* item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-servicestreatments-activity"
* item[=].item[=].item[=].item[=].item[=].text = "Activity"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/procedure-1"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 23 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-servicestreatments-provider"
* item[=].item[=].item[=].item[=].item[=].text = "Provider"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 31 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-servicestreatments-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false

//Notes
* item[=].item[=].item[+].linkId = "notes"
* item[=].item[=].item[=].text = "Notes"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[+].linkId = "notes-additionalcomments"
* item[=].item[=].item[=].item[=].text = "Additional notes or comments"
* item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].repeats = true

//Final preparations of plan
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].linkId = "completion"
* item[=].item[=].item[=].text = "Completion"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "completion-consent"
* item[=].item[=].item[=].item[=].text = "Consent"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "completion-consent-sharingconsent"
* item[=].item[=].item[=].item[=].item[=].text = "Consent given for sharing of information with relevant healthcare providers"
* item[=].item[=].item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "completion-consent-planconsent"
* item[=].item[=].item[=].item[=].item[=].text = "Consent given to proceed with plan after discussion of the purpose, benefits, process and costs"
* item[=].item[=].item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "completion-review"
* item[=].item[=].item[=].item[=].text = "Scheduled review date"
* item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].item[=].linkId = "completion-copyoffered"
* item[=].item[=].item[=].item[=].text = "Patient has been offered a copy of this plan"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerOption[+].valueString = "Yes, copy provided"
* item[=].item[=].item[=].item[=].answerOption[+].valueString = "Yes, copy to be provided at a later date"
* item[=].item[=].item[=].item[=].answerOption[+].valueString = "Yes, but declined"
* item[=].item[=].item[=].item[=].answerOption[+].valueString = "Not offered, plan to follow up and offer at a later date"
