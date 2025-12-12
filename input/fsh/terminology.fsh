Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org

Alias: $v2-0532 = http://terminology.hl7.org/CodeSystem/v2-0532|2.0.0

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
