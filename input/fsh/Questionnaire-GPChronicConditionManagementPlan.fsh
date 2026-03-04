Alias: $LNC = http://loinc.org
Alias: $SCT = http://snomed.info/sct
Alias: $UCUM = http://unitsofmeasure.org
Alias: $questionnaire-item-control = http://hl7.org/fhir/questionnaire-item-control

Instance: GPChronicConditionManagementPlan
InstanceOf: Questionnaire
Usage: #definition
Title: "GP Chronic Condition Management Plan"
Description: "GP Chronic Condition Management Plan"

//* contained[+] = YesNoNA
* contained[+] = YesNoPending
* contained[+] = YesNo
* contained[+] = pulse-rhythm-1
* contained[+] = MedicationStatementStatusLimited
* contained[+] = GoalStatusLimited

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

* extension[variable][+].valueExpression.name = "ObsPulseRate"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=78564009&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsPulseRhythm"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=364095004&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsOxygenSaturation"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=2708-6&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsBloodPressure"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=85354-9&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsSmokingStatus"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=1747861000168109&_sort=-date&patient={{%patient.id}}"

* extension[variable][+].valueExpression.name = "ObsAlcoholStatus"
* extension[variable][=].valueExpression.language = #application/x-fhir-query
* extension[variable][=].valueExpression.expression = "Observation?code=897148007&_sort=-date&patient={{%patient.id}}"


//fhirpath variables
* extension[variable][+].valueExpression.name = "age"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "repeat(item).where(linkId='patient-age').answer.value"
    //BMI calculation variables
* extension[variable][+].valueExpression.name = "weight"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "repeat(item).where(linkId='clinicaldetails-observations-maingrid-weight-newresultvalue').answer.value"

* extension[variable][+].valueExpression.name = "height"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "repeat(item).where(linkId='clinicaldetails-observations-maingrid-height-newresultvalue').answer.value"
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

* extension[variable][+].valueExpression.name = "ObsPulseRateLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsPulseRate.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsPulseRhythmLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsPulseRhythm.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsOxygenSaturationLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsOxygenSaturation.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsBloodPressureLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBloodPressure.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsSmokingStatusLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsSmokingStatus.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[variable][+].valueExpression.name = "ObsAlcoholStatusLatest"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsAlcoholStatus.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

        //Previous results variables
* extension[variable][+].valueExpression.name = "ObsBodyHeightValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBodyHeightLatest.value.where(exists(system='http://unitsofmeasure.org' and code='cm')).value" 
* extension[variable][+].valueExpression.name = "ObsBodyHeightDateString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBodyHeightLatest.effective.toString().substring(0,10)"  
* extension[variable][+].valueExpression.name = "ObsBodyHeightDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBodyHeightDateString.substring(8,2).toInteger().toString() + ' ' + %ObsBodyHeightDateString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsBodyHeightDateString.substring(0,4)"

* extension[variable][+].valueExpression.name = "ObsBodyWeightValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBodyWeightLatest.value.where(exists(system='http://unitsofmeasure.org' and code='kg')).value"
* extension[variable][+].valueExpression.name = "ObsBodyWeightDateString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBodyWeightLatest.effective.toString().substring(0,10)"
* extension[variable][+].valueExpression.name = "ObsBodyWeightDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBodyWeightDateString.substring(8,2).toInteger().toString() + ' ' + %ObsBodyWeightDateString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsBodyWeightDateString.substring(0,4)"

* extension[variable][+].valueExpression.name = "ObsWaistCircumferenceValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsWaistCircumferenceLatest.value.where(exists(system='http://unitsofmeasure.org' and code='cm')).value"
* extension[variable][+].valueExpression.name = "ObsWaistCircumferenceDateString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsWaistCircumferenceLatest.effective.toString().substring(0,10)"
* extension[variable][+].valueExpression.name = "ObsWaistCircumferenceDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsWaistCircumferenceDateString.substring(8,2).toInteger().toString() + ' ' + %ObsWaistCircumferenceDateString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsWaistCircumferenceDateString.substring(0,4)"

* extension[variable][+].valueExpression.name = "ObsPulseRateValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsPulseRateLatest.value.where(exists(system='http://unitsofmeasure.org' and code='/min')).value"
* extension[variable][+].valueExpression.name = "ObsPulseRateDateString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsPulseRateLatest.effective.toString().substring(0,10)"
* extension[variable][+].valueExpression.name = "ObsPulseRateDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsPulseRateDateString.substring(8,2).toInteger().toString() + ' ' + %ObsPulseRateDateString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsPulseRateDateString.substring(0,4)"

