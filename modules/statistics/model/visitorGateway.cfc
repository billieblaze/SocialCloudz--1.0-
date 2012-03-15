<cfcomponent extends="/model/baseGateway">
	<cffunction name="get">
		<cfargument name="ipaddress" default="">
		<cfargument name="communityID" default="">
		<cfargument name="token" default="">
		<cfargument name="city" default="">
		<cfargument name="region" default="">
		<cfargument name="countrycode" default=""> 
		<cfargument name="browser" default="">
        <cfargument name="timespan" default='1'>
		<cfargument name="timePart" default='h'>
   		<cfargument name="visitorID" default="">
		<cfargument name="sort" default="visitorID desc">
        <cfscript> 
				startdate = createODBCDateTime(dateadd(arguments.timepart, 0-arguments.timespan, now()));
				enddate = createODBCDateTime(now());
		</cfscript>
 
		<cfquery datasource="#this.datasource#" name="qGetVisitors">
        	select *, 
            		(select count(ID) from views v2 where v.visitorID = v2.visitorID) as pagecount,
              		(select querystring from views v3 where v.visitorID = v3.visitorID order by dateEntered limit 1) as firstPage,
              		(select querystring from views v3 where v.visitorID = v3.visitorID order by dateEntered  desc limit 1) as lastPage                    
             from  visitor v
            where 1=1
            <Cfif arguments.visitorID neq ''>
			and v.visitorID = #arguments.visitorID#
			</cfif>
            <cfif arguments.ipaddress neq ''> 
            and ipaddress = '#arguments.ipaddress#'
            </cfif>
            
            <cfif arguments.communityID neq ''>
            and communityID = '#arguments.communityID#'
            </cfif>
            
            <cfif arguments.token neq ''>
            and token = '#arguments.token#'
            </cfif>
            
            <cfif arguments.city neq ''>
            and city = '#arguments.city#'
            </cfif>
            
            <cfif arguments.region neq ''>
            and region = '#arguments.region#'
            </cfif>
            
            <cfif arguments.countrycode neq ''>
            and countrycode = '#arguments.countrycode#'
            </cfif>
            
            <cfif arguments.browser neq ''>
            and browser = '#arguments.browser#'
            </cfif>
            <Cfif arguments.visitorID eq ''>
		      
            and dateupdated between #startdate# and #endDate#
</cfif>

			order by #arguments.sort#
        </cfquery>

        <cfreturn qGetVisitors> 
	</cffunction>
	
	<cffunction name="save">
    	<cfargument name="datastruct" default="">

		<cfscript>
 		return super.save('visitor', dataStruct);
		</cfscript>
    </cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
		<cfscript>
			return super.delete('visitor', arguments);
		</cfscript>
	</cffunction>
</cfcomponent>