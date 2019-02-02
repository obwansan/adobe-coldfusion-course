<!--- Form data (parameters?) is posted to this actionPage.cfm. It must be assigned to / available on
      a cf form object (struct) because each input element 'name' attribute is available as a property 
      on the form struct. For checkboxes, the value attribute is posted if the checkbox is checked.
      If not checked, and a default value is set, the default value is posted. --->

<cfparam name="form.fld_conditions" default="NO" >
<cfparam name="form.fld_interests" default="none" >

<cfdump var="#form#" >