<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/13/2010
Description : 			
 cms page handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>


	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkPrivate');
			
			if (isdefined('rc.edit')){	request.session.splashpage = 0;	}
			request.layout.edit = 1;
			
			event.setView('dspBlank');
        </cfscript>	

		<cfif request.page.id eq 'home' and request.community.domain.startPage neq '' and request.community.domain.startPage neq '/' and request.community.domain.startPage neq '#cgi.script_name##cgi.path_info#'>
			<cflocation url="http://#request.community.baseurl##request.community.domain.startpage#">
		</cfif>
	</cffunction>
	
	<cffunction name="admin" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
			event.setvalue('community', application.community.setupCommunity(communityID = request.community.communityID));
			event.setLayout('layout.AJAX');
		</cfscript>	
	</cffunction>

	<cffunction name="form" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			var page = '';
			announceInterception('checkAdmin');
			
			rc.pageDetail = application.cms.page.get(  url = rc.page, communityID = request.community.communityID );
			
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="addsubmit" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
			pageid =  application.cms.page.save(rc);	

			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='add page', 
				contentType = 'cmspages', 
				contentID = pageID, 
				memberID = request.session.memberID});
				
			event.renderData('plain','/pages/#rc.url#');
		</cfscript>
	</cffunction>
	
	<cffunction name="submit" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
			pageid =  application.cms.page.save(rc);	
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='edit page', 
				contentType = 'cmspages', 
				contentID = pageID, 
				memberID = request.session.memberID});
			
			getPlugin("messagebox").setMessage("info", "Saved.");
			setNextEvent('cms.page.form', 'page=#rc.url#')
		</cfscript>
	</cffunction>

	<cffunction name="delete" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
			application.cms.page.delete(id=rc.id);
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='delete page', 
				contentType = 'cmspages', 
				contentID = rc.id, 
				memberID = request.session.memberID});
			event.setView('dspBlank',true);
		</cfscript>
	</cffunction>
</cfcomponent>