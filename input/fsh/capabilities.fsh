Instance: GPCCMPServerCapabilityStatement
InstanceOf: CapabilityStatement
Usage: #definition
* name = "GPCCMPServerCapabilityStatement"
* title = "GP CCMP Server Capability Statement"
* description = "This CapabilityStatement describes the expected capabilities for systems to exchange the data needed to support the [GP Chronic Condition Management Plan](Questionnaire-GPChronicConditionManagementPlan.html). It lists the server's conformance expectations for the resource types required as Questionnaire launch context, resource types required to support prepopulation of the form and QuestionnaireResponse requirements for managing form responses. These expectations include supported FHIR profiles, RESTful operations, and search parameters."
* status = #draft
* experimental = false
* date = "2026-02-13"
* publisher = "AEHRC CSIRO"
* jurisdiction = urn:iso:std:iso:3166#AU
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #json
* format[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* format[=].extension[0].valueCode = #SHALL

* rest.mode = #server
* rest.documentation = "GPCCMP Launch Server **SHALL**:
1. Support the [GP CCMP AllergyIntolerance resource profile](StructureDefinition-GPCCMPAllergyIntolerance.html)
1. Support the [GP CCMP Condition resource profile](StructureDefinition-GPCCMPCondition.html)
1. Support the [GP CCMP Encounter resource profile](StructureDefinition-GPCCMPEncounter.html)
1. Support the [GP CCMP Location resource profile](StructureDefinition-GPCCMPLocation.html)
1. Support the [GP CCMP Medication profile](StructureDefinition-GPCCMPMedication.html)
1. Support the [GP CCMP MedicationStatement profile](StructureDefinition-GPCCMPMedicationStatement.html)
1. Support the [GP CCMP Observation resource profiles](profiles-and-extensions.html#observation)
1. Support the [GP CCMP Patient resource profile](StructureDefinition-GPCCMPPatient.html)
1. Support the [GP CCMP Practitioner resource profile](StructureDefinition-GPCCMPPractitioner.html)
1. Support the [GP CCMP PractitionerRole resource profile](StructureDefinition-GPCCMPPractitionerRole.html)
1. Support the [GP CCMP Questionnaire Response resource profile](StructureDefinition-GPCCMPQuestionnaireResponse.html)
1. Implement the RESTful behavior according to the FHIR specification
1. Support JSON source formats for all interactions"

* rest.security.cors = true
* rest.security.cors.extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.security.cors.extension[0].valueCode = #MAY
* rest.security.service = http://terminology.hl7.org/CodeSystem/restful-security-service#SMART-on-FHIR
* rest.security.service.extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.security.service.extension[0].valueCode = #MAY
* rest.security.description = "GPCCMP Launch Server **MAY**:
1. Support CORS headers
1. Support SMART on FHIR security services

Also see the [AU Core Security and Privacy](https://hl7.org.au/fhir/core/2.0.0-preview/security.html) section for general considerations and recommendations."

//AllergyIntolerance
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].type = #AllergyIntolerance
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPAllergyIntolerance)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the AllergyIntolerance resource, the GP CCMP profile and the conformance expectations for the AllergyIntolerance resource."
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #SHALL

//Condition
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "category"
* rest.resource[=].type = #Condition
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPCondition)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the Condition resource, the GP CCMP profile and the conformance expectations for the Condition resource."
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Condition-category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a code value and **MAY** provide both the system and code values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

//Encounter
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #MAY
* rest.resource[=].type = #Encounter
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPEncounter)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **MAY** support the Encounter resource. If it does, it **SHALL** support the GP CCMP profile and the conformance expectations for the Encounter resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//Location
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].type = #Location
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPLocation)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the Location resource, the GP CCMP profile and the conformance expectations for the Location resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//Medication
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #MAY
* rest.resource[=].type = #Medication
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPMedication)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "If an external reference to a Medication resource is used in MedicationStatement, then the server **SHALL** support the Medication resource, the GP CCMP profile and the conformance expectations for the Medication resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//MedicationStatement
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "status"
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #MAY
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "status"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_include"
* rest.resource[=].type = #MedicationStatement
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPMedicationStatement)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the MedicationStatement resource, the GP CCMP profile and the conformance expectations for the MedicationStatement resource.

If a medication in a MedicationStatement resource is represented as an external Medication resource reference, the server **SHALL** support the `_include` parameter for searching this element (`MedicationStatement:medication`)
"
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].searchInclude[+] = "MedicationStatement:medication"
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a code value and **MAY** provide both the system and code values.

The server **SHALL** support both.

The client **SHALL** support `multipleOr`.

The server **SHALL** support `multipleOr`."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_include"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "If a medication in a MedicationStatement resource is represented as an external Medication resource reference, the server **SHALL** support the `_include` parameter for searching this element (`MedicationStatement:medication`).

The client **SHALL** support this method."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

