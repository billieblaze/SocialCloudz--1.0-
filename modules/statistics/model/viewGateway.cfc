<cfcomponent extends="/model/baseGateway">

	<cffunction name="get">
		<cfargument name="id">
		<cfargument name="visitorID">
		<cfargument name="sort" default="id desc">
		<cfscript>
			return super.get('views', arguments, arguments.sort);
		</cfscript>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="datastruct">
		<cfparam name="cookie.visitorid" default="">

		<cfscript>	
		var rval = structNew();
			rVal.visitorID = datastruct.visitorID ;
			arguments.datastruct = variables.instance.dao.truncate("views",arguments.datastruct);
			rVal.viewID = super.save('views',datastruct, 'insert');
			return rVal;
		</cfscript>

    </cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfscript>
			return super.delete('views', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>