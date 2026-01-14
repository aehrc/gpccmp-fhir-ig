
Alias: $LNC = http://loinc.org
Alias: $SCT = http://snomed.info/sct
Alias: $UCUM = http://unitsofmeasure.org
Alias: $obligation = http://hl7.org/fhir/StructureDefinition/obligation

Alias: $au-core-allergyintolerance = http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance
Alias: $au-core-condition = http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition
Alias: $au-core-encounter = http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter
Alias: $au-core-immunization = http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization
Alias: $au-core-medication = http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication
Alias: $au-core-medicationstatement = http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement
Alias: $au-core-bloodpressure = http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure
Alias: $au-core-bodyheight = http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight
Alias: $au-core-bodyweight = http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight
Alias: $au-core-diagnosticresult-path = http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path
Alias: $au-core-headcircum = http://hl7.org.au/fhir/core/StructureDefinition/au-core-headcircum
Alias: $au-core-heartrate = http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate
Alias: $au-core-waistcircum = http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum
Alias: $au-core-smokingstatus = http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus
Alias: $au-core-patient = http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient
Alias: $au-core-practitioner = http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner
Alias: $sdc-questionnaireresponse = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaireresponse

Alias: $au-address = http://hl7.org.au/fhir/StructureDefinition/au-address
Alias: $au-pensionerconcessioncardnumber = http://hl7.org.au/fhir/StructureDefinition/au-pensionerconcessioncardnumber
Alias: $au-healthcarecardnumber = http://hl7.org.au/fhir/StructureDefinition/au-healthcarecardnumber

RuleSet: obligationApp(index, appCode)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{appCode}"
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPClient)

RuleSet: obligation2App(index, appCode1, appCode2)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{appCode1}"
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{appCode2}"
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPClient)

RuleSet: obligationServer(index, serverCode)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{serverCode}"
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPServer)

RuleSet: obligation2Server(index, serverCode1, serverCode2)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{serverCode1}"
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{serverCode2}"
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPServer)

RuleSet: obligation3Server(index, serverCode1, serverCode2, serverCode3)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{serverCode1}"
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{serverCode2}"
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #"{serverCode3}"
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPServer)


Profile: GPCCMPQuestionnaireResponse
Parent: $sdc-questionnaireresponse
Id: GPCCMPQuestionnaireResponse
Title: "GP CCMP Questionnaire Response"
Description: "This profile sets the minimum expectations for a QuestionnaireResponse resource to record, search and save GP Chronic Condition Management Plan information."

* id MS
* id insert obligation2Server (0, SHALL:populate, SHALL:persist)
* id insert obligation2App (1, SHALL:populate-if-known, SHALL:process)
* text MS
* text insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* text insert obligation2App (1, SHALL:populate, SHALL:process)
* questionnaire MS
* questionnaire insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* questionnaire insert obligation2App (1, SHALL:populate, SHALL:process)
* questionnaire.extension[questionnaireDisplay] MS
* questionnaire.extension[questionnaireDisplay] insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* questionnaire.extension[questionnaireDisplay] insert obligation2App (1, SHALL:populate, SHALL:process)
* status MS
* status insert obligation2Server (0, SHALL:populate, SHALL:persist)
* status insert obligation2App (1, SHALL:populate, SHALL:process)
* subject 1.. MS
* subject insert obligation2Server (0, SHALL:populate, SHALL:persist)
* subject insert obligation2App (1, SHALL:populate, SHALL:process)
* subject only Reference(Patient)
* encounter MS
* encounter insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* encounter insert obligation2App (1, SHALL:populate-if-known, SHALL:process)
* authored MS
* authored insert obligation2Server (0, SHALL:populate, SHALL:persist)
* authored insert obligation2App (1, SHALL:populate, SHALL:process)
* author 1.. MS
* author insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* author insert obligation2App (1, SHALL:populate, SHALL:process)
* author only Reference(Practitioner)
* item MS
* item insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item insert obligation2App (1, SHALL:populate-if-known, SHALL:process)
* item.linkId MS
* item.linkId insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.linkId insert obligation2App (1, SHALL:populate-if-known, SHALL:process)
* item.text MS
* item.text insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.text insert obligation2App (1, SHALL:populate-if-known, SHALL:process)
* item.answer MS
* item.answer insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.answer insert obligation2App (1, SHALL:populate-if-known, SHALL:process)
* item.answer.value[x] MS
* item.answer.value[x] insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.answer.value[x] insert obligation2App (1, SHALL:populate-if-known, SHALL:process)
* item.item MS
* item.item insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.item insert obligation2App (1, SHALL:populate-if-known, SHALL:process)