//Observation
* rest.resource[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "code"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_sort"
* rest.resource[=].type = #Observation
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPBodyHeight)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPBodyWeight)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPWaistCircumference)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPulseRate)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPulseRhythm)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPOxygenSaturation)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPBloodPressure)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPSmokingStatus)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPAlcoholUseStatus)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the Observation resource, the Smart Health Checks profiles listed and the conformance expectations for the Observation resource."
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both. "
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a code value and **MAY** provide both the code and system values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_sort"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].documentation = "The client and server **SHALL** support search result sorting by date and **MAY** support other values."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

//Patient
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].type = #Patient
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPatient)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the Patient resource, GP CCMP profile and the conformance expectations for the Patient resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//Practitioner
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].type = #Practitioner
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPractitioner)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the Practitioner resource, GP CCMP profile and the conformance expectations for the Practitioner resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//PractitionerRole
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_id"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_include"
* rest.resource[=].type = #PractitionerRole
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPractitionerRole)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the PractitionerRole resource, GP CCMP profile and the conformance expectations for the PractitionerRole resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "_id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_include"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "`_include` parameter for searching location (`PractitionerRole:location`)."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

//QuestionnaireResponse
* rest.resource[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_count"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_sort"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "questionnaire"
* rest.resource[=].type = #QuestionnaireResponse
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPQuestionnaireResponse)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The server **SHALL** support the QuestionnaireResponse resource, SDC profile and the conformance expectations for the QuestionnaireResponse resource. The server **SHALL** support versioned updates to QuestionnaireResponse resources."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].versioning = #versioned
* rest.resource[=].versioning.extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].versioning.extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "questionnaire"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-questionnaire"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both.

The client and server **SHALL** support chained search questionnaire.title using the :contains modifier."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_count"
* rest.resource[=].searchParam[=].type = #number
* rest.resource[=].searchParam[=].documentation = "The client and server **SHALL** support search result limiting."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_sort"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].documentation = "The client and server **SHALL** support search result sorting by authored and **MAY** support other values."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

* rest.interaction[+].code = #transaction
* rest.interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.interaction[=].extension[0].valueCode = #SHALL
* rest.interaction[=].documentation = "The server **SHALL** support the transaction interaction for all resources."

Instance: GPCCMPClientCapabilityStatement
InstanceOf: CapabilityStatement
Usage: #definition
* name = "GPCCMPClientCapabilityStatement"
* title = "GP CCMP Client Capability Statement"
* description = "This CapabilityStatement describes the expected capabilities for systems to exchange the data needed to support the [GP Chronic Condition Management Plan](Questionnaire-GPChronicConditionManagementPlan.html). It lists the client's conformance expectations for the resource types required as Questionnaire launch context, resource types required to support prepopulation of the form and QuestionnaireResponse requirements for managing form responses. These expectations include supported FHIR profiles, RESTful operations, and search parameters."
* status = #draft
* experimental = false
* date = "2026-02-13"
* publisher = "AEHRC CSIRO"
* jurisdiction = urn:iso:std:iso:3166#AU
* kind = #requirements
* fhirVersion = #4.0.1
* format[+] = #json
* format[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* format[=].extension[0].valueCode = #SHALL

* rest.mode = #server
* rest.documentation = "GPCCMP Launch Server **SHALL**:
1. Support the [GP CCMP AllergyIntolerance resource profile](StructureDefinition-GPCCMPAllergyIntolerance.html)
1. Support the [GP CCMP Condition resource profile](StructureDefinition-GPCCMPCondition.html)
1. Support the [GP CCMP Encounter resource profile](StructureDefinition-GPCCMPEncounter.html)
1. Support the [GP CCMP Medication profile](StructureDefinition-GPCCMPMedication.html)
1. Support the [GP CCMP MedicationStatement profile](StructureDefinition-GPCCMPMedicationStatement.html)
1. Support the [GP CCMP Patient resource profile](StructureDefinition-GPCCMPPatient.html)
1. Support the [GP CCMP Practitioner resource profile](StructureDefinition-GPCCMPPractitioner.html)
1. Support the [GP CCMP PractitionerRole resource profile](StructureDefinition-GPCCMPPractitionerRole.html)
1. Support the [GP CCMP QuestionnaireResponse resource profile](StructureDefinition-GPCCMPQuestionnaireResponse.html)
1. Implement the RESTful behavior according to the FHIR specification
1. Support JSON source formats for all interactions"

* rest.security.cors = true
* rest.security.cors.extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.security.cors.extension[0].valueCode = #MAY
* rest.security.service = http://terminology.hl7.org/CodeSystem/restful-security-service#SMART-on-FHIR
* rest.security.service.extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.security.service.extension[0].valueCode = #MAY
* rest.security.description = "GPCCMP Launch Server **MAY**:
1. Support CORS headers
1. Support SMART on FHIR security services

Also see the [AU Core Security and Privacy](https://hl7.org.au/fhir/core/2.0.0-preview/security.html) section for general considerations and recommendations."

//AllergyIntolerance
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].type = #AllergyIntolerance
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPAllergyIntolerance)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the AllergyIntolerance resource, the GP CCMP profile and the conformance expectations for the AllergyIntolerance resource."
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #SHALL