* extension[variable][+].valueExpression.name = "ObsPulseRhythmValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsPulseRhythmLatest.value.coding.where(system='http://snomed.info/sct').first()"
* extension[variable][+].valueExpression.name = "ObsPulseRhythmDateString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsPulseRhythmLatest.effective.toString().substring(0,10)"
* extension[variable][+].valueExpression.name = "ObsPulseRhythmDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsPulseRhythmDateString.substring(8,2).toInteger().toString() + ' ' + %ObsPulseRhythmDateString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsPulseRhythmDateString.substring(0,4)"

* extension[variable][+].valueExpression.name = "ObsOxygenSaturationValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsOxygenSaturationLatest.value.where(exists(system='http://unitsofmeasure.org' and code='%')).value"
* extension[variable][+].valueExpression.name = "ObsOxygenSaturationString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsOxygenSaturationLatest.effective.toString().substring(0,10)"
* extension[variable][+].valueExpression.name = "ObsOxygenSaturationDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsOxygenSaturationString.substring(8,2).toInteger().toString() + ' ' + %ObsOxygenSaturationString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsOxygenSaturationString.substring(0,4)"

* extension[variable][+].valueExpression.name = "ObsSmokingStatusValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsSmokingStatusLatest.value.coding.where(system='http://snomed.info/sct').first()"
* extension[variable][+].valueExpression.name = "ObsSmokingStatusDateString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsSmokingStatusLatest.effective.toString().substring(0,10)"
* extension[variable][+].valueExpression.name = "ObsSmokingStatusDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsSmokingStatusDateString.substring(8,2).toInteger().toString() + ' ' + %ObsSmokingStatusDateString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsSmokingStatusDateString.substring(0,4)"

* extension[variable][+].valueExpression.name = "ObsAlcoholStatusValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsAlcoholStatusLatest.value.coding.where(system='http://snomed.info/sct').first()"
* extension[variable][+].valueExpression.name = "ObsAlcoholStatusDateString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsAlcoholStatusLatest.effective.toString().substring(0,10)"
* extension[variable][+].valueExpression.name = "ObsAlcoholStatusDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsAlcoholStatusDateString.substring(8,2).toInteger().toString() + ' ' + %ObsAlcoholStatusDateString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsAlcoholStatusDateString.substring(0,4)"

* extension[variable][+].valueExpression.name = "ObsBloodPressureValue"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBloodPressureLatest.component.where(code.coding.exists(code='8480-6')).value.value.round(0).toString() + ' / ' + %ObsBloodPressureLatest.component.where(code.coding.exists(code='8462-4')).value.value.round(0).toString()"
* extension[variable][+].valueExpression.name = "ObsBloodPressureDateString"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBloodPressureLatest.effective.toString().substring(0,10)"
* extension[variable][+].valueExpression.name = "ObsBloodPressureDateFormatted"
* extension[variable][=].valueExpression.language = #text/fhirpath
* extension[variable][=].valueExpression.expression = "%ObsBloodPressureDateString.substring(8,2).toInteger().toString() + ' ' + %ObsBloodPressureDateString.substring(5,2).replace('01','Jan').replace('02','Feb').replace('03','Mar').replace('04','Apr').replace('05','May').replace('06','Jun').replace('07','Jul').replace('08','Aug').replace('09','Sep').replace('10','Oct').replace('11','Nov').replace('12','Dec') + ' ' + %ObsBloodPressureDateString.substring(0,4)"

//R5 preadoption extensions
* extension[artifact-versionAlgorithm].valueCoding = http://hl7.org/fhir/version-algorithm#semver

//Questionnaire metadata
* meta.profile[+] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-render"
* meta.profile[+] = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-pop-exp"
* url = "http://www.health.gov.au/assessments/GPChronicConditionManagementPlan"
* name = "GPChronicConditionManagementPlan"
* title = "GP Chronic Condition Management Plan"
* status = #draft
* experimental = false
* subjectType[+] = #Patient
* date = "2026-02-13"
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
* item[=].item[=].item[=].text = "This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record. Changes to patient demographic information should be made in the source system."
* item[=].item[=].item[=].text.extension[rendering-xhtml].valueString = "<div xmlns=\"http://www.w3.org/1999/xhtml\">
    <p><em>This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record. Changes to patient demographic information should be made in the source system.</em></p></div>"
