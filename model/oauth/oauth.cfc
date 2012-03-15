<cfcomponent>
	<cffunction name="init">
		<cfscript>
			
			var loadPaths = ArrayNew(1);
			loadPaths[1] = expandPath("/model/oauth/lib/signpost-core-1.2.1.1.jar");
			loadPaths[2] = expandPath("/model/oauth/lib/signpost-commonshttp4-1.2.1.1.jar");
			loadPaths[3] = expandPath("/model/oauth/lib/commons-codec-1.4.jar");
			loadPaths[4] = expandPath("/model/oauth/lib/commons-logging-1.1.1.jar");
			loadPaths[5] = expandPath("/model/oauth/lib/httpclient-4.1.1.jar");
			loadPaths[6] = expandPath("/model/oauth/lib/httpclient-cache-4.1.1.jar");
			loadPaths[7] = expandPath("/model/oauth/lib/httpcore-4.1.jar");
			loadPaths[8] = expandPath("/model/oauth/lib/httpmime-4.1.1.jar");				

			this.loader = CreateObject("component","coldbox.system.core.javaloader.JavaLoader").init(loadPaths);
			
			this.OAuth = this.loader.create('oauth.signpost.OAuth');

			this.consumer = '';
			this.provider = '';
			this.providerData = '';
			this.hasToken = 0;
			this.token = '';
		</cfscript>
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="doAPICall">
		<cfargument name="providerName">
		<cfargument name="apiURL">
		<cfargument name="apiData" default="#structNew()#">
		<cfargument name="returnURL" default="http://#cgi.http_host##cgi.script_name#?#cgi.query_string#">
		<cfargument name="oauth_verifier" default="">
		<Cfargument name="key" default="">
		<Cfargument name="secret" default="">
		<cfargument name="accessToken" default="">
		<cfargument name="accessTokenSecret" default="">
		<cfargument name="httpMethod" default="GET">
		<cfargument name="doBinary" default="false">
		<cfargument name="scope" default="">
		<cfscript>
			arguments.secret = trim(arguments.secret);
			arguments.key = trim(arguments.key);
			this.providerData = createObject('component','providers/#arguments.providerName#').init(argumentcollection = arguments);
			
			if (arguments.accessToken eq '') {
				if (arguments.oauth_verifier eq '' and this.hasToken eq 0){
					this.getRequestToken(returnURL = arguments.returnURL);
				} else if (arguments.oauth_verifier neq '' and this.hasToken eq 0) {
					if (not isdefined('this.providerData.oauthVersion') or this.providerData.oauthVersion eq 1){
						this.getAuthToken(oauth_verifier = arguments.oauth_verifier);
					} else {
						this.getAuthTokenV2(oauth_verifier = arguments.oauth_verifier, redirectURL = arguments.returnURL);
					}
				}
			} else {
				if (not isdefined('this.providerData.oauthVersion') or this.providerData.oauthVersion eq 1){
					this.setAuthToken(accesstoken = arguments.accesstoken, accesstokenSecret = arguments.accessTokenSecret);
				} else { 
					this.setAuthTokenV2(accesstoken = arguments.accesstoken, accesstokenSecret = arguments.accessTokenSecret);
				}
			}
			return this.httpDo(arguments.httpMethod,arguments.apiURL, arguments.apiData,arguments.doBinary);			
		</cfscript>
	</cffunction>
	
	<cffunction name="getRequestToken">
		<cfargument name="returnURL">
		<Cfscript>
			var authURL = '';
				if (not isdefined('this.providerData.oauthVersion') or this.providerData.oauthVersion eq 1){
					this.consumer = this.loader.create('oauth.signpost.commonshttp.CommonsHttpOAuthConsumer').init( 
							this.providerData.consumerKey, 
							this.providerData.consumerSecret);
	
					this.provider = this.loader.create('oauth.signpost.commonshttp.CommonsHttpOAuthProvider').init(
							this.providerData.requestEndpoint,
							this.providerData.accessEndpoint,
							this.providerData.authorizeEndpoint);
	
				 // Get the Auth URL and store the old tokens
				 authURL = this.provider.retrieveRequestToken(this.consumer, arguments.returnURL);
			  } else { 
			  	authURL = this.providerData.requestEndpoint & '?client_id=#this.providerData.consumerKey#&redirect_uri=' & arguments.returnURL & '&scope='&this.providerData.scope; 
			  }
		</Cfscript>
		<cflocation url="#authURL#">
	</cffunction>
	
	<cffunction name="getAuthToken">
		<cfargument name="oauth_verifier">
		<cfscript>		
			var token = '';
		  	token = this.provider.retrieveAccessToken(this.consumer, '#arguments.oauth_verifier#');
		    this.hastoken = 1;
		    return 1;
 		</cfscript>	
	</cffunction>

	<cffunction name="getAuthTokenV2">
		<cfargument name="oauth_verifier">
		<cfargument name="redirectURL">
		<Cfhttp method="get" url="#this.providerData.accessEndPoint#?client_id=#this.providerData.consumerKey#&client_secret=#this.providerData.consumerSecret#&code=#arguments.oauth_verifier#&redirect_uri=#arguments.redirectURL#">
		</cfhttp>

		<cfif cfhttp.responseheader.status_code eq '200'>
			<cfset this.token = cfhttp.filecontent>
			<cfset this.hasToken = 1>
			<cfreturn 1>
		<cfelse>
			<Cfreturn 0>
		</cfif>
	</cffunction>
	
	<cffunction name="setAuthToken">
		<cfargument name="accessToken">
		<cfargument name="accessTokenSecret">
		<cfscript>		
			var token="";
			// Setup the schtuff
			this.consumer = this.loader.create('oauth.signpost.commonshttp.CommonsHttpOAuthConsumer').init( 
					this.providerData.consumerKey, 
					this.providerData.consumerSecret);
					
			this.provider = this.loader.create('oauth.signpost.basic.DefaultOAuthProvider').init(
					this.providerData.requestEndpoint,
					this.providerData.accessEndpoint,
					this.providerData.authorizeEndpoint);
		    token = this.consumer.setTokenWithSecret(arguments.accessToken,arguments.accessTokenSecret);
		    this.hastoken = 1;
		    return 1;
 		</cfscript>	
	</cffunction>

	<cffunction name="setAuthTokenV2">
		<cfargument name="accessToken">
		<cfargument name="accessTokenSecret">
		<cfscript>		
			this.token = arguments.accessToken;
		    this.hastoken = 1;
		    return 1;
 		</cfscript>	
	</cffunction>
		
	<cffunction name="isAuthorized">
		<cfif isdefined('this.hasToken') and this.hasToken eq 1>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>
	
	<cffunction name="outputToken">
		<cfscript>
			var token="";
			if (this.hasToken and this.hasToken eq 1) {
				token=this.consumer.getToken();
			}
			return trim(token);
		</cfscript>
	</cffunction>

	<cffunction name="outputTokenSecret">
		<cfscript>
			var token="";
			if (this.hasToken and this.hasToken eq 1) {
				token=this.consumer.getTokenSecret();
			}
			return trim(token);
		</cfscript>
	</cffunction>
	
	<cffunction name="getParams">
		<cfscript>
			var params = '';
			params = this.loader.create('org.apache.http.params.BasicHttpParams').init();
			this.loader.create('org.apache.http.params.HttpProtocolParams').setUseExpectContinue(params,false);
        	return params;
		</cfscript>
	</cffunction>
	
	<cffunction name="httpDo">
		<cfargument name="httpMethod" default="GET">
		<cfargument name="apiURL" default="">
		<cfargument name="apiData" default="">
		<cfargument name="doBinary" default="false">
		<cfscript>
 			// Create connection to a URL
	        var in1 = "";
	        var br = "";
	        var inputStreamReader = "";
			var	response = "";
			var params = '';
			var httpclient = '';
			var token = '';
			var objConnection = '';
			var bodRow = '';
			var entity = '';
			var in1 = '';
			var intRow = 1;
						
				params = getParams();	
				httpclient = this.loader.create('org.apache.http.impl.client.DefaultHttpClient').init(params);


				//oauth2 needs access_token passed in url
				if (structKeyExists(this.providerData, 'oauthVersion') and this.providerData.oauthVersion eq 2){
					token = this.token;
					if (this.token contains 'access_token'){
						token = replace(token, 'access_token=', '');
						if (token contains '&expires'){
							tokenExpires = find('&expires=', token)-1;
							token = left(token, tokenExpires);
						}
					}
					arguments.apiURL = arguments.apiURL & '?access_token=#urlEncodedFormat(token)#';
					if (structKeyExists(apiData, 'queryString')){
						arguments.apiURL = arguments.apiURL & '&' & apiData.queryString;	
					}
				
				}
			
				if (httpMethod eq "GET") {
					objConnection=this.loader.create('org.apache.http.client.methods.HttpGet').init(arguments.apiURL);
				}
				if (httpMethod eq "DELETE") {
					objConnection=this.loader.create('org.apache.http.client.methods.HttpDelete').init(arguments.apiURL);
					objConnection.addHeader("If-Match", "*"); 
				}
				if (httpMethod eq "PUT") {
					objConnection= this.loader.create('org.apache.http.client.methods.HttpPut').init(arguments.apiURL);
					for (bodRow = 1; bodRow lte arrayLen(apiData.body); bodRow = (bodRow + 1)) {
						entityS= this.loader.create('org.apache.http.entity.StringEntity').init(arguments.apiData.body[bodRow].data,"UTF-8"); 
						objConnection.setEntity(entityS);
						objConnection.addHeader("Content-Type",arguments.apiData.body[bodRow].contenttype); 
					}
					objConnection.addHeader("If-Match","*"); 
				}
				if (httpMethod eq "POST") {
					objConnection= this.loader.create('org.apache.http.client.methods.HttpPost').init(arguments.apiURL);
					for (bodRow = 1; bodRow lte arrayLen(apiData.body); bodRow = (bodRow + 1)) {
						if (arguments.apiData.body[bodRow].type eq "file") {
							f = createObject('java','java.io.File').init(urldecode(arguments.apiData.body[bodRow].data));
							entity = this.loader.create('org.apache.http.entity.FileEntity').init(f,arguments.apidata.body[bodRow].contentType);
						}
						objConnection.setEntity(entity);
					}
				}
				try {
					if (structKeyExists(apiData, 'headers')){
						for (intRow = 1; intRow lte arrayLen(apiData.headers); intRow = (intRow + 1)) {
							objConnection.addHeader(apiData.headers[intRow].type, apiData.headers[intRow].data ); 
						}
					}

					if (not isdefined('this.providerData.oauthVersion') or this.providerData.oauthVersion eq 1){
						this.consumer.sign(objConnection);
					}
					
					if (arguments.doBinary) {
						in1 = this.loader.create('org.apache.http.util.EntityUtils').toByteArray (httpclient.execute(objConnection).getEntity());
					} else {
						in1 = this.loader.create('org.apache.http.util.EntityUtils').toString (httpclient.execute(objConnection).getEntity(),"UTF-8");
					}
				    return in1;
				} catch (UnsupportedEncodingException e) {
				    e.printStackTrace();
				} catch (NullPointerException e) {
				    e.printStackTrace();
				} catch (ClientProtocolException e) {
				    e.printStackTrace();
				} catch (IOException e) {
				    e.printStackTrace();
				}
		</cfscript>
	</cffunction>
</cfcomponent>