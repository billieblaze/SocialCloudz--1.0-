<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/20/2010
Description : 			
 api auth / view switcher
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.Interceptor" 
			 output="false">
  
<!------------------------------------------- PUBLIC ------------------------------------------->	 	

   
    <cffunction name="configure" access="public" returntype="void" output="false" hint="Configure your interceptor">
		
	</cffunction>
    

<!------------------------------------------- PRIVATE ------------------------------------------->	 	
    <cffunction name="preProcess" access="public" returntype="void" output="false" hint="Configure your interceptor">
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">

		<cfscript>
			var rc = event.getCollection();		
			
			rc.apiCall = 0;
			if ( structKeyExists(rc,'apikey')){ rc.apiCall = 1; }
		</cfscript>

	</cffunction>
	
    <cffunction name="preLayout" access="public" returntype="void" output="false" hint="Configure your interceptor">
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
 	
		<cfscript>
			var rc = event.getCollection();		
			if (event.getValue('apiCall',0) eq 1){	event.setView('render/jsonQuery', true);	}
		</cfscript>
	</cffunction>

</cfcomponent>