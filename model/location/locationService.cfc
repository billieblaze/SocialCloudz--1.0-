<cfcomponent extends="../baseService">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true"  inject="coldbox:datasource:location">
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			super.init(argumentCollection=arguments);
			
			this.gateway = createObject('component', 'locationGateway').init(this.datasource, variables.instance.DAO);
			return this;
		</cfscript>
	</cffunction>
	
	<Cffunction name="getIp2Location">
		<cfargument name="ipAddress">
		
		<cfset var location = structNew()>
 
			<cfset location.cityName = ''>	
			<cfset location.countryName = ''>
			<cfset location.countryCode = ''>
			<cfset location.regionName = ''>
			<cfset location.latitude = ''>
			<cfset location.longitude = ''>			
		
		
		<cfreturn location>
	</cffunction>
	
</cfcomponent>