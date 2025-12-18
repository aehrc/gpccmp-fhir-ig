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
* extension[sdc-questionnaire-launchContext][=].extension[description].valueString = "The patient that is to be used to pre-populate the form"
* extension[sdc-questionnaire-launchContext][+].extension[name].valueCoding = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext#user
* extension[sdc-questionnaire-launchContext][=].extension[type].valueCode = #Practitioner
* extension[sdc-questionnaire-launchContext][=].extension[description].valueString = "The practitioner user that is to be used to pre-populate the form"
* extension[sdc-questionnaire-launchContext][+].extension[name].valueCoding = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext#encounter
* extension[sdc-questionnaire-launchContext][=].extension[type].valueCode = #Encounter
* extension[sdc-questionnaire-launchContext][=].extension[description].valueString = "The encounter that is to be used to pre-populate the form"

//fhir query variables
* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "GPCCMPLatest"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #application/x-fhir-query
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "QuestionnaireResponse?questionnaire=http://www.health.gov.au/assessments/GPChronicConditionManagementPlan&_count=1&_sort=-authored&patient={{%patient.id}}"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "GPCCMPLatestCompleted"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #application/x-fhir-query
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "QuestionnaireResponse?questionnaire=http://www.health.gov.au/assessments/GPChronicConditionManagementPlan&status=completed&_count=1&_sort=-authored&patient={{%patient.id}}"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "PractitionerRole"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #application/x-fhir-query
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "PractitionerRole?practitioner={{%user.id}}"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "Condition"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #application/x-fhir-query
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "Condition?patient={{%patient.id}}&category=http://terminology.hl7.org/CodeSystem/condition-category|problem-list-item"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "AllergyIntolerance"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #application/x-fhir-query
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "AllergyIntolerance?patient={{%patient.id}}"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "MedicationStatement"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #application/x-fhir-query
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "MedicationStatement?patient={{%patient.id}}&status=active&_include=MedicationStatement:medication"


* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "ObsBloodPressure"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #application/x-fhir-query
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "Observation?code=85354-9&_sort=-date&patient={{%patient.id}}"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "ObsTobaccoSmokingStatus"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #application/x-fhir-query
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "Observation?code=1747861000168109&_sort=-date&patient={{%patient.id}}"


//fhirpath variables
* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "age"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #text/fhirpath
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "repeat(item).where(linkId='patient-age').answer.value"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "medicationsFromContained"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #text/fhirpath
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "%MedicationStatement.entry.resource.contained.ofType(Medication).where(id in %MedicationStatement.entry.resource.medication.select(reference.replace('#', '')))"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "medicationsFromRef"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #text/fhirpath
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "%MedicationStatement.entry.resource.ofType(Medication).where(id in %MedicationStatement.entry.resource.medication.select(reference.replace('Medication/', '')))"

    //client side filtering on Observations
* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "ObsBloodPressureLatest"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #text/fhirpath
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "%ObsBloodPressure.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

