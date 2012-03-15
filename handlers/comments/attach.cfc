<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 comment attachment handler
		
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

	<cffunction name="prehandler">
  		<cfargument name="event" />
  		<cfscript>
			var rc = event.getCollection();	
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="image">
  		<cfargument name="event" />
  		<cfscript>
			var rc = event.getCollection();	
		</cfscript>
	</cffunction>
	
	<cffunction name="link">
  		<cfargument name="event" />
  		<cfscript>
			var rc = event.getCollection();	
		</cfscript>
	</cffunction>
	
	<cffunction name="video">
  		<cfargument name="event" />
  		<cfscript>
			var rc = event.getCollection();	
		</cfscript>
	</cffunction>


</cfcomponent>