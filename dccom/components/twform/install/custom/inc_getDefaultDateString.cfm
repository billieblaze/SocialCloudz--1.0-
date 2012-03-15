<cfsetting enablecfoutputonly="Yes">
<cfif NOT StructKeyExists( ATTRIBUTES, "dbtype" )>
	<cfinclude template="../includes/inc_getDBType.cfm">
</cfif>
<cfswitch expression="#ATTRIBUTES.dbtype#">
	
	<cfcase value="MSSQL">
		<cfset REQUEST.defaultDateString = "getdate()">
	</cfcase>

	<cfcase value="ORACLE">
		<cfset REQUEST.defaultDateString = "(SELECT currdate FROM dual)">
	</cfcase>

	<cfdefaultcase>
		<cfset REQUEST.defaultDateString = "now()">
	</cfdefaultcase>

</cfswitch>
<cfsetting enablecfoutputonly="No">