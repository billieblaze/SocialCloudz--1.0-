<cfparam name="form.editable" default="0">
<cfparam name="form.sortable" default="0">
<cfparam name="form.searchable" default="0">
<cfset application.dynamicGrid.column.update(datastruct = form)>