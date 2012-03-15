<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 forum post handler
		
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
			announceInterception('checkLogin');
			request.layout.columns = 1;
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('post', application.forum.getTopic(ID=event.getvalue('id')));
			
			request.page.title = 'Forum Post';
			event.setView('post');
		</cfscript>
	</cffunction>
	
	<cffunction name="submit">
		<cfargument name="event" />
	  	<cfscript>
		  	var rc = event.getCollection();
		
			rc.memberid = request.session.memberID;
			rc.postDate = now();
			rc.content = rc.postBody;
			newID = application.forum.savePost(rc);
	
			// add subscription
			if (isdefined("rc.subscribe") and rc.subscribe eq 1){
				if(isdefined('rc.postid')){subID = rc.postID;} else { subID = newID;}
				application.forum.subscribeTopic(request.session.memberID, subid, 1);
			}
		
			// Send to Subscribers
			if (isdefined('rc.postID') and rc.postID neq 0){
				getsubscriptions = application.forum.getSubscriptions(rc.postID);
				getsubscriptions = application.members.joinMemberData(getSubscriptions);
				
				//todo: move to emailTagDecorator
				mailData.title = application.forum.getTopic(rc.postID).title;
				mailData.link = 'http://#request.community.baseurl#/index.cfm/forum/thread/id/#rc.postID#';
				
				for (i=1; i LTE getSubscriptions.recordcount; i=i+1){
					application.emailTemplates.send(to=getSubscriptions.email[i], template='forum', data=mailData);
				}
			}
		
			// Is a reply
			if( isdefined('rc.postid') ){  
				setNextEvent('forums:display.thread','id=#rc.postID#');
			} else {
				setNextEvent('forums:display.thread','id=#newID#');
			}
		</cfscript>
	</cffunction>

	<cffunction name="delete">
	  	<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();

			application.forum.deletePost({postID = rc.id});
			application.forum.deletePost(rc);
			
			setNextEvent('forums:display.topics', 'id=#posts.ID#');
		</cfscript>
	</cffunction>
	
</cfcomponent>