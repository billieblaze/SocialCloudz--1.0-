<cfcomponent name="authInterceptor"	output="false">
	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptor" output="false" >
	</cffunction>

	<cffunction name="preEvent" access="public" returntype="void" hint="Executes after the framework and application configuration loads, but before the aspects get configured. " output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<cfset var rc = event.getCollection()>
		<cfset var data = '' >
		<Cfset var visitorID = ''>
		<cfparam name="request.stats.viewid" default="">
		
        <cfscript>
			announceInterception('createVisitorCookie');
	
			data = structNew();
			data.visitorid = cookie.visitorid;
			data.referer=cgi.HTTP_REFERER;
			data.querystring = cgi.query_string;
	    	data.communityID = request.community.communityID;
    		data.memberID =	request.session.memberID;
	    	
	    	request.stats.viewID = application.statistics.view.save(data).viewid; 
			application.members.userclick();
	    
			announceInterception('trackCampaign');
		</cfscript>
	
		
	</cffunction>
	
	<cffunction name="postProcess" output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">

		<cfscript>
			var rc = event.getCollection();
			application.statistics.updateVisitor(cookie.visitorID, request.session.memberID);
	    </cfscript>
	</cffunction>
	
	
	<cffunction name="createVisitorCookie" interceptionPoint="true" output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">

		<cfset var rc = event.getCollection()>
		<Cfset var visitorID = ''>

			<cfif not isdefined('cookie.visitorID')>
        	<cfscript>

				visitorID = application.statistics.createVisitor(
						request.session.ipaddress, 
						cgi.http_user_agent,
						cgi.http_referrer,
						cgi.query_string,
						request.community.communityID,
						cookie.token, 
						request.session.location.cityName, 
						request.session.location.regionName, 
						request.session.location.countrycode
					);
	        </cfscript>
	        <cfcookie name="visitorID" value="#visitorID#" expires="never">
		</cfif>
			
	</cffunction>
	
	<cffunction name="trackCampaign" interceptionPoint="true" output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">

		<cfset var rc = event.getCollection()>

		<cfif (not isdefined('cookie.campaignID') and isdefined('rc.t')) 
			or (isdefined('rc.t') and isdefined('cookie.campaignID') 
			and rc.t neq cookie.campaignID)>
			<cfscript>
				application.members.invitation.track(invitationID = rc.t, memberid=request.session.memberID, visitorID=cookie.visitorID );
				announceInterception('logActivity', { activityType='Invite', activityAction = 'Visit', contentID = rc.t});
			</cfscript>
			<cfcookie name="inviteID" value="#rc.t#" expires="never">
		</cfif>
	</cffunction>
	
	<cffunction name="logActivity" interceptionPoint="true" output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">

		<cfscript>
			var rc = event.getCollection();
			param name='interceptdata.contentID' default=0;
			application.statistics.activity.save(
							activityType=interceptData.activityType, 
							activityAction=interceptData.activityAction, 
							contentType = interceptData.contentType, 
							contentID = interceptData.contentID, 
							memberid = interceptData.memberID
					);		
		</cfscript>
	</cffunction>
	
	<cffunction name="dataChange" interceptionPoint="true" output="false" >
		<cfargument name="event" required="true"  hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">

		<cfscript>
			var rc = event.getCollection();
			application.statistics.audit.save(
							visitorID = cookie.visitorID, 
							fkType=interceptData.fkType, 
							fkID=interceptData.fkID, 
							originalValue = interceptData.originalValue, 
							newValue = interceptData.newValue
					);		
		</cfscript>
	</cffunction>
	</cfcomponent>