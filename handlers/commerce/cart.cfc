<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 commerce cart 
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="postHandler" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('commerce.cart.index');
		</cfscript>
	</cffunction>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			rc.cart = request.session.cart.list();
			request.layout.columns = 1;
		</cfscript>
	</cffunction>
	
  	<cffunction name="add">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();	
			request.session.cart.add( rc.productID, rc.quantity, rc.price);		
			application.session.saveSession(cookie.token, request.session);	
		</cfscript>
    </cffunction>

    <cffunction name="clear">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			request.session.cart = createObject('component', 'model.commerce.cart').init();
			application.session.saveSession(cookie.token, request.session);
		</cfscript>
    </cffunction>

    <cffunction name="update">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			var i = '';
			var thisProduct = '';
			var thisField = '';
			
			// update quantities
			for ( i = 1; i lte listlen(form.fieldNames); i=i+1){
				thisField = listGetAt(form.fieldNames,i);
				if ( thisField contains 'quantity_'){
					thisProduct = replace(thisField, 'quantity_', '');
					request.session.cart.update(thisProduct, evaluate('form.#thisField#'));
				}
			}
			
			// handle removes
			if ( structKeyExists(rc,"productID")){
				for ( i = 1; i lte listlen(rc.productID); i = i + 1){
					thisProduct = listGetAt(rc.productID, i);
					request.session.cart.remove(thisProduct)
				}
			}
			
			application.session.saveSession(cookie.token, request.session);
		</cfscript>
    </cffunction>

</cfcomponent>