<cfif ThisTag.ExecutionMode NEQ "End"><cfexit method="EXITTEMPLATE"></cfif>
<cfsetting enablecfoutputonly="Yes">

<cfparam name="REQUEST.twFormCount" default="0">
<cfset REQUEST.twFormCount = REQUEST.twFormCount + 1>

<cfif isdefined("APPLICATION.siteEngine")>
	<cfparam name="ATTRIBUTES.thisPageURL" default="#APPLICATION.siteengine.GetCurrentURL()#">
</cfif>
<cfif NOT StructKeyExists( ATTRIBUTES, "thisPageURL" )>
	<cfif NOT StructKeyExists( REQUEST, "GetCurrentURL" )>
		<cfinclude template="udf_GetCurrentURL.cfm">
	</cfif>
	<cfset ATTRIBUTES.thisPageURL = REQUEST.GetCurrentURL()>
</cfif>

<cfif NOT Find("?",ATTRIBUTES.thisPageUrl)>
	<cfset ATTRIBUTES.thisPageURL = ATTRIBUTES.thisPageURL & "?">
<cfelse>
	<cfset ATTRIBUTES.thisPageURL = ATTRIBUTES.thisPageURL & "&">
</cfif>


<cfset ATTRIBUTES.datasource = 'community'>

<!--- Ensure instanceName ATTRIBUTES was passed --->
<cfif NOT StructKeyExists( ATTRIBUTES, "instanceName" )>
	<cfmodule template="showErrMessage.cfm" title="Missing Parameter 'InstanceName'" message="For <strong>TWForm Add-On</strong> to work, you'll need to pass in attribute <strong>instanceName</strong>.<br/>The instance name is just a useful name for this form - it also allows you to place the same for in multiple places on your website.">
</cfif>

<!--- Edit mode is on by default - should be turned off when finish --->
<cftry>
	<cfparam name="ATTRIBUTES.edit" default="no" type="boolean">
	<cfcatch type="Any">
		<cfmodule template="showErrMessage.cfm" title="Incorrect Parameter 'edit'" message="Attribute <strong>edit</strong> should be either <em>yes</em> or <em>no</em>.">
	</cfcatch>
</cftry>

<!--- START: License checking --->
<!--- Now with a version number --->
<cfparam name="ATTRIBUTES.version" default="1.2">
<cfparam name="ATTRIBUTES.releaseDate" default="#CreateDate(2009,02,01)#"><!--- y/m/dd --->
<cfinclude template="install/inc_installFromSite.cfm">

<cfif StructKeyExists( REQUEST, "pagePlugUsedInstanceIdList" )>
	<cfif NOT ListFind( REQUEST.pagePlugUsedInstanceIdList, REQUEST.instanceId )>
		<cfset REQUEST.pagePlugUsedInstanceIdList = ListAppend( REQUEST.pagePlugUsedInstanceIdList, REQUEST.instanceId )>
	</cfif>
<cfelse>
	<cfset REQUEST.pagePlugUsedInstanceIdList = REQUEST.instanceId>
</cfif>

<cfset ATTRIBUTES.RelSharedPath = RelSharedPath>

<cfinclude template="inc_renderForm.cfm">
	
<cfsetting enablecfoutputonly="No">