* extension[http://hl7.org/fhir/StructureDefinition/variable][+].valueExpression.name = "ObsTobaccoSmokingStatusLatest"
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.language = #text/fhirpath
* extension[http://hl7.org/fhir/StructureDefinition/variable][=].valueExpression.expression = "%ObsTobaccoSmokingStatus.entry.resource.where(status = 'final' or status = 'amended' or status = 'corrected').first()"

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
* item[+].linkId = "container"
* item[=].type = #group
* item[=].repeats = false

//Patient details
* item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-closed
* item[=].item[=].linkId = "patient"
* item[=].item[=].text = "Patient details"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "(%patient.name.where(use='official').select((given.join(' ') | family).join(' ') | text) | %patient.name.select((given.join(' ') | family).join(' ') | text)).first()"
* item[=].item[=].item[=].linkId = "patient-name"
* item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "(%patient.name.where(use='usual').select((given.join(' ') | family).join(' ') | text)).first()"
* item[=].item[=].item[=].linkId = "patient-preferredname"
* item[=].item[=].item[=].text = "Preferred name"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(exists(url='http://hl7.org/fhir/StructureDefinition/individual-pronouns') and extension.where(url='period').value.end.empty()).extension.where(url='value').value.coding"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].linkId = "patient-preferredpronouns"
* item[=].item[=].item[=].text = "Preferred pronouns"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-pronouns-1"
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.birthDate"
* item[=].item[=].item[=].linkId = "patient-dob"
* item[=].item[=].item[=].text = "Date of birth"
* item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "iif(today().toString().select(substring(5,2) & substring(8,2)).toInteger() > %patient.birthDate.toString().select(substring(5,2) & substring(8,2)).toInteger(), today().toString().substring(0,4).toInteger() - %patient.birthDate.toString().substring(0,4).toInteger(), today().toString().substring(0,4).toInteger() - %patient.birthDate.toString().substring(0,4).toInteger() - 1)"
* item[=].item[=].item[=].linkId = "patient-age"
* item[=].item[=].item[=].text = "Age"
* item[=].item[=].item[=].type = #integer
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(exists(url='http://hl7.org/fhir/StructureDefinition/individual-recordedSexOrGender' and extension.where(exists(url='type' and value.coding.code='1515311000168102')) and extension.where(url='effectivePeriod').value.end.empty())).extension.where(url='value').value.coding"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].linkId = "patient-sexatbirth"
* item[=].item[=].item[=].text = "Sex assigned at birth"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/biological-sex-1"
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(exists(url='http://hl7.org/fhir/StructureDefinition/individual-genderIdentity') and extension.where(url='period').value.end.empty()).extension.where(url='value').value.coding"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].linkId = "patient-genderidentity"
* item[=].item[=].item[=].text = "Gender identity"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/gender-identity-response-1"
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(url='http://hl7.org.au/fhir/StructureDefinition/indigenous-status').value"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].linkId = "patient-firstnationsstatus"
* item[=].item[=].item[=].text = "Aboriginal and/or Torres Strait Islander status"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-indigenous-status-1"
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.extension.where(url='http://hl7.org.au/fhir/StructureDefinition/closing-the-gap-registration').value"
* item[=].item[=].item[=].linkId = "patient-ctg"
* item[=].item[=].item[=].text = "Registered for Closing the Gap PBS Co-payment Measure (CTG)"
* item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-enableWhenExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-enableWhenExpression].valueExpression.expression = "%age >= 50"
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].extension[questionnaire-choiceOrientation].valueCode = #horizontal
* item[=].item[=].item[=].linkId = "patient-myagedcare"
* item[=].item[=].item[=].text = "Registered for My Aged Care"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].answerValueSet = "#YesNoNA"
* item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].extension[questionnaire-choiceOrientation].valueCode = #horizontal
* item[=].item[=].item[=].linkId = "patient-ndis"
* item[=].item[=].item[=].text = "Registered for NDIS"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].answerValueSet = "#YesNoNA"
* item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "MedicareNumberArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.identifier.where(type.coding.exists(system='http://terminology.hl7.org/CodeSystem/v2-0203' and code='MC'))"
* item[=].item[=].item[=].linkId = "patient-medicare"
* item[=].item[=].item[=].text = "Medicare number"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%MedicareNumberArray.value.substring(0,10)"
* item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/regex].valueString = "matches('^[0-9]{10}$')"
* item[=].item[=].item[=].item[=].linkId = "patient-medicare-number"
* item[=].item[=].item[=].item[=].text = "Number"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%MedicareNumberArray.value.substring(10,1)"
* item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/regex].valueString = "matches('^[0-9]{1}$')"
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
* item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "PrivateHealthInsuranceArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.identifier.where(type.coding.exists(system='http://terminology.hl7.org/CodeSystem/v2-0203' and code='MB'))"
* item[=].item[=].item[=].linkId = "patient-healthinsurance"
* item[=].item[=].item[=].text = "Private health insurance"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PrivateHealthInsuranceArray.assigner.display"
* item[=].item[=].item[=].item[=].linkId = "patient-healthinsurance-provider"
* item[=].item[=].item[=].item[=].text = "Provider"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PrivateHealthInsuranceArray.value"
* item[=].item[=].item[=].item[=].linkId = "patient-healthinsurance-membernumber"
* item[=].item[=].item[=].item[=].text = "Member number"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
    // Contact information
