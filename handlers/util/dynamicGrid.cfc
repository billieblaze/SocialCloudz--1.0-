<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	11/24/2010
Description : 			
 dynamicGrid Coldbox interface
		
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

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		</cfscript>

		<cfif not isdefined('rc.method')>
			<Cfthrow message="method must be specified in the url">
		</cfif>
		
		<cfparam name="rc.page" default="1">
		<Cfparam name="rc.rows" default="20">
		<cfparam name="rc.sidx" default="">
		<cfparam name="rc.sord" default="">
		
		<!--- sort field --->	
		<cfset rc.sort = '#rc.sIdx# #rc.sord#'>
		
		<cfscript>
			rc.limit = rc.rows;
			if (  rc.method neq ''){
				rc.grid.data  = evaluate('#rc.method#(argumentcollection = rc)');

				form.countonly = 1;
				try{
					rc.grid.count  = evaluate('#rc.method#(argumentcollection = form)').count;
				}
				catch (any E){
					rc.grid.count = rc.grid.data.recordcount;
				}
			}
			if (isdefined('rc.debug')){
				writeDump(rc.grid.data);
				abort;
			}
			event.setView('render/jsonQuery', true);
		</cfscript>
		<!---

		<Cfdump var='#rc.grid.data#'><Cfabort>
		--->
	</cffunction>
	
</cfcomponent>