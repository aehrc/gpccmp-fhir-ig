Profile: GPCCMPGoal
Parent: Goal
Id: gpccmp-goal
Title: "GPCCMP Goal"
Description: "A Goal profile for documenting health goals within a General Practitioner Chronic Condition Management Plan."

* ^version = "0.1.0"
* ^status = #draft
* ^date = "2024-01-01"
* ^publisher = "AEHRC"

// Lifecycle status
* lifecycleStatus 1..1 MS
* lifecycleStatus from http://hl7.org/fhir/ValueSet/goal-status (required)
* lifecycleStatus ^short = "proposed | planned | accepted | active | on-hold | completed | cancelled | entered-in-error | rejected"

// Category
* category MS
* category ^short = "Category of goal"

// Description is required
* description 1..1 MS
* description ^short = "Description of the goal"

// Subject must be a patient
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "Who the goal is for"

// Start date
* start[x] MS
* start[x] ^short = "When goal pursuit begins"

// Target
* target MS
* target.measure MS
* target.measure ^short = "The parameter being measured"
* target.detail[x] MS
* target.detail[x] ^short = "The target value to achieve"
* target.due[x] MS
* target.due[x] ^short = "Target date for achievement"

// Addresses - conditions this goal relates to
* addresses MS
* addresses only Reference(Condition)
* addresses ^short = "Issues this goal addresses"

// Notes
* note MS
* note ^short = "Comments about the goal"

// Expressed by
* expressedBy MS
* expressedBy only Reference(Patient or Practitioner or PractitionerRole)
* expressedBy ^short = "Who established the goal"
