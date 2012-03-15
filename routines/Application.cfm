<cfapplication name="socialcloudz_routines" sessionmanagement="true">
<cfinclude template="/config/settings.cfm">
<cfset application.directory="">
<cfset  application.server = createObject('component', '/model/server/serverService').init(datasource='statistics', xmlDefinition="/model/server/server.xml")>
<cfparam name="application.lastsitemap" default="1">