//Condition
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "category"
* rest.resource[=].type = #Condition
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPCondition)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the Condition resource, the GP CCMP profile and the conformance expectations for the Condition resource."
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Condition-category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a code value and **MAY** provide both the system and code values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

//Encounter
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #MAY
* rest.resource[=].type = #Encounter
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPEncounter)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **MAY** support the Encounter resource. If it does, it **SHALL** support the GP CCMP profile and the conformance expectations for the Encounter resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//Location
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].type = #Location
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPLocation)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the Location resource, the GP CCMP profile and the conformance expectations for the Location resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//Medication
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #MAY
* rest.resource[=].type = #Medication
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPMedication)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "If an external reference to a Medication resource is used in MedicationStatement, then the client **SHALL** support the Medication resource, the GP CCMP profile and the conformance expectations for the Medication resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//MedicationStatement
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "status"
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #MAY
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "status"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_include"
* rest.resource[=].type = #MedicationStatement
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPMedicationStatement)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the MedicationStatement resource, the GP CCMP profile and the conformance expectations for the MedicationStatement resource.

If a medication in a MedicationStatement resource is represented as an external Medication resource reference, the client **SHALL** support the `_include` parameter for searching this element (`MedicationStatement:medication`)
"
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].searchInclude[+] = "MedicationStatement:medication"
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a code value and **MAY** provide both the system and code values.

The server **SHALL** support both.

The client **SHALL** support `multipleOr`.

The server **SHALL** support `multipleOr`."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_include"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "If a medication in a MedicationStatement resource is represented as an external Medication resource reference, the server **SHALL** support the `_include` parameter for searching this element (`MedicationStatement:medication`).

The client **SHALL** support this method."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

//Observation
* rest.resource[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "code"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_sort"
* rest.resource[=].type = #Observation
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPBodyHeight)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPBodyWeight)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPWaistCircumference)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPulseRate)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPulseRhythm)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPOxygenSaturation)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPBloodPressure)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPSmokingStatus)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPAlcoholUseStatus)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the Observation resource, the Smart Health Checks profiles listed and the conformance expectations for the Observation resource."
* rest.resource[=].interaction[0].code = #search-type
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both. "
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a code value and **MAY** provide both the code and system values. 

The server **SHALL** support both."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_sort"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].documentation = "The client and server **SHALL** support search result sorting by date and **MAY** support other values."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

//Patient
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].type = #Patient
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPatient)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the Patient resource, GP CCMP profile and the conformance expectations for the Patient resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//Practitioner
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].type = #Practitioner
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPractitioner)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the Practitioner resource, GP CCMP profile and the conformance expectations for the Practitioner resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL

//PractitionerRole
* rest.resource[+].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[0].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_id"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_include"
* rest.resource[=].type = #PractitionerRole
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPPractitionerRole)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the PractitionerRole resource, GP CCMP profile and the conformance expectations for the PractitionerRole resource."
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[0].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[0].extension[0].valueCode = #SHALL
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "_id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_include"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "`_include` parameter for searching location (`PractitionerRole:location`)."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

//QuestionnaireResponse
* rest.resource[+].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination"
* rest.resource[=].extension[=].extension[+].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].extension[=].extension[=].valueCode = #SHALL
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "patient"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_count"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "_sort"
* rest.resource[=].extension[=].extension[+].url = "required"
* rest.resource[=].extension[=].extension[=].valueString = "questionnaire"
* rest.resource[=].type = #QuestionnaireResponse
* rest.resource[=].supportedProfile[+] = Canonical(GPCCMPQuestionnaireResponse)
* rest.resource[=].supportedProfile[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].supportedProfile[=].extension[0].valueCode = #SHALL
* rest.resource[=].documentation = "The client **SHALL** support the QuestionnaireResponse resource, SDC profile and the conformance expectations for the QuestionnaireResponse resource. The client **SHALL** support versioned updates to QuestionnaireResponse resources."
* rest.resource[=].interaction[+].code = #read
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].interaction[=].extension[0].valueCode = #SHALL
* rest.resource[=].versioning = #versioned
* rest.resource[=].versioning.extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].versioning.extension[0].valueCode = #SHALL
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both. "
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "questionnaire"
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-questionnaire"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].documentation = "The client **SHALL** provide at least a id value and **MAY** provide both the Type and id values. 

The server **SHALL** support both.

The client and server **SHALL** support chained search questionnaire.title using the :contains modifier."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_count"
* rest.resource[=].searchParam[=].type = #number
* rest.resource[=].searchParam[=].documentation = "The client and server **SHALL** support search result limiting."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY
* rest.resource[=].searchParam[+].name = "_sort"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].documentation = "The client and server **SHALL** support search result sorting by authored and **MAY** support other values."
* rest.resource[=].searchParam[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.resource[=].searchParam[=].extension[0].valueCode = #MAY

* rest.interaction[+].code = #transaction
* rest.interaction[=].extension[0].url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest.interaction[=].extension[0].valueCode = #SHALL
* rest.interaction[=].documentation = "The server **SHALL** support the transaction interaction for all resources."
