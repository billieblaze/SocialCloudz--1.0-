<cfcomponent extends="/model/baseService">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			super.init(argumentCollection=arguments);
			this.datasource = arguments.datasource;
			
			this.activity = createObject('component', 'activityGateway').init(this.datasource, variables.instance.DAO);
			this.audit = createObject('component', 'auditGateway').init(this.datasource, variables.instance.DAO);
			this.bots = createObject('component', 'botGateway').init(this.datasource, variables.instance.DAO);				
			this.campaign = createObject('component', 'campaignGateway').init(this.datasource, variables.instance.DAO);
			this.view = createObject('component', 'viewGateway').init(this.datasource, variables.instance.DAO);
			this.visitor = createObject('component', 'visitorGateway').init(this.datasource, variables.instance.DAO);

			return this;
		</cfscript>
	</cffunction>

	<cffunction name="isBot">
		<cfargument name="useragent">
		<cfscript>
			return this.bots.get(arguments.useragent).recordcount;
		</cfscript>
	</cffunction>
	
	<cffunction name="createVisitor">
		<cfargument name="ipAddress">
		<cfargument name="browser">
		<cfargument name="referer">
		<cfargument name="startPage">
		<cfargument name="communityID">
		<cfargument name="token">
		<cfargument name="city">
		<cfargument name="region">
		<cfargument name="countrycode">

        <cfscript>
			arguments.isbot = this.isbot(arguments.browser);
			return this.visitor.save(arguments);
		</cfscript>
   </cffunction>

   <cffunction name="updateVisitor">
    	<cfargument name="visitorID">
		<cfargument name="memberID">
		<cfscript>
			arguments.dateUpdated = '#dateformat(now(),'yyyy/mm/dd')# #timeformat(now(), 'HH:mm:ss')#';
			
			return this.visitor.save(arguments);
		</cfscript>
    </cffunction>
	
   <cffunction name="logDataChange">
		<cfargument name="viewID">
		<cfargument name="fkID">
		<Cfargument name="fkType">
		<cfargument name="originalData">
		<cfargument name="newData">

		<Cfscript>
			var originalValue = '';
			var newValue = '';
			
			var stOriginalValue = this.utils.queryRowToStruct(arguments.originalData);
			
			for (key in stOriginalValue){

				if (structKeyExists(newData, key)){

					originalValue = stOriginalValue[key];
					newValue = arguments.newData[key];
					
					if ( originalValue neq newData[key]){
						this.audit.save( 
							viewID = arguments.viewID,
							fkID = arguments.fkID, 
							fkType = arguments.fkType, 
							field = key,
							originalValue = originalValue, 
							newValue = newValue
						);
					}
				}
			}
		</Cfscript>
   </cffunction>
</cfcomponent>