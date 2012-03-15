<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 domain management handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "check";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>
	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
			event.setValue('community', application.community.setupCommunity(communityID = event.getValue('communityID')));
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
			 
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
			rc.domain = getModel('community/domain').init();
			rc.domain.setID(event.getValue('id',0));
			application.community.domain.getMask(rc.domain);
			event.setvalue('menuFeatures', application.cms.menu.getFeatures());
			event.setvalue('CMSPages',  application.cms.page.get());
			event.setValue('dnsmask', application.community.domain.listMask(communityID = event.getValue('communityID')));
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			application.community.domain.deleteMask(id=rc.id);
			event.setLayout('layout.AJAX');
			
			announceinterception('logActivity', {	activityType='app', 
			 	activityAction='delete domain', 
				contentType = 'domain', 
				contentID = rc.id, 
				memberID = request.session.memberID});
				
			event.setNextEvent(linkTo='community.domain.index',queryString='communityID=#rc.community.communityID#');
		</cfscript>
	</cffunction>

	<cffunction name="submit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			rc.domain.communityID = event.getValue('community').communityID;
			rc.domain.verified = 0;
			application.community.domain.saveMask(rc.domain);
			announceinterception('logActivity', {	activityType='app', 
			 	activityAction='update domain', 
				contentType = 'domain', 
				contentID = rc.domain.id, 
				memberID = request.session.memberID});
				
			setNextEvent('community.domain.index', 'communityID=#rc.communityID#')			
		</cfscript>
	</cffunction>
	
   	<cffunction name="verify">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			rc.domain = getModel('community/domain').init();
			rc.domain.setID(event.getValue('id',0));
			application.community.domain.getMask(rc.domain);
		</cfscript>
		<cftry>
			<cfhttp url="http://#rc.domain.getSubDomain()#.#rc.domain.getDomain()#/index.cfm/community/domain/check" result="checkDomain">
			<cfscript>			
				if (trim(checkDomain.filecontent) contains 'OK'){
					request.session.message = 'DNS Configuration has been verified.';
					rc.domain.setVerified(1);
				} else { 
					request.session.message = 'DNS Configuration has not taken effect yet.';
					rc.domain.setVerified(0);
				}
			</cfscript>
			<cfcatch>
				<cfscript>
					request.session.message = 'DNS Configuration has not taken effect yet.';
					rc.domain.setVerified(0);
				</cfscript>
			</cfcatch>
		</cftry>
		<cfscript>
			
			application.session.saveSession(cookie.token, request.session);
			application.community.domain.saveMask(rc.domain.getMemento());
			
			announceinterception('logActivity', {	activityType='app', 
			 	activityAction='verify domain', 
				contentType = 'domain', 
				contentID = rc.domain.getID(), 
				memberID = request.session.memberID});
			setNextEvent('community.domain.index', 'communityID=#rc.domain.getCommunityID()#');
		</cfscript>
	</cffunction>

	<cffunction name="check">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
		<cfset event.renderdata('plain','OK')>
	</cffunction>
</cfcomponent>