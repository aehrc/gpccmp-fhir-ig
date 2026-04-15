
Alias: $LNC = http://loinc.org
Alias: $SCT = http://snomed.info/sct
Alias: $UCUM = http://unitsofmeasure.org
Alias: $obligation = http://hl7.org/fhir/StructureDefinition/obligation

Alias: $au-core-allergyintolerance = http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance
Alias: $au-core-condition = http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition
Alias: $au-core-encounter = http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter
Alias: $au-core-medication = http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication
Alias: $au-core-medicationstatement = http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement
Alias: $au-core-bloodpressure = http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure
Alias: $au-core-bodyheight = http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight
Alias: $au-core-bodyweight = http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight
Alias: $au-core-heartrate = http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate
Alias: $au-core-waistcircum = http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum
Alias: $au-core-smokingstatus = http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus
Alias: $au-core-patient = http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient
Alias: $au-core-practitioner = http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner
Alias: $au-core-practitionerrole = http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole
Alias: $au-core-location = http://hl7.org.au/fhir/core/StructureDefinition/au-core-location
Alias: $sdc-questionnaireresponse = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaireresponse

Alias: $au-address = http://hl7.org.au/fhir/StructureDefinition/au-address

RuleSet: obligationClient(index, clientCode)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #{clientCode}
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPClient)

RuleSet: obligation2Client(index, clientCode1, clientCode2)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #{clientCode1}
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #{clientCode2}
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPClient)

RuleSet: obligationServer(index, serverCode)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #{serverCode}
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPServer)

RuleSet: obligation2Server(index, serverCode1, serverCode2)
* ^extension[{index}].url = $obligation
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #{serverCode1}
* ^extension[=].extension[+].url = "code"
* ^extension[=].extension[=].valueCode = #{serverCode2}
* ^extension[=].extension[+].url = "actor"
* ^extension[=].extension[=].valueCanonical = Canonical(GPCCMPServer)


Profile: GPCCMPQuestionnaireResponse
Parent: $sdc-questionnaireresponse
Id: GPCCMPQuestionnaireResponse
Title: "GP CCMP QuestionnaireResponse"
Description: "This profile sets the minimum expectations for a QuestionnaireResponse resource to record, search and save GP Chronic Condition Management Plan information."

* id MS
* id insert obligation2Server (0, SHALL:populate, SHALL:persist)
* id insert obligation2Client (1, SHALL:populate-if-known, SHALL:process)
* text MS
* text insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* text insert obligation2Client (1, SHALL:populate, SHALL:process)
* questionnaire MS
* questionnaire insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* questionnaire insert obligation2Client (1, SHALL:populate, SHALL:process)
* questionnaire.extension[questionnaireDisplay] MS
* questionnaire.extension[questionnaireDisplay] insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* questionnaire.extension[questionnaireDisplay] insert obligation2Client (1, SHALL:populate, SHALL:process)
* status MS
* status insert obligation2Server (0, SHALL:populate, SHALL:persist)
* status insert obligation2Client (1, SHALL:populate, SHALL:process)
* subject 1.. MS
* subject insert obligation2Server (0, SHALL:populate, SHALL:persist)
* subject insert obligation2Client (1, SHALL:populate, SHALL:process)
* subject only Reference(Patient)
* encounter MS
* encounter insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* encounter insert obligation2Client (1, SHALL:populate-if-known, SHALL:process)
* authored MS
* authored insert obligation2Server (0, SHALL:populate, SHALL:persist)
* authored insert obligation2Client (1, SHALL:populate, SHALL:process)
* author 1.. MS
* author insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* author insert obligation2Client (1, SHALL:populate, SHALL:process)
* author only Reference(Practitioner)
* item MS
* item insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item insert obligation2Client (1, SHALL:populate-if-known, SHALL:process)
* item.linkId MS
* item.linkId insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.linkId insert obligation2Client (1, SHALL:populate-if-known, SHALL:process)
* item.text MS
* item.text insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.text insert obligation2Client (1, SHALL:populate-if-known, SHALL:process)
* item.answer MS
* item.answer insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.answer insert obligation2Client (1, SHALL:populate-if-known, SHALL:process)
* item.answer.value[x] MS
* item.answer.value[x] insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.answer.value[x] insert obligation2Client (1, SHALL:populate-if-known, SHALL:process)
* item.item MS
* item.item insert obligation2Server (0, SHALL:populate-if-known, SHALL:persist)
* item.item insert obligation2Client (1, SHALL:populate-if-known, SHALL:process)


Profile: GPCCMPPatient
Parent: $au-core-patient
Id: GPCCMPPatient
Title: "GP CCMP Patient"
Description: "This profile sets the minimum expectations for a Patient resource to search and retrieve patient information when used within the GP Chronic Condition Management Plan."