* item[=].item[=].item[+].linkId = "patient-contact"
* item[=].item[=].item[=].text = "Contact information"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.telecom.where(all(system = 'email' and (use.empty() or use = 'home'))).value"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-email"
* item[=].item[=].item[=].item[=].text = "Email"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "HomeAddressArray"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.address.where(all(use='home' and (type.empty() or type!='postal')))"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-homeaddress"
* item[=].item[=].item[=].item[=].text = "Home address"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = false
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
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/regex].valueString = "matches('^[0-9]{4}$')"
* item[=].item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/entryFormat].valueString = "####"
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
* item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/regex].valueString = "matches('^[0-9]{4}$')"
* item[=].item[=].item[=].item[=].item[=].extension[http://hl7.org/fhir/StructureDefinition/entryFormat].valueString = "####"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-postaladdress-postcode"
* item[=].item[=].item[=].item[=].item[=].text = "Postcode"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false   
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.telecom.where(system = 'phone' and use = 'home').value"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-homephone"
* item[=].item[=].item[=].item[=].text = "Home phone"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%patient.telecom.where(system = 'phone' and use = 'mobile').value"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-mobilephone"
* item[=].item[=].item[=].item[=].text = "Mobile phone"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "EmergencyContactArray"
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%patient.contact.where(relationship.coding.exists(code = 'C'))"
* item[=].item[=].item[=].item[=].linkId = "patient-contact-emergencycontact"
* item[=].item[=].item[=].item[=].text = "Emergency contact"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%EmergencyContactArray.name.select((given.join(' ') | family).join(' ') | text)"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-emergencycontact-name"
* item[=].item[=].item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%EmergencyContactArray.telecom.value"
* item[=].item[=].item[=].item[=].item[=].linkId = "patient-contact-emergencycontact-phone"
* item[=].item[=].item[=].item[=].item[=].text = "Phone"
* item[=].item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].item[=].repeats = true
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
* item[=].item[=].item[=].item[+].linkId = "patient-carerinformation-details"
* item[=].item[=].item[=].item[=].text = "Details"
* item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].enableWhen[+].question = "patient-carerinformation-hascarer"
* item[=].item[=].item[=].item[=].enableWhen[=].operator = #=
* item[=].item[=].item[=].item[=].enableWhen[=].answerCoding = http://terminology.hl7.org/CodeSystem/v2-0136#Y
* item[=].item[=].item[=].item[=].repeats = false

//Practitioner details
* item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-closed
* item[=].item[=].linkId = "practitioner"
* item[=].item[=].text = "Practitioner details"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "(%user.name.where(use='official').select((given.join(' ') | family).join(' ') | text) | %user.name.select((given.join(' ') | family).join(' ') | text)).first()"
* item[=].item[=].item[=].linkId = "practitioner-name"
* item[=].item[=].item[=].text = "Name"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PractitionerRole.telecom.where(system = 'phone').value"
* item[=].item[=].item[=].linkId = "practitioner-phone"
* item[=].item[=].item[=].text = "Phone"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PractitionerRole.telecom.where(system = 'email').value"
* item[=].item[=].item[=].linkId = "practitioner-email"
* item[=].item[=].item[=].text = "Email"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%PractitionerRole.entry.resource.identifier.where(system = 'http://ns.electronichealth.net.au/id/medicare-provider-number').value"
* item[=].item[=].item[=].linkId = "practitioner-providernumber"
* item[=].item[=].item[=].text = "Provider number"
* item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].repeats = true

