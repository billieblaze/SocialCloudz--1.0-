<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 statistics
		
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
			announceInterception('checkAdmin');
			
		</cfscript>
		
		<Cfparam name="rc.communityID" default="#request.community.communityID#">

		<cfset event.setvalue('community', application.community.setupCommunity(communityID = rc.communityID))>

		<cfif request.session.accesslevel gte 100>
			<cfset event.setvalue('communityList',application.community.gateway.get())>
		<cfelse>
			<cfset event.setvalue('communityList',application.community.getMine(memberID = request.session.memberID,adminOnly = 1))>
		</cfif>
		
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
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="detail">
			<cfargument name="event" />
			
	        <cfscript>
	      	  var rc = event.getCollection();	
				event.setvalue('actions',application.statistics.activity.getActions(rc.type));
				event.setLayout('layout.AJAX');
			</cfscript>
	</cffunction>	
	
	<cffunction name="data">
			<cfargument name="event" />
			
	        <cfscript>
	        var rc = event.getCollection();	

			//rc.endDate = dateAdd('w', 1, event.getValue('endDate', now()));
			qActivity = application.statistics.activity.getCount(
						'',
						'#listgetat(rc.activity,1,':')#', 
						'#listgetat(rc.activity,2,':')#',
						'#rc.groupby#', 
						'#rc.startdate#', 
						'#rc.enddate#', 
						'#rc.communityID#');
			categories = listToArray(valueList(qActivity.dateEntered), ',');
			seriesData = {name: 'Count', data: listToArray(valueList(qActivity.views), ',')};
			rc.data = [ categories,seriesData];
			event.renderData('json', rc.data);
			</cfscript>
	</cffunction>
</cfcomponent>