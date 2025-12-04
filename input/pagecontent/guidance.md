### General Guidance

This page provides guidance on implementing the GP Chronic Condition Management Plan profiles.

### Care Plan Structure

A GPCCMP CarePlan represents a chronic condition management plan created by a general practitioner for a patient. The care plan:

1. **Must have** a status indicating the current state of the plan
2. **Must have** a category indicating it is a chronic disease management plan
3. **Must have** a title providing a human-readable name
4. **Should have** a description summarising the plan
5. **Must reference** the patient who is the subject of the plan
6. **Should reference** the conditions being addressed
7. **Should include** goals for the patient's health outcomes
8. **May include** specific activities or interventions

### Goal Setting

Goals within a GPCCMP represent specific health outcomes the patient and care team are working towards. Goals:

1. **Must have** a lifecycle status
2. **Must have** a description of the goal
3. **Must reference** the patient who is the subject of the goal
4. **Should have** target measures and due dates where appropriate
5. **May reference** the conditions the goal addresses

### Care Team

The care team involved in managing a patient's chronic conditions may include:
- General practitioners
- Practice nurses
- Allied health professionals
- Specialists

### Review and Updates

Chronic condition management plans should be reviewed regularly (e.g., annually) and updated as needed based on:
- Changes in the patient's condition
- Achievement of goals
- Changes in treatment recommendations
- Patient preferences

### Australian Context

This implementation guide is designed for use in the Australian healthcare context and aligns with:
- Medicare Benefits Schedule (MBS) items for chronic disease management
- Australian health data standards
- Australian Core Data for Interoperability (AUCDI) requirements
