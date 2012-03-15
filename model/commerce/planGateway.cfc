<cfcomponent extends="../baseGateway">
	<cffunction name="get">
    	<cfargument name="planID" default="">
        <cfset var q_get = ''>
        <cfquery datasource="#this.datasource#" name="q_get">
	        select * from plans pl
	        inner join products pr on pl.planID = pr.planID 
	        where 1 = 1
	        
            <cfif arguments.planID neq ''>
			    and pl.planID = #arguments.planID#
	        </cfif>  
	    </cfquery>
		<cfreturn q_get>
    </cffunction>
	
   	<cffunction name="save">
       	<cfargument name="datastruct">
        <cfscript>
			return super.save('plans', arguments.datastruct);
		</cfscript>
	</cffunction>

	<cffunction name="delete">
       	<cfargument name="id">
        <cfscript>
			return super.delete('plans', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>