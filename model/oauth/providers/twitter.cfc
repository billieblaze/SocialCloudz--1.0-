<cfcomponent>
	<cffunction name="init">
		<cfscript>
			this.consumerKey = 'RhwJEV6i7f1Az42Isq3mNw';
			this.consumerSecret = 'Kt79OlaWyAxpXufdgfNPLOuwl3ABGSWGn2a30';
			this.requestEndpoint = "https://api.twitter.com/oauth/request_token";
			this.accessEndpoint = "https://api.twitter.com/oauth/access_token";
			this.authorizeEndpoint = "https://api.twitter.com/oauth/authorize";
			return this;
		</cfscript>
	</cffunction>
</cfcomponent>