<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 content utils
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="incrementView">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();			
			application.content.gateway.incrementViews(rc.contentID);
			
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='view content', 
				contentType = 'content', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});
			
			event.renderData('plain', 'OK');
		</cfscript>
	</cffunction>
		
	<cffunction name="flag">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
		 	if (isdefined('rc.status')) {
				if ( rc.status eq 'Yes'){rc.newStatus = 0;} else {rc.newStatus=1;}
			}
			application.content.gateway.flag(rc.contentid, rc.newstatus,1);
			
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='flag content', 
				contentType = 'content', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});
			
			setNextEvent('content.admin.index');
		</cfscript>
	</cffunction>

	<Cffunction name="rss" output="false">
		<cfargument name="event" />
		<Cfset var rc = event.getCollection()>
		<cfparam name="rc.limit" default="20">
		<cfscript>
			event.setvalue('entries', application.content.get(argumentcollection = rc));
			foo = renderView('content/util/rss');
			event.renderData('plain', foo);
		</cfscript>
	</cffunction>

	<Cffunction name="json" output="false">
		<cfargument name="event" />
		<Cfset var rc = event.getCollection()>
		<cfparam name="rc.limit" default="20">
		<cfparam name="rc.page" default="1">
		<Cfparam name="rc.rows" default="20">
		<cfparam name="rc.sidx" default="">
		<cfparam name="rc.sord" default="">
		
		<!--- sort field --->	
		<cfset rc.sort = '#form.sIdx# #form.sord#'>

		<cfscript>
			rc.rows = rc.limit
			rc.mode = 'simple';
			rc.grid.data =  application.content.get(argumentcollection = rc);
			rc.countonly = 1;
			rc.limit = 0;
			rc.grid.count =  application.content.get(argumentcollection = rc).count;
			event.setView('render/jsonQuery', true);
		</cfscript>
	</cffunction>

	<cffunction name="rating" output="false">
		<cfargument name="event" />
	        <cfscript>	
	    	    var rc = event.getCollection();
	    	    application.rating.addRating(argumentcollection = rc);
	    	    
	    	    announceinterception('logActivity', {	activityType='content', 
				 	activityAction='rate content', 
					contentType = 'content', 
					contentID = rc.contentId, 
					memberID = request.session.memberID});
		    	    
	    	    event.setLayout('layout.None');
	    	    event.setView('dspBlank');
	    	</cfscript>	
	</cffunction>		

	<cffunction name="printRSVPList">
		<cfargument name="event" />
		<cfscript>
			content = application.content.get(contentID=event.getvalue('contentID',''));
			
			rsvpList = application.content.favorite.get(event.getvalue('contentID',''),'1');
			rsvpList = application.members.joinMemberData(rsvplist);
			
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='print event rsvps', 
				contentType = 'content', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});
			
			
			event.setvalue('qContent', content);
			event.setvalue('qRSVPList', rsvpList);
			event.setLayout('layout.none');
			event.setView('content/util/rsvplist');
		</cfscript>
   </cffunction>
		
</cfcomponent>