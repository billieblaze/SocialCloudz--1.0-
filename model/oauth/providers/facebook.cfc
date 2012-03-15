<cfcomponent>
	<cffunction name="init">
		<Cfargument name="key">
		<cfargument name="secret">
		<cfargument name="scope" default="email,user_groups,read_stream">
		<cfscript>
			this.consumerKey = arguments.key;
			this.consumerSecret = arguments.secret;
			this.scope = arguments.scope;
			this.requestEndpoint = "https://www.facebook.com/dialog/oauth";
			this.accessEndpoint = "https://graph.facebook.com/oauth/access_token";
			this.authorizeEndpoint = "";
			this.oauthVersion = '2';
			
			return this;
		</cfscript>
	</cffunction>
</cfcomponent>