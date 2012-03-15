<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	11/2/2010
Description : 			
 email template handler
		
AUTOWIRE DSL:
ioc	 Get the named ioc bean and inject it. Name comes from the cfproperty name or argument name
ocm	 Get the name key from the Coldbox cache and inject it. Name comes from the cfproperty name or argument name
model	 Get a model with the same name or alias as defined in the cfproperty name="{name}" attribute. Name comes from the cfproperty name or argument name
model:{name}	 Same as above but it will get the {name} model object from the DSL and inject it.
model:{name}:{method}	 Get the {name} model object, call the {method} and inject the results
webservice:{alias}	 Get a webservice object using an {alias} that matches in your coldbox.xml
coldbox	 Get the coldbox controller
coldbox:setting:{setting}	 Get the {setting} setting and inject it
coldbox:plugin:{plugin}	 Get the {plugin} plugin and injct it
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
		this.posthandler_except = "index";
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>

	
	<!--- preHandler --->
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();

		</cfscript>
	</cffunction>
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('emailTemplates:mapping.index', 'emailID=#rc.emailID#');
		</cfscript>
	</cffunction>	
				
	
	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfset var rc = event.getCollection()>		
		<cfset var mapping = ''>
		<cfparam name="rc.id" default="0">
		<cfscript>	
			rc.mappings = application.emailTemplates.mapping.get(emailID=rc.emailid);
			rc.tags = application.emailTemplates.tags.get(emailID=rc.emailid);
			
			mapping = application.emailTemplates.mapping.get(ID=rc.id);
			mapping = application.utils.queryRowToStruct(mapping);
			structAppend(rc,mapping, false);

			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="submit" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		
			application.emailTemplates.mapping.save(rc);
		</cfscript>
	</cffunction>

	<cffunction name="delete" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			application.emailTemplates.mapping.delete(rc.id);
		</cfscript>
	</cffunction>
	
</cfcomponent>