<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	11/2/2010
Description : 			
 email template handler
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index,picker";
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>

	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();

		</cfscript>
	</cffunction>

	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfset var rc = event.getCollection()>		
		<cfset var tagList = ''>
		<cfparam name="rc.id" default="0">
		<cfscript>
			tagList = application.emailTemplates.tags.get(ID=rc.id);
			tagList = application.util.queryRowToStruct(tagList);
			
			rc.tags = application.emailTemplates.tags.get();
			rc.globalTags = application.emailTemplates.getGlobalTags();
			
			structAppend(rc,tagList, false);

			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>

	<cffunction name="picker" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfset var rc = event.getCollection()>		
		<cfset var tags = ''>
		<cfparam name="rc.id" default="0">
		<cfscript>	
			rc.tags = application.emailTemplates.tags.get();
			rc.globalTags = application.emailTemplates.getGlobalTags();
			
			tags = application.emailTemplates.tags.get(ID=rc.id);
			tags = application.utils.queryRowToStruct(tags);
			
			structAppend(rc,tags, false);

			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="submit" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			var tagData = structNew(); 
		
			application.emailTemplates.tags.save(rc);
		</cfscript>
	</cffunction>

	<cffunction name="delete" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			application.emailTemplates.tags.delete(rc.id);
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('emailTemplates:tags.index', 'emailID=#rc.emailID#&communityID=#rc.communityID#');
		</cfscript>
	</cffunction>	
				
</cfcomponent>