* extension[indigenousStatus] MS
* extension[indigenousStatus] insert obligationClient (2, SHALL:process)
* extension[closingTheGapRegistration] MS
* extension[closingTheGapRegistration] insert obligationServer (0, SHALL:populate-if-known)
* extension[closingTheGapRegistration] insert obligationClient (1, SHALL:process)
* extension[genderIdentity] MS
* extension[genderIdentity] insert obligationClient (2, SHALL:process)
* extension[individualPronouns] MS
* extension[individualPronouns] insert obligationClient (2, SHALL:process)
* extension[recordedSexOrGender] MS
* extension[recordedSexOrGender] insert obligationServer (0, SHALL:populate-if-known)
* extension[recordedSexOrGender] insert obligationClient (1, SHALL:process)
* identifier MS
* identifier insert obligationClient (2, SHALL:process)
* identifier[medicare] MS
* identifier[medicare] insert obligationClient (2, SHALL:process)
* name MS
* name insert obligationClient (2, SHALL:process)
* name.use MS
* name.use insert obligationClient (2, SHALL:process)
* name.text MS
* name.text insert obligationClient (2, SHALL:process)
* name.family MS
* name.family insert obligationClient (2, SHALL:process)
* name.given MS
* name.given insert obligationClient (2, SHALL:process)
* name.prefix MS
* name.prefix insert obligationClient (0, SHALL:process)
* telecom MS
* telecom insert obligationClient (2, SHALL:process)
* telecom.system MS
* telecom.system insert obligationClient (2, SHALL:process)
* telecom.value MS
* telecom.value insert obligationClient (2, SHALL:process)
* telecom.use MS
* telecom.use insert obligationClient (2, SHALL:process)
* birthDate MS
* birthDate insert obligationClient (2, SHALL:process)
* address MS
* address only $au-address
* address insert obligationClient (2, SHALL:process)
* address.use MS
* address.use insert obligationServer (0, SHALL:populate-if-known)
* address.use insert obligationClient (1, SHALL:process)
* address.type MS
* address.type insert obligationServer (0, SHALL:populate-if-known)
* address.type insert obligationClient (1, SHALL:process)
* address.line MS
* address.line insert obligationServer (0, SHALL:populate-if-known)
* address.line insert obligationClient (1, SHALL:process)
* address.city MS
* address.city insert obligationServer (0, SHALL:populate-if-known)
* address.city insert obligationClient (1, SHALL:process)
* address.state MS
* address.state insert obligationServer (0, SHALL:populate-if-known)
* address.state insert obligationClient (1, SHALL:process)
* address.postalCode MS
* address.postalCode insert obligationServer (0, SHALL:populate-if-known)
* address.postalCode insert obligationClient (1, SHALL:process)
* contact MS
* contact insert obligationServer (0, SHALL:populate-if-known)
* contact insert obligationClient (1, SHALL:process)
* contact.relationship MS
* contact.relationship insert obligationServer (0, SHALL:populate-if-known)
* contact.relationship insert obligationClient (1, SHALL:process)
* contact.name MS
* contact.name insert obligationServer (0, SHALL:populate-if-known)
* contact.name insert obligationClient (1, SHALL:process)
* contact.name.family MS
* contact.name.family insert obligationServer (0, SHALL:populate-if-known)
* contact.name.family insert obligationClient (1, SHALL:process)
* contact.name.given MS
* contact.name.given insert obligationServer (0, SHALL:populate-if-known)
* contact.name.given insert obligationClient (1, SHALL:process)
* contact.name.prefix MS
* contact.name.prefix insert obligationClient (0, SHALL:process)
* contact.telecom MS
* contact.telecom insert obligationServer (0, SHALL:populate-if-known)
* contact.telecom insert obligationClient (1, SHALL:process)

Profile: GPCCMPPractitioner
Parent: $au-core-practitioner
Id: GPCCMPPractitioner
Title: "GP CCMP Practitioner"
Description: "This profile sets the minimum expectations for a Practitioner resource to search and retrieve practitioner information when used within the GP Chronic Condition Management Plan."
* id MS
* id insert obligationServer (0, SHALL:populate)
* id insert obligationClient (1, SHALL:process)
* name MS
* name insert obligationClient (2, SHALL:process)

Profile: GPCCMPPractitionerRole
Parent: $au-core-practitionerrole
Id: GPCCMPPractitionerRole
Title: "GP CCMP Practitioner Role"
Description: "This profile sets the minimum expectations for a PractitionerRole resource to search and retrieve practitioner role information when used within the GP Chronic Condition Management Plan."
* id MS
* id insert obligationServer (0, SHALL:populate)
* id insert obligationClient (1, SHALL:process)
* identifier MS
* identifier insert obligationClient (2, SHALL:process)
* identifier[medicareProvider] MS
* identifier[medicareProvider] insert obligationClient (2, SHALL:process)
* location ..1 MS
* location insert obligationServer (0, SHALL:populate-if-known)
* location insert obligationClient (1, SHALL:process)
* telecom MS
* telecom insert obligationClient (2, SHALL:process)
* telecom.system MS
* telecom.system insert obligationClient (2, SHALL:process)
* telecom.value MS
* telecom.value insert obligationClient (2, SHALL:process)

