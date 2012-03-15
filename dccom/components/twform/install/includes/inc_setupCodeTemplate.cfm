<!--- Only do this, if the inc_codeTemplate file exists --->
<cfif FileExists( thisFilePath & "../custom/inc_codeTemplate.cfm" )>

	<cfif NOT StructKeyExists( APPLICATION, "siteFilePath" )><cfexit method="EXITTEMPLATE"></cfif>

	<cfset dest = APPLICATION.siteFilePath & "pages/plugins/page/">
	<cfset pluginFileName = "pagePlugin_" & ATTRIBUTES.instanceName & "_" & ATTRIBUTES.component & ".cfm">
	
	<!--- Only create the plugin file if it's not already there --->
	<cfif NOT fileExists( dest & pluginFileName )>
	
		<!--- Create the directory path if needed --->
		<cfif NOT DirectoryExists( dest )>
			<cfdirectory action="CREATE" directory="#dest#">
		</cfif>

		<!--- Read the template file --->
		<cffile action="READ" file="#thisFilePath#../custom/inc_codeTemplate.cfm" variable="template">

		<!--- Replace [componentName] in template --->
		<cfset template = replaceNoCase( template, "[componentName]", ATTRIBUTES.component, "ALL" )>

		<!--- Replace [instanceName] in template --->
		<cfset template = replaceNoCase( template, "[instanceName]", ATTRIBUTES.instanceName, "ALL" )>
		
		<!--- Replace [dbtype] in template --->
		<cfset template = replaceNoCase( template, "[dbtype]", APPLICATION.db_type, "ALL" )>

		<!--- write the file out --->	
		<cffile action="WRITE" file="#dest##pluginFileName#" output="#template#" addnewline="No">
	
	</cfif>
	
	<!--- dccom.cfm may need to be copied into the includes folder --->
	<cfif NOT FileExists( dest & "dccom.cfm" )>
		<cffile action="COPY" source="#APPLICATION.siteFilePath#SiteEngine/includes/dccom.cfm" destination="#APPLICATION.siteFilePath#pages/plugins/page/dccom.cfm">
	</cfif>

</cfif>