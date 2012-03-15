<cfcomponent extends="../baseGateway">
	<cffunction name="get">

	</cffunction>
	
    <cffunction name="save">
		<cfargument name="data">
		<cfscript>
			return super.save('attribs',arguments.data);
		</cfscript>
	</cffunction>
	
	<cffunction name="delete">

	</cffunction>
</cfcomponent>