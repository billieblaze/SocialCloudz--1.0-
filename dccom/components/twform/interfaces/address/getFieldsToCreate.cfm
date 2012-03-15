<!--- Assumes fieldInfo struct contains all required field information --->
<cfset fieldsToCreate = ArrayNew(1)>

<cfset fieldsToCreate[1] = StructNew()>
<cfset fieldsToCreate[1].fieldtype = "varchar(255)">
<cfset fieldsToCreate[1].field = "line1">

<cfset fieldsToCreate[2] = StructNew()>
<cfset fieldsToCreate[2].fieldtype = "varchar(255)">
<cfset fieldsToCreate[2].field = "line2">

<cfset fieldsToCreate[3] = StructNew()>
<cfset fieldsToCreate[3].fieldtype = "varchar(255)">
<cfset fieldsToCreate[3].field = "city">

<cfset fieldsToCreate[4] = StructNew()>
<cfset fieldsToCreate[4].fieldtype = "varchar(50)">
<cfset fieldsToCreate[4].field = "state">

<cfset fieldsToCreate[5] = StructNew()>
<cfset fieldsToCreate[5].fieldtype = "varchar(50)">
<cfset fieldsToCreate[5].field = "zip">

<cfset fieldsToCreate[6] = StructNew()>
<cfset fieldsToCreate[6].fieldtype = "varchar(50)">
<cfset fieldsToCreate[6].field = "country">