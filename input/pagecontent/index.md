### Introduction

The GP Chronic Condition Management Plan (GPCCMP) Implementation Guide is provided to support the use of HL7<sup>&reg;</sup> FHIR<sup>&reg;&copy;</sup> for documenting and exchanging chronic condition management plans in an Australian general practice context.

GPCCMP defines the data model and structure for representing chronic condition management plans, including:
- Care plans for chronic conditions
- Treatment goals and targets
- Activities and interventions
- Care team members involved in management

### Project Background

This implementation guide is developed by the Australian e-Health Research Centre (AEHRC) to support the standardised exchange of chronic condition management plan information in Australian healthcare.

Chronic condition management plans are a key component of primary care in Australia, supporting the coordinated management of conditions such as:
- Diabetes
- Cardiovascular disease
- Chronic respiratory conditions
- Mental health conditions
- Musculoskeletal conditions

### Scope

This implementation guide defines profiles for:

#### In-Scope
- CarePlan resources for documenting chronic condition management plans
- Goal resources for documenting treatment goals
- References to Condition resources for the conditions being managed
- References to Practitioner and Organization resources for care team members

#### Out of Scope
- Detailed clinical decision support rules
- Billing and claiming information
- Appointment scheduling

### How To Read This Guide

This guide is divided into several pages which are listed at the top of each page in the menu bar.

- [Home](index.html): This page provides the introduction and scope for this guide.
- [Guidance](guidance.html): This page provides guidance on using the profiles defined in this guide.
- [Profiles and Extensions](profiles-and-extensions.html): This page lists the profiles and extensions defined in this guide.
- [Terminology](terminology.html): This page lists the value sets and code systems used in this guide.
- [Downloads](downloads.html): This page provides links to downloadable artefacts.
- [Change Log](changes.html): This page documents the changes across versions of this guide.

### Dependencies

This implementation guide builds on FHIR R4 (4.0.1).

### Collaboration

This guide is the product of work undertaken by AEHRC. Feedback and contributions are welcome.

Primary Editors: AEHRC
