<cfcomponent hint="I am the abstract service.  I setup the gateway and validator functions which get inherited by the concrete services that extend me.  All other services should extend me.  I also provide the ability to perform generic select, save and delete via onMissingMethod." output="false">
	<cffunction name="init" returnType="any" hint="I am the initialize function for the abstract service layer.  If a concrete service that extends me requires it's own internal init function, i should be invoked via super.init()"  output="false">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		<cfset var xmlString = ''>
		<!--- Setup Local Variables --->
		<cfset variables.instance = structNew()>
		<cfset variables.instance.datasource = arguments.datasource>
		
		<cfset this.datasource = arguments.datasource>

		<!--- This is the xml definition for the dataMGR --->
		<cfset this.xmlDefinition = arguments.xmlDefinition>
		<!--- Create the datamgr dao --->
		<cfset variables.instance.DAO = createobject('component', 'model.DataMgr.DataMgr').init(datasource=this.datasource,database='MYSQL')>
		
		<!--- Load the table definitions --->
		<cfset this.xmlDefinition = arguments.xmlDefinition>
		<cfif isdefined('this.xmlDefinition') and  this.xmlDefinition neq ''>
			<cffile action="read" file="#expandPath(this.xmlDefinition)#" variable="xmlString"/>
			<cfset variables.instance.DAO.loadXML(XMLParse(trim(xmlString)),true,true)>
		</cfif>

		<!--- 
		Instantiate the gateway for containing extra, non-DataMGR SQL 
		Explicitly declared gateways passed to this INIT method, should 
		always extend the abstractGateway to inherit its methods
		--->
		<cfif arguments.gateway neq ''>
			<cfset this.gateway = createobject('component', arguments.gateway).init(this.datasource,variables.instance.DAO)>
		<Cfelse>
			<cfset this.gateway = createobject('component', 'model.baseGateway').init(this.datasource,variables.instance.DAO)>
		</cfif>

		<!--- 
		Instantiate the a base validator
		Explicitly declared validators passed to this INIT method, should 
		always extend the baseValidator to inherit its methods
		--->
		<cfset this.validator = createobject('component', '/ValidateThis/ValidateThis').init()>
			
		<cfset this.utils = createobject('component', 'udf.util').init()>
		
		<cfreturn this />
	</cffunction>
    
</cfcomponent>