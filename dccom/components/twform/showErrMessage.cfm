<cfparam name="ATTRIBUTES.title" default="Error" type="string">
<cfparam name="ATTRIBUTES.message" type="string">
<cfset REQUEST.ATTRIBUTES = ATTRIBUTES>
<cfset ATTRIBUTES = CALLER.ATTRIBUTES>
<cfinclude template="inc_stylesheet.cfm">
<cfset ATTRIBUTES = REQUEST.ATTRIBUTES>

<cfoutput>
<form class="formWizForm formWizFormErrorMsg">
<h3>TW Form Add-On : #ATTRIBUTES.title#</h3>
#ATTRIBUTES.message#
</form>
</cfoutput>
<cfabort>
