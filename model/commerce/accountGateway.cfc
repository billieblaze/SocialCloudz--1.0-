<cfcomponent extends="../baseGateway">
	<cffunction name="get">
       	<cfargument name="id">
        <cfscript>
			return super.get('accounts', arguments);
		</cfscript>
	</cffunction>

	<cffunction name="save">
       	<cfargument name="datastruct">
        <cfscript>
			return super.save('accounts', arguments.datastruct, 'update');
		</cfscript>
    </cffunction>
	
	<cffunction name="delete">
       	<cfargument name="id">
        <cfscript>
			return super.delete('accounts', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>