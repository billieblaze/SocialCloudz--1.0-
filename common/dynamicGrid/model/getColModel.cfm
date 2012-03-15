<cfsetting showdebugoutput="false">
<cfparam name="url.grid" default="">
<cfparam name="url.view" default="default">
<cfparam name="url.application" default="">
<cfparam name="url.isAdmin" default="0">

<cfoutput>#application.dynamicGrid.loadGridView(url.grid, url.view, url.pid, url.application, url.isAdmin)#</cfoutput>