<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 member profile
		
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
		</cfscript>
		<cfif not isdefined('rc.username')>
			<cfparam name="rc.memberID" default="#request.session.memberID#">
		</cfif>
	</cffunction>
	
	<!--- postHandler --->
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
	</cffunction>

			 
<!------------------------------------------- PUBLIC EVENTS ------------------------------------------->	 	

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();

			if ( isdefined('rc.username')){ 
				event.setvalue('member', application.members.gateway.list( username= event.getValue('username','')));	
			} else {
				event.setvalue('member', application.members.gateway.list(memberID = event.getValue('memberID', request.session.memberID)));	
			}
			
			rc.memberID = rc.member.memberID;

			event.setvalue('sections', application.members.profile.getSections( typeID = rc.member.profileType));
			
			if( rc.member.recordcount eq 0){
				setNextEvent('member.profile.notFound');
			}	

			request.page.title = "#rc.member.username#'s Profile";
			request.layout.template = 1;
			request.layout.edit = 1;

			event.setvalue('displayLayout', '0');
			event.setValue('fkType', 'Profile');
			event.setValue('fkID', rc.member.memberid);	
			event.setValue('commentReturnURL', '/index.cfm/member/profile/index##tabs-2');
			event.setvalue('commentMemberID', rc.member.memberID);
			rc.comments = runEvent('comments.main.index');
			
			rc.sideBar = renderView('member/profile/nav');

			if (application.community.settings.getValue('friends') eq 1){
				event.setvalue('friends',application.members.friend.list(memberID = rc.member.memberID));
				rc.sideBar = rc.sideBar & renderView('member/friends/nav');
			}
					
			if ( request.session.memberID neq rc.member.memberid) { application.members.gateway.incrementProfileView(rc.member.memberID); }
		</cfscript>
    </cffunction>

	<cffunction name="edit">
        <cfargument name="event">   
	    <cfscript>
			var rc = event.getCollection();
			announceInterception('checkLogin');

			event.setLayout('layout.AJAX');
			event.setvalue('type',application.members.profile.getTypes(communityID = request.community.communityID));
		</cfscript>
	</cffunction>	
	
	<cffunction name="multiEdit">
        <cfargument name="event">   
	    <cfscript>
			var rc = event.getCollection();
			announceInterception('checkLogin');

			event.setvalue('sections', application.members.profile.getSections(communityID = request.community.communityID));
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>	

	<cffunction name="submit">
        <cfargument name="event">
        <cfscript>
			var rc = event.getCollection();
			announceInterception('checkLogin');

			application.members.profile.save(rc);
			Event.setView(name="dspBlank");
			event.setLayout('layout.none');
			
			announceinterception('logActivity', {	activityType='members', 
						 	activityAction='updated profile', 
							contentType = 'profile', 
							contentID = rc.memberID, 
							memberID = request.session.memberID});
							
		</cfscript>
    </cffunction>

	<cffunction name="multiSubmit">
        <cfargument name="event">
        <cfscript>
			var rc = event.getCollection();
			announceInterception('checkLogin');

			application.members.profile.save(rc);
			Event.setView(name="dspBlank");
			event.setLayout('layout.none');
		</cfscript>
	
    </cffunction>

	<cffunction name="notFound">
        <cfargument name="event">
        <cfscript>
			var rc = event.getCollection();
			request.layout.columns = 1;
		</cfscript>	
	</cffunction>

	<cffunction name="deleteMultiQuestionAnswers">
		<cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			var answer = '';
			
			announceInterception('checkLogin');

			answer = application.members.profile.getQuestions(memberid=rc.memberID, groupID=rc.questionID, answerSet=rc.answerSet);
		</cfscript>		
		<cfloop query="answer">
			<cfset application.members.profile.deleteMultiQuestionAnswers(answerSet=rc.answerSet,questionID=answer.questionID,memberID=rc.memberID)>
		</cfloop>
		<cfscript>	
			event.renderdata('plain', 'OK');
		</cfscript>	
	</cffunction>
</cfcomponent>