Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org

Alias: $v2-0532 = http://terminology.hl7.org/CodeSystem/v2-0532|3.0.0
Alias: $goal-status = http://hl7.org/fhir/goal-status|4.0.1
Alias: $medication-statement-status = http://hl7.org/fhir/CodeSystem/medication-statement-status|4.0.1

CodeSystem: LaunchContextExtended
Id: LaunchContextExtended
Title: "Launch Context Extension"
Description: "The Launch Context Extension code system defines concepts that extend the HL7 launch context concepts in http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext. They enable additional launch context items to be specified for use when launching a GP CCMP Questionnaire."

* ^experimental = false
* ^caseSensitive = true
* #gpccmppractitionerrole "GP CCMP Practitioner Role" "PractitionerRole in context at launch time that is associated with the user in context. This concept has been defined to support use cases where the PractitionerRole is required to pre-populate the GP CCMP Questionnaire."

CodeSystem: GPCCMPExpandedYesNoIndicatorSupplement
Id: GPCCMPExpandedYesNoIndicatorSupplement
Title: "GP CCMP Expanded Yes No Indicator Supplement"
Description: "The GP CCMP Expanded Yes No Indicator Supplement defines consumer friendly terms for the HL7 expandedYes-NoIndicator code system for use in the GP CCMP Questionnaire."
* ^experimental = false
* ^content = #supplement
* ^supplements = $v2-0532
* #NAV "Pending"
* #NA "N/A"
/*
ValueSet: YesNoNA
Id: YesNoNA
Title: "Yes/No/NA"
Description: "Concepts for Yes, No and Not applicable"
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/valueset-supplement"
* ^extension[=].valueCanonical = Canonical(GPCCMPExpandedYesNoIndicatorSupplement|0.1.0)
* ^experimental = false
* $v2-0532#Y "Yes"
* $v2-0532#N "No"
* $v2-0532#NA "N/A"
* ^expansion.identifier = "urn:uuid:99ee7588-62b6-4bfe-b071-07d85efffeab"
* ^expansion.timestamp = "2026-02-17T10:59:10+10:00"
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
* ^expansion.parameter[=].valueUri = "http://terminology.hl7.org/CodeSystem/v2-0532|3.0.0"
* ^expansion.parameter[+].name = "used-supplement"
* ^expansion.parameter[=].valueUri = "https://gpccmp.csiro.au/ig/CodeSystem/GPCCMPExpandedYesNoIndicatorSupplement|0.1.0"
* ^expansion.contains[0].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #Y
* ^expansion.contains[=].display = "Yes"
* ^expansion.contains[+].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #N
* ^expansion.contains[=].display = "No"
* ^expansion.contains[+].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #NA
* ^expansion.contains[=].display = "N/A"
*/
ValueSet: YesNo
Id: YesNo
Title: "Yes/No"
Description: "Concepts for Yes and No"
* ^experimental = false
* $v2-0532#Y "Yes"
* $v2-0532#N "No"
* ^expansion.identifier = "urn:uuid:65f54ac5-483f-4d55-a6eb-43c1588ba934"
* ^expansion.timestamp = "2026-02-17T11:03:51+10:00"
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
* ^expansion.parameter[=].valueUri = "http://terminology.hl7.org/CodeSystem/v2-0532|3.0.0"
* ^expansion.contains[0].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #Y
* ^expansion.contains[=].display = "Yes"
* ^expansion.contains[+].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #N
* ^expansion.contains[=].display = "No"

ValueSet: YesNoPending
Id: YesNoPending
Title: "Yes/No/Pending"
Description: "Concepts for Yes, No and Pending"
* ^extension[+].url = "http://hl7.org/fhir/StructureDefinition/valueset-supplement"
* ^extension[=].valueCanonical = Canonical(GPCCMPExpandedYesNoIndicatorSupplement|0.1.0)
* ^experimental = false
* ^expansion.identifier = "urn:uuid:105bb5ba-72a4-43a2-ab99-6859a21463a8"
* ^expansion.timestamp = "2026-02-17T10:59:10+10:00"
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
* ^expansion.parameter[=].valueUri = "http://terminology.hl7.org/CodeSystem/v2-0532|3.0.0"
* ^expansion.parameter[+].name = "used-supplement"
* ^expansion.parameter[=].valueUri = "https://gpccmp.csiro.au/ig/CodeSystem/GPCCMPExpandedYesNoIndicatorSupplement|0.1.0"
* ^expansion.contains[0].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #Y
* ^expansion.contains[=].display = "Yes"
* ^expansion.contains[+].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #N
* ^expansion.contains[=].display = "No"
* ^expansion.contains[+].system = "http://terminology.hl7.org/CodeSystem/v2-0532"
* ^expansion.contains[=].code = #NAV
* ^expansion.contains[=].display = "Pending"
* $v2-0532#Y "Yes"
* $v2-0532#N "No"
* $v2-0532#NAV "Pending"

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
* $medication-statement-status#active
* $medication-statement-status#completed
* $medication-statement-status#stopped
* $medication-statement-status#on-hold


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

CodeSystem: GPCCMPGoalStatusSupplement
Id: GPCCMPGoalStatusSupplement
Title: "GP CCMP Goal Status Supplement"
Description: "The GP CCMP Goal Status Supplement defines consumer friendly terms for the GoalLifecycleStatus code system for use in the GP CCMP Questionnaire."
* ^experimental = false
* ^content = #supplement
* ^supplements = $goal-status
* #cancelled "withdrawn"

ValueSet: GoalStatusLimited
Id: GoalStatusLimited
Title: "Goal Status Limited"
Description: "This value set includes the minimal set of codes to represent the status of a goal (i.e., active, completed, and withdrawn)."
* ^experimental = false
* ^expansion.identifier = "urn:uuid:363b3b05-2833-47d2-b88f-6d2ccb006278"
* ^expansion.timestamp = "2026-02-17T14:48:48+10:00"
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
* ^expansion.parameter[=].valueUri = "http://hl7.org/fhir/goal-status|4.0.1"
* ^expansion.parameter[+].name = "used-supplement"
* ^expansion.parameter[=].valueUri = "https://gpccmp.csiro.au/ig/CodeSystem/GPCCMPGoalStatusSupplement|0.1.0"
* ^expansion.contains[0].system = "http://hl7.org/fhir/goal-status"
* ^expansion.contains[=].code = #active
* ^expansion.contains[=].display = "active"
* ^expansion.contains[+].system = "http://hl7.org/fhir/goal-status"
* ^expansion.contains[=].code = #completed
* ^expansion.contains[=].display = "completed"
* ^expansion.contains[+].system = "http://hl7.org/fhir/goal-status"
* ^expansion.contains[=].code = #cancelled
* ^expansion.contains[=].display = "withdrawn"
* $goal-status#active "active"
* $goal-status#completed "completed"
* $goal-status#cancelled "withdrawn"
