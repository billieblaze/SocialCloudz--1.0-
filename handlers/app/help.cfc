<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 help system handler
		
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
			event.setvalue('adminsections', application.help.getHelpSections(type="admin"));
			event.setvalue('usersections', application.help.getHelpSections(type="user"));
		</cfscript>
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
			event.setvalue('admintopics', application.help.getHelpTopics(type="admin", limit=10, order='views'));
			event.setvalue('usertopics', application.help.getHelpTopics(type="user", limit=10, order='views'));
			rc.sideBar = renderView('app/help/sections');
		</cfscript>
    </cffunction>
    
    <cffunction name="topics">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			event.setvalue('thissection', application.help.getHelpSections(id = event.getvalue('sectionid','')));
			event.setvalue('topics', application.help.getHelpTopics(sectionID=event.getvalue('sectionid','')));
			rc.sideBar = renderView('app/help/sections');
		</cfscript>
    </cffunction>
	
    <cffunction name="detail">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	

			event.setvalue('topic', application.help.getHelpTopics(ID=event.getvalue('id','')));
    		event.setvalue('thissection', application.help.getHelpSections(id = event.getvalue('topic','').sectionid));
			rc.sideBar = renderView('app/help/sections');
		</cfscript>
    </cffunction>
    
    <cffunction name="form">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			request.layout.columns = 1;
			event.setvalue('sections', application.help.getHelpSections());
			event.setvalue('topic', application.help.getHelpTopics(ID=event.getvalue('id','')));
			rc.sideBar = renderView('app/help/sections');
		</cfscript>    
    </cffunction>
    
    <cffunction name="submit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			id=application.help.saveHelp(rc);
			setNextEvent('app.help.detail','id=#id#');
		</cfscript>
    </cffunction>

</cfcomponent>