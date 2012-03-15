
	<cfif request.session.memberID IS 0>
		<cfoutput><pre>Session Timeout, please log in again</pre></cfoutput>
		<cfabort>
	</cfif>

<cfquery name="getFormInfo" datasource="#attributes.datasource#">
SELECT	formTitle, formCreationDate, formCreatedByUserId, formLastUpdatedDate, formLastUpdatedByUserId, formDesignWDDX
FROM	dccom_twform_forms
WHERE	instanceId = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#URL.instanceId#">
</cfquery>
<cfif getFormInfo.recordCount IS 0>
<cfinclude template="../../install/custom/inc_createdefaultform.cfm">
</cfif>

<cfset twformwizardFolder = "twForm">
	
<cfsetting enablecfoutputonly="No">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head><title>Form Wizard</title>

<cfset NEWLINE = chr(13) & chr(10)>
<cfdirectory action="LIST" directory="#GetDirectoryFromPath( GetCurrentTemplatePath() )#../../interfaces/" name="interfaces">
<script>
var interfaces = {};
<cfif Len( getFormInfo.formDesignWDDX )>
	<cfwddx action="WDDX2JS" input="#getFormInfo.formDesignWDDX#" TOPLEVELVARIABLE="data">
var formInfo = data["forminfo"];
var formItems = data["formitems"];
<cfelse>
var formInfo = {};
var formItems = {};

</cfif>

var instanceId = <cfoutput>#URL.instanceId#</cfoutput>;
<cfif StructKeyExists( URL, "ref" )>var ref = "<cfoutput>#URL.ref#</cfoutput>";</cfif>
var componentURL = "<cfif NOT isdefined("ATTRIBUTES") OR NOT StructKeyExists( ATTRIBUTES, "RelSharedPath" )><cfoutput>#JSStringFormat(  "/dcCom/components/" & twformwizardFolder & "/" )#</cfoutput></cfif>";
var PluginPageLoaderURL = "<cfif NOT isdefined("ATTRIBUTES") OR NOT StructKeyExists( ATTRIBUTES, "RelSharedPath" )><cfoutput></cfoutput></cfif>";
</script>
<cfsetting enablecfoutputonly="Yes">
<cfloop query="interfaces">
	<cfif Left( Name, 1 ) NEQ "." AND Type EQ "Dir">
		<cfoutput><script src="interfaces/#Name#/interface.js" type="text/javascript"></script></cfoutput>
	</cfif>
</cfloop>
<cfsetting enablecfoutputonly="No">
<script src="js/uuid.js" type="text/javascript"></script>
<script src="js/prototype.js" type="text/javascript"></script>
<script src="js/scriptaculous/scriptaculous.js" type="text/javascript"></script>
<script src="js/tabpane.js" type="text/javascript"></script>
<script src="js/formWizard.js" type="text/javascript"></script>
<script src="js/cfListFunctions.js" type="text/javascript"></script>
<script src="js/wddx.js" type="text/javascript"></script>
<link type="text/css" rel="stylesheet" href="tabcss/luna/tab.css" />
<link rel="STYLESHEET" type="text/css" href="Plugin_TeamworkCMS/CMSPages/formwizard.css">
<link rel="STYLESHEET" type="text/css" href="styles/default/style.css">
</head><body id="mainBody">
<div class="tab-pane" id="side">

	<script type="text/javascript">
	var formWizTabs = new WebFXTabPane( document.getElementById( "side" ) );
	</script>

	<div class="tab-page" id="formWizAddField"><h2 class="tab">Add Field</h2><script type="text/javascript">formWizTabs.addTabPage( document.getElementById( "formWizAddField" ) );</script>
		<cfinclude template="includes/inc_tab_addAField.cfm">
	</div>
	
	<div class="tab-page" id="formWizFieldProps"><h2 class="tab">Field</h2><script type="text/javascript">formWizTabs.addTabPage( document.getElementById( "formWizFieldProps" ) );</script>
		<cfinclude template="includes/inc_tab_fieldProps.cfm">
	</div>
	
	<div class="tab-page" id="formWizFormProps"><h2 class="tab">Form</h2><script type="text/javascript">formWizTabs.addTabPage( document.getElementById( "formWizFormProps" ) );</script>
		<cfinclude template="includes/inc_tab_formProps.cfm">
	</div>
	
</div>

<div id="formWizPreview">
	<cfinclude template="includes/inc_tab_formPreview.cfm">
</div>

<div id="editArrow"></div>

<div id="addDeleteButtons">
	<a href="javascript:duplicate()" title="Duplicate"><img src="images/icons/add.png" width="16" height="16" alt="Duplicate" border="0"></a>
	<a href="javascript:removeItem()" title="Delete"><img src="images/icons/delete.png" width="16" height="16" alt="Delete" border="0"></a>
</div>

<div id="saveMessage" style="display:none">
	<h3 id="saveMessageH3">Saving Form</h3>
	<div>Please wait, your form is being compiled and saved.</div>
</div>

<div id="alertMessage" style="display:none">
	<input id="alertBut" type="button" style="padding:10px;" value="OK" onclick="closeAlertMessage()">
	<h3 id="alertMessageH3">Error</h3>
	<div id="alertMessageTxt">lorem ipsum</div>
</div>

<div id="overlay" style="display:none"></div>

</body></html>