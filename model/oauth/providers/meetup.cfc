<cfcomponent>
	<cffunction name="init">
		<cfscript>
			this.consumerKey = '';
			this.consumerSecret = '';
			this.requestEndpoint = "https://api.meetup.com/oauth/request/";
			this.accessEndpoint = "";
			this.authorizeEndpoint = "";
			return this;
		</cfscript>
	</cffunction>
</cfcomponent>
