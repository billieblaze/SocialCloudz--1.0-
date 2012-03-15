<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 my modules
		
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
			announceInterception('checkAdmin');
			event.setLayout('layout.AJAX');
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
    
	<cffunction name="add">  
		<cfargument name="event" />
		<cfparam name='rc.memberid' default=''>
		<Cfsetting showdebugoutput="false">
		<cfscript> 
			var rc = event.getCollection();
			rc.mpid = application.cms.addModule(list=1, moduleID=rc.moduleID, page=rc.page, iscontent=0);
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='add module', 
				contentType = rc.page, 
				contentID = rc.moduleID, 
				memberID = request.session.memberID});
				
			event.renderData('plain','#rc.mpID#');
		</cfscript>
    </cffunction>
	
	<Cffunction name="list">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			rc.modulelist = application.cms.modules.list(page = request.page.id);
		</cfscript>
	</cffunction>

	<cffunction name="load">
		<cfargument name="event" />
		<Cfsetting showdebugoutput="false">
		<cfscript>
			var rc = event.getCollection();
			var module = application.cms.modules.get(moduleSettingID = rc.moduleSettingID);
			rc.content.contentType = module.contentType;
			
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='add module', 
				contentType = request.page.id, 
				contentID = rc.moduleSettingID, 
				memberID = request.session.memberID});
				
		  	event.setView('cms/modules/load');
		</cfscript>
	</cffunction>
   
	<cffunction name="edit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			event.setvalue('types',application.members.profile.getTypes(communityID = request.community.communityID));
			rc.getModule = application.cms.modules.get(rc.id);
			event.setView('/cms/modules/edit/#rc.editfile#');
		</cfscript>
	</cffunction>
    
    <cffunction name="save">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.cms.updateModuleOrder(rc.data, rc.page);
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='update module order', 
				contentType = rc.page, 
				memberID = request.session.memberID});
				
			event.renderData('plain','');
        </cfscript>
	</cffunction>
	
    <cffunction name="update">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			if ( not isdefined('rc.displayRecordCount') ) rc.displayRecordCount = 0;
		  	rc.moduleSettingID = application.cms.modules.updateSettings(rc);

		  	announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='update module settings', 
				contentType = 'modulesettings', 
				contentID = rc.modulesettingID, 
				memberID = request.session.memberID});
				
		  	event.setView('cms/modules/load');
        </cfscript>
	</cffunction>
	
	<Cffunction name="listMyModules">
		<cfargument name="event">
		<cfscript>
			var rc = event.getCollection();	
			rc.mymodules = application.cms.modules.getExisting();
		</cfscript>
	</cffunction>
	
    <cffunction name="addMyModule">  
		<cfargument name="event" />
		<cfscript> 
			var rc = event.getCollection();
			mpid = application.cms.modules.copy(list=1, modulesettingID=rc.modulesettingID, page=rc.page);
			
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='add module', 
				contentType = rc.page, 
				contentID = rc.moduleSettingID, 
				memberID = request.session.memberID});
				
			relocate(request.session.lastpage);
		</cfscript>
    </cffunction>

    <cffunction name="deleteMyModule">  
		<cfargument name="event" />
		<cfscript> 
			var rc = event.getCollection();
			application.cms.modules.delete(modulesettingID=rc.modulesettingID);
			
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='delete module', 
				contentType = rc.page, 
				contentID = rc.moduleSettingID, 
				memberID = request.session.memberID});
				
			relocate(request.session.lastpage);
		</cfscript>
    </cffunction>
</cfcomponent>