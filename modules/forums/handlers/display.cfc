<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 forum display
		
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
		  	request.layout.columns = 1;
		</cfscript>
	</cffunction>
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		  	request.page.title = 'Forums';
			event.setvalue('sections',application.forum.getSections());
			event.setView('index');
		</cfscript>
	</cffunction>
	
	<cffunction name="topics">
	  <cfargument name="event" />
	  	<cfscript>
		  	var rc = event.getCollection();	
			event.setvalue('topics', application.forum.getTopics(rc.id));
			event.setvalue('forum', application.forum.getForum(rc.ID));
			request.page.title = '#event.getvalue('forum').forum#';
			event.setView('topics');
		</cfscript>
	</cffunction>
	
	<cffunction name="thread">
	  <cfargument name="event" />
	  	<cfscript>
			var rc = event.getCollection();	
			event.setValue('topic',application.forum.getThread(id=event.getValue('id')));
			event.setValue('forum',application.forum.getForum(event.getValue('topic').forumid));
			event.setvalue('subscription', application.forum.checksubscription(event.getvalue('id')));
			request.page.title = '#event.getvalue('topic').title#';
			application.forum.updateViews(event.getValue('id',''));
						event.setView('thread');
		</cfscript>
	</cffunction>

	<cffunction name="admin">
	  <cfargument name="event" />
	  <cfscript>
		var rc = event.getCollection();	
		announceInterception('checkAdmin');
	 	request.page.title = 'Forum Admin';
		event.setvalue('sections',application.forum.getSections());
		event.setView('admin');
	  </cfscript>
	</cffunction>
	
</cfcomponent>