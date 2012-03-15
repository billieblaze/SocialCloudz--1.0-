<cfsetting enablecfoutputonly="Yes">

<cfparam name="URL.cmsfile">
<cfparam name="URL.instanceId">

<cfif NOT StructKeyExists( URL, "ref" )>
	<cfabort>
</cfif>

<!--- Security --->
<cfif NOT Find( "actions/act_save.cfm", URL.cmsfile ) AND ( Find( "/", URL.cmsfile ) OR Find( "\", URL.cmsfile ) OR Find( "..", URL.cmsfile ) )>
	<cfoutput>aborted</cfoutput>
	<cfabort>
</cfif>

<cfmodule template="serializeAttributes.cfm" method="load" uid="#URL.ref#">
<cfset attributes.datasource = 'community'>

<cfinclude template="install/includes/inc_getDBType.cfm">

<cfset thisFilePath = replace( getCurrentTemplatePath(), "\", "/", "ALL" )>
<cfset thisFile = ListLast( thisFilePath, "/" )>
<cfset thisFolder = ListGetAt( thisFilePath, ListLen( thisFilePath, "/" )-1, "/" )>
<cfset thisFolderPath = Left( thisFilePath, Len( thisFilePath )- ( Len( thisFile ) ) )>

<cfset REQUEST.dcComComponentFilePath = GetDirectoryFromPath( GetCurrentTemplatePath() )>
<cfset REQUEST.dcComComponentURLPath = "dccom/components/twform/">
<cfset REQUEST.dcComComponent = 'twform'>

<cfinclude template="Plugin_TeamworkCMS/CMSPages/#URL.cmsfile#">

<cfsetting enablecfoutputonly="No">