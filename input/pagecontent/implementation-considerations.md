This page provides guidance on implementation considerations for systems implementing the GP CCMP actors. The guidance is intended to help implementers understand the clinical workflow and technical design decisions that may arise when building a GP CCMP solution.

### Workflow Considerations

A GP CCMP progresses through a defined lifecycle, represented by the `status` field of the [GP CCMP QuestionnaireResponse](StructureDefinition-GPCCMPQuestionnaireResponse.html). The status values are the same as those in the [QuestionnaireResponseStatus value set]({{site.data.fhir.path}}valueset-questionnaire-answers-status.html) bound to [QuestionnaireResponse.status]({{site.data.fhir.path}}questionnaireresponse-definitions.html#QuestionnaireResponse.status). The following additional guidance is provided for the GP CCMP:

- **In Progress** (`in-progress`): The form has been started but not yet finalised. A [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHOULD** support saving a partially completed form so that it can be resumed within or across sessions.
- **Completed** (`completed`): The form has been finalised. A [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** support transitioning a form from `in-progress` to `completed` and saving it via the [GP CCMP Server](ActorDefinition-GPCCMPServer.html).
- **Amended** (`amended`): A previously completed or amended form that has been reopened and modified. A [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHOULD** support amending a completed or previously amended form. When a user saves changes to a `completed` QuestionnaireResponse, the status **SHALL** transition to `amended`. Subsequent edits to an `amended` QuestionnaireResponse **SHALL** retain the `amended` status.
- **Stopped** (`stopped`): The form has been partially filled out with answers but has been abandoned. It is unknown whether changes or additions are expected to be made to it. A [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **MAY** support transitioning a form from `in-progress` to `stopped`. The form **MAY** be re-started and transition back to `in-progress`.
- **Entered in Error** (`entered-in-error`): The form was created in error and should be disregarded. A [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **MAY** support transitioning a form to `entered-in-error` from any status.

The following diagram illustrates how these states may be applied to the GP CCMP QuestionnaireResponse lifecycle:

<div><img alt="GP CCMP QuestionnaireResponse lifecycle" src="GPCCMPStateMachine.png" style="max-width:50%; height:auto; padding:20px;"/></div>

#### GP CCMP Review

After completing an initial GP CCMP, a **review** may be undertaken. A **review** of a GP CCMP is a distinct clinical event from an amendment. A review occurs in the context of a follow-up encounter and results in a new `QuestionnaireResponse` resource — it does not modify the previously completed or amended form.

To support clinical efficiency, a [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHOULD** support cloning a previously completed or amended form, allowing the clinician to use the prior plan's content as a starting point for completing the review. Implementers **SHOULD** clone the answer values from the source `QuestionnaireResponse`. Resource-management elements such as `id`, `meta`, and `authored` **SHALL NOT** be copied, as these are generated for the new response instance.

Cloning a form will disrupt the standard prepopulation flow, as the answers in the cloned form may differ from what the current patient record contains. To address this, a [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHOULD** provide a mechanism for the user to perform **re-population** — selectively updating form fields based on a comparison between the current patient record and the cloned form content — allowing the user to decide which values to accept from the patient record.

### Printable Copy

A [GP CCMP Client](ActorDefinition-GPCCMPClient.html) **SHALL** support the generation of a human-readable, printable representation of a completed GP CCMP for the purpose of providing the patient with a copy of their plan. Implementers **SHALL** ensure the printable copy reflects the content of the finalised `QuestionnaireResponse` and includes relevant patient and practitioner identifying information.
