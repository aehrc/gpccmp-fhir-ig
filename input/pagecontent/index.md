### Introduction
This guide is provided to support the implementation of the FHIR GP Chronic Condition Management Plan (CCMP) form. 
CCMPs help eligible health professionals coordinate health care for patients with chronic or terminal medical conditions ([Services Australia](https://www.servicesaustralia.gov.au/gp-chronic-condition-management-plan)).

### Design Principles

The FHIR GP CCMP is represented as a Questionnaire resource and its technical design and function are guided by the [Structured Data Capture specification](http://build.fhir.org/ig/HL7/sdc/index.html). The data exchange requirements have been designed to align with [AU Core](https://build.fhir.org/ig/hl7au/au-fhir-core/index.html) to the greatest extent possible. AU Core describes a requester/responder paradigm of data access. Data exchange requirements described in this guide have significant overlap and derives much of its content from AU Core. The exchange of QuestionnaireResponse resources is in addition to those requirements.

The form content has been informed by requirements gathered from the [Sparked Chronic Condition Management Clinical Focus Group](https://sparked.csiro.au/index.php/ccm-cfg/). The key principles for this release are as follows: *Insert principles*

### Scope
The scope of this implementation guide includes the data exchange requirements to populate the form with existing data from a patient record and managing the completion of the form.

It **does not** include guidance on implementing the [Structured Data Capture specification](http://build.fhir.org/ig/HL7/sdc/index.html) and supporting specific form behaviour.

### Actors

It is expected the GP CCMP will be available for use within the context of a patient management system. The following actors have been included to reflect this expectation:

1. CCMP Server
   The CCMP Server supports:
   * retrieval and provision of patient health information for the purposes of prepopulating the form
   * retrieval and storage of completed or partially completed forms.
1. CCMP Client
   The CCMP Client supports:
   * requesting and processing of patient health information for the purposes of prepopulating the form
   * requesting and production of completed or partially completed forms.

<img alt="Actors Overview" src="ActorsOverview.png" style="width:100%; max-width:700px; float:none"/>

### Dependencies

{% include dependency-table.xhtml %}
{% include expansion-params.xhtml %}

This guide is also dependent on:
- Terminology published in Australia's [National Clinical Terminology Service](https://www.healthterminologies.gov.au/access-clinical-terminology/access-fhir-terminology-resources/)

### Usage

This document is a working specification that may be directly implemented by FHIR<sup>&reg;&copy;</sup> system producers.

FHIR<sup>&reg;&copy;</sup> connectathon events are key to the verification of the guide as being suitable for 
implementation. This implementation guide will be used as the basis for Australian connectathon events.

### How to read this guide

This guide is divided into several pages which are listed at the top of each page in the menu bar.

- [Home](index.html): This page provides the introduction and scope for this guide.
- Guidance
  - [General Requirements](general-requirements.html): This page documents how CapabilityStatements declare conformance to profiles and their FHIR interactions. It also defines the expectations for mandatory and *Must Support* elements.
- FHIR Artefacts: These pages provide detailed descriptions and formal definitions for all the FHIR artefacts defined in this guide.
  - [Artefact Summary](artifacts.html): This page lists all of the FHIR artefacts defined in this guide.
  - [Questionnaires](questionnaires.html): This page lists all of the Questionnaire resources defined in this guide.
  - [Profiles and Extensions](profiles-and-extensions.html): This page lists all of the StructureDefinition resources defined in this guide.
  - [Capability Statements](capability-statements.html): This page lists all of the CapabilityStatement resources defined in this guide.
  - [Actor Definitions](actor-definitions.html): This page lists all of the ActorDefinition resources defined in this guide.
- [Downloads](downloads.html): This page provides links to downloadable artefacts including the Smart Forms FHIR NPM package.

### Collaboration
This guide is the product of collaborative work undertaken with participants from:

* [Sparked Chronic Condition Management Clinical Focus Group](https://sparked.csiro.au/index.php/ccm-cfg/)
* Australian FHIR Implementers Community