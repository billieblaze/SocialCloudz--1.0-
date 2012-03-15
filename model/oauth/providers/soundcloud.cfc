<cfcomponent>
	<cffunction name="init">
		<cfscript>
			this.consumerKey = '3MguewHSDiZMdjr6ONRrQQ';
			this.consumerSecret = 'RJFIQ6oA95vdIiLexQNtfd7e6c2l0FSqMbMVyXxsxw';
			this.requestEndpoint = "http://api.soundcloud.com/oauth/request_token";
			this.accessEndpoint = "http://api.soundcloud.com/oauth/access_token";
			this.authorizeEndpoint = "http://api.soundcloud.com/oauth/authorize";

			return this;
		</cfscript>
	</cffunction>
</cfcomponent>

