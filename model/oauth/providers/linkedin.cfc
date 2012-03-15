<cfcomponent>
	<cffunction name="init">
		<Cfargument name="key">
		<cfargument name="secret">
		<cfscript>
			this.consumerKey = arguments.key;
			this.consumerSecret = arguments.secret;
			this.requestEndpoint = "https://api.linkedin.com/uas/oauth/requestToken";
			this.accessEndpoint = "https://api.linkedin.com/uas/oauth/accessToken";
			this.authorizeEndpoint = "https://api.linkedin.com/uas/oauth/authorize";

			return this;
		</cfscript>
	</cffunction>
</cfcomponent>

