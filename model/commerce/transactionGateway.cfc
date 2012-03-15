<cfcomponent extends="../baseGateway">
	<cffunction name="get">
       	<cfargument name="datastruct">
        <cfscript>
			return super.get('transaction', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name="save">
       	<cfargument name="datastruct">
        <cfscript>
		return super.save('transaction', arguments.datastruct, 'update');
		</cfscript>
    </cffunction>
	
	<cffunction name="delete">
       	<cfargument name="id">
        <cfscript>
			return super.delete('transaction', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>