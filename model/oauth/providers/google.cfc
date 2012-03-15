<cfcomponent>
	<cffunction name="init">
		<cfargument name="scope" default="https://docs.google.com/feeds/">
		<cfscript>
			this.consumerKey = 'scdevsite.com';
			this.consumerSecret = 'I5OTcgE6wrDYn/krQhtpfRfl';
			this.scope = arguments.scope;
			this.requestEndpoint = "https://www.google.com/accounts/OAuthGetRequestToken?scope="& urlEncodedFormat(scope);
			this.accessEndpoint = "https://www.google.com/accounts/OAuthGetAccessToken";
			this.authorizeEndpoint = "https://www.google.com/accounts/OAuthAuthorizeToken";
			return this;
		</cfscript>
	</cffunction>
</cfcomponent>