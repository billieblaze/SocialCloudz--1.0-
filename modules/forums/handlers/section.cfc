<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 forum section
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index,submit";
		this.allowedMethods = structnew();
	</cfscript>

	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('forums:display.admin');
		</cfscript>
	</cffunction>	

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			event.setvalue('sections',application.forum.getSections(event.getvalue('id'),request.community.communityID));
			structappend(rc, application.util.queryRowToStruct(event.getvalue('sections')),false);

			event.setLayout('layout.AJAX');
			event.setView('section');
		</cfscript>
	</cffunction>
	
	<cffunction name="submit">
	  <cfargument name="event" />
	  <cfscript>
			var rc = event.getCollection();
			
			if(rc.id eq 0){
				rc.sortorder = application.forum.getsections(communityID = rc.communityID).recordcount + 1;
			}

			application.forum.saveSection(rc);
			event.renderData('plain', 'ok');
		</cfscript>
	</cffunction>
	
	<cffunction name="order">
	  <cfargument name="event" />
	  <cfscript>
		var rc = event.getCollection();
		sections = application.forum.getsections();
	
		for (i=1; i lte sections.recordcount; i = i + 1){
			data = structnew();
			data.communityID = request.community.communityID;
			data.ID = sections.ID[i];
	
			if (rc.move eq '-1' and data.ID neq rc.ID){
				if(i eq rc.sortorder){
					data.sortorder = i - 1;
	
				}else if(i eq rc.sortorder -1){
					data.sortorder = i + 1;
				}
				 else {
					data.sortorder = i;
				}
	
			// Move Down
			} else if (rc.move eq '1' and data.ID neq rc.ID){
	
				if(i eq rc.sortorder){
					data.sortorder =i + 1;
	
				}else if(i eq rc.sortorder +1){
					data.sortorder = i - 1;
	
				}
				 else {
					data.sortorder = i;
				}
			} else if (data.ID eq rc.id) {
				data.sortorder = i + rc.move;
			}
			application.forum.saveSection(data);
			structclear(data);
			}
	
	  </cfscript>
	</cffunction>
	
	<cffunction name="delete">
	  	<cfargument name="event" />
	  	<cfscript>
		  	var rc = event.getCollection();
			application.forum.deleteSection(rc);
		</cfscript>
	</cffunction>

</cfcomponent>