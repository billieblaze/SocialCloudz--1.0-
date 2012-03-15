<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 status comments
		
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

	<cffunction name="index" returntype="any" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setValue('status', application.content.comments.get(
				fkID=rc.memberID,
				fkType='Profile', 
				sort='dateEntered', 
				sortOrder='desc', 
				limit=1, 
				memberid = request.session.memberID));
			return renderView(view="comments/status/index");
		</cfscript>
	</cffunction>
	
	<cffunction name="update">
	  	<cfargument name="event" />
	  	<cfscript> 
		  	var rc = event.getCollection();	
		  	announceInterception('checkLogin');
	  		rc.memberID = request.session.memberid;
			rc.communityID = request.community.communityID;
			rc.comment = application.processtext.tagStripper(rc.comment);		
			rc.comment = application.processtext.ActivateURL(rc.comment, '_blank'); 
				
			rc.ID = application.content.comments.save(rc);
			
			rc.commentID = rc.id;
			announceinterception('logActivity', {	activityType='member', 
			 	activityAction='update status', 
				contentType = 'comment', 
				contentID = rc.memberid, 
				memberID = request.session.memberID});
				
			setNextEvent('member.profile.index');
		</cfscript>
	</cffunction> 

</cfcomponent>