* item[=].item[=].item[=].type = #display
* item[=].item[=].item[+].linkId = "patient-consent"
* item[=].item[=].item[=].text = "Consent"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "patient-consent-consentforplan"
* item[=].item[=].item[=].item[=].text = "Consent given to proceed with plan after discussion of the purpose, benefits, process and costs"
* item[=].item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].item[=].repeats = false
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
* item[=].item[=].item[=].item[=].answerValueSet = "#YesNoPending"
* item[=].item[=].item[=].item[+].linkId = "patient-myagedcare-number"
* item[=].item[=].item[=].item[=].text = "My Aged Care Number"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-myagedcare-registered"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "patient-myagedcare-comment"
* item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].type = #string
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
* item[=].item[=].item[=].item[=].answerValueSet = "#YesNoPending"
* item[=].item[=].item[=].item[+].linkId = "patient-ndis-number"
* item[=].item[=].item[=].item[=].text = "NDIS Number"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-ndis-registered"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "patient-ndis-comment"
* item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].type = #string
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
* item[=].item[=].item[=].item[=].answerValueSet = "#YesNo"
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
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].item[=].extension[questionnaire-choiceOrientation].valueCode = #horizontal
* item[=].item[=].item[=].item[=].linkId = "patient-carerinformation-present"
* item[=].item[=].item[=].item[=].text = "Carer present at appointment"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-carerinformation-hascarer"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "#YesNo"
        // Additional contacts
* item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "AdditionalContactsArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.contact.where(relationship.coding.exists(code = 'C' or code = '394619001' or code = '1620171000168100' or code = 'CP' or code = 'N'))"
* item[=].item[=].item[=].linkId = "patient-additionalcontacts"
* item[=].item[=].item[=].text = "Additional contacts"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%AdditionalContactsArray.relationship.coding"
* item[=].item[=].item[=].item[=].linkId = "patient-additionalcontacts-type"
* item[=].item[=].item[=].item[=].text = "Type"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://snomed.info/sct#394619001
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://snomed.info/sct#1620171000168100
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://terminology.hl7.org/CodeSystem/v2-0131#C
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://terminology.hl7.org/CodeSystem/v2-0131#CP
* item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://terminology.hl7.org/CodeSystem/v2-0131#N
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%AdditionalContactsArray.name.select((given.join(' ') | family).join(' ') | text)"
* item[=].item[=].item[=].item[=].linkId = "patient-additionalcontacts-name"
* item[=].item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%AdditionalContactsArray.telecom.where(system = 'phone').value"
* item[=].item[=].item[=].item[=].linkId = "patient-additionalcontacts-phone"
* item[=].item[=].item[=].item[=].text = "Phone"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%AdditionalContactsArray.telecom.where(system = 'email').value"
* item[=].item[=].item[=].item[=].linkId = "patient-additionalcontacts-email"
* item[=].item[=].item[=].item[=].text = "Email"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
// this is a user entered field and is not equivalent to the relationship coding in the FHIR resource
* item[=].item[=].item[=].item[+].linkId = "patient-additionalcontacts-relationship"
* item[=].item[=].item[=].item[=].text = "Relationship to patient"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
        //Additional information
* item[=].item[=].item[+].linkId = "patient-additionalinformation"
* item[=].item[=].item[=].text = "Additional information"
* item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].repeats = false


//Practitioner details
* item[=].item[+].linkId = "practitioner"
* item[=].item[=].text = "Practitioner details"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
* item[=].item[=].item[+].linkId = "practitioner-instructions"
* item[=].item[=].item[=].text = "This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record. Changes to practitioner information should be made in the source system."
* item[=].item[=].item[=].text.extension[rendering-xhtml].valueString = "<div xmlns=\"http://www.w3.org/1999/xhtml\">
    <p><em>This form has been prefilled with information that was available from the patient's health record. Upon saving, the form will be stored, but additional information entered will not be used to update the patient's health record. Changes to practitioner information should be made in the source system.</em></p></div>"
* item[=].item[=].item[=].type = #display
* item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "(%user.name.where(use='official').select((given.join(' ') | family).join(' ') | text) | %user.name.select((given.join(' ') | family).join(' ') | text)).first()"
* item[=].item[=].item[=].linkId = "practitioner-name"
* item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "%PractitionerRole.entry.resource.telecom.where(system = 'phone').value"
* item[=].item[=].item[=].linkId = "practitioner-phone"
* item[=].item[=].item[=].text = "Phone"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "%PractitionerRole.entry.resource.telecom.where(system = 'email').value"
* item[=].item[=].item[=].linkId = "practitioner-email"
* item[=].item[=].item[=].text = "Email"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "%PractitionerRole.entry.resource.identifier.where(system = 'http://ns.electronichealth.net.au/id/medicare-provider-number').value"
* item[=].item[=].item[=].linkId = "practitioner-medicareprovidernumber"
* item[=].item[=].item[=].text = "Medicare provider number"
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
* item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses"
* item[=].item[=].item[=].text = "Problems/Diagnoses"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
        //Recorded Problems/Diagnoses
