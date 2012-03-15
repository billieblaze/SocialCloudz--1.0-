<!--- REQUEST.instanceId should be defined at this point --->
<cfset thisFilePath = GetDirectoryFromPath( GetCurrentTemplatePath() )>
<cftry>

	<cfset bFlagInsertedTestData = false>
	<cfif REQUEST.bFlagIsNewInstance>
		<!--- Insert Some Test Data --->
		<cfif FileExists( thisFilePath & "../custom/inc_insertSampleData.cfm" )>
			<cfinclude template="../custom/inc_insertSampleData.cfm">
		</cfif>
		<cfset bFlagInsertedTestData = true>
	</cfif>

	<!--- Attempt to execute the test query --->	
	<cfif FileExists( thisFilePath & "../custom/inc_testQuery.cfm" )>
		<cfinclude template="../custom/inc_testQuery.cfm">
	</cfif>
	
	<cfcatch type="Database">

		<!--- Create the tables --->
		<cfif FileExists( thisFilePath & "../custom/inc_createDBTables.cfm" )>
			<cfinclude template="../custom/inc_createDBTables.cfm">
		</cfif>

		<cfif REQUEST.bFlagIsNewInstance AND NOT bFlagInsertedTestData>
			<!--- Insert Some Test Data --->
			<cfif FileExists( thisFilePath & "../custom/inc_insertSampleData.cfm" )>
				<cfinclude template="../custom/inc_insertSampleData.cfm">
			</cfif>
		</cfif>
		
		<!--- Attempt to execute the test query --->	
		<cfif FileExists( thisFilePath & "../custom/inc_testQuery.cfm" )>
			<cfinclude template="../custom/inc_testQuery.cfm">
		</cfif>

	</cfcatch>
</cftry>

<!--- Set-up the database - create tables and insert sample data --->
<cfinclude template="inc_setupCodeTemplate.cfm">
