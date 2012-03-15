<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 application dashboard
		
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
			
			request.layout.template = 4;
			request.layout.width="doc2";
			request.layout.skinFile="/css/skin_admin.css";
			request.layout.headerFile="/views/app/admin/header.cfm";
			request.layout.menuFile = "/views/app/admin/menu.cfm";
		</cfscript>

		<Cfparam name="rc.communityID" default="#request.community.communityID#">

		<cfset event.setvalue('community', application.community.setupCommunity(communityID = rc.communityID))>
		<cfif request.session.accesslevel gte 100>
			<cfset event.setvalue('communityList',application.community.gateway.get())>
		<cfelse>
			<cfset event.setvalue('communityList',application.community.getMine(memberID=request.session.memberID,adminOnly = 1))>
		</cfif>
	</cffunction>
		
	<cffunction name="configure">
		 <cfargument name="event"> 
		<cfscript>
			var rc = event.getCollection();
		    rc.sidebar = renderView('app/dashboard/nav');
		</cfscript>
	</cffunction>
	
	<cffunction name="premium">
	  	<cfargument name="event" />
	    <cfscript>
		    var rc = event.getCollection();
		   	rc.sidebar = renderView('app/dashboard/nav');
		</cfscript>
	</cffunction>	
	
	<cffunction name="community">
		 <cfargument name="event"> 
		<cfscript>
			var rc = event.getCollection();
		</cfscript>
	</cffunction>
	
	<cffunction name="forms">
		 <cfargument name="event"> 
		<cfscript>
			var rc = event.getCollection();
		    event.setvalue('forms', application.forms.getForms(communityID = rc.communityID));
		    event.setView('cms/forms/index'); 
		</cfscript>
	</cffunction>
	
	<cffunction name="manage">
		 <cfargument name="event"> 
		<cfscript>
			var rc = event.getCollection();
		    rc.sidebar = renderView('app/dashboard/nav');
		</cfscript>
	</cffunction>
	
	<cffunction name="statistics">
		 <cfargument name="event"> 
		<cfscript>
			var rc = event.getCollection();
		    rc.sidebar = renderView('app/dashboard/nav');
		</cfscript>
	</cffunction>
	
</cfcomponent>