<!--- Assumes fieldInfo struct contains all required field information --->
<cfset fieldsToCreate = ArrayNew(1)>

<cfset fieldsToCreate[1] = StructNew()>
<cfset fieldsToCreate[1].fieldtype = "time"> 
<cfset fieldsToCreate[1].field = "email"> 