//Clinical history
* item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-closed
* item[=].item[=].linkId = "clinicalhistory"
* item[=].item[=].text = "Clinical history summary"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
    //Problems/Diagnoses
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.name = "ConditionArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext].valueExpression.expression = "%Condition.entry.resource.where(verificationStatus.coding.all(code.empty() or code='confirmed'))"
* item[=].item[=].item[=].linkId = "clinicalhistory-problemsdiagnoses"
* item[=].item[=].item[=].text = "Problems/Diagnoses"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-width].valueQuantity = 40 '%'
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-problemsdiagnoses-condition"
* item[=].item[=].item[=].item[=].text = "Condition"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#drop-down
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.clinicalStatus.coding"
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-problemsdiagnoses-clinicalstatus"
* item[=].item[=].item[=].item[=].text = "Clinical status"
* item[=].item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].item[=].answerValueSet = "http://hl7.org/fhir/ValueSet/condition-clinical|4.0.1"
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.onset.ofType(dateTime).toDate()"
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-problemsdiagnoses-onsetdate"
* item[=].item[=].item[=].item[=].text = "Onset date"
* item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%ConditionArray.abatement.ofType(dateTime).toDate()"
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-problemsdiagnoses-abatementdate"
* item[=].item[=].item[=].item[=].text = "Abatement date"
* item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].repeats = false
    //Adverse reaction risk summary
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][+].valueExpression[+].name = "AllergyIntoleranceArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].expression = "%AllergyIntolerance.entry.resource.where(clinicalStatus.coding.exists(code='active')).where(verificationStatus.coding.all(code.empty() or code='confirmed'))"
* item[=].item[=].item[=].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].linkId = "clinicalhistory-allergy"
* item[=].item[=].item[=].text = "Adverse reaction risk summary"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.code.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-allergy-substance"
* item[=].item[=].item[=].item[=].text = "Substance"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/adverse-reaction-agent-1"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.reaction.manifestation.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-allergy-manifestation"
* item[=].item[=].item[=].item[=].text = "Manifestation"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-finding-1"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
//possible to support repeating comments. Needs nested itemPopulationContext which may not yet be supported. Needs investigation.
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%AllergyIntoleranceArray.note[0].text"
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-allergy-comment"
* item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].repeats = false
    // Current medications
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][+].valueExpression[+].name = "MedicationStatementArray"
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-itemPopulationContext][=].valueExpression[=].expression = "%MedicationStatement.entry.resource.ofType(MedicationStatement)"
* item[=].item[=].item[=].extension[+].url = "https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton"
* item[=].item[=].item[=].extension[=].valueBoolean = true
* item[=].item[=].item[=].linkId = "clinicalhistory-medications"
* item[=].item[=].item[=].text = "Current medications"
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
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-medications-medication"
* item[=].item[=].item[=].item[=].text = "Medication"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/australian-medication-1"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.dosage.text"
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-medications-dosage"
* item[=].item[=].item[=].item[=].text = "Dosage"
* item[=].item[=].item[=].item[=].type = #text
//do we need to support repeats for dosage?
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.reasonCode.select((coding.where(system='http://snomed.info/sct') | coding.where(system!='http://snomed.info/sct').first() | text ).first())"
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-medications-clinicalindication"
* item[=].item[=].item[=].item[=].text = "Clinical indication"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/medication-reason-taken-1"
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression][+].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression][=].valueExpression.expression = "%MedicationStatementArray.note.text"
* item[=].item[=].item[=].item[=].linkId = "clinicalhistory-medications-comment"
* item[=].item[=].item[=].item[=].text = "Comment"
* item[=].item[=].item[=].item[=].type = #text
//do we need to support repeats for comments?
* item[=].item[=].item[=].item[=].repeats = false

//Management plan details
* item[=].item[+].linkId = "plandetails"
* item[=].item[=].text = "Management plan details"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "today()"
* item[=].item[=].item[=].linkId = "plandetails-commenceddate"
* item[=].item[=].item[=].text = "Date this management plan commenced"
* item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%GPCCMPLatest.entry.resource.where(status='in-progress').exists()"
* item[=].item[=].item[=].linkId = "plandetails-inprogress"
* item[=].item[=].item[=].text = "Management plan already in progress?"
* item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].readOnly = true
* item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "%GPCCMPLatestCompleted.entry.resource.authored"
* item[=].item[=].item[=].linkId = "plandetails-lastcompleteddate"
* item[=].item[=].item[=].text = "Date of last completed management plan"
* item[=].item[=].item[=].type = #dateTime
* item[=].item[=].item[=].repeats = false
    //GP notes
* item[=].item[=].item[+].linkId = "gpnotes"
* item[=].item[=].item[=].text = "GP notes"
* item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].repeats = true

//Management plan
* item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].linkId = "plan"
* item[=].item[=].text = "Management plan"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
    //Chronic condition
* item[=].item[=].item[+].linkId = "plan-chronicconditiondetails"
* item[=].item[=].item[=].text = "Chronic condition details"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].linkId = "plan-chronicconditiondetails-condition"
* item[=].item[=].item[=].item[=].text = "Condition"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[+].linkId = "plan-chronicconditiondetails-onsetdate"
* item[=].item[=].item[=].item[=].text = "Onset date"
* item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].repeats = false
    // Plan item
