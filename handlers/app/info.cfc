<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/13/2010
Description : 			
 application info
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>

	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			request.layout.columns = 1;
		</cfscript>
	</cffunction>
	
	<cffunction name="terms" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			request.page.title = 'Terms of Service';
		</cfscript>
	</cffunction>
	
	<cffunction name="privacy" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			request.page.title = 'Privacy Policy';
		</cfscript>
	</cffunction>

 	<cffunction name="error">
		<cfargument name="event" />
		<cfscript>
		var rc = event.getCollection();
		request.page.title = 'An Error has Occured';
        </cfscript>
    </cffunction>

	<cffunction name="available">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			request.page.title = 'Community Available';
		</cfscript>
    </cffunction>

    <cffunction name="inactive">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			request.page.title = 'Inactive Community';
		</cfscript>
    </cffunction>

    <cffunction name="pageNotFound">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			request.page.title = 'Page Not Found';
		</cfscript>
    </cffunction>
		
   <cffunction name="private">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			request.page.title = 'Private';
        </cfscript>
    </cffunction>
</cfcomponent>