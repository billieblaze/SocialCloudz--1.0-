<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 ecommerce categories
		
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
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
	</cffunction>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('products', application.shopping.getProducts(categoryID=event.getvalue('categoryID')));
			event.setvalue('category', application.shopping.getCategories(categoryID=event.getvalue('categoryID')));
			rc.sideBar = renderView('commerce/category/nav');
			rc.sideBar = rc.sideBar & renderView('commerce.MiniCart', contentvariable='rightNav', append='true');
		</cfscript>
	</cffunction>

	<cffunction name="form">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
		</cfscript>
    </cffunction>

    <cffunction name="submit">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
		</cfscript>
    </cffunction>

    <cffunction name="delete">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
</cfcomponent>