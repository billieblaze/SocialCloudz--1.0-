<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<Cfargument name="memberID">
		<cfargument name="provider">
		<cfargument name="userID">
		<cfscript>
			return super.get('one', arguments);
		</cfscript>
	</cffunction>	

    <cffunction name="save">
		<cfargument name="datastruct">
    	<cfscript>
    		return super.save('one', arguments.datastruct);
		</cfscript>
	</cffunction>	
	
	<cffunction name="delete">
		<cfscript>
			return super.delete('one', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>