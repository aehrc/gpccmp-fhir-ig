Instance: gpccmp-careplan-example-01
InstanceOf: GPCCMPCarePlan
Title: "GPCCMP CarePlan Example - Diabetes Management"
Description: "An example of a chronic condition management plan for a patient with Type 2 Diabetes."
Usage: #example

* status = #active
* intent = #plan
* category[chronicConditionManagement] = $SCT#710993005 "Chronic disease management plan"
* title = "Type 2 Diabetes Management Plan"
* description = "Comprehensive management plan for Type 2 Diabetes including lifestyle modifications, medication management, and regular monitoring."
* subject = Reference(Patient/example-patient)
* subject.display = "John Smith"
* period.start = "2024-01-15"
* period.end = "2025-01-15"
* created = "2024-01-15"
* author = Reference(Practitioner/example-gp)
* author.display = "Dr Jane Wilson"

* goal[0] = Reference(Goal/gpccmp-goal-example-01)
* goal[0].display = "HbA1c target"

* activity[0].detail.status = #scheduled
* activity[0].detail.description = "Regular HbA1c testing every 3 months"
* activity[0].detail.scheduledPeriod.start = "2024-01-15"
* activity[0].detail.scheduledPeriod.end = "2025-01-15"

* activity[1].detail.status = #scheduled
* activity[1].detail.description = "Annual eye examination referral"
* activity[1].detail.scheduledPeriod.start = "2024-06-01"
* activity[1].detail.scheduledPeriod.end = "2024-06-30"

* activity[2].detail.status = #in-progress
* activity[2].detail.description = "Metformin 500mg twice daily"

* note.text = "Patient is motivated to improve diabetes control. Referred to diabetes educator for dietary counselling."
