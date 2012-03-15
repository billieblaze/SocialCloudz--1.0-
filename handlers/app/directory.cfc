<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 site directory
		
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
			
		</cfscript>
	</cffunction>

	<cffunction name="index" >
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
		request.layout.template = 6;
		request.page.title = 'Directory';
		event.setvalue('community', application.community.gateway.get(categoryid=event.getvalue('categoryid',''), private=0, directory = 1, limit=10, page=event.getvalue('page',''), parentID=request.community.communityID));
		event.setvalue('communityCount', application.community.gateway.get(parentID = request.community.communityID, categoryid=event.getvalue('categoryid',''), private=0, directory = 1, countonly=1).count);
		event.setvalue('communityCategories', application.community.category.get());

		rc.sidebar = renderView('app/directory/nav');
		</cfscript>
	</cffunction>

</cfcomponent>