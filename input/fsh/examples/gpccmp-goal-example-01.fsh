Instance: gpccmp-goal-example-01
InstanceOf: GPCCMPGoal
Title: "GPCCMP Goal Example - HbA1c Target"
Description: "An example of a treatment goal for HbA1c control in a diabetes management plan."
Usage: #example

* lifecycleStatus = #active
* description.text = "Achieve HbA1c level of 7.0% or below"
* subject = Reference(Patient/example-patient)
* subject.display = "John Smith"
* startDate = "2024-01-15"
* target.measure = $LNC#4548-4 "Hemoglobin A1c/Hemoglobin.total in Blood"
* target.detailQuantity.value = 7.0
* target.detailQuantity.unit = "%"
* target.detailQuantity.system = "http://unitsofmeasure.org"
* target.detailQuantity.code = #%
* target.dueDate = "2024-07-15"
* expressedBy = Reference(Practitioner/example-gp)
* expressedBy.display = "Dr Jane Wilson"
* note.text = "Initial HbA1c was 8.2%. Target is to reduce to 7.0% within 6 months through medication and lifestyle changes."