Profile: GPCCMPLocation
Parent: $au-core-location
Id: GPCCMPLocation
Title: "GP CCMP Location"
Description: "This profile sets the minimum expectations for a Location resource to search and retrieve location information when used within the GP Chronic Condition Management Plan."
* name MS
* name insert obligationClient (2, SHALL:process)
* address MS
* address insert obligationClient (2, SHALL:process)

Profile: GPCCMPEncounter
Parent: $au-core-encounter
Id: GPCCMPEncounter
Title: "GP CCMP Encounter"
Description: "This profile sets the minimum expectations for an Encounter resource to retrieve encounter information when used within the GP Chronic Condition Management Plan."
* id MS
* id insert obligationServer (0, SHALL:populate)
* id insert obligationClient (1, SHALL:process)


Profile: GPCCMPCondition
Parent: $au-core-condition
Id: GPCCMPCondition
Title: "GP CCMP Condition"
Description: "This profile sets the minimum expectations for a Condition resource to record and search condition information when used within the GP Chronic Condition Management Plan."

* clinicalStatus MS
* clinicalStatus insert obligationClient (2, SHALL:process)
* verificationStatus MS
// Server obligation is only AU Core inherited SHALL:populate-if-known (not additional SHALL:populate), as the condition may be recorded without verificationStatus and the expression accounts for non-populated verificationStatus.
* verificationStatus insert obligationClient (2, SHALL:process)
* category ^slicing.discriminator[0].type = #value
* category ^slicing.discriminator[=].path = "coding.code"
* category ^slicing.discriminator[+].type = #value
* category ^slicing.discriminator[=].path = "coding.system"
* category ^slicing.ordered = false
* category ^slicing.rules = #open
* category contains problemListCategory 1..1 
* category[problemListCategory] MS
* category[problemListCategory] insert obligationServer (2, SHALL:populate)
* category[problemListCategory].coding 1..*
* category[problemListCategory].coding only Coding
* category[problemListCategory].coding.system 1..1
* category[problemListCategory].coding.system only uri
* category[problemListCategory].coding.system = "http://terminology.hl7.org/CodeSystem/condition-category" (exactly)
* category[problemListCategory].coding.code 1..1
* category[problemListCategory].coding.code only code
* category[problemListCategory].coding.code = #problem-list-item (exactly)
* code MS
* code insert obligationClient (2, SHALL:process)
* subject MS
* subject insert obligationServer (2, SHALL:populate)
* onset[x] MS
* onset[x] insert obligationClient (2, SHALL:process)
* onsetDateTime MS
* onsetDateTime insert obligationClient (0, SHALL:process)
* abatement[x] MS
* abatement[x] insert obligationClient (2, SHALL:process)
* abatementDateTime MS
* abatementDateTime insert obligationClient (0, SHALL:process)


Profile: GPCCMPAllergyIntolerance
Parent: $au-core-allergyintolerance
Id: GPCCMPAllergyIntolerance
Title: "GP CCMP AllergyIntolerance"
Description: "This profile sets the minimum expectations for an AllergyIntolerance resource to record and search allergy or adverse reaction information when used within the GP Chronic Condition Management Plan."

* patient MS
* patient insert obligationServer (2, SHALL:populate)
* clinicalStatus MS 
* clinicalStatus insert obligationServer (2, SHALL:populate)
* clinicalStatus insert obligationClient (3, SHALL:process)
* verificationStatus MS
// Server obligation is only AU Core inherited SHALL:populate-if-known (not additional SHALL:populate), as the condition may be recorded without verificationStatus and the expression accounts for non-populated verificationStatus.
* verificationStatus insert obligationClient (2, SHALL:process)
* code MS
* code insert obligationClient (2, SHALL:process)
* note ..1 MS
* note insert obligationClient (2, SHALL:process)
* note.text MS
* note.text insert obligationServer (0, SHALL:populate-if-known)
* note.text insert obligationClient (1, SHALL:process)
* reaction MS
* reaction insert obligationClient (2, SHALL:process)
* reaction.manifestation MS
* reaction.manifestation insert obligationClient (2, SHALL:process)

Profile: GPCCMPMedicationStatement
Parent: $au-core-medicationstatement
Id: GPCCMPMedicationStatement
Title: "GP CCMP MedicationStatement"
Description: "This profile sets the minimum expectations for a MedicationStatement resource to record and search medication information when used within the GP Chronic Condition Management Plan."

