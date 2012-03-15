<cfcomponent>
	<cffunction name="init">
		<cfreturn this>
	</cffunction>
	
	<Cffunction name="authenticate">
		<cfargument name="signed_request">
		<cfargument name="pageID">
		
		<cfif isdefined('arguments.signed_request')>
			<cfset raw_str = ListGetAt(arguments.signed_request, 2, ".")>
			<cfset res = Len(raw_str) % 4>
			<cfif res eq 2>
			     <cfset raw_str &= "==">
			<cfelseif res eq 3>
			     <cfset raw_str &= "=">
			</cfif>
			
			<!--- Base 64 Decode --->
			<cfset result = ToString(BinaryDecode(raw_str, "Base64"))>
			
			<!--- String to JSON --->
			<cfset appData = DeserializeJSON(result)>
		</cfif>

		<cfif isdefined('arguments.pageID')>
			<cfset appData.page.id = arguments.pageID>
		</cfif>

		<cfoutput>
			<cfif (not isDefined('appData.user_id') or appData.user_id eq '') and not isdefined('rc.pageID')>
			<script>
				location.href='https://www.facebook.com/dialog/oauth/?client_id=#application.community.settings.getValue('facebookAPI')#&redirect_uri=#cgi.script_name#/#cgi.path_info#;
			</script>
			<cfabort>
			</cfif>
		</cfoutput>
			
		<cfreturn appData>
	</cffunction>
	
	<cffunction name="getObject">
		<cfargument name="appData">
		<cfargument name="objectID">
			<cfscript>
				if (not isdefined('session.oauth.facebook')){
					session.oauth.facebook = createObject('component','/model/oauth/oauth').init(useJavaLoader = 1);
				}
				
				token = '';
				
				if (isdefined('appData.oauth_token')){
					token = appData.oauth_token;
				}

				apiResponse = session.oauth.facebook.doAPICall(
					providerName='facebook', 
					apiURL = 'https://graph.facebook.com/#arguments.objectid#',
					scope='access_token,user_events,friends_events',
					accesstoken = token,
					key = application.community.settings.getValue('facebookAPI'),
					secret = application.community.settings.getValue('facebookAppSecret')
				);
				
				sourcedata=deserializeJSON(apiResponse);
				return sourceData;
			</cfscript>
	</cffunction>
	
	<cffunction name="getFeed">
		<cfargument name="appData">
		<cfargument name="objectID">

		<cfscript>
			token = '';
			
			if (not isdefined('session.oauth.facebook')){
				session.oauth.facebook = createObject('component','/model/oauth/oauth').init(useJavaLoader = 1);
			}
			
			if (isdefined('appData.oauth_token')){
				token = appData.oauth_token;
			}
			apiResponse = session.oauth.facebook.doAPICall(
				providerName='facebook', 
				apiURL = 'https://graph.facebook.com/#arguments.objectID#/feed',
				scope='access_token,user_events,friends_events',
				accesstoken = token,
				key = application.community.settings.getValue('facebookAPI'),
				secret = application.community.settings.getValue('facebookAppSecret')
			);
			
			feedData=deserializeJSON(apiResponse);
			return feedData;
		</cfscript>
	</cffunction>
	
	<cffunction name="importEvent">
	
	</cffunction>

	<cffunction name="importPhoto">
	
	</cffunction>
	
	<cffunction name="importVideo">
	
	</cffunction>
	
	<cffunction name="importLink">
	
	</cffunction>
	<cffunction name="importMusic">
	
	</cffunction>
</cfcomponent>