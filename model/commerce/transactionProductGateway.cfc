<cfcomponent extends="../baseGateway">
	<cffunction name="get">
       	<cfargument name="datastruct">
        <cfscript>
			return super.get('transactionProduct', arguments.datastruct);
		</cfscript>
	</cffunction>
	
  	<cffunction name="save">
       	<cfargument name="datastruct">
        <cfscript>
		return super.save('transactionProduct', arguments.datastruct);
		</cfscript>
    </cffunction>
	
  	<cffunction name="delete">
       	<cfargument name="datastruct">
        <cfscript>
			return super.delete('transactionProduct', arguments.datastruct);
		</cfscript>
	</cffunction>
</cfcomponent>