* item[=].item[=].item[=].item[+].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "ConditionArray"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%Condition.entry.resource.where(verificationStatus.coding.all(code.empty() or code='confirmed'))"
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-recordedproblems"
* item[=].item[=].item[=].item[=].text = "Recorded problems/diagnoses"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-width].valueQuantity = 30 '%'
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-recordedproblems-condition"
* item[=].item[=].item[=].item[=].item[=].text = "Condition"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.clinicalStatus.coding"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-recordedproblems-clinicalstatus"
* item[=].item[=].item[=].item[=].item[=].text = "Clinical status"
* item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "http://hl7.org/fhir/ValueSet/condition-clinical|4.0.1"
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].readOnly = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.onset.ofType(dateTime).toDate()"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-recordedproblems-onsetdate"
* item[=].item[=].item[=].item[=].item[=].text = "Onset date"
* item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.abatement.ofType(dateTime).toDate()"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-recordedproblems-abatementdate"
* item[=].item[=].item[=].item[=].item[=].text = "Abatement date"
* item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].readOnly = false
        //New Problems/Diagnoses
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-newproblems"
* item[=].item[=].item[=].item[=].text = "New problems/diagnoses"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-width].valueQuantity = 35 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-newproblems-condition"
* item[=].item[=].item[=].item[=].item[=].text = "Condition"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 25 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-newproblems-onsetdate"
* item[=].item[=].item[=].item[=].item[=].text = "Onset date"
* item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 40 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-problemsdiagnoses-newproblems-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false

    //Adverse reaction risk
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].linkId = "clinicaldetails-allergies"
* item[=].item[=].item[=].text = "Adverse reaction risks"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
        //Recorded adverse reactions
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext][+].valueExpression[+].name = "AllergyIntoleranceArray"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].expression = "%AllergyIntolerance.entry.resource.where(clinicalStatus.coding.exists(code='active')).where(verificationStatus.coding.all(code.empty() or code='confirmed'))"
* item[=].item[=].item[=].item[=].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergies-recordedallergies"
* item[=].item[=].item[=].item[=].text = "Recorded adverse reaction risks"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergies-recordedallergies-substance"
* item[=].item[=].item[=].item[=].item[=].text = "Substance"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/adverse-reaction-agent-1"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.clinicalStatus.coding"
* item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl][+].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergies-recordedallergies-status"
* item[=].item[=].item[=].item[=].item[=].text = "Status"
* item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "http://hl7.org/fhir/ValueSet/allergyintolerance-clinical|4.0.1"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.reaction.manifestation.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].item[=].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergies-recordedallergies-manifestation"
* item[=].item[=].item[=].item[=].item[=].text = "Manifestation"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-finding-1"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
//possible to support repeating comments. Needs nested itemPopulationContext which may not yet be supported. Needs investigation.
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.note[0].text"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergies-recordedallergies-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].item[=].repeats = false
        //new adverse reactions
* item[=].item[=].item[=].item[+].linkId = "clinicaldetails-allergies-newallergies"
* item[=].item[=].item[=].item[=].text = "New adverse reaction risks"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergies-newallergies-substance"
* item[=].item[=].item[=].item[=].item[=].text = "Substance"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/adverse-reaction-agent-1"
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-allergies-newallergies-manifestation"
* item[=].item[=].item[=].item[=].item[=].text = "Manifestation"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-finding-1"
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-allergies-newallergies-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].item[=].repeats = false

    // Medications
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open    
* item[=].item[=].item[=].linkId = "clinicaldetails-medications"
* item[=].item[=].item[=].text = "Medications (current)"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
        //Recorded medications
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext][+].valueExpression[+].name = "MedicationStatementArray"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].expression = "%MedicationStatement.entry.resource.ofType(MedicationStatement)"
* item[=].item[=].item[=].item[=].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-recordedmedications"
* item[=].item[=].item[=].item[=].text = "Recorded medications"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
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
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "iif(%MedicationStatementArray.medication.reference.replace('#', '') in %medicationsFromContained.id, %medicationsFromContained.where(id = %MedicationStatementArray.medication.reference.replace('#', '')).code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first()), iif(%MedicationStatementArray.medication.reference.replace('Medication/', '') in %medicationsFromRef.id , %medicationsFromRef.where(id = %MedicationStatementArray.medication.reference.replace('Medication/', '')).code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first()), %MedicationStatementArray.medication.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())))"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-recordedmedications-medication"
* item[=].item[=].item[=].item[=].item[=].text = "Medication"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-medication-1"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.status"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-recordedmedications-status"
* item[=].item[=].item[=].item[=].item[=].text = "Status"
* item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "#MedicationStatementStatusLimited"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.dosage.text"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-recordedmedications-dosage"
* item[=].item[=].item[=].item[=].item[=].text = "Dosage"
* item[=].item[=].item[=].item[=].item[=].type = #text
//do we need to support repeats for dosage?
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].readOnly = false
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.reasonCode.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-recordedmedications-indication"
* item[=].item[=].item[=].item[=].item[=].text = "Indication"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/medication-reason-taken-1"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.note.text"
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-recordedmedications-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #text
//do we need to support repeats for comments?
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].readOnly = false
        //New medications
