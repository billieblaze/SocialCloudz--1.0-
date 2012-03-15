<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 style
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="true">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "skin";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
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
		    event.setvalue('templates', application.cms.templates.get());
		    event.setLayout('layout.AJAX');
        </cfscript>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="event" />
		<cfparam name='rc.templateID' default='0'>
		<cfparam name="rc.designType" default="Advanced">
		<cfscript>
			var rc = event.getCollection();
			application.cms.saveStyle(rc.data, 0);
			application.memcached.delete("css_#request.community.communityID#_#application.versionnumber#");
			
			if (rc.templateID eq 0 or rc.templateID eq ''){
				if(rc.designtype neq 'Simple'){
				application.cms.style.saveCSS(rc.extracss);
				announceinterception('logActivity', {	activityType='cms', 
				 	activityAction='change style', 
					contentType = 'style', 
					memberID = request.session.memberID});
				}
			}else{
				application.cms.template.save(rc.data, rc.templateID);
				announceinterception('logActivity', {	activityType='cms', 
													 	activityAction='change style', 
														contentType = 'style', 
														memberID = request.session.memberID});		
			}
			
			
			//relocate(request.session.lastpage);
		</cfscript>
	</cffunction>

    <cffunction name="clear">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.cms.style.delete();

			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='clear style', 
				contentType = 'style', 
				memberID = request.session.memberID});
				
			relocate(request.session.lastpage);
		</cfscript>
	</cffunction>
    
 	<cffunction name="skin">
		<cfargument name="event" />
		<cfsetting showdebugoutput="no">
		<cfset event.showdebugpanel("false")>
		<cfcontent type="text/css; charset=ISO-8859-1">
		<cfscript>
       		var rc = event.getCollection();
       		var skin = '';
			var q_skin = application.cms.style.get();
			var thisSelector = '';
			var i = 0;
			
			for(i=1;i lte q_skin.recordcount; i=i+1){
				if (q_skin.selector[i] neq thisSelector){
					if(i neq 1){	skin = skin & '}';     }
					thisSelector = q_skin.selector[i];
					skin = skin & thisSelector & '{';
				}
				skin = skin & q_skin.attribute[i] & ':' & q_skin.value[i] & ';';
			}
			skin = skin &'}';
			skin = skin & application.cms.style.getCSS();
			return skin;
		</cfscript>
    </cffunction>

	<cffunction name="elements">
		<cfargument name="event" />
		<cfsetting showdebugoutput="no">
		<cfset event.showdebugpanel("false")>
		<cfscript>
			var rc = event.getCollection();
			var q_get = application.cms.style.getElements(itemID = rc.itemID);
			var r = "";
			var x = 1;

			if(q_get.RecordCount GT 0){
				for(x = 1; x lte q_get.RecordCount; x = x + 1){
					if(len(trim(r)) GT 0){r = "#r#|";}
					r = "#r##q_get['item'][x]#~#q_get['description'][x]#";
				}
			}
			return r;
		</cfscript> 
	</cffunction>	
	
	<cffunction name="properties">
		<cfargument name="event" />
		<cfsetting showdebugoutput="no">
		<cfset event.showdebugpanel("false")>
		<cfscript>
			var rc = event.getCollection();
			var qGetElements = application.cms.style.getElements(argumentcollection=rc);
			var q_get = application.cms.style.getProperties(qGetElements.ID);
			var r = "";
			var x = 1;
			
			if(q_get.RecordCount GT 0){
				for(x = 1; x lte q_get.RecordCount; x = x + 1){
					if(len(trim(r)) GT 0){r = "#r#|";}
					r = "#r##q_get['selector'][x]#!#q_get['property'][x]#~#q_get['description'][x]#";
				}
			}
			return r;
		</cfscript>
	</cffunction>	
</cfcomponent>