* status MS
* status insert obligationServer (2, SHALL:populate)
* status insert obligationClient (3, SHALL:process)
* status from MedicationStatementStatusLimited (required)
* medication[x] MS
* medication[x] insert obligationClient (2, SHALL:process)
* medicationCodeableConcept MS
* medicationCodeableConcept insert obligationClient (2, SHALL:process)
* medicationReference MS
* medicationReference only Reference(GPCCMPMedication)
* medicationReference insert obligationClient (2, SHALL:process)
* subject MS
* subject insert obligationServer (2, SHALL:populate)
* reasonCode MS
* reasonCode insert obligationClient (2, SHALL:process)
* note ..1 MS
* note insert obligationServer (0, SHALL:populate-if-known)
* note insert obligationClient (1, SHALL:process)
* note.text MS
* note.text insert obligationServer (0, SHALL:populate-if-known)
* note.text insert obligationClient (1, SHALL:process)
* dosage ..1 MS
* dosage insert obligationClient (2, SHALL:process)
* dosage.text MS
* dosage.text insert obligationClient (2, SHALL:process)

Profile: GPCCMPMedication
Parent: $au-core-medication
Id: GPCCMPMedication
Title: "GP CCMP Medication"
Description: "This profile sets the minimum expectations for a Medication resource to search and retrieve medication information when used within the GP Chronic Condition Management Plan."
* id MS
* id insert obligationServer (0, SHALL:populate)
* id insert obligationClient (1, SHALL:process)
* code MS
* code insert obligationClient (2, SHALL:process)

Profile: GPCCMPBodyHeight
Parent: $au-core-bodyheight
Id: GPCCMPBodyHeight
Title: "GP CCMP Body Height"
Description: "This profile sets the minimum expectations for a Body Height resource to record and search body height information when used within the GP Chronic Condition Management Plan."

