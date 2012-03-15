<cfcomponent output="false">
	<cfproperty name="facebook" inject="model">

	<cfscript>
		this.event_cache_suffix = "";
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "list";
		/* HTTP Methods Allowed for actions. */
		/* Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'} */
		this.allowedMethods = structnew();
	</cfscript>
	
	<cffunction name="prehandler" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfscript>
				if (not isdefined('session.oauth.facebook')){
					session.oauth.facebook = createObject('component','/model/oauth/oauth').init(useJavaLoader = 1);
				}
				
				apiResponse = session.oauth.facebook.doAPICall(
					providerName='facebook', 
					apiURL = 'https://graph.facebook.com/#rc.objectID#',
					oauth_verifier=event.getValue('code',''),
					returnURL = 'http://#cgi.http_host#/index.cfm/facebook/import/list',
					key = application.community.settings.getValue('facebookAPI'),
					secret = application.community.settings.getValue('facebookAppSecret'),
					scope = 'user_events,friends_events'
				);
				
				rc.data=deserializeJSON(apiResponse);
			
		</cfscript>
		<cfset rc.objectData = variables.facebook.getObject(objectID = rc.objectID)>
		<cfset event.setLayout('layout.ajax')>
	</cffunction>
	
	<cffunction name="list" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()> 
		<cfset event.setView('facebook/import')>
	</cffunction>
		
	<!--- Default Action --->
	<cffunction name="event" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfscript>
				
				fileName = '#createUUID()#.jpg';
				image = '#application.tempUpload#/#filename#';
		</cfscript>
			<cfhttp method="get" getasbinary="true" url="#rc.objectdata.metadata.connections.picture#" file='#image#'>
		<Cfset container = 'user_#request.session.memberid#'>
		
		<cfset session.mosso = CreateObject("component", "model.cloudfiles").init(application.MOSSO_USER, application.MOSSO_KEY) />
		<cftry>
			<cfif session.mosso.createContainer(container)>
				<cfset uri = session.mosso.enableCDN(container) />
			</cfif>
			<cfcatch type="any"><cfset log.warn('Could Not Create Container')></cfcatch>
		</cftry>

		<cfset containerDetails = session.mosso.getContainer(container) />
		<cfset log.info('Put Object to CloudFiles')>
		<cfset session.mosso.putObject( container, filename , '#image#', 'image/jpeg') />
		
		
		<cfset rc.contentData = {
					title = rc.objectData.name,
					startdate:  application.timezone.castToServer(rc.objectdata.start_time, application.community.settings.getValue('timezone')),
					enddate: application.timezone.castToServer(rc.objectData.end_time, application.community.settings.getValue('timezone')),
					desc = '<pre>'&application.processText.activateURL(rc.objectData.description)&'</pre>',
					facebookID = rc.objectData.id,
					venue = rc.objectData.location,
					contentType = 'event',
					memberID = request.community.adminID,
					image = '#containerDetails.cdn.uri#/#fileName#',
					communityID = request.community.communityID,
					approved = 1
			}>
		<Cfif isDefined('rc.objectData.venue')>
			<cfif isdefined('rc.objectData.street')>
				<cfset rc.contentData.address = rc.objectData.venue.street>
			</cfif>
		
			<cfif isdefined('rc.objectData.city')>
				<cfset rc.contentData.city = rc.objectData.venue.city>
			</cfif>
		
			<cfif isdefined('rc.objectData.state')>
				<cfset rc.contentData.state = rc.objectData.venue.state>
			</cfif>
		
			<cfif isdefined('rc.objectData.country')>
				<cfset rc.contentData.country = rc.objectData.venue.country>
			</cfif>
		
		</cfif>
	</cffunction>

	<cffunction name="photo" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfdump var='import photo'><cfabort>		
	</cffunction>

	<cffunction name="music" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfdump var='import music'><cfabort>
	</cffunction>

	<cffunction name="link" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfdump var='import link'><cfabort>		
	</cffunction>

	<cffunction name="video" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfdump var='import video'><cfabort>		
	</cffunction>
	
	<cffunction name="postHandler" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>

		<cfdump var='#rc.contentData#'>
		
		<cfset contentID = application.content.save(rc.contentData)>
		<cfdump var="#contentID#">

		<cflocation url="/index.cfm/facebook/pagetab/index/pageID/#rc.pageID#">
	</cffunction>
</cfcomponent>