<cfcomponent extends="../baseService">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			super.init(argumentCollection=arguments);
			this.gateway = createObject('component', 'oneGateway').init(this.datasource, variables.instance.DAO);
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="populateFromIdentity">
		<cfargument name="provider">
		<cfargument name="userID">
		<cfargument name='memberID'>
		<cfscript>
			var data = this.gateway.get(argumentcollection = arguments);
			var arrData = this.utils.queryToArrayOfStructures(data);
			if ( data.recordcount ){ 
				request.session.one = createObject('component', 'model.one.one').init( oneID = data.oneID, providers = arrData);
			} else { 
				
				arrData[1].provider = arguments.provider;
				arrData[1].userID = arguments.userID;
				arrData[1].privacy = 0;
				arrData[1].oneID = createUUID();
				
				request.session.one = createObject('component', 'model.one.one').init( providers = arrData);
			}
		</cfscript>
	</cffunction>

	<cffunction name="save">
		<Cfargument name="objOne">
		<cfscript>
			var data =	arguments.objOne.getProviders();
			var i = 0;
			
			for (i=1; i lte arrayLen(data); i=i+1){
				if (isdefined('data[i].memberID')){
					data[i].oneID = arguments.objOne.getOneID();
					this.gateway.save(data[i]);
				}
			}
			return 1; 		
		</cfscript>
	</cffunction>
</cfcomponent>