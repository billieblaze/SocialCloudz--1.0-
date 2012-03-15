<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="lastresponse" default="">
		<cfset var q_billing = ''>
		<cfquery name="q_Billing" datasource="#this.datasource#">
	        select distinct r.communityid, r.productid, r.lastbilled, r.attempts, r.lastresponse,r.recurringFrequency, p.cost, p.name, pl.storage, pl.bandwidth
	        from recurringCharges r
	        inner join products p on p.id = r.productid
	        inner join accounts a on a.ID = r.accountID
	        left join plans pl on pl.planid = p.planID 
	<!---        where lastBilled < #dateadd('d', -14, now())#--->
			where 1=1
			<cfif arguments.lastresponse neq ''>
	        and lastresponse = '#arguments.lastresponse#'
	        </cfif>
			order by recurringfrequency, lastbilled
        </cfquery>
        <cfreturn q_billing>
    </cffunction>
	
    <cffunction name="save">
    	<cfargument name="datastruct">
        <cfscript>
			return super.save('recurringCharges', arguments.datastruct);
		</cfscript>
    </cffunction>
	
	<cffunction name="delete">
       	<cfargument name="id">
        <cfscript>
			return super.delete('recurringCharges', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>