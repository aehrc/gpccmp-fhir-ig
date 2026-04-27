Instance: GPCCMPClient
InstanceOf: ActorDefinition
Usage: #definition
Description: "The GP CCMP Client is a system that can display the GPCCPM form, prepopulate it with patient health information retrieved from the GP CCMP Server, allow a user to fill out the form and save the form to the GP CCMP Server."

* name = "GPCCMPClient"
* title = "GP CCMP Client"
* status = #draft
* experimental = false
* type = #system
* documentation = """The GP CCMP Client: 
- **SHALL** invoke read Patient request
- **SHALL** invoke read Practitioner request
- **SHALL** invoke read PractitionerRole request
- **MAY** invoke read Encounter request
- **SHALL** invoke search QuestionnaireResponse request
- **SHALL** invoke read QuestionnaireResponse request
- **SHALL** invoke create and update QuestionnaireResponse request
- **SHALL** invoke search and read requests for resources required by this IG to pre-populate questionnaire response
"""
* capabilities = Canonical(GPCCMPClientCapabilityStatement)
* derivedFrom = "http://hl7.org.au/fhir/core/ActorDefinition/au-core-actor-requester"

Instance: GPCCMPServer
InstanceOf: ActorDefinition
Usage: #definition
Description: "The GP CCMP Server allows the GP CCMP Client to retrieve patient health information and writeback completed or partially completed forms."
* name = "GPCCMPServer"
* title = "GP CCMP Server"
* status = #draft
* experimental = false
* type = #system
* documentation = """The GP CCMP Server: 
- **SHALL** respond to read Patient request
- **SHALL** respond to read Practitioner request
- **SHALL** respond to read PractitionerRole request
- **MAY** respond to read Encounter request
- **SHALL** respond to search QuestionnaireResponse request
- **SHALL** respond to read QuestionnaireResponse request
- **SHALL** respond to create and update QuestionnaireResponse requests
- **SHALL** respond to search and read requests for resources required by this IG
"""
* capabilities = Canonical(GPCCMPServerCapabilityStatement)
* derivedFrom = "http://hl7.org.au/fhir/core/ActorDefinition/au-core-actor-responder"