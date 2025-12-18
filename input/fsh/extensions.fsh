/*
Extension: QuestionnaireItemTextHidden
Id: QuestionnaireItemTextHidden
Title: "Questionnaire Item Text Hidden"
Description: "This custom extension is used to indicate that the text of a Questionnaire item should be hidden in the user interface. This is useful for items where the text is not intended to be displayed to the user but is still needed for other processes."
Context: Questionnaire.item.text

* ^url = https://smartforms.csiro.au/ig/StructureDefinition/QuestionnaireItemTextHidden
* . 0..1
* . ^short = "Don't display text to user"
* . ^definition = "If true, indicates that the text of an item should not be displayed to the user."
* value[x] 1..
* value[x] only boolean

Extension: GroupHideAddItemButton
Id: GroupHideAddItemButton
Title: "Group Hide Add Item Button"
Description: "This custom extension is used to hide the UI component that allows a user to add new items for repeating groups in a Questionnaire. This is useful for preventing users from adding additional groups when it is not appropriate to do so, such as when a group is intended to be prepopulated with existing data but no new ones added by the user."
Context: Questionnaire.item

* ^url = https://smartforms.csiro.au/ig/StructureDefinition/GroupHideAddItemButton
* ^contextInvariant = "type='group' and repeats=true"
* . 0..1
* . ^short = "Group hide add item button"
* . ^definition = "If true, the UI component that allows a user to add new items will be hidden."
* value[x] 1..
* value[x] only boolean
*/