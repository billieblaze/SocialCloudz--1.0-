<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	11/26/2010
Description : 			
 content category handler
		
AUTOWIRE DSL:
ioc	 Get the named ioc bean and inject it. Name comes from the cfproperty name or argument name
ocm	 Get the name key from the Coldbox cache and inject it. Name comes from the cfproperty name or argument name
model	 Get a model with the same name or alias as defined in the cfproperty name="{name}" attribute. Name comes from the cfproperty name or argument name
model:{name}	 Same as above but it will get the {name} model object from the DSL and inject it.
model:{name}:{method}	 Get the {name} model object, call the {method} and inject the results
webservice:{alias}	 Get a webservice object using an {alias} that matches in your coldbox.xml
coldbox	 Get the coldbox controller
coldbox:setting:{setting}	 Get the {setting} setting and inject it
coldbox:plugin:{plugin}	 Get the {plugin} plugin and inject it
coldbox:myPlugin:{MyPlugin}	 Get the {MyPlugin} custom plugin and inject it
coldbox:datasource:{alias}	 Get the datasource bean according to {alias}
coldbox:configBean	 get the config bean object and inject it
coldbox:mailsettingsbean	 get the mail settings bean and inject it
coldbox:loaderService	 get the loader service
coldbox:requestService	 get the request service
coldbox:debuggerService	 get the debugger service
coldbox:pluginService	 get the plugin service
coldbox:handlerService	 get the handler service
coldbox:interceptorService	 get the interceptor service
coldbox:cacheManager	 get the cache manager
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

<!----------------------------------------- IMPLICIT EVENTS ------------------------------------------>

	<!--- UNCOMMENT HANDLER IMPLICIT EVENTS
	
	<!--- preHandler --->
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
		</cfscript>
	</cffunction>
	
	<!--- postHandler --->
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	
	<!--- onMissingAction --->
	<cffunction name="onMissingAction" access="public" returntype="void" output="false" hint="Executes if a request action (method) is not found in this handler">
		<cfargument name="event" 			type="any">
		<cfargument name="missingAction" 	type="any" hint="The requested action string"/>
		<cfscript>	
			var rc = event.getCollection();
			
		</cfscript>
	</cffunction>
	
	<!--- onError --->
	<cffunction name="onError" access="public" returntype="void" output="false" hint="Executes if ANY error ocurrs in this handler.">
		<cfargument name="event" 		type="any">
		<cfargument name="faultAction" 	type="any" hint="The name of the action that caused the exception">
		<cfargument name="exception" 	type="any" hint="The exception object">
		<cfscript>	
			var rc = event.getCollection();
			
		</cfscript>
	</cffunction>
	
	--->
			 
<!------------------------------------------- PUBLIC EVENTS ------------------------------------------->	 	

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			rc.category = application.content.category.get(event.getValue('id','0'));
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="save" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			categoryID = application.content.category.save(rc);
			
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='add category', 
				contentType = 'contentCategory', 
				contentID = categoryid, 
				memberID = request.session.memberID});
			
			
			event.setLayout('layout.None');
			event.setView('dspBlank');
		</cfscript>
	</cffunction>

	<cffunction name="delete" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			rc.communityID =  request.community.communityID;
			delete = application.content.category.delete(rc.id);
			
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='delete category', 
				contentType = 'contentCategory', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});
			
			event.setLayout('layout.None');
			event.setView('dspBlank');
		</cfscript>
	</cffunction>
</cfcomponent>