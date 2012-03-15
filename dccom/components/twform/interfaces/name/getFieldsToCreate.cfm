<!--- Assumes fieldInfo struct contains all required field information --->
<cfset fieldsToCreate = ArrayNew(1)>

<cfif fieldInfo.format EQ "normal">

	<cfset fieldsToCreate[1] = StructNew()>
	<cfset fieldsToCreate[1].fieldtype = "varchar(50)">
	<cfset fieldsToCreate[1].field = "firstname">

	<cfset fieldsToCreate[2] = StructNew()>
	<cfset fieldsToCreate[2].fieldtype = "varchar(50)">
	<cfset fieldsToCreate[2].field = "lastname">

<cfelse><!--- extended --->

	<cfset fieldsToCreate[1] = StructNew()>
	<cfset fieldsToCreate[1].fieldtype = "varchar(10)">
	<cfset fieldsToCreate[1].field = "title">

	<cfset fieldsToCreate[2] = StructNew()>
	<cfset fieldsToCreate[2].fieldtype = "varchar(50)">
	<cfset fieldsToCreate[2].field = "firstname">

	<cfset fieldsToCreate[3] = StructNew()>
	<cfset fieldsToCreate[3].fieldtype = "varchar(50)">
	<cfset fieldsToCreate[3].field = "lastname">

	<cfset fieldsToCreate[4] = StructNew()>
	<cfset fieldsToCreate[4].fieldtype = "varchar(10)">
	<cfset fieldsToCreate[4].field = "suffix">

</cfif>