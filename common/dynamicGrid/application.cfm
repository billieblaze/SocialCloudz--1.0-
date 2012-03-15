<Cfapplication name="jqGrid" sessionmanagement="true"> 
<cfparam name="url.datasource" default="">
<cfif isdefined('form.datasource')><cfset url.datasource = form.datasource></cfif>
<cfset application.dynamicGrid = createobject('component','common.dynamicGrid.model.gridService').init(datasource="#url.datasource#")>
<cfset application.utils = createObject('component', 'udf.util').init()>
