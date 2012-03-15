<cfcomponent extends="/model/baseGateway">
    <cffunction name="get">
		<cfargument name="ID">
		<cfargument name="fkID" default="">
		<cfargument name="fkType" default="">
		<cfargument name="orderby" default="">
		<cfscript>
			return super.get('emailLog', arguments, arguments.orderBy);
	    </cfscript>

	</cffunction>
	
    <cffunction name="save">
		<cfargument name="datastruct">
		<cfscript>
		return super.save('emailLog', arguments.datastruct);
	    </cfscript>

	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="ID">
	
		<cfscript>
		return super.delete('emailLog', arguments);
	    </cfscript>
	</cffunction>
	
</cfcomponent>