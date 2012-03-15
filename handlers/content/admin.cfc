<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 content admin
		
----------------------------------------------------------------------->

<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "delete";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
			request.layout.template = 4;
			request.layout.width="doc2";
			request.layout.skinFile="/css/skin_admin.css";
			request.layout.headerFile="/views/app/admin/header.cfm";
			request.layout.menuFile = "/views/app/admin/menu.cfm";
		</cfscript>

		<Cfparam name="rc.communityID" default="#request.community.communityID#">

		<cfset event.setvalue('community', application.community.setupCommunity(communityID = rc.communityID))>
		<cfif request.session.accesslevel gte 100>
			<cfset event.setvalue('communityList',application.community.gateway.get())>
		<cfelse>
			<cfset event.setvalue('communityList',application.community.getMine(memberID=request.session.memberID,adminOnly = 1))>
		</cfif>

	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
			event.setvalue('community', application.community.setupCommunity(communityID = event.getValue('communityID')));
	   	</cfscript>
	</cffunction>

	<cffunction name="community" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('mycommunities', application.community.getMine(memberID = request.session.memberId));
			event.setvalue('contentCommunity', application.content.community.get(contentID = event.getValue('contentID')));
			event.setLayout('layout.AJAX');
	   	</cfscript>
	</cffunction>

	<cffunction name="communitySubmit" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			 application.content.community.save(contentID = rc.contentID, communityList = rc.contentCommunityList);
			 
			 announceinterception('logActivity', {	activityType='content', 
			 	activityAction='update community', 
				contentType = 'contentCommunity', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});
			 
			 event.renderData('plain','<script>location.href="/index.cfm/content/admin/community"</script>');
	   	</cfscript>
	</cffunction>
	
	<cffunction name="approve">
	  <cfargument name="event" />
	  <cfscript>
			var rc = event.getCollection();	
			announceInterception('checkAdmin');
		
			content = application.content.get(contentID=rc.contentID, approved=0, updateviews =0);
			rc.contentType = content.contentType;		
			
			if (content.approved eq 0){
				rc.approved = 1;
			}else{
				rc.approved = 0;
			}
			
			application.content.save(rc);		
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='approve content', 
				contentType = 'content', 
				contentID = rc.contentID, 
				memberID = request.session.memberID});
			
			member = application.members.gateway.get(memberID = content.memberID);
			application.emailTemplates.send(to=member.email, template="contentApproved", data=structnew());
			setNextEvent('content.admin.index');
		</cfscript>
	</cffunction>

	<cffunction name="save" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			categoryID = application.content.save(rc);	
			
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='update content', 
				contentType = rc.contentType, 
				contentID = rc.contentId, 
				memberID = request.session.memberID});
			
			
	   	</cfscript>
	</cffunction>
	
	<cffunction name="delete">
	  	<cfargument name="event" />
	  	<cfscript>
			announceInterception('checkLogin');
			var rc = event.getCollection();	
	
		    application.content.gateway.delete(rc.contentID);
		    
		    announceinterception('logActivity', {	activityType='content', 
			 	activityAction='delete content', 
				contentType = 'content', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});
		    
		    
			if(rc.contentType eq 'Photo'){
				relocate('/index.cfm/content/gallery/#rc.parentID#');			
			}else { 
				relocate('/index.cfm/content/#rc.ContentType#/');	
			}
	  	</cfscript>
	</cffunction>
</cfcomponent>