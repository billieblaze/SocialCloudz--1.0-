<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 account handler
		
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

	<!--- preHandler --->
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkLogin');

			request.layout.template = 2;
		</cfscript>
		<cfparam name='rc.memberID' default='#request.session.memberid#'>
		<cfparam name='rc.communityID' default='#request.community.communityID#'>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('sections', application.members.profile.getSections(communityID = request.community.communityID, typeID=request.session.profileType));
			event.setvalue('member', application.members.gateway.list(communityID = request.community.communityID,memberID = rc.memberID));
			rc.sideBar = renderView('/member/account/nav');
		</cfscript>
	</cffunction>

    <cffunction name="details">
	 	<cfargument name="event" />
		<cfset rc = event.getCollection()>
		<cfparam name="rc.member" default="#structNew()#">
        <cfscript>
			var rc = event.getCollection();
			var qMember = application.members.gateway.list(memberid=rc.memberID);
			var stMember = application.util.queryRowToStruct(qMember);
			event.setvalue('types',application.members.profile.getTypes(communityID = request.community.communityID));
			structappend(rc.member, stMember, false);
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
    <cffunction name="submit">
		<cfargument name="event" />
		 <cfscript>
			var rc = event.getCollection();
			var formUtils = getMyPlugin("formutilities").buildFormCollections(rc); // create nested form structs *ex: form.member.memberid
			var oMember = createObject('component','/model/members/member'); // create a blank member object
			var validation = '';

			rc.member.city = event.getValue('city','');
			rc.member.state = event.getValue('state','');
			rc.member.country = event.getValue('country','');
			rc.member.latitude = event.getValue('latitude','');
			rc.member.longitude = event.getValue('longitude','');
			rc.member.location = event.getValue('location','');

			if (rc.member.password eq ''){ 
				structDelete(rc.member, 'password');
			}

			getPlugin("beanFactory").populateFromStruct(oMember, rc.member);
			validation = application.members.validator.validate(objectType="members",theObject=oMember, context='profile');
			rc.errors = validation.getFailuresForUniForm();
			
	    	if (not validation.getIsSuccess()){
	    		rc.memberID=rc.member.memberID;
	    		runEvent('member.account.index');
				event.setView('member/account/index');
				rc.sideBar = renderView('/member/account/nav');
			} else {
				oMember.setSignupComplete(1);
				application.members.gateway.save(oMember.getMemento());
				application.members.account.save(oMember.getMemento());
				
				announceinterception('logActivity', {	activityType='members', 
				 	activityAction='update account', 
					contentType = 'members', 
					contentID = rc.member.memberID, 
					memberID = request.session.memberID});
				setNextEvent('member.account.index','memberID=#rc.member.memberID#');
			}
		</cfscript>
	</cffunction>
	
	<Cffunction name="clearProfileImage">
		<cfargument name="event" />
		 <cfscript>
			var rc = event.getCollection();
			application.server.storage.delete(fktype='profilepic',contentID = rc.memberID, communityId = request.session.communityID);
			announceinterception('logActivity', {	activityType='members', 
						 	activityAction='clear profile image', 
							contentType = 'members', 
							contentID = rc.memberID, 
							memberID = request.session.memberID});
							
			event.renderData('plain','OK');
		</cfscript>
	</cffunction>
</cfcomponent>