* item[=].item[=].item[=].item[+].linkId = "clinicaldetails-medications-newmedications"
* item[=].item[=].item[=].item[=].text = "New medications"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-newmedications-medication"
* item[=].item[=].item[=].item[=].item[=].text = "Medication"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-medication-1"
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-medications-newmedications-dosage"
* item[=].item[=].item[=].item[=].item[=].text = "Dosage"
* item[=].item[=].item[=].item[=].item[=].type = #text
//do we need to support repeats for dosage?
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-medications-newmedications-indication"
* item[=].item[=].item[=].item[=].item[=].text = "Indication"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/medication-reason-taken-1"
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-medications-newmedications-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #text
//do we need to support repeats for comments?
* item[=].item[=].item[=].item[=].item[=].repeats = false

// Observations
    // Main table
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].linkId = "clinicaldetails-observations"
* item[=].item[=].item[=].text = "Observations"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-instructions"  
* item[=].item[=].item[=].item[=].text = "The tabled observations will display the most recent results available from the patient record. New observations may be added."
* item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/rendering-xhtml].valueString = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p style=\"font-size:0.9em; font-weight:normal\"><em>The tabled observations will display the most recent results available from the patient record. New observations may be added.</em></p></div>"    
* item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#grid
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid"  
* item[=].item[=].item[=].item[=].text = "Observations"
* item[=].item[=].item[=].item[=].text.extension[+].url = Canonical(QuestionnaireItemTextHidden)
* item[=].item[=].item[=].item[=].text.extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = false

        //Height
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-height"
* item[=].item[=].item[=].item[=].item[=].text = "Height"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-height-lastresult"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last result"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsBodyHeightValue.exists() and %ObsBodyHeightDateFormatted.exists(), %ObsBodyHeightValue.round(0).toString() + ' cm ( ' + %ObsBodyHeightDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden height items to support BMI calculation and recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBodyHeightValue.round(0)"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#cm
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-height-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBodyHeightLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-height-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New height result
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-unit].valueCoding = $UCUM#cm
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-height-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-height-newresultvalue-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "cm"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-maingrid-height-newresultvalue').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-height-newresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

        //Weight
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-weight"
* item[=].item[=].item[=].item[=].item[=].text = "Weight"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //last weight result
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-weight-lastresult"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last result"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsBodyWeightValue.exists() and %ObsBodyWeightDateFormatted.exists(), %ObsBodyWeightValue.round(1).toString() + ' kg ( ' + %ObsBodyWeightDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden weight items to support BMI calculation and recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBodyWeightValue.round(1)"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#kg
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-weight-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBodyWeightLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-weight-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New weight result
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-unit].valueCoding = $UCUM#kg
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-weight-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-weight-newresultvalue-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "kg"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-maingrid-weight-newresultvalue').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-weight-newresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

        //BMI
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-bmi"
* item[=].item[=].item[=].item[=].item[=].text = "BMI (calculated)"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //Last BMI result
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-bmi-lastresult"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last result"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsBodyWeightValue.exists() and %ObsBodyHeightValue.exists() and %ObsBodyHeightValue > 0, (%ObsBodyWeightValue/((%ObsBodyHeightValue/100).power(2))).round(1).toString() + ' kg/m2', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden BMI item to support recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "iif(%ObsBodyWeightValue.exists() and %ObsBodyHeightValue.exists() and %ObsBodyHeightValue > 0, (%ObsBodyWeightValue/((%ObsBodyHeightValue/100).power(2))).round(1), {})"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#kg/m2
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-bmi-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New BMI result
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.description = "BMI calculation"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%weight.exists() and %height.exists() and %height > 0, (%weight/((%height/100).power(2))).round(1), {})"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#kg/m2
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-bmi-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-bmi-newresult-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "kg/m2"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display

        //Waist circumference"
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-waistcircumference"
* item[=].item[=].item[=].item[=].item[=].text = "Waist circumference"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //Last waist circumference result
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-waistcircumference-lastresult"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last result"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsWaistCircumferenceValue.exists() and %ObsWaistCircumferenceDateFormatted.exists(), %ObsWaistCircumferenceValue.round(0).toString() + ' cm ( ' + %ObsWaistCircumferenceDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden waist circumference items to support recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsWaistCircumferenceValue.round(0)"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#cm
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-waistcircumference-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsWaistCircumferenceLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-waistcircumference-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New waist circumference result
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-unit].valueCoding = $UCUM#cm
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-waistcircumference-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-waistcircumference-newresultvalue-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "cm"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-maingrid-waistcircumference-newresultvalue').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-waistcircumference-newdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

        //Pulse rate
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-pulserate"
* item[=].item[=].item[=].item[=].item[=].text = "Pulse rate"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //Last pulse rate result
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-pulserate-lastresult"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last result"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsPulseRateValue.exists() and %ObsPulseRateDateFormatted.exists(), %ObsPulseRateValue.round(0).toString() + ' /min ( ' + %ObsPulseRateDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden pulse rate items to support recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsPulseRateValue.round(0)"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#/min
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserate-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsPulseRateLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserate-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New pulse rate result
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-unit].valueCoding = $UCUM#/min
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserate-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserate-newresultvalue-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "/min"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-maingrid-pulserate-newresultvalue').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserate-newresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

        //Pulse rhythm
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-pulserhythm"
* item[=].item[=].item[=].item[=].item[=].text = "Pulse rhythm"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //Last pulse rhythm result
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-pulserhythm-lastresult"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last result"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsPulseRhythmValue.exists() and %ObsPulseRhythmDateFormatted.exists(), %ObsPulseRhythmValue.display + ' ( ' + %ObsPulseRhythmDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden pulse rhythm items to support recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsPulseRhythmValue"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserhythm-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "#pulse-rhythm-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsPulseRhythmLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserhythm-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New pulse rhythm result
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserhythm-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "#pulse-rhythm-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-maingrid-pulserhythm-newresultvalue').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-pulserhythm-newresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

        //Oxygen saturation"
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-oxygensaturation"
* item[=].item[=].item[=].item[=].item[=].text = "Oxygen saturation"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //Last oxygen saturation result
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-lastresult"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last result"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsOxygenSaturationValue.exists() and %ObsOxygenSaturationDateFormatted.exists(), %ObsOxygenSaturationValue.round(0).toString() + ' % ( ' + %ObsOxygenSaturationDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden oxygen saturation items to support recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsOxygenSaturationValue.round(0)"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#%
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsOxygenSaturationLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New oxygen saturation result
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-unit].valueCoding = $UCUM#%
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-newresultvalue-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "%"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-maingrid-oxygensaturation-newresultvalue').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-maingrid-oxygensaturation-newresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New result date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

    // Blood pressure table
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#grid
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid"
* item[=].item[=].item[=].item[=].text = "Blood pressure"
* item[=].item[=].item[=].item[=].text.extension[+].url = Canonical(QuestionnaireItemTextHidden)
* item[=].item[=].item[=].item[=].text.extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].type = #group 
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-bpgrid-bp"
* item[=].item[=].item[=].item[=].item[=].text = "Blood pressure"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
        //Last blood pressure result
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-bpgrid-bp-lastresult"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last result"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsBloodPressureValue.exists() and %ObsBloodPressureDateFormatted.exists(), %ObsBloodPressureValue + ' mm Hg ( ' + %ObsBloodPressureDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden blood pressure items to support recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBloodPressureLatest.component.where(code.coding.exists(code='8480-6')).value.value.round(0)"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#mm[Hg]
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bp-lastresultvaluesystolic"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBloodPressureLatest.component.where(code.coding.exists(code='8462-4')).value.value.round(0)"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-unit].valueCoding = $UCUM#mm[Hg]
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bp-lastresultvaluediastolic"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #decimal
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsBloodPressureLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bp-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
        //New blood pressure result
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-unit].valueCoding = $UCUM#mm[Hg]
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bp-newresultsystolic"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Systolic"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bp-newresultsystolic-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "mm Hg"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-unit].valueCoding = $UCUM#mm[Hg]
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bp-newresultdiastolic"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Diastolic"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = http://hl7.org/fhir/questionnaire-item-control#unit
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bp-newresultdiastolic-unit"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "mm Hg"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-bpgrid-bp-newresultsystolic').answer.value.exists() or %resource.repeat(item).where(linkId='clinicaldetails-observations-bpgrid-bp-newresultdiastolic').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-bpgrid-bp-newresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date performed"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

    //Substance use table
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#grid
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid"
* item[=].item[=].item[=].item[=].text = "Substance use"
* item[=].item[=].item[=].item[=].text.extension[+].url = Canonical(QuestionnaireItemTextHidden)
* item[=].item[=].item[=].item[=].text.extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].type = #group 
* item[=].item[=].item[=].item[=].repeats = false
        //Smoking status
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceusegrid-smokingstatus"
* item[=].item[=].item[=].item[=].item[=].text = "Smoking status"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //Last smoking status
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceusegrid-smokingstatus-laststatus"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last status"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsSmokingStatusValue.exists() and %ObsSmokingStatusDateFormatted.exists(), %ObsSmokingStatusValue.display + ' ( ' + %ObsSmokingStatusDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden smoking status items to support recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsSmokingStatusValue"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid-smokingstatus-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/smoking-status-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsSmokingStatusLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid-smokingstatus-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New smoking status
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid-smokingstatus-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New status"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/smoking-status-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-substanceusegrid-smokingstatus-newresultvalue').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid-smokingstatus-newresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New status date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-smokingstatusgrid-smokingstatus-newresultcomment"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
        //Alcohol consumption status
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceusegrid-alcoholstatus"
* item[=].item[=].item[=].item[=].item[=].text = "Alcohol consumption status"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //Last alcohol consumption status
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceusegrid-alcoholstatus-laststatus"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last status"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsAlcoholStatusValue.exists() and %ObsAlcoholStatusDateFormatted.exists(), %ObsAlcoholStatusValue.display + ' ( ' + %ObsAlcoholStatusDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //Hidden alcohol consumption items to support recording in QuestionnaireResponse
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsAlcoholStatusValue"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid-alcoholstatus-lastresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/alcohol-intake-status-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsAlcoholStatusLatest.effective.toString().substring(0,10).toDate()"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[questionnaire-hidden].valueBoolean = true
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid-alcoholstatus-lastresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
            //New alcohol status
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultvalue"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New status"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/alcohol-intake-status-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultvalue').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New status date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceusegrid-alcoholstatus-newresultcomment"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
        // Additional information
