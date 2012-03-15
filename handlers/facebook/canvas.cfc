<cfcomponent output="false">
	<cfproperty name="facebook" inject="model">

	<cfscript>
		this.event_cache_suffix = "";
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>


	<!--- Default Action --->
	<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfset event.setLayout('layout.ajax')>
		<cfscript>
			rc.facebook = variables.facebook;
			rc.appData = variables.facebook.authenticate(argumentCollection = rc);
			//writeDump(appData);
			rc.targetID = rc.appData.user_id;
			rc.sourceData = variables.facebook.getObject(objectId = rc.targetId);
			//writeDump(sourceData);
			
			if ( rc.sourceData.id eq rc.appdata.user_id){
				rc.feedData = variables.facebook.getFeed(objectID = rc.targetId).data;	
			}
			//writeDump(feedData);
			event.setView('facebook/contentList');
		</cfscript>
	</cffunction>

</cfcomponent>