* status MS
* status insert obligationServer (3, SHALL:populate)
* status insert obligationClient (4, SHALL:process)
* code MS
* code insert obligationServer (2, SHALL:populate)
* code.coding[BodyHeightCode] MS
* code.coding[BodyHeightCode] insert obligationServer (0, SHALL:populate)
* subject MS
* subject insert obligationServer (2, SHALL:populate)
* effective[x] MS
* effective[x] insert obligationClient (2, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (2, SHALL:populate)
* effectiveDateTime insert obligationClient (3, SHALL:process)
* value[x] MS
* value[x] insert obligationServer (0, SHALL:populate-if-known)
* value[x] insert obligationClient (1, SHALL:process)
* valueQuantity MS
* valueQuantity insert obligationClient (2, SHALL:process)
* valueQuantity.value MS
* valueQuantity.value insert obligationClient (2, SHALL:process)
* valueQuantity.system MS
* valueQuantity.system insert obligationClient (2, SHALL:process)
* valueQuantity.code MS
* valueQuantity.code insert obligationClient (2, SHALL:process)

Profile: GPCCMPBodyWeight
Parent: $au-core-bodyweight 
Id: GPCCMPBodyWeight
Title: "GP CCMP Body Weight"
Description: "This profile sets the minimum expectations for a Body Weight resource to record and search body weight information when used within the GP Chronic Condition Management Plan."

* status MS
* status insert obligationServer (3, SHALL:populate)
* status insert obligationClient (4, SHALL:process)
* code MS
* code insert obligationServer (2, SHALL:populate)
* code.coding[BodyWeightCode] MS
* code.coding[BodyWeightCode] insert obligationServer (0, SHALL:populate)
* subject MS
* subject insert obligationServer (2, SHALL:populate)
* effective[x] MS
* effective[x] insert obligationClient (2, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (2, SHALL:populate)
* effectiveDateTime insert obligationClient (3, SHALL:process)
* value[x] MS
* value[x] insert obligationServer (0, SHALL:populate-if-known)
* value[x] insert obligationClient (1, SHALL:process)
* valueQuantity MS
* valueQuantity insert obligationClient (2, SHALL:process)
* valueQuantity.value MS
* valueQuantity.value insert obligationClient (2, SHALL:process)
* valueQuantity.system MS
* valueQuantity.system insert obligationClient (2, SHALL:process)
* valueQuantity.code MS
* valueQuantity.code insert obligationClient (2, SHALL:process)

Profile: GPCCMPWaistCircumference
Parent: $au-core-waistcircum
Id: GPCCMPWaistCircumference
Title: "GP CCMP Waist Circumference"
Description: "This profile sets the minimum expectations for a Waist Circumference resource to record and search waist circumference information when used within the GP Chronic Condition Management Plan."

* status MS
* status insert obligationServer (3, SHALL:populate)
* status insert obligationClient (4, SHALL:process)
* code MS
* code insert obligationServer (2, SHALL:populate)
* code.coding[loincWaistCircumCode] MS
* code.coding[loincWaistCircumCode] insert obligationServer (0, SHALL:populate)
* subject MS
* subject insert obligationServer (2, SHALL:populate)
* effective[x] MS
* effective[x] insert obligationClient (2, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (2, SHALL:populate)
* effectiveDateTime insert obligationClient (3, SHALL:process)
* value[x] MS
* value[x] insert obligationServer (0, SHALL:populate-if-known)
* value[x] insert obligationClient (1, SHALL:process)
* valueQuantity MS
* valueQuantity insert obligationClient (2, SHALL:process)
* valueQuantity.value MS
* valueQuantity.value insert obligationServer (0, SHALL:populate-if-known)
* valueQuantity.value insert obligationClient (1, SHALL:process)
* valueQuantity.system MS
* valueQuantity.system insert obligationServer (0, SHALL:populate-if-known)
* valueQuantity.system insert obligationClient (1, SHALL:process)
* valueQuantity.code MS
* valueQuantity.code insert obligationServer (0, SHALL:populate-if-known)
* valueQuantity.code insert obligationClient (1, SHALL:process)

Profile: GPCCMPPulseRate
Parent: $au-core-heartrate
Id: GPCCMPPulseRate
Title: "GP CCMP Pulse Rate"
Description: "This profile sets the minimum expectations for a Pulse Rate resource to record and search pulse rate information when used within the GP Chronic Condition Management Plan."

* status MS
* status insert obligationServer (3, SHALL:populate)
* code MS
* code insert obligationServer (2, SHALL:populate)
* code.coding contains snomedPulseRate 1..1 MS
* code.coding[snomedPulseRate] insert obligationServer (0, SHALL:populate)
* code.coding[snomedPulseRate].system 1..1
* code.coding[snomedPulseRate].system = "http://snomed.info/sct" (exactly)
* code.coding[snomedPulseRate].code 1..1
* code.coding[snomedPulseRate].code = #78564009 (exactly)
* subject MS
* subject insert obligationServer (2, SHALL:populate)
* effective[x] MS
* effective[x] insert obligationClient (2, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (2, SHALL:populate)
* effectiveDateTime insert obligationClient (3, SHALL:process)
* value[x] MS
* value[x] insert obligationServer (0, SHALL:populate-if-known)
* value[x] insert obligationClient (1, SHALL:process)
* valueQuantity MS
* valueQuantity insert obligationClient (2, SHALL:process)
* valueQuantity.value MS
* valueQuantity.value insert obligationClient (2, SHALL:process)
* valueQuantity.system MS
* valueQuantity.system insert obligationClient (2, SHALL:process)
* valueQuantity.code MS
* valueQuantity.code insert obligationClient (2, SHALL:process)

Invariant: gpccmp-pulserhythm-01
Description: "At least value or data absent reason shall be present"
* severity = #error
* expression = "dataAbsentReason.exists() or value.exists()"
* xpath = "exists(f:*[starts-with(local-name(.), 'value')]) or exists(f:dataAbsentReason)"

Invariant: gpccmp-pulserhythm-02
Description: "Date shall be at least to day or, if not available, the Data Absent Reason extension shall be present"
* severity = #error
* expression = "(($this is dateTime implies $this.toString().length() >= 10) and extension('http://hl7.org/fhir/StructureDefinition/data-absent-reason').value.exists().not()) xor ($this is dateTime implies ($this.hasValue().not() and extension('http://hl7.org/fhir/StructureDefinition/data-absent-reason').value.exists()))"
* xpath = "((self::dateTime and string-length(.) >= 10 and not(extension[@url='http://hl7.org/fhir/StructureDefinition/data-absent-reason'])) xor (self::dateTime and not(.) and extension[@url='http://hl7.org/fhir/StructureDefinition/data-absent-reason']))"

Profile: GPCCMPPulseRhythm
Parent: Observation
Id: GPCCMPPulseRhythm
Title: "GP CCMP Pulse Rhythm"
Description: "This profile sets the minimum expectations for an Observation resource to record and search pulse rhythm observation information when used within the GP Chronic Condition Management Plan."

* . ^short = "Pulse Rhythm"
* . ^definition = "Measurement of a patient's pulse rhythm at a point in time."
* obeys gpccmp-pulserhythm-01
* status MS
* status insert obligationServer (1, SHALL:populate)
* status insert obligationClient (2, SHALL:process)
* category ^slicing.discriminator[0].type = #value
* category ^slicing.discriminator[=].path = "coding.code"
* category ^slicing.discriminator[+].type = #value
* category ^slicing.discriminator[=].path = "coding.system"
* category ^slicing.ordered = false
* category ^slicing.rules = #open
* category contains vitalSignsCategory 1..1 
* category[vitalSignsCategory].coding 1..*
* category[vitalSignsCategory].coding only Coding
* category[vitalSignsCategory].coding.system 1..1
* category[vitalSignsCategory].coding.system only uri
* category[vitalSignsCategory].coding.system = "http://terminology.hl7.org/CodeSystem/observation-category" (exactly)
* category[vitalSignsCategory].coding.code 1..1
* category[vitalSignsCategory].coding.code only code
* category[vitalSignsCategory].coding.code = #vital-signs (exactly)
/*
* category[vitalSignsCategory] = http://terminology.hl7.org/CodeSystem/observation-category#vital-signs (exactly) 
* category[vitalSignsCategory] insert obligationServer (0, SHALL:persist)
* category[vitalSignsCategory] insert obligationClient (1, SHALL:populate)
*/
* code MS
* code insert obligationServer (0, SHALL:populate)
* code ^short = "Pulse Rhythm"
* code ^definition = "Pulse Rhythm."
* code.coding
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[=].path = "code"
* code.coding ^slicing.discriminator[+].type = #value
* code.coding ^slicing.discriminator[=].path = "system"
* code.coding ^slicing.ordered = false
* code.coding ^slicing.rules = #open
* code.coding contains snomedPulseRhythmCode 1..1 MS
* code.coding[snomedPulseRhythmCode] insert obligationServer (0, SHALL:populate)
* code.coding[snomedPulseRhythmCode].system 1..1
* code.coding[snomedPulseRhythmCode].system = "http://snomed.info/sct" (exactly)
* code.coding[snomedPulseRhythmCode].code 1..1
* code.coding[snomedPulseRhythmCode].code = #364095004 (exactly)
* subject 1.. MS
* subject only Reference($au-core-patient)
* subject insert obligationServer (0, SHALL:populate)
* effective[x] 1..
* effective[x] only dateTime
* effective[x] obeys gpccmp-pulserhythm-02
* effective[x] ^short = "Date, and optionally time, the observation was performed"
* effective[x] ^definition = "Date, and optionally time, the observation was performed."
* effective[x] ^condition = "gpccmp-pulserhythm-02"
* effective[x] MS
* effective[x] insert obligationServer (0, SHALL:populate-if-known)
* effective[x] insert obligationClient (1, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (0, SHALL:populate)
* effectiveDateTime insert obligationClient (1, SHALL:process)
* value[x] only CodeableConcept
* value[x] from PulseRhythm (extensible)
* value[x] ^condition = "gpccmp-pulserhythm-01"
* value[x] MS
* value[x] insert obligationServer (0, SHALL:populate-if-known)
* value[x] insert obligationClient (1, SHALL:process)
* valueCodeableConcept.coding MS
* valueCodeableConcept.coding insert obligationServer (0, SHALL:populate-if-known)
* valueCodeableConcept.coding insert obligationClient (1, SHALL:process)
* dataAbsentReason ^condition = "gpccmp-pulserhythm-01"

Invariant: gpccmp-oxygensaturation-01
Description: "At least value or data absent reason shall be present"
* severity = #error
* expression = "dataAbsentReason.exists() or value.exists()"
* xpath = "exists(f:*[starts-with(local-name(.), 'value')]) or exists(f:dataAbsentReason)"

Invariant: gpccmp-oxygensaturation-02
Description: "Date shall be at least to day or, if not available, the Data Absent Reason extension shall be present"
* severity = #error
* expression = "(($this is dateTime implies $this.toString().length() >= 10) and extension('http://hl7.org/fhir/StructureDefinition/data-absent-reason').value.exists().not()) xor ($this is dateTime implies ($this.hasValue().not() and extension('http://hl7.org/fhir/StructureDefinition/data-absent-reason').value.exists()))"
* xpath = "((self::dateTime and string-length(.) >= 10 and not(extension[@url='http://hl7.org/fhir/StructureDefinition/data-absent-reason'])) xor (self::dateTime and not(.) and extension[@url='http://hl7.org/fhir/StructureDefinition/data-absent-reason']))"

Profile: GPCCMPOxygenSaturation
Parent: http://hl7.org/fhir/StructureDefinition/oxygensat
Id: GPCCMPOxygenSaturation
Title: "GP CCMP Oxygen Saturation"
Description: "This profile sets the minimum expectations for an Observation resource to record and search oxygen saturation observation information when used within the GP Chronic Condition Management Plan."

* . ^short = "Oxygen Saturation"
* . ^definition = "Measurement of a patient's oxygen saturation at a point in time."
* obeys gpccmp-oxygensaturation-01
* status MS
* status insert obligationServer (1, SHALL:populate)
* status insert obligationClient (2, SHALL:process)
* code MS
* code insert obligationServer (0, SHALL:populate)
* code.coding[OxygenSatCode] MS
* code.coding[OxygenSatCode] insert obligationServer (0, SHALL:populate)
* subject 1.. MS
* subject only Reference($au-core-patient)
* subject insert obligationServer (0, SHALL:populate)
* effective[x] 1..
* effective[x] only dateTime
* effective[x] obeys gpccmp-oxygensaturation-02
* effective[x] ^short = "Date, and optionally time, the observation was performed"
* effective[x] ^definition = "Date, and optionally time, the observation was performed."
* effective[x] ^condition = "gpccmp-oxygensaturation-02"
* effective[x] MS
* effective[x] insert obligationServer (0, SHALL:populate-if-known)
* effective[x] insert obligationClient (1, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (0, SHALL:populate)
* effectiveDateTime insert obligationClient (1, SHALL:process)
* value[x] MS
* value[x] insert obligationServer (0, SHALL:populate-if-known)
* value[x] insert obligationClient (1, SHALL:process)
* valueQuantity MS
* valueQuantity insert obligationClient (0, SHALL:process)
* valueQuantity.value MS
* valueQuantity.value insert obligationClient (0, SHALL:process)
* valueQuantity.system MS
* valueQuantity.system insert obligationClient (0, SHALL:process)
* valueQuantity.code MS
* valueQuantity.code insert obligationClient (0, SHALL:process)
* dataAbsentReason ^condition = "gpccmp-oxygensaturation-01"

Profile: GPCCMPBloodPressure
Parent: $au-core-bloodpressure
Id: GPCCMPBloodPressure
Title: "GP CCMP Blood Pressure"
Description: "This profile sets the minimum expectations for a Blood Pressure resource to record and search blood pressure information when used within the GP Chronic Condition Management Plan."

* status MS
* status insert obligationServer (3, SHALL:populate)
* code MS
* code insert obligationServer (2, SHALL:populate)
* code.coding[BPCode] MS
* code.coding[BPCode] insert obligationServer (0, SHALL:populate)
* subject MS
* subject insert obligationServer (2, SHALL:populate)
* effective[x] MS
* effective[x] insert obligationClient (2, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (2, SHALL:populate)
* effectiveDateTime insert obligationClient (3, SHALL:process)
* component MS
* component insert obligationClient (2, SHALL:process)
* component[SystolicBP] MS
* component[SystolicBP] insert obligationClient (2, SHALL:process)
* component[SystolicBP].code MS
* component[SystolicBP].code insert obligationClient (2, SHALL:process)
* component[SystolicBP].valueQuantity MS
* component[SystolicBP].valueQuantity insert obligationClient (2, SHALL:process)
* component[SystolicBP].valueQuantity.value MS
* component[SystolicBP].valueQuantity.value insert obligationClient (2, SHALL:process)
* component[SystolicBP].valueQuantity.system MS
* component[SystolicBP].valueQuantity.system insert obligationClient (2, SHALL:process)
* component[SystolicBP].valueQuantity.code MS
* component[SystolicBP].valueQuantity.code insert obligationClient (2, SHALL:process)
* component[DiastolicBP].valueQuantity MS
* component[DiastolicBP].valueQuantity insert obligationClient (2, SHALL:process)
* component[DiastolicBP].valueQuantity.value MS
* component[DiastolicBP].valueQuantity.value insert obligationClient (2, SHALL:process)
* component[DiastolicBP].valueQuantity.system MS
* component[DiastolicBP].valueQuantity.system insert obligationClient (2, SHALL:process)
* component[DiastolicBP].valueQuantity.code MS
* component[DiastolicBP].valueQuantity.code insert obligationClient (2, SHALL:process)

Profile: GPCCMPSmokingStatus
Parent: $au-core-smokingstatus
Id: GPCCMPSmokingStatus
Title: "GP CCMP Smoking Status"
Description: "This profile sets the minimum expectations for a Smoking Status resource to record and search smoking status information when used within the GP Chronic Condition Management Plan."

* status MS
* status insert obligationServer (3, SHALL:populate)
* status insert obligationClient (4, SHALL:process)
* code MS
* code insert obligationServer (2, SHALL:populate)
* subject MS
* subject insert obligationServer (2, SHALL:populate)
* effective[x] MS
* effective[x] insert obligationClient (2, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (2, SHALL:populate)
* effectiveDateTime insert obligationClient (3, SHALL:process)
* value[x] MS
* value[x] insert obligationClient (2, SHALL:process)
* valueCodeableConcept.coding MS
* valueCodeableConcept.coding insert obligationServer (0, SHALL:populate-if-known)
* valueCodeableConcept.coding insert obligationClient (1, SHALL:process)

Invariant: gpccmp-alcoholusestatus-01
Description: "At least value or data absent reason shall be present"
* severity = #error
* expression = "dataAbsentReason.exists() or value.exists()"
* xpath = "exists(f:*[starts-with(local-name(.), 'value')]) or exists(f:dataAbsentReason)"

Invariant: gpccmp-alcoholusestatus-02
Description: "Date shall be at least to day or, if not available, the Data Absent Reason extension shall be present"
* severity = #error
* expression = "(($this is dateTime implies $this.toString().length() >= 10) and extension('http://hl7.org/fhir/StructureDefinition/data-absent-reason').value.exists().not()) xor ($this is dateTime implies ($this.hasValue().not() and extension('http://hl7.org/fhir/StructureDefinition/data-absent-reason').value.exists()))"
* xpath = "((self::dateTime and string-length(.) >= 10 and not(extension[@url='http://hl7.org/fhir/StructureDefinition/data-absent-reason'])) xor (self::dateTime and not(.) and extension[@url='http://hl7.org/fhir/StructureDefinition/data-absent-reason']))"

Profile: GPCCMPAlcoholUseStatus
Parent: Observation
Id: GPCCMPAlcoholUseStatus
Title: "GP CCMP Alcohol Use Status"
Description: "This profile sets the minimum expectations for an Observation resource to record and search alcohol use status information when used within the GP Chronic Condition Management Plan."
* . ^short = "Alcohol Use Status"
* . ^definition = "Measurement of a patient's alcohol use status at a point in time."
* obeys gpccmp-alcoholusestatus-01
* status MS
* status insert obligationServer (1, SHALL:populate)
* status insert obligationClient (2, SHALL:process)
* category ^slicing.discriminator[0].type = #value
* category ^slicing.discriminator[=].path = "coding.code"
* category ^slicing.discriminator[+].type = #value
* category ^slicing.discriminator[=].path = "coding.system"
* category ^slicing.ordered = false
* category ^slicing.rules = #open
* category contains socialHistory 1..1 
* category[socialHistory].coding 1..*
* category[socialHistory].coding only Coding
* category[socialHistory].coding.system 1..1
* category[socialHistory].coding.system only uri
* category[socialHistory].coding.system = "http://terminology.hl7.org/CodeSystem/observation-category" (exactly)
* category[socialHistory].coding.code 1..1
* category[socialHistory].coding.code only code
* category[socialHistory].coding.code = #social-history (exactly)
* code MS
* code insert obligationServer (0, SHALL:populate)
* code ^short = "Alcohol Use Status"
* code ^definition = "Alcohol Use Status."
* code.coding
* code.coding ^slicing.discriminator[0].type = #value
* code.coding ^slicing.discriminator[=].path = "code"
* code.coding ^slicing.discriminator[+].type = #value
* code.coding ^slicing.discriminator[=].path = "system"
* code.coding ^slicing.ordered = false
* code.coding ^slicing.rules = #open
* code.coding contains snomedAlcoholUseStatusCode 1..1 MS
* code.coding[snomedAlcoholUseStatusCode] insert obligationServer (0, SHALL:populate)
* code.coding[snomedAlcoholUseStatusCode].system 1..1
* code.coding[snomedAlcoholUseStatusCode].system = "http://snomed.info/sct" (exactly)
* code.coding[snomedAlcoholUseStatusCode].code 1..1
* code.coding[snomedAlcoholUseStatusCode].code = #897148007 (exactly)
* subject 1.. MS
* subject only Reference($au-core-patient)
* subject insert obligationServer (0, SHALL:populate)
* effective[x] 1..
* effective[x] only dateTime
* effective[x] obeys gpccmp-alcoholusestatus-02
* effective[x] ^short = "Date, and optionally time, the observation was performed"
* effective[x] ^definition = "Date, and optionally time, the observation was performed."
* effective[x] ^condition = "gpccmp-alcoholusestatus-02"
* effective[x] MS
* effective[x] insert obligationServer (0, SHALL:populate-if-known)
* effective[x] insert obligationClient (1, SHALL:process)
* effectiveDateTime MS
* effectiveDateTime insert obligationServer (0, SHALL:populate)
* effectiveDateTime insert obligationClient (1, SHALL:process)
* value[x] only CodeableConcept
* value[x] from https://healthterminologies.gov.au/fhir/ValueSet/alcohol-intake-status-1 (extensible)
* value[x] ^condition = "gpccmp-alcoholusestatus-01"
* value[x] MS
* value[x] insert obligationServer (0, SHALL:populate-if-known)
* value[x] insert obligationClient (1, SHALL:process)
* valueCodeableConcept.coding MS
* valueCodeableConcept.coding insert obligationServer (0, SHALL:populate-if-known)
* valueCodeableConcept.coding insert obligationClient (1, SHALL:process)
* dataAbsentReason ^condition = "gpccmp-alcoholusestatus-01"