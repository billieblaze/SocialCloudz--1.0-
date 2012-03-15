<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	11/27/2010
Description : 			
 nested set handler
		
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

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			rc.setData = application.content.nestedSet.get();
			event.setView('util/nestedSet/index');
		</cfscript>
	</cffunction>
	
	<cffunction name="submit" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			application.content.nestedSet.save(argumentcollection =  rc);
			setNextEvent('util.nestedSet.index');
		</cfscript>		
	</cffunction>
	
	<cffunction name="delete" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			application.content.nestedSet.delete(argumentcollection =  rc);
			setNextEvent('util.nestedSet.index');
		</cfscript>		
	</cffunction>	
</cfcomponent>