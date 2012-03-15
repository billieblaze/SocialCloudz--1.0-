<cfif StructKeyExists( ATTRIBUTES, "dbtype" )><cfexit method="EXITTEMPLATE"></cfif>
<!--- Perform tests, to determine which database type is in use --->
<!--- 1. Try mySQL --->
<cftry>
	<cfquery name="connTest" datasource="#ATTRIBUTES.datasource#">
	SELECT version(), sysdate(), now()
	</cfquery>
	<cfset ATTRIBUTES.dbtype = "MYSQL">
	<cfcatch type="Database">
		<!--- 2. Try MSSQL --->
		<cftry>
			<cfquery name="connTest" datasource="#ATTRIBUTES.datasource#">
			SELECT getdate(), current_timestamp
			</cfquery>
			<cfset ATTRIBUTES.dbtype = "MSSQL">
			<cfcatch type="Database">
				<!--- 3. Try Access --->
				<cftry>
					<cfquery name="connTest" datasource="#ATTRIBUTES.datasource#">
					SELECT now(), time()
					</cfquery>
					<cfset ATTRIBUTES.dbtype = "MSACCESS">
					<cfcatch type="Database">
						<!--- 4. Try Oracle --->
						<cftry>
							<cfquery name="connTest" datasource="#ATTRIBUTES.datasource#">
							SELECT currdate FROM dual
							</cfquery>
							<cfset ATTRIBUTES.dbtype = "ORACLE">
							<cfcatch type="Database"></cfcatch>
						</cftry>
					</cfcatch>
				</cftry>
			</cfcatch>
		</cftry>
	</cfcatch>
</cftry>
<cfparam name="ATTRIBUTES.dbtype" default="UNKNOWN">
<cfset ATTRIBUTES.dbtype = UCASE(ATTRIBUTES.dbtype)>