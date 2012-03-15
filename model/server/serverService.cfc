<cfcomponent extends="../baseService">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			super.init(argumentCollection=arguments);
			this.datasource = arguments.datasource;
			
			this.bandwidth = createObject('component', 'bandwidthGateway').init(this.datasource, variables.instance.DAO);
			this.storage = createObject('component', 'storageGateway').init(this.datasource, variables.instance.DAO);
			this.webserver = createObject('component', 'webserverGateway').init(this.datasource, variables.instance.DAO);

			return this;
		</cfscript>
	</cffunction>
	
</cfcomponent>