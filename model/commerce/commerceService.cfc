<cfcomponent extends="../baseService">
		<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			super.init(argumentCollection=arguments);
			this.datasource = arguments.datasource;
			this.paypal = createObject('component', '../../udf/paypal').init();
			
			this.account = createObject('component', 'accountGateway').init(this.datasource, variables.instance.DAO);
			this.plan = createObject('component', 'planGateway').init(this.datasource, variables.instance.DAO);				
			this.product = createObject('component', 'productGateway').init(this.datasource, variables.instance.DAO);
			this.recurring = createObject('component', 'recurringGateway').init(this.datasource, variables.instance.DAO);
			this.transaction = createObject('component', 'transactionGateway').init(this.datasource, variables.instance.DAO);
			this.transactionProduct = createObject('component', 'transactionProductGateway').init(this.datasource, variables.instance.DAO);

			return this;
		</cfscript>
	</cffunction>
</cfcomponent>