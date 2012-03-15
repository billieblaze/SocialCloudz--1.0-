<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 community polls
		
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

	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			request.layout.columns = 1;
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
		</cfscript>
	</cffunction>
	
	<cffunction name="results">
	  <cfargument name="event" />
	    <cfscript>
		  	var rc = event.getCollection();	  
		if (event.getValue('pollID') eq ''){
			event.setvalue('pollID',application.poll.getCurrentPoll(event.getValue('polltype')));
		}
		
		event.setValue('poll', application.poll.getPoll(event.getValue('pollID')));
	    </cfscript>
	</cffunction>
	
	<cffunction name="past" hint="I display past poll results">
	  <cfargument name="event" />
	    <cfscript>
		    var rc = event.getCollection();	
			request.page.title = 'Past Polls';
			
			event.setValue('pollList', application.poll.pastPolls(event.getValue('pollType')));
			
			for(i=1;i lte event.getValue('pollList').recordCount; i=i+1){
				event.setValue('poll', application.poll.getPoll(event.getValue('pollList').questionID[i]));
				event.setView("community/poll/past");
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="admin" hint="I am the admin page for adding Site or Profile Polls">
	  <cfargument name="event" />
	   <cfscript>
			announceInterception('checkAdmin');
			request.page.title = 'Poll Admin';
			
			if(event.getValue('pollID', '') neq ''){
				event.setValue('poll', application.poll.getPoll(event.getValue('pollID')));
			} else {
				event.setValue('poll', application.poll.getPoll(0));
			}
			
			event.setValue('pollList', application.poll.pastPolls(event.getValue('pollType','module')));
			
		</cfscript>
	</cffunction>
	
	<cffunction name="add" hint="I am the add Poll action">
	  <cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			announceInterception('checkAdmin');
			id = application.poll.insertPoll();
			
			announceinterception('logActivity', {	activityType='community', 
			 	activityAction='add poll', 
				contentType = 'poll', 
				contentID = id, 
				memberID = request.session.memberID});
				
			setNextEvent(linkTo='community.poll.admin', queryString='pollType=#event.getValue('pollType', 'module')#');
	    </cfscript>
	</cffunction>
	
	<cffunction name="update" hint="I am the update Poll action">
	  <cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			announceInterception('checkAdmin');
			application.poll.updatePoll();
			
			announceinterception('logActivity', {	activityType='community', 
			 	activityAction='update poll', 
				contentType = 'poll', 
				contentID = rc.id, 
				memberID = request.session.memberID});
				
			setNextEvent(linkTo='community.poll.admin', queryString='pollType=#event.getValue('pollType', 'module')#');
	    </cfscript>
	</cffunction>
	
	<cffunction name="delete">
	    <cfargument name="event">
	    <cfscript>
		    var rc = event.getCollection();	
			application.poll.delete(event.getValue('pollID'));
			
			announceinterception('logActivity', {	activityType='community', 
			 	activityAction='delete poll', 
				contentType = 'poll', 
				contentID = rc.pollid, 
				memberID = request.session.memberID});
				
			setNextEvent(linkTo='community.poll.admin', queryString='pollType=#event.getValue('pollType','module')#');
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteAnswer">
	    <cfargument name="event">
	    <cfscript>
		    var rc = event.getCollection();	
		    announceInterception('checkAdmin');
			application.poll.deleteAnswer(event.getValue('answerID'));		
			announceinterception('logActivity', {	activityType='community', 
					 	activityAction='delete poll answer', 
						contentType = 'poll', 
						contentID = rc.answerid, 
						memberID = request.session.memberID});
			setNextEvent(linkTo='community.poll.admin', queryString='pollType=#rc.polltype#&pollID=#rc.pollID#');
		</cfscript>
	</cffunction>
	
	<cffunction name="vote" hint="I am the Vote action">
	  <cfargument name="event" />
	  <cfscript>
		  var rc = event.getCollection();	
			application.poll.vote(rc.questionID, rc.answerID);
				announceinterception('logActivity', {	activityType='community', 
			 	activityAction='vote on a poll', 
				contentType = 'poll', 
				contentID = rc.questionid, 
				memberID = request.session.memberID});
			relocate(request.session.lastpage);
	  </cfscript>
	</cffunction>

</cfcomponent>