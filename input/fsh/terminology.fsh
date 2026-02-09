Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org

Alias: $v2-0532 = http://terminology.hl7.org/CodeSystem/v2-0532|2.0.0

CodeSystem: LaunchContextExtended
Id: LaunchContextExtended
Title: "Launch Context Extension"
Description: "The Launch Context Extension code system defines concepts that extend the HL7 launch context concepts in http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext. They enable additional launch context items to be specified for use when launching a GP CCMP Questionnaire."

* ^experimental = false
* ^caseSensitive = true
* #gpccmppractitionerrole "GP CCMP Practitioner Role" "PractitionerRole in context at launch time that is associated with the user in context. This concept has been defined to support use cases where the PractitionerRole is required to pre-populate the GP CCMP Questionnaire."

ValueSet: YesNoNA
Id: YesNoNA
Title: "Yes/No/NA"
Description: "Concepts for Yes, No and Not applicable"
* ^experimental = false
* $v2-0532#Y "Yes"
* $v2-0532#N "No"
* $v2-0532#NA "not applicable"
* ^expansion.identifier = "urn:uuid:b0d3ebde-96ab-4f8f-bb5e-063a45acdcff"
* ^expansion.timestamp = "2025-12-11T11:44:01+10:00"
* ^expansion.total = 3
* ^expansion.offset = 0
* ^expansion.parameter[0].name = "displayLanguage"
* ^expansion.parameter[=].valueCode = #en
* ^expansion.parameter[+].name = "count"
* ^expansion.parameter[=].valueInteger = 1000
* ^expansion.parameter[+].name = "offset"
* ^expansion.parameter[=].valueInteger = 0
* ^expansion.parameter[+].name = "excludeNested"
* ^expansion.parameter[=].valueBoolean = false
* ^expansion.parameter[+].name = "used-codesystem"
* ^expansion.parameter[=].valueUri = "http://terminology.hl7.org/CodeSystem/v2-0532|2.0.0"
* ^expansion.contains[0].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #Y
* ^expansion.contains[=].display = "Yes"
* ^expansion.contains[+].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #N
* ^expansion.contains[=].display = "No"
* ^expansion.contains[+].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #NA
* ^expansion.contains[=].display = "not applicable"
/*
ValueSet: YesNo
Id: YesNo
Title: "Yes/No"
Description: "Concepts for Yes and No"
* ^experimental = false
* $v2-0532#Y "Yes"
* $v2-0532#N "No"
* ^expansion.identifier = "urn:uuid:474362d7-3506-484a-b015-6f1e4d31434a"
* ^expansion.timestamp = "2025-12-11T11:44:00+10:00"
* ^expansion.total = 2
* ^expansion.offset = 0
* ^expansion.parameter[0].name = "displayLanguage"
* ^expansion.parameter[=].valueCode = #en
* ^expansion.parameter[+].name = "count"
* ^expansion.parameter[=].valueInteger = 1000
* ^expansion.parameter[+].name = "offset"
* ^expansion.parameter[=].valueInteger = 0
* ^expansion.parameter[+].name = "excludeNested"
* ^expansion.parameter[=].valueBoolean = false
* ^expansion.parameter[+].name = "used-codesystem"
* ^expansion.parameter[=].valueUri = "http://terminology.hl7.org/CodeSystem/v2-0532|2.0.0"
* ^expansion.contains[0].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #Y
* ^expansion.contains[=].display = "Yes"
* ^expansion.contains[+].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #N
* ^expansion.contains[=].display = "No"
*/