* item[=].item[=].item[+].linkId = "clinicaldetails-observations-additionalinformation"
* item[=].item[=].item[=].text = "Additional information"
* item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].repeats = false

/*
    //Smoking status table
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#grid
* item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-smokingstatusgrid"
* item[=].item[=].item[=].item[=].text = "Smoking status"
* item[=].item[=].item[=].item[=].type = #group 
* item[=].item[=].item[=].item[=].repeats = false
        //Last recorded smoking status
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-smokingstatusgrid-laststatus"
* item[=].item[=].item[=].item[=].item[=].text = "Last recorded status"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-smokingstatusgrid-laststatus-status"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Status"
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsSmokingStatusValue.exists() and %ObsSmokingStatusDateFormatted.exists(), %ObsSmokingStatusValue.display + ' ( ' + %ObsSmokingStatusDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #display
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-smokingstatusgrid-laststatus-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ObsSmokingStatusLatest.note[0].text"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-smokingstatusgrid-laststatus-comment"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].readOnly = true
        //New smoking status
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-smokingstatusgrid-newstatus"
* item[=].item[=].item[=].item[=].item[=].text = "New status"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-smokingstatusgrid-newstatus-status"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Status"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/smoking-status-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-smokingstatusgrid-newstatus-status').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-smokingstatusgrid-newstatus-date"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-smokingstatusgrid-newstatus-comment"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
*/
/*
    //Substance use
* item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceuse"
* item[=].item[=].item[=].item[=].text = "Substance use"
* item[=].item[=].item[=].item[=].type = #group 
* item[=].item[=].item[=].item[=].repeats = false
        //Smoking status
* item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceuse-smokingstatus"
* item[=].item[=].item[=].item[=].item[=].text = "Smoking status"
* item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].repeats = false
            //Last smoking status
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceuse-smokingstatus-laststatus"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "Last recorded status"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceuse-smokingstatus-laststatus-status"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text = "Status"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].text.extension[http://hl7.org/fhir/StructureDefinition/cqf-expression].valueExpression.expression = "iif(%ObsSmokingStatusValue.exists() and %ObsSmokingStatusDateFormatted.exists(), %ObsSmokingStatusValue.display + ' ( ' + %ObsSmokingStatusDateFormatted + ' )', 'Not available')"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/rendering-style].valueString = "text-align: left;"
* item[=].item[=].item[=].item[=].item[=].item[=].item[=].type = #display
            //New smoking status
* item[=].item[=].item[=].item[=].item[=].item[+].linkId = "clinicaldetails-observations-substanceuse-smokingstatus-newstatus"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New status"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/smoking-status-1"
* item[=].item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-calculatedExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-calculatedExpression].valueExpression.expression = "iif(%resource.repeat(item).where(linkId='clinicaldetails-observations-substanceuse-smokingstatus-newstatus').answer.value.exists(), today())"
* item[=].item[=].item[=].item[=].item[=].item[=].linkId = "clinicaldetails-observations-substanceuse-smokingstatus-newdate"
* item[=].item[=].item[=].item[=].item[=].item[=].text = "New status date"
* item[=].item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].item[=].repeats = false

*/


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
* item[=].item[=].item[=].text = "Conditions addressed"
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
* item[=].item[=].item[=].item[=].text = "Problems/Needs"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[+].linkId = "plan-goalstasks-details-goalsetting"
* item[=].item[=].item[=].item[=].text = "Goal setting"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].linkId = "plan-goalstasks-details-goalsetting-goals"
* item[=].item[=].item[=].item[=].item[=].text = "Goals"
* item[=].item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "plan-goalstasks-details-goalsetting-initiator"
* item[=].item[=].item[=].item[=].item[=].text = "Initiator"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "plan-goalstasks-details-goalsetting-targetdate"
* item[=].item[=].item[=].item[=].item[=].text = "Target date"
* item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "plan-goalstasks-details-goalsetting-status"
* item[=].item[=].item[=].item[=].item[=].text = "Status"
* item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "#GoalStatusLimited"
* item[=].item[=].item[=].item[=].item[+].linkId = "plan-goalstasks-details-goalsetting-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
/*
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting"
* item[=].item[=].item[=].item[=].text = "Goal setting"
* item[=].item[=].item[=].item[=].text.extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/QuestionnaireItemTextHidden"
* item[=].item[=].item[=].item[=].text.extension[=].valueBoolean = true
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 30 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting-goals"
* item[=].item[=].item[=].item[=].item[=].text = "Goals"
* item[=].item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 20 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting-initiator"
* item[=].item[=].item[=].item[=].item[=].text = "Initiator"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 15 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting-targetdate"
* item[=].item[=].item[=].item[=].item[=].text = "Target date"
* item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 15 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting-status"
* item[=].item[=].item[=].item[=].item[=].text = "Status"
* item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "#GoalStatusLimited"
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-width].valueQuantity = 20 '%'
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-goalstasks-details-goalsetting-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
*/
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
* item[=].item[=].item[=].item[+].linkId = "completion-consentforsharing"
* item[=].item[=].item[=].item[=].text = "Consent given for sharing of information with relevant healthcare providers"
* item[=].item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "completion-review"
* item[=].item[=].item[=].item[=].text = "Review"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].item[=].item[=].linkId = "completion-review-appointmentstatus"
* item[=].item[=].item[=].item[=].item[=].text = "Appointment status"
* item[=].item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://hl7.org/fhir/appointmentstatus#booked "Booked"
* item[=].item[=].item[=].item[=].item[=].answerOption[+].valueCoding = http://hl7.org/fhir/appointmentstatus#proposed "Proposed"
* item[=].item[=].item[=].item[=].item[+].linkId = "completion-review-date"
* item[=].item[=].item[=].item[=].item[=].text = "Date"
* item[=].item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "completion-review-comment"
* item[=].item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].item[=].linkId = "completion-copyoffered"
* item[=].item[=].item[=].item[=].text = "Patient has been offered a copy of this plan"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerOption[+].valueString = "Yes, copy provided"
* item[=].item[=].item[=].item[=].answerOption[+].valueString = "Yes, copy to be provided at a later date"
* item[=].item[=].item[=].item[=].answerOption[+].valueString = "Yes, but declined"
* item[=].item[=].item[=].item[+].linkId = "completion-comment"
* item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
