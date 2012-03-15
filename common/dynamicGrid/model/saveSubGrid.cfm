<cfset data = attributes>
<cfset data.gridName = attributes.subGridName>
<cfset data.application = attributes.application>
<Cfset gridID = application.dynamicGrid.grid.save(data)>

<Cfif (attributes.subGridMethod neq '')>
	<cfif attributes.subGridArguments eq ''>
		<Cfset subgridarguments = 'limit=1'>
	<cfelse>
		<Cfset subgridarguments = replace(attributes.subgridarguments, "=", "='", 'all')>
		<Cfset subgridarguments = replace(subgridarguments, '&', "',", 'all')>
		<cfset subgridarguments = subgridarguments & "',limit=1">
	</cfif>
	<Cfset qry = evaluate('#attributes.subGridMethod#( #subgridarguments# )')>

<cfset struct = application.util.queryRowToStruct(qry)>
<Cfset columns = structKeyList(struct)>
<cfset cnt = 1>
<Cfloop list="#columns#" index="i">
	<Cfset data = structNew()>
	<cfset data.gridName = attributes.subGridName>
	<cfset data.viewName = 'default'>
	<cfset data.name = i>
	<cfset data.label = i>
	<Cfset data.hidden = 0>
	<Cfset data.colOrder = cnt >
	<cfset data.width = 50>
	<cfset data.pid = ''>
	<cfset application.dynamicGrid.column.save(data)>
	<cfset cnt = cnt + 1>
</cfloop>
</Cfif>