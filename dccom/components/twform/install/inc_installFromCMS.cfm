<cfparam name="REQUEST.instanceId">

<!--- Set-up the code-template, database - create tables and insert sample data --->
<cfinclude template="includes/inc_setupDatabase.cfm">
<cfinclude template="includes/inc_setupCodeTemplate.cfm">
<!--- Process the optional include file "extrastep.cfm" --->
<cfif FileExists( GetDirectoryFromPath( GetCurrentTemplatePath() ) & "custom/inc_extrastep.cfm" )>
	<cfinclude template="custom/inc_extrastep.cfm">
</cfif>