ValueSet: MedicationStatementStatusLimited
Id: MedicationStatementStatusLimited
Title: "Medication Statement Status Limited"
Description: "This value set includes the minimal set of codes to represent the status of a medication statement (i.e., active, completed, stopped and on-hold)."
* ^experimental = false
* ^expansion.identifier = "urn:uuid:59fe5ac1-65bf-4606-8c2a-0a55fba1d064"
* ^expansion.timestamp = "2025-08-25T15:53:32+10:00"
* ^expansion.total = 4
* ^expansion.offset = 0
* ^expansion.parameter[0].name = "count"
* ^expansion.parameter[=].valueInteger = 1000
* ^expansion.parameter[+].name = "offset"
* ^expansion.parameter[=].valueInteger = 0
* ^expansion.parameter[+].name = "excludeNested"
* ^expansion.parameter[=].valueBoolean = false
* ^expansion.parameter[+].name = "used-codesystem"
* ^expansion.parameter[=].valueUri = "http://hl7.org/fhir/CodeSystem/medication-statement-status|4.0.1"
* ^expansion.contains[0].system = "http://hl7.org/fhir/CodeSystem/medication-statement-status"
* ^expansion.contains[=].code = #active
* ^expansion.contains[=].display = "Active"
* ^expansion.contains[+].system = "http://hl7.org/fhir/CodeSystem/medication-statement-status"
* ^expansion.contains[=].code = #completed
* ^expansion.contains[=].display = "Completed"
* ^expansion.contains[+].system = "http://hl7.org/fhir/CodeSystem/medication-statement-status"
* ^expansion.contains[=].code = #stopped
* ^expansion.contains[=].display = "Stopped"
* ^expansion.contains[+].system = "http://hl7.org/fhir/CodeSystem/medication-statement-status"
* ^expansion.contains[=].code = #on-hold
* ^expansion.contains[=].display = "On Hold"
* http://hl7.org/fhir/CodeSystem/medication-statement-status#active
* http://hl7.org/fhir/CodeSystem/medication-statement-status#completed
* http://hl7.org/fhir/CodeSystem/medication-statement-status#stopped
* http://hl7.org/fhir/CodeSystem/medication-statement-status#on-hold


ValueSet: PulseRhythm
Id: pulse-rhythm-1
Title: "Pulse Rhythm"
Description: "The Pulse Rhythm value set includes values that may be used to represent the pulse rhythm of an individual."

* ^experimental = false
* ^expansion.identifier = "urn:uuid:a544a2bc-fc6b-45e8-bbaa-4472eedaba72"
* ^expansion.timestamp = "2026-02-09T11:26:29+10:00"
* ^expansion.total = 4
* ^expansion.offset = 0
* ^expansion.parameter[0].name = "displayLanguage"
* ^expansion.parameter[=].valueCode = #en
* ^expansion.parameter[+].name = "count"
* ^expansion.parameter[=].valueInteger = 1000
* ^expansion.parameter[+].name = "offset"
* ^expansion.parameter[=].valueInteger = 0
* ^expansion.parameter[+].name = "excludeNested"
* ^expansion.parameter[=].valueBoolean = false
* ^expansion.parameter[+].name = "system-version"
* ^expansion.parameter[=].valueUri = "http://snomed.info/sct|http://snomed.info/sct/32506021000036107"
* ^expansion.parameter[+].name = "used-codesystem"
* ^expansion.parameter[=].valueUri = "http://snomed.info/sct|http://snomed.info/sct/32506021000036107/version/20260131"
* ^expansion.parameter[+].name = "version"
* ^expansion.parameter[=].valueUri = "http://snomed.info/sct|http://snomed.info/sct/32506021000036107/version/20260131"
* ^expansion.contains[0].system = "http://snomed.info/sct"
* ^expansion.contains[=].code = #271636001
* ^expansion.contains[=].display = "Pulse regular"
* ^expansion.contains[+].system = "http://snomed.info/sct"
* ^expansion.contains[=].code = #61086009
* ^expansion.contains[=].display = "Pulse irregular"
* ^expansion.contains[+].system = "http://snomed.info/sct"
* ^expansion.contains[=].code = #271637005
* ^expansion.contains[=].display = "Pulse irregularly irregular"
* ^expansion.contains[+].system = "http://snomed.info/sct"
* ^expansion.contains[=].code = #271638000
* ^expansion.contains[=].display = "Pulse regularly irregular"
* $SCT#271636001 "Pulse regular"
* $SCT#61086009 "Pulse irregular"
* $SCT#271637005 "Pulse irregularly irregular"
* $SCT#271638000 "Pulse regularly irregular"

