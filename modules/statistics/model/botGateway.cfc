<cfcomponent extends="/model/baseGateway">
	<cffunction name="get">
		<cfargument name="id">
		<cfargument name="useragent">
		<cfscript>
			return super.get('bots', arguments);
		</cfscript>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="datastruct">
		<cfscript>
			return super.save('bots', arguments.datastruct);
		</cfscript>

	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfscript>
			return super.delete('bots', arguments);
		</cfscript>
	</cffunction>
	
	
</cfcomponent>