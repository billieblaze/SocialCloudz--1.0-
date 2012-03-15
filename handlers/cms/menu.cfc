<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 cms menu
		
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
		</cfscript>
	</cffunction>
	
	<cffunction name="index">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();			
	     	event.setvalue('menu', application.cms.menu.get());
			event.setvalue('menuFeatures', application.cms.menu.getFeatures());
			event.setvalue('menuCMS',  application.cms.page.get());
			event.setvalue('types',application.members.profile.getTypes(communityID = request.community.communityID));
			event.setLayout('layout.AJAX');
        </cfscript>
	</cffunction>
    
	<cffunction name="submit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();	
			rc.json = replace(rc.json, 'null,', '', 'all');
			rc.json = replace(rc.json, ',null', '', 'all');
			rc.json = replace(rc.json, 'null', '', 'all');
			menuData = deserializeJSON(rc.json);
			menuOrder = trim(rc.order);
			
			application.cms.menu.delete();
			cnt = 1;
        </cfscript>
        <cfloop list="#menuOrder#" delimiters=" " index="i">
	        <cfloop from="1" to="#arraylen(menuData)#" index="j">
				<cfif (menudata[j].sortorder eq i)>
					<cfscript>
						data = structnew();
						data.title = menudata[j].title;
						data.sortorder = cnt;
						data.communityID = request.community.communityID;
						data.type = menudata[j].type;
						data.url = menudata[j].url;
						data.newWindow = menuData[j].newWindow;
						data.visibleTo = menuData[j].visibleTo;
						data.visibleToProfileType = menuData[j].visibleToProfileType  ;
						data.feature = menuData[j].feature;
						data.cms = menuData[j].cms;
						application.cms.menu.save(data);
						structclear(data);
						cnt = cnt + 1;
					</cfscript>
	            </cfif>
	        </cfloop>
		</cfloop>

    	<cfscript>
			rc.communityID = request.community.communityID;
			application.community.settings.save(rc);
			announceinterception('logActivity', {	activityType='cms', 
			 	activityAction='update menu', 
				contentType = 'menu', 
				memberID = request.session.memberID});
			relocate(request.session.lastpage);
	  	</cfscript>
	</cffunction>
</cfcomponent>