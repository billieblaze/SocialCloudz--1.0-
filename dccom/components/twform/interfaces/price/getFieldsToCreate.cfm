<!--- Assumes fieldInfo struct contains all required field information --->
<cfset fieldsToCreate = ArrayNew(1)>

<cfif fieldInfo.currency NEQ "yen">

	<cfset fieldsToCreate[1] = StructNew()>
	<cfset fieldsToCreate[1].fieldtype = "float(50)">
	<cfset fieldsToCreate[1].field = "price">

<cfelse><!--- yen --->

	<cfset fieldsToCreate[1] = StructNew()>
	<cfset fieldsToCreate[1].fieldtype = "int">
	<cfset fieldsToCreate[1].field = "title">

</cfif>