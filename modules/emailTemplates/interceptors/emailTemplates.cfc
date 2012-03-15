<cfcomponent name="authInterceptor"	output="false">
	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>

	<cffunction name="afterConfigurationLoad" access="public" returntype="void" hint="Executes after the framework and application configuration loads, but before the aspects get configured. " output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<cfset application.emailTemplates = createobject('component','/modules/emailTemplates/model/emailTemplateService').init(datasource=getDatasource('community').getName(), decorator="/model/emailTagDecorator", debugMode=getSetting('debugMode'))>
	</cffunction>
	
</cfcomponent>