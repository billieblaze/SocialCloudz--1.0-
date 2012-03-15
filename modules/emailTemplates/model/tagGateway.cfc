<cfcomponent extends="/model/baseGateway">
    <cffunction name="get">
		<cfargument name="ID">
		<cfargument name="applicationName">
		<cfscript>
		return super.get('emailTag', arguments, 'tag');
	    </cfscript>

	</cffunction>

    <cffunction name="save">
		<cfargument name="datastruct">
	
		<cfscript>
		return super.save('emailTag', arguments.datastruct);
	    </cfscript>

	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="ID">
	
		<cfscript>
		return super.delete('emailTag', arguments);
	    </cfscript>
	</cffunction>
	
</cfcomponent>