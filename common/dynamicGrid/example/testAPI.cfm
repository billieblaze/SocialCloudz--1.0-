<cfsetting showdebugoutput="false">
<!--- Setup --->
<cfparam name="form.page" default="1">
<Cfparam name="form.rows" default="20">

<!--- sort field --->	
<cfset form.sort = '#form.sIdx# #form.sord#'>

<!--- Extra url params + get data --->
<cfparam name="url.id" default="">
<cfparam name="url.is_school" default="0">
<cfparam name="url.filter" default="">
<cfset request.grid.data = application.department.get(id=url.id, is_school = url.is_school, filter=url.filter, sort = form.sort)>
<!--- serialize and send --->
<Cfinclude template="/common/dynamicGrid/toJSON.cfm">