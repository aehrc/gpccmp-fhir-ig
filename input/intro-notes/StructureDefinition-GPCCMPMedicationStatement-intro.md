### Usage Scenarios
The following are supported usage scenarios for this profile:
* Search for a patient's medication use statements for the purposes of prepopulating the GP Chronic Condition Management Plan form
* Record a patient's medication use in the GP Chronic Condition Management Plan form.

### Profile Specific Implementation Guidance

MedicationStatement resources can include medication detail as:
1. `MedicationStatement.medicationCodeableConcept`
1. `MedicationStatement.medicationReference` with a reference to a [GP CCMP Medication](StructureDefinition-GPCCMPMedication.html) resource using a [contained]({{site.data.fhir.path}}references.html#contained) resource
1. `MedicationStatement.medicationReference` with a reference to a [GP CCMP Medication](StructureDefinition-GPCCMPMedication.html) resource using an external resource

For prepopulation, a [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** respond to search requests made by a [GP CCMP Client](ActorDefinition-GPCCMPClient.html) by providing any one of the three variations listed. The GP CCMP Client **SHALL** be able to process all variants. Obligations describing this are included in the profile and can be seen as:
- AU Core Responder [SHALL:populate-if-known](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHALL.58populate-if-known) on both `MedicationStatement.medicationCodeableConcept` and `MedicationStatement.medicationReference` as inherited from the AU Core profile.
- GP CCMP Client [SHALL:process](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHALL.58process) on both `MedicationStatement.medicationCodeableConcept` and `MedicationStatement.medicationReference`.