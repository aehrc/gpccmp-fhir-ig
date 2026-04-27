### General Requirements
Systems compatible with the GP Chronic Condition Management Plan (GPCCMP) are required to support healthcare client and provider information conforming to profiles, AND implement the interaction requirements of relevant actor's capability statements defined in this implementation guide.

The requirements of the FHIR standard and [FHIR Conformance Rules](http://hl7.org/fhir/conformance-rules.html) apply, and define the conformance verbs - **SHALL**, **SHALL NOT**, **SHOULD**, **SHOULD NOT**, **MAY**.

This page documents how CapabilityStatements declare conformance to the GPCCMP profiles and their FHIR interactions. It also defines the expectations for mandatory and *Must Support* elements. 


### Conformance Artifacts
The [Artefacts](artifacts.html) page lists the GPCCMP profiles defined for this implementation guide. Core profile [StructureDefinitions]({{site.data.fhir.path}}structuredefinition.html) define the minimum elements, extensions, vocabularies, and value sets which **SHALL** be present when using the profile. Many profile pages also contain additional guidance.

The profile elements consist of both mandatory and *Must Support* elements. Mandatory elements are elements with a minimum cardinality of 1 (min=1). The base FHIR [*Must Support*]({{site.data.fhir.path}}profiling.html#mustsupport) guidance requires specifications to define the support expected for profile elements labelled *Must Support*. The sections below explain how these elements are displayed and define the rules for interpreting profile elements and sub-elements labelled mandatory and *Must Support* for [GP CCMP Server](ActorDefinition-GPCCMPServer.html) and [GP CCMP Client](ActorDefinition-GPCCMPClient.html).


#### Capability Statements 

The [capability statement](capability-statements.html) page lists the capability statements that are to be supported by systems implementing the GPCCMP actors in this IG. 

### Exchange Format Support

In FHIR, resources are commonly exchanged in multiple formats including JSON and XML. At a minimum JSON **SHALL** be supported. 

### Profile and Interaction Support
The GPCCMP systems support the GPCCMP *profiles* to represent clinical information and the GPCCMP REST API *interactions* to access that information. Therefore, the [GP CCMP Server](ActorDefinition-GPCCMPServer.html) must implement and support GPCCMP profiles AND interactions to be compatible with a [GP CCMP Client](ActorDefinition-GPCCMPClient.html).

#### Profile Support
Profile support refers to the support of the GPCCMP profiles, such that the system exposes FHIR resources that adhere to the GPCCMP profiles' content model. Specifically, a [GP CCMP Server](ActorDefinition-GPCCMPServer.html) with GPCCMP profile support:
* **SHALL** communicate all profile data elements that are mandatory by that profile's StructureDefinition. 

#### Interaction Support
Interaction support refers to a system that supports the GPCCMP REST API interactions. Specifically, a server with GPCCMP Interaction support:
* **SHALL** implement the REST API behavior according to the FHIR specification, including *read*, *search*, *create* and *patch* interactions as required, and the required search parameters as defined in the [GP CCMP Server CapabilityStatement](CapabilityStatement-GPCCMPServerCapabilityStatement.html#resourcesSummary1).
* **SHALL** specify the full capability details from the GP CCMP Server CapabilityStatement it claims to implement, including mandatory support for _FHIR transactions_.

### Must Support and Obligations

In the context of GPCCMP, [Obligations](https://hl7.org/fhir/extensions/CodeSystem-obligation.html) defines how an actor ([GP CCMP Server](ActorDefinition-GPCCMPServer.html) or [GP CCMP Client](ActorDefinition-GPCCMPClient.html)) must “support” a given element. All [*Must Support*]({{site.data.fhir.path}}conformance-rules.html#mustSupport) elements in this IG are accompanied by an explicit obligation, which identifies structured expectations for a given actor. If a *Must Support* element has no obligation for a given actor, that element need not be supported by that actor. 

GPCCMP profiles are derived from AU Core profiles, hence any elements flagged as *Must Support* in AU Core are also *Must Support* in the GPCCMP profiles of this implementation guide. The GP CCMP Server and GP CCMP Client actors are derived from AU Core Responder and AU Core Requester respectively, hence the actor obligations are inherited from AU Core as the default obligations in the GPCCMP profiles. Additional obligations constrain and augment these defaults as required, to support the prepopulation and writeback requirements of each actor in this implementation guide.

The actor obligations of *Must Support* elements are specified in the element description of each GPCCMP profile.

#### Obligation Code Definitions
The Obligation codes are defined in the FHIR Extensions [Obligation Codes ValueSet](https://hl7.org/fhir/extensions/ValueSet-obligation.html). The Obligation codes used within this implementation guide are summarised below, with descriptions of how the data elements are expected to be supported by each actor.

Obligations are specified for each actor in the context of two sets of interactions:
1. data access for prepopulation of the GP CCMP form; and
2. writeback of data (QuestionnaireResponse) to the GP CCMP Server.

The figure below illustrates the relationship between the GPCCMP and AU Core actors, the default *Must Support* Obligations inherited from AU Core actors, and the additional Obligations of each GPCCMP actor specified for the Prepopulation and Writeback interactions.

<div><img alt="Obligations overview.png" src="ObligationsOverview-derivedFrom.png" style="max-width:60%; height:auto; padding:30px;"/></div>

#### Obligations for GP CCMP Server
A [GP CCMP Server](ActorDefinition-GPCCMPServer.html) actor **SHALL** support the data usage expectations specified in the Obligations of the [GP CCMP Server](ActorDefinition-GPCCMPServer.html) actor for each *Must Support* element. 

The [GP CCMP Server](ActorDefinition-GPCCMPServer.html) actor derives from AU Core Responder actor, hence the *Must Support* elements in GPCCMP profiles that are derived from AU Core profiles inherit the default `SHALL:populate-if-known` obligation for data access interactions. This requires the [GP CCMP Server](ActorDefinition-GPCCMPServer.html) to populate an element if that element is available. There are a few potential reasons why a *Must Support* element may not be available, for example:
* a system may not have the capability to collect a data element, therefore is not expected to ever provide a value
* for a particular patient, a value may not be available for a data element, but in some cases a value is provided
* a value is available, but the [GP CCMP Client](ActorDefinition-GPCCMPClient.html) or its user is not authorized to access the data, therefore the value is not provided.

The GPCCMP profiles may specify additional obligations for the [GP CCMP Server](ActorDefinition-GPCCMPServer.html) actor related to data access for prepopulation and writeback interactions. These include:

Code | Interactions | GP CCMP Server Obligations
--- | --- | ---
[SHALL:populate-if-known](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHALL.58populate-if-known) | Prepopulation | Indicates the element **SHALL** be populated where a value is known, it is important for prepopulation, however missing data is allowed.
[SHALL:populate](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHALL.58populate) | Prepopulation | Indicates the element **SHALL** be capable of being populated when a value is known and allowed to be shared. It is required for search queries or prepopulation and hence always populated. 
[SHOULD:populate](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHOULD.58populate) | Prepopulation | Indicates the element **SHOULD** be capable of being populated. It is important for prepopulation, however missing data is allowed. 
[SHALL:persist](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHALL.58persist) | Writeback | Indicates where the element is populated, the value **SHALL** be stored in a persistent store.

#### Obligations for GP CCMP Client
The [GP CCMP Client](ActorDefinition-GPCCMPClient.html) actor **SHALL** support the data usage expectations specified in the Obligations of the [GP CCMP Client](ActorDefinition-GPCCMPClient.html) actor for each *Must Support* data element.  The [GP CCMP Client](ActorDefinition-GPCCMPClient.html) actor derives from the AU Core Requester actor, hence the *Must Support* elements in GPCCMP profiles that are derived from AU Core profiles inherit the default `SHALL:no-error` obligation for data access interactions. This requires the [GP CCMP Client](ActorDefinition-GPCCMPClient.html) actor to accept resources containing any valid value for the element without error, including missing data and data absent reason codes and extensions.

The GPCCMP profiles may specify additional obligations for the [GP CCMP Client](ActorDefinition-GPCCMPClient.html) actor related to data access for prepopulation and writeback interactions, these may include:

Code | Interactions | GP CCMP Client Obligations
--- | --- | ---
[SHALL:process](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHALL.58process) | Prepopulation | Indicates the element **SHALL** be processed as part of prepopulation. 
[SHALL:populate-if-known](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHALL.58populate-if-known) | Writeback | Indicates the element **SHALL** be populated when a value is available, either from prepopulation or user entry.
[SHALL:populate](https://hl7.org/fhir/extensions/CodeSystem-obligation.html#obligation-SHALL.58populate) | Writeback | Indicates the element **SHALL** be populated as a value will always be known and allowed to be shared. 

#### Must Support - Resource References

Some elements labelled as *Must Support* allow references to multiple resource types or profiles (e.g. `MedicationStatement.reasonReference`).  These *Must Support* elements and their actor obligations could be inherited from the base AU Core profile. Since [GP CCMP Server](ActorDefinition-GPCCMPServer.html) and [GP CCMP Client](ActorDefinition-GPCCMPClient.html) are derived from AU Core Responder and AU Core Requester actors respectively: 

* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** populate a known reference value to *at least one* resource type or profile allowed by the element
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** accept with no error *all* resource types or profiles allowed by the element.

Additionally, GPCCMP actor obligations that support writeback can be specified on elements that reference multiple resource types or profiles. In this case: 
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** persist a valid reference for *all* resource types or profiles allowed by the element
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** correctly populate a reference to *at least one* resource type or profile allowed by the element.

As of this version of the GPCCMP IG, there are no GPCCMP profiles with *Must Support* element with writeback obligations that allow multiple resource types or profiles. The writeback obligations guidance above is provided in case a future version of this IG does allow a *Must Support* element with multiple resource types or profiles.

#### Must Support - Choice of Data Types

Some elements labelled as *Must Support* allow values of different data types (e.g., `Condition.onset[x]`). These 'choice elements' can inherit the *Must Support* label and obligations from the base AU Core profile. Since [GP CCMP Server](ActorDefinition-GPCCMPServer.html) and [GP CCMP Client](ActorDefinition-GPCCMPClient.html) are derived from AU Core Responder and AU Core Requester actors respectively, the GPCCMP actor obligations default to their respective AU Core actor obligations and can have additional obligations specific to them. The following guidance describes how these obligations are to be interpreted for various scenarios.

##### Inherited AU Core Obligations
Where a 'choice element' (e.g. `Condition.onset[x]`) has *Must Support* inherited from AU Core, the following conformance requirements apply:
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** populate choice elements using *at least one* data type if a value is known 
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** accept with no error for *all* data types.

For example, when claiming conformance to the [GPCCMP Condition](StructureDefinition-GPCCMPCondition.html):
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** populate a known value using either `Condition.onsetDateTime`, `Condition.onsetAge`, `Condition.onsetPeriod` or `Condition.onsetRange` depending on type of data available
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** accept without error valid data in either `Condition.onsetDateTime`, `Condition.onsetAge`, `Condition.onsetPeriod` or `Condition.onsetRange`.

##### Additional GPCCMP Obligations
###### Prepopulation
GPCCMP actors can have additional obligations applied to 'choice elements' to support prepopulation requirements. 

A 'choice element' with an inherited AU Core *Must Support* can also label a specific data type as *Must Support* with [GP CCMP Server](ActorDefinition-GPCCMPServer.html) obligation of `SHOULD:populate` and [GP CCMP Client](ActorDefinition-GPCCMPClient.html) obligation of `SHALL:process`. In this case, the:
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** populate a known value in the choice element, and **SHOULD** populate the choice element using the *Must Support* data type
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** accept without error all valid data types, and **SHALL** process the choice element using the *Must Support* data type. 

For example, when claiming conformance to the [GPCCMP Condition](StructureDefinition-GPCCMPCondition.html):
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** populate *at least one* of `Condition.onsetDateTime`, `Condition.onsetAge`, `Condition.onsetPeriod` or `Condition.onsetRange` if a value is known, and **SHOULD** populate `Condition.onsetDateTime`
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** accept without error valid data in `Condition.onsetDateTime`, `Condition.onsetAge`, `Condition.onsetPeriod` or `Condition.onsetRange`, and **SHALL** process `Condition.onsetDateTime`.

###### Writeback
AU Core actors do not have obligation requirements related to writeback, therefore the writeback requirements for GPCCMP *Must Support* elements will be specified solely using GPCCMP actor obligations.

The current scope of writeback includes the QuestionnaireReponse resource only. The [GPCCMP Questionnaire Response](StructureDefinition-GPCCMPQuestionnaireResponse.html) does not derive from an AU Core profile (as one does not exist) and hence has no inherited actor obligations. Therefore, this profile's *Must Support* obligation requirements are defined using GPCCMP actors.

There is only one example of a 'choice element' labelled *Must Support* in the [GPCCMP Questionnaire Response](StructureDefinition-GPCCMPQuestionnaireResponse.html): `QuestionnaireResponse.item.answer.value[x]`. This element has prepopulation and writeback requirements without any specific *Must Support* datatype. In this case, the [GP CCMP Server](ActorDefinition-GPCCMPServer.html) obligations of `SHALL:populate-if-known` and `SHALL:persist`, and [GP CCMP Client](ActorDefinition-GPCCMPClient.html) obligations of `SHALL:process` and `SHALL:populate-if-known` are applicable. For choice elements with prepopulation and writeback requirements:  
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** correctly populate a known value for the choice element using *at least one* data type allowed by the element
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** persist a valid value for *all* data types allowed by the element
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** process valid data for *all* data types of the choice element
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** correctly populate a known value for the choice element using *at least one* data type allowed by the element.

When claiming conformance to the [GPCCMP Questionnaire Response](StructureDefinition-GPCCMPQuestionnaireResponse.html):
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** populate a known value using *at least one* of types allowed for `QuestionnaireResponse.item.answer.value[x]`
* [GP CCMP Server](ActorDefinition-GPCCMPServer.html) **SHALL** persist a valid value for *all* data types allowed for `QuestionnaireResponse.item.answer.value[x]`
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** process valid value for *all* data types allowed for `QuestionnaireResponse.item.answer.value[x]`
* [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** populate a known value using *at least one* of types allowed for `QuestionnaireResponse.item.answer.value[x]`.

#### Missing Data
There are situations when information on a particular data element is missing, and the source system does not know the reason for the absence of data.

##### Optional And Must Support Elements
If the [GP CCMP Server](ActorDefinition-GPCCMPServer.html) does not have data for an element with a minimum cardinality = 0 (including elements labelled *Must Support*), the data element **SHALL** be omitted from the resource.

##### Required And Must Support Elements

If the [GP CCMP Server](ActorDefinition-GPCCMPServer.html) does not have data to be included, the reason for the absence has to be specified as follows:

1. For non-coded data elements, use the [DataAbsentReason Extension]({{site.data.fhir.path}}extension-data-absent-reason.html) in the data type.
2. For coded data elements:
     - *example*, *preferred*, or *extensible* binding strengths (CodeableConcept datatypes):
       - if the source systems have text but no coded data, only the text element is used.
       - if there is neither text nor codes representing actual (i.e., non-exceptional) concepts:
         - use the appropriate exceptional concept code from the value set if available
         - use the appropriate concept code from the [DataAbsentReason Value Set]({{site.data.fhir.path}}valueset-data-absent-reason.html) if the value set does not have it.
     - *required* binding strength (CodeableConcept or code datatypes):
       - use the appropriate exceptional concept code from the value set

##### Accepting and Processing Must Support Elements With Missing Data
A [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** be able to accept resource instances containing data elements asserting missing data without error. This is *except* for when the *Must Support* element has an [GP CCMP Client](ActorDefinition-GPCCMPClient.html) obligation of `SHALL:process` and a [GP CCMP Server](ActorDefinition-GPCCMPServer.html) obligation of `SHALL:populate`, where the [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **MAY** report an error due to not being able to perform the prepopulation process.

