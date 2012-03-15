<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/13/2010
Description : 			
 application admin handler
		
----------------------------------------------------------------------->
<cfcomponent hint="i control the application dashboard" 
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
			
			announceInterception('checkSuperAdmin');
		    
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
			request.layout.columns = 1;
			request.page.title = 'Global Admin';
		</cfscript>
  	</cffunction> 	

	<cffunction name="general">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');
		</cfscript>
  	</cffunction>
	
   <cffunction name="communities">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			event.setvalue('communities', application.community.gateway.get());
			event.setLayout('layout.AJAX');
		</cfscript>
  	</cffunction>
  
   <cffunction name="storage">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');			
		</cfscript>
  	</cffunction>

   <cffunction name="bandwidth">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');	
		</cfscript>
  	</cffunction>

   <cffunction name="sessions">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');		
		</cfscript>
  	</cffunction>
</cfcomponent>