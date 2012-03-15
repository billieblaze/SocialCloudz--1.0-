
<Cfset gridData = application.dynamicGrid.grid.get(gridName = attributes.gridName)>

<cfif gridData.recordCount eq 0>
	<Cfset gridID = application.dynamicGrid.grid.save(attributes)>
</cfif>
	<Cfif (attributes.method neq '')>
	
		<Cfif left(attributes.method,5) eq 'func_' >
			<cfdump var='#attributes.arguments#'>
			<Cfset qry = evaluate('variables.#attributes.method#( #attributes.arguments# )')>
		<Cfelse>
			<cfif attributes.arguments eq ''>
				<Cfset attributes.myarguments = 'limit=1'>
			<cfelse>
				<Cfset attributes.myarguments = replace(attributes.arguments, "=&", "=''&", 'all')>
				<Cfset attributes.myarguments = replace(attributes.myarguments, "=", "='", 'all')>
				<Cfset attributes.myarguments = replace(attributes.myarguments, '&', "',", 'all')>
				<Cfset attributes.myarguments = replace(attributes.myarguments, "''''", "''", 'all')>
				<cfset attributes.myarguments = attributes.myarguments & "',limit=1">
			</cfif>
			<Cfset qry = evaluate('#attributes.method#( #attributes.myarguments# )')>
		</cfif>
	</Cfif>

<cfset struct = application.util.queryRowToStruct(qry)>
<Cfset columns = structKeyList(struct)>
<cfset cnt = 1>
	<!--- lookup the columns for this grid --->
	<cfset qryExistingColumns = application.dynamicGrid.column.get(grid = attributes.gridName, view='default')>
	<cfset listExistingColumns = valueList(qryExistingColumns.name)>
	
	<!---<cfif listLen(columns) neq listLen(listExistingColumns)>--->
	<cfif attributes.isAdmin eq 1>
		<!--- Process Updates --->	
<Cfloop list="#columns#" index="i">
			<!--- if column does not exist --->
				<cfif not listFind(listExistingColumns,i)>
	<Cfset data = structNew()>
	<cfset data.gridName = attributes.gridName>
	<cfset data.viewName = 'default'>
	<cfset data.name = i>
	<cfset data.label = i>
	<Cfset data.colOrder = cnt >
	<cfset data.width = 50>
					<Cfset data.hidden = 1>
					<cfset data.sortable = 1>
					<cfset data.pid = ''>
					<cfset data.key = 0>
					<Cfset data.editable = 0>
					<cfset application.dynamicGrid.column.save(data)>
				</cfif>
	
				<cfset cnt = cnt + 1>
		</cfloop>
	
		<!--- process deletes --->
		<Cfloop list="#listExistingColumns#" index="i">
			<!--- if column does not exist --->
			<cfif not listFind(columns,i)>
				<Cfset data = structNew()>
				<cfset data.gridName = attributes.gridName>
				<cfset data.viewName = 'default'>
				<cfset data.name = i>
				<cfset data.pid = ''>
				<cfset application.dynamicGrid.column.delete(argumentCollection = data)>
			</cfif>
	
			<cfset cnt = cnt + 1>
		</cfloop>
	</cfif>