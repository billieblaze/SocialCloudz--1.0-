<cfcomponent extends="/model/baseGateway">
	<cffunction name="get">
		<cfargument name="name">
		<cfargument name="memberID" default="#request.session.memberID#">
		<cfset var check = ''>
		<cfquery datasource="#this.datasource#" name="check">
	   	  select ifnull(value,defaultvalue) as value 
	   	  from preferencelist pl
	  	  left join preferences p on p.preferenceID = pl.id     
	  	  		and ( memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">)
	   	  where pl.name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.name#">
	    </cfquery>
	
		<cfreturn check.value>
	</cffunction>
	
	<cffunction name="list">
		<cfargument name="memberID">
		<cfset var qry = ''>
		<cfquery datasource="#this.datasource#" name="qry">
		    select section, answers, name, displayname, ifnull(value, defaultvalue) as value, ID 
		    from preferencelist pl
		    left join preferences p on p.preferenceid = pl.id 
		    	and p.memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
			order by section, sortorder
	    </cfquery>
	    <cfreturn qry>
	</cffunction>

	<cffunction name="getID">
		<cfargument name="preferenceName">
		<cfset var qry = ''>
		<cfquery datasource="#this.datasource#" name="qry">
		    select  ID 
		    from preferencelist pl
			where name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.preferenceName#">
	    </cfquery>
	    <cfreturn qry.id>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="datastruct">
		<cfscript>
		super.save('preferences', arguments.datastruct);
	    </cfscript>
	</cffunction>

</cfcomponent>