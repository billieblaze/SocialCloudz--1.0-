<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/5/2011
Description : 			
 multi-homed image manipulation module
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	
	<cffunction name="index">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setLayout('layout.None');
			
		</cfscript>
		
	</cffunction>
</cfcomponent>