* item[=].item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].item[=].linkId = "plan-planitems"
* item[=].item[=].item[=].text = "Plan items"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].linkId = "plan-planitems-problemneed"
* item[=].item[=].item[=].item[=].text = "Problem or need"
* item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/clinical-condition-1"
* item[=].item[=].item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].item[=].linkId = "plan-planitems-goalsactions"
* item[=].item[=].item[=].item[=].text = "Goals and actions"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].linkId = "plan-planitems-goalsactions-goals"
* item[=].item[=].item[=].item[=].item[=].text = "Health and lifestyle goals"
* item[=].item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[+].linkId = "plan-planitems-goalsactions-actions"
* item[=].item[=].item[=].item[=].item[=].text = "Patient actions"
* item[=].item[=].item[=].item[=].item[=].type = #text
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
* item[=].item[=].item[=].item[=].extension[=].valueCodeableConcept = $questionnaire-item-control#gtable
* item[=].item[=].item[=].item[=].linkId = "plan-planitems-treatmentsservices"
* item[=].item[=].item[=].item[=].text = "Treatments and services"
* item[=].item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].item[=].repeats = true
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-planitems-treatmentsservices-servicetype"
* item[=].item[=].item[=].item[=].item[=].text = "Service type"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/service-type-1"
* item[=].item[=].item[=].item[=].item[+].extension[questionnaire-itemControl][+].valueCodeableConcept = $questionnaire-item-control#autocomplete
* item[=].item[=].item[=].item[=].item[=].linkId = "plan-planitems-treatmentsservices-practitionerrole"
* item[=].item[=].item[=].item[=].item[=].text = "Practitioner role"
* item[=].item[=].item[=].item[=].item[=].type = #open-choice
* item[=].item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[=].item[=].answerValueSet = "https://healthterminologies.gov.au/fhir/ValueSet/practitioner-role-1"

//Final preparations of management plan
* item[=].item[+].extension[sdc-questionnaire-collapsible].valueCode = #default-open
* item[=].item[=].linkId = "finalpreparations"
* item[=].item[=].text = "Final preparations of management plan"
* item[=].item[=].type = #group
* item[=].item[=].repeats = false
* item[=].item[=].item[+].linkId = "finalpreparations-consent"
* item[=].item[=].item[=].text = "Consent"
* item[=].item[=].item[=].type = #group
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "finalpreparations-consent-sharingconsent"
* item[=].item[=].item[=].item[=].text = "Consent given for sharing of information with relevant healthcare providers"
* item[=].item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].linkId = "finalpreparations-consent-planconsent"
* item[=].item[=].item[=].item[=].text = "Consent given to proceed with plan after discussion of the purpose, benefits, process and costs"
* item[=].item[=].item[=].item[=].type = #boolean
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "(%user.name.where(use='official').select((given.join(' ') | family).join(' ') | text) | %user.name.select((given.join(' ') | family).join(' ') | text)).first()"
* item[=].item[=].item[=].item[=].linkId = "finalpreparations-consent-practitioner"
* item[=].item[=].item[=].item[=].text = "Practitioner who recorded consent"
* item[=].item[=].item[=].item[=].type = #string
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].item[+].extension[sdc-questionnaire-initialExpression].valueExpression.language = #text/fhirpath
* item[=].item[=].item[=].item[=].extension[sdc-questionnaire-initialExpression].valueExpression.expression = "today()"
* item[=].item[=].item[=].item[=].linkId = "finalpreparations-consent-date"
* item[=].item[=].item[=].item[=].text = "Date consent was recorded"
* item[=].item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].linkId = "finalpreparations-review"
* item[=].item[=].item[=].text = "Scheduled review date"
* item[=].item[=].item[=].type = #date
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[+].extension[questionnaire-itemControl].valueCodeableConcept = $questionnaire-item-control#radio-button
* item[=].item[=].item[=].linkId = "finalpreparations-copyoffered"
* item[=].item[=].item[=].text = "Patient has been offered a copy of this plan"
* item[=].item[=].item[=].type = #choice
* item[=].item[=].item[=].repeats = false
* item[=].item[=].item[=].answerOption[+].valueString = "Yes, copy provided"
* item[=].item[=].item[=].answerOption[+].valueString = "Yes, copy to be posted"
* item[=].item[=].item[=].answerOption[+].valueString = "Yes, but declined"
* item[=].item[=].item[=].answerOption[+].valueString = "Not offered. Plan to follow up and offer at a later date"
