<cfcomponent output="false">
	<cfprocessingdirective suppresswhitespace="true">
		<cfset this.name = "socialcloudz_tools" />
		<cfset this.sessionmanagement = true>
		<cffunction name='onApplicationStart'>
			<cfinclude template="/config/settings.cfm">
			  <cfset application.server = createObject('component', '/model/server/serverService').init(datasource='statistics', xmlDefinition="/model/server/server.xml")>

		</cffunction>
	</cfprocessingdirective>
</cfcomponent>