<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="id">
		<cfscript>
			return super.get('bandwidth', arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="save">
    	<cfargument name="data">

        <cfscript>
			var myTotal = '';

			mytotal = this.check(arguments.data.communityID);
			arguments.data.id = mytotal.id;
			arguments.data.total = arguments.data.size + mytotal.total;
			if(mytotal.hits eq ''){
				arguments.data.hits = 1;
			}else{
				arguments.data.hits = mytotal.hits + 1;
			}
			super.save('bandwidth',arguments.data,'update');
		</cfscript>
    </cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfscript>
			return super.delete('bandwidth', arguments);
		</cfscript>
	</cffunction>
	
	 <cffunction name="check">
    	<cfargument name="communityID">
    	<cfargument name="range" default="day">

        <cfscript>
			var mydata = structNew();
			var startDate = '';
			var endDate = '';
			var q_get = '';
			
			if (arguments.range eq 'day'){
				startdate = '#dateformat(now(),'yyyy-mm-dd')# 00:00:00.0';
				endDate = '#dateformat(now(),'yyyy-mm-dd')# 23:59:59.9';
			} else if (arguments.range eq 'month'){
				startdate = '#year(now())#-#month(now())#-1 00:00:00.0';
				endDate = '#dateformat(now(),'yyyy-mm-dd')# 23:59:59.9';
			}
        </cfscript>

    	<cfquery datasource="#this.datasource#" name="q_get">
        	select id, ifnull(sum(total),0) as total, ifnull(sum(hits),0) as hits from bandwidth where communityID = #arguments.communityID#
        	and dateEntered between '#startDate#' and '#endDate#'
			group by communityID
        </cfquery>
		<cfif q_get.recordcount eq 0>
			<cfset mydata.id = '0'>
            		<cfset mydata.total = 0>
			<cfset mydata.hits = 0>
            <cfreturn mydata>
        <cfelse>
	        <cfreturn q_get>
        </cfif>
    </cffunction>
	
</cfcomponent>