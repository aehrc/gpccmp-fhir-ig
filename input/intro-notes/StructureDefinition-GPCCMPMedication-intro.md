### Usage Scenarios
The following are supported usage scenarios for this profile:
* Retrieve and search for medication detail referenced by a patient's medication use statements for the purposes of prepopulating the GP Chronic Condition Management Plan form
* Record a patient's medication detail in the GP Chronic Condition Management Plan form.

### Profile Specific Implementation Guidance

Medication resources **MAY** be used to represent medication detail when referenced from a [GP CCMP MedicationStatement](StructureDefinition-GPCCMPMedicationStatement.html) resource. [GPCCMP Server](ActorDefinition-GPCCMPServer.html) actors that represent medication detail with an external reference to a Medication resource **SHALL** support returning Medication resources in response to a MedicationStatement search with `_include=MedicationStatement:medication`.