<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 upgrade subscription
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
				    
			request.layout.template = 4;
			request.layout.width="doc2";
			request.layout.skinFile="/css/skin_admin.css";
			request.layout.headerFile="/views/app/admin/header.cfm";
			request.layout.menuFile = "/views/app/admin/menu.cfm";
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			request.layout.template = 5;
			request.page.title = 'Upgrade';
			rc.plans = application.commerce.plan.get();
			rc.premium = application.commerce.product.get(type="premium");
			rc.products = application.commerce.product.get(type="add-on");
			
			rc.sideBar = renderView('/commerce/upgrade/nav');
			rc.sideBar = rc.sideBar & renderView('commerce/upgrade/addons');
		</cfscript>
	</cffunction>

	<cffunction name="submit">
		<cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			var i = 0;
			
			// get plan's productID
			var product = '';
			
			if (request.community.planID neq rc.planID){
				product = application.commerce.product.get(planID=rc.planID);
				request.session.cart.add(product.ID, 1, product.cost, product.planID);
			}	
		
			// premium features	
			if (isdefined('rc.premium')){
				for (i = 1; i lte listlen(rc.premium); i = i + 1){
					productID = listGetAt(rc.premium, i);
					product = application.commerce.product.get(productID);
					request.session.cart.add(product.ID, 1, product.cost);	
				}
			}
			
			// addon features	
			if (isdefined('rc.addon')){
				for (i = 1; i lte listlen(rc.addon); i = i + 1){
					productID = listGetAt(rc.addon, i);
					product = application.commerce.product.get(productID);
					request.session.cart.add(product.ID, 1, product.cost);	
				}
			}
				
			application.session.savesession(cookie.token, request.session);

			// forward to secure checkout
			setNextEvent('commerce.cart.index'); 				
		</cfscript>	

	</cffunction>

	<cffunction name="alert">
        <cfargument name="event">
        <cfscript>
			var rc = event.getCollection();	
		</cfscript>
	</cffunction>
</cfcomponent>