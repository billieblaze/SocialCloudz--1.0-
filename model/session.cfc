<cfcomponent>
	<cffunction name="init" returntype="session">
		<cfargument name="memcached">
		
		<cfset variables.instance.memcached = arguments.memcached>
		
        <cfreturn this>
    </cffunction>
    
    <cffunction name="saveSession">
    	<cfargument name="ID">
        <cfargument name="dataStruct">
        <cfscript>
		    variables.instance.memcached.set(key="session_#arguments.id#",value=arguments.datastruct,expiry=86400);
		</cfscript> 
    </cffunction>    

    <cffunction name="getSession">
    	<cfargument name="ID">
        <cfscript>
			var mysession = variables.instance.memcached.get(key="session_#arguments.id#");
	
			if (isstruct(mysession)){
				return mysession;
			} else { 
				return structnew();
			}
		</cfscript>
    </cffunction>    

	<cffunction name="deleteSession">
    	<cfargument name="ID">
        <cfargument name="dataStruct">
        <cfscript>
	      variables.instance.memcached.delete("session_#arguments.id#");
  		</cfscript>
    </cffunction> 

</cfcomponent>