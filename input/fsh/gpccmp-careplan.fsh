Profile: GPCCMPCarePlan
Parent: CarePlan
Id: gpccmp-careplan
Title: "GPCCMP CarePlan"
Description: "A CarePlan profile for documenting a General Practitioner Chronic Condition Management Plan in an Australian healthcare setting."

* ^version = "0.1.0"
* ^status = #draft
* ^date = "2024-01-01"
* ^publisher = "AEHRC"

// Require status and intent
* status 1..1 MS
* status from http://hl7.org/fhir/ValueSet/request-status (required)
* status ^short = "draft | active | on-hold | revoked | completed | entered-in-error | unknown"

* intent 1..1 MS
* intent = #plan
* intent ^short = "plan"

// Category for chronic condition management
* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains chronicConditionManagement 1..1
* category[chronicConditionManagement] = $SCT#710993005 "Chronic disease management plan"
* category[chronicConditionManagement] ^short = "Chronic disease management plan"

// Title is required
* title 1..1 MS
* title ^short = "Human-friendly name for the care plan"

// Description is recommended
* description MS
* description ^short = "Summary of nature of plan"

// Subject must be a patient
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Who the care plan is for"

// Author/contributor
* author MS
* author only Reference(Practitioner or PractitionerRole or Organization)
* author ^short = "Who is the designated responsible party"

// Encounter context
* encounter MS
* encounter ^short = "Created in context of this encounter"

// Period of plan
* period MS
* period.start MS
* period.start ^short = "Start date of the care plan"
* period.end MS
* period.end ^short = "End date of the care plan"

// Created date
* created MS
* created ^short = "Date record was first recorded"

// Addresses - conditions being managed
* addresses MS
* addresses only Reference(Condition)
* addresses ^short = "Chronic conditions being managed"

// Goals
* goal MS
* goal only Reference(Goal)
* goal ^short = "Health goals for the plan"

// Activities within the plan
* activity MS
* activity.detail MS
* activity.detail.status MS
* activity.detail.description MS
* activity.detail.scheduledTiming MS
* activity.detail.scheduledPeriod MS
* activity.detail.performer MS

// Care team
* careTeam MS
* careTeam ^short = "Who's involved in plan"

// Notes
* note MS
* note ^short = "Comments about the plan"
