<cfcomponent hint="This is the Mosso API for Cloud Files">

<!---
Mosso CloudFiles CFC, Version 0.7b 2009-01-17
Author: Louis Brauer (louis77@mac.com)
License: MIT (http://www.opensource.org/licenses/mit-license.php)
Mosso API Reference: v20081119 (http://www.mosso.com)
 --->
	
	<cfscript>
		variables.STATUS_NOTCONNECTED = 0;
		variables.STATUS_CONNECTED = 1;
		variables.SESSION_TIMEOUT = 300;
		variables.SESSION_EXPIRATION = 86400;
		variables.MOSSO_MAX_CONTAINERNAME_LENGTH = 63;
		variables.MOSSO_MAX_OBJECTNAME_LENGTH = 127;
		variables.MOSSO_META_HEADER_PREFIX = "X-Object-Meta-";
		variables.MOSSO_AUTH_URL_BASE = "api.mosso.com/auth";
	
		variables.mosso_storage_url = "";
		variables.mosso_cdn_url = "";
		variables.mosso_auth_token = "";
		variables.mosso_status = variables.STATUS_NOTCONNECTED;
		variables.mosso_user = "";
		variables.mosso_key = "";
	
		variables.mosso_auth_token_created = "";
		variables.mosso_last_request = "";
	</cfscript>	

	<cffunction name="init" access="public" returnType="any" output="no">
		<cfargument name="user" type="string" required="true" />
		<cfargument name="key" type="string" required="true" />
		<cfargument name="ssl" type="boolean" required="false" default="true" />
		
		<cfscript>
			variables.mosso_user = arguments.user;
			variables.mosso_key = arguments.key;
			variables.mosso_protocol = IIf(arguments.ssl eq true, DE("https"), DE("http"));
			variables.mosso_auth_url = "#variables.mosso_protocol#://#variables.MOSSO_AUTH_URL_BASE#";
			_connect();
		
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="_connect" access="private" returnType="void" output="no">
		<cfhttp method="GET" charset="utf-8" url="#variables.mosso_auth_url#" >
			<cfhttpparam type="header" name="X-Auth-User" value="#variables.mosso_user#" />
			<cfhttpparam type="header" name="X-Auth-Key" value="#variables.mosso_key#" />
		</cfhttp>	
		<cfset _refreshTimeout() />	
		
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- Success --->
			<cfcase value="204">
				<cfset variables.mosso_auth_token = cfhttp.responseheader["X-Auth-Token"] />
				<cfset variables.mosso_storage_url = cfhttp.responseheader["X-Storage-Url"] />
				<cfset variables.mosso_cdn_url = cfhttp.responseheader["X-CDN-Management-Url"] />
				<cfset variables.mosso_status = variables.STATUS_CONNECTED />
				<cfset variables.mosso_auth_token_created = variables.mosso_last_request />
			</cfcase>
			
			<!--- Authentication failed --->
			<cfcase value="401">
				<cfset variables.mosso_status = variables.STATUS_NOTCONNECTED />
				<cfthrow type="Mosso.Connection.AuthenticationFailed" message="Authentication to Mosso failed (User: #variables.mosso_user#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
			
			<!--- Something went wrong --->
			<cfdefaultcase>
				<cfthrow type="Mosso.Connection.UnexpectedServerResponse" message="Unexpected server response during authentication." detail="Could not authenticate at Mosso API (HTTP message: #cfhttp.errordetail#)" errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="_checkConnection" access="private" returnType="void" output="no">
		<cfscript>
			if(not isConnected()) _connect();
		</cfscript>
	</cffunction>

	<cffunction name="isConnected" access="public" returnType="boolean" output="no">
		<cfscript>
			var result = false;
			if(variables.mosso_status eq variables.STATUS_CONNECTED and (DateDiff("s", variables.mosso_auth_token_created, Now()) lt variables.SESSION_EXPIRATION) and (DateDiff("s", variables.mosso_last_request, Now()) lt variables.SESSION_TIMEOUT))
				result = true;
			else
				variables.mosso_status = variables.STATUS_NOTCONNECTED;
			return result;
		</cfscript>
	</cffunction>

	<!--- Container functions --->

	<cffunction name="getContainerList" access="public" returnType="array" output="no">
		<cfset var result = ArrayNew(1) />
		<cfset _checkConnection />
		
		<cfhttp method="GET" charset="utf-8" url="#variables.mosso_storage_url#">
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>
		<cfset _refreshTimeout() />	
				
		
		
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- no containers --->
			<cfcase value="204">
				<cfset result = ArrayNew(1) />
			</cfcase>
			
			<!--- found containers --->
			<cfcase value="200">
				<cfset result = ListToArray(cfhttp.filecontent, Chr(10), false) />
				<cfset ArraySort(result, "text") />
			</cfcase>
		
		</cfswitch>
		
		<cfreturn result />
	</cffunction>
	
	
	<cffunction name="createContainer" access="public" returnType="boolean" output="no">
		<cfargument name="container" type="string" required="true" />
		<cfset var result = false />
		<cfset _checkConnection />

		<cfhttp method="PUT" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#">
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>			
		<cfset _refreshTimeout() />
		
		
		
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- container created --->
			<cfcase value="201">
				<cfset result = true />
			</cfcase>
			
			<!--- container already existed --->
			<cfcase value="202">
				<cfset result = false />
			</cfcase>
		</cfswitch>	
		
		<cfreturn result />		
	</cffunction>

	<cffunction name="deleteContainer" access="public" returnType="void" output="no">
		<cfargument name="container" type="string" required="true" />
		
		<cfset _checkConnection />

		<cfhttp method="DELETE" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#">
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>			
		<cfset _refreshTimeout() />
		
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- container deleted --->
			<cfcase value="204" />

			<!--- container not found --->
			<cfcase value="404">
				<cfthrow type="Mosso.Request.ContainerNotFound" message="Container not found (#arguments.container#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>

			<!--- container not empty, need to handle this! --->
			<cfcase value="409">
				<cfthrow type="Mosso.Request.ContainerNotEmpty" message="Container not empty (#arguments.container#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
		</cfswitch>		
	</cffunction>
	
	<cffunction name="getContainer" access="public" returnType="struct" output="no">
		<cfargument name="container" type="string" required="true" />
		<cfset var result = StructNew() />
		<cfset _checkConnection />
		
		<cfhttp method="HEAD" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#">
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>	
		<cfset _refreshTimeout() />		
		
		
		
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- container found --->
			<cfcase value="204">
				<cfset result["name"] = arguments.container />
				<cfset result["objects"] = cfhttp.responseheader["X-Container-Object-Count"] />
				<cfset result["size"] = cfhttp.responseheader["X-Container-Bytes-Used"] />
			
				<!--- check if container is CDN enabled --->
				<cfset result["cdn"] = StructNew() />
				<cfset result["cdn"] = _getCDNProperties(arguments.container) />
			</cfcase>
			
			<!--- container not found --->
			<cfcase value="404">
				<cfthrow type="Mosso.Request.ContainerNotFound" message="Container not found (#arguments.container#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
		</cfswitch>	
		
		<cfreturn result />		
	</cffunction>	

	<!--- CDN functions --->
	
	<cffunction name="enableCDN" access="public" returnType="string" output="no">
		<cfargument name="container" type="string" required="true" />
		<cfargument name="ttl" type="numeric" required="false" />
		<cfset var result = ''>
		<cfset _checkConnection />
		<cfhttp method="PUT" charset="utf-8" url="#variables.mosso_cdn_url#/#_encodeContainerName(arguments.container)#">
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
			<cfif isDefined("arguments.ttl")>
				<cfhttpparam type="header" name="X-TTL" value="#arguments.ttl#" />
			</cfif>
		</cfhttp>	
		<cfset _refreshTimeout() />
	
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- container enabled --->
			<cfcase value="201">
				<cfset result = cfhttp.responseheader["X-CDN-URI"] />
			</cfcase>
			<!--- container TTL adjusted --->
			<cfcase value="202">
				<cfset result = cfhttp.responseheader["X-CDN-URI"] />
			</cfcase>
			<cfcase value="404">
				<cfthrow type="Mosso.Request.ContainerNotFound" message="Container not found (#arguments.container#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
		</cfswitch>
		<cfreturn result />	
	</cffunction>


	<!--- Object functions --->

	<cffunction name="getObjectList" access="public" returnType="array" output="no">
		<cfargument name="container" type="string" required="true" />
		<cfargument name="prefix" type="string" required="false" default="" />
		<cfargument name="limit" type="numeric" required="false" default="0"/>
		<cfargument name="offset" type="numeric" required="false" default="0"/>
		<cfset var result = ArrayNew(1) />
		<cfset _checkConnection />
		
		<cfhttp method="GET" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#">
			<cfif Len(arguments.prefix)>
				<cfhttpparam type="URL" name="prefix" value="#_encodeObjectName(arguments.prefix)#" />
			</cfif>		
			<cfif arguments.limit gt 0>
				<cfhttpparam type="URL" name="limit" value="#arguments.limit#" />
			</cfif>
			<cfif arguments.offset gt 0>
				<cfhttpparam type="URL" name="offset" value="#arguments.offset#" />
			</cfif>
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>
		<cfset _refreshTimeout() />
		
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- no objects in container --->
			<cfcase value="204">
				<cfset result = ArrayNew(1) />
			</cfcase>

			<!--- container not found --->
			<cfcase value="404">
				<cfthrow type="Mosso.Request.ContainerNotFound" message="Container not found (#arguments.container#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
			
			<!--- found objects --->
			<cfcase value="200">
				<cfset result = ListToArray(cfhttp.filecontent, Chr(10), false) />
				<cfset ArraySort(result, "text") />
			</cfcase>
		
		</cfswitch>
		
		<cfreturn result />
	</cffunction>
	
	<cffunction name="getObject" access="public" returnType="struct" output="no">
		<cfargument name="container" type="string" required="true" />
		<cfargument name="objectName" type="string" required="true" />
		<cfset var result = StructNew() />
		<cfset _checkConnection />
		<cfhttp method="GET" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#/#_encodeObjectName(arguments.objectName)#" getAsBinary="yes">
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>		
		<cfset _refreshTimeout() />

		

		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- object found --->
			<cfcase value="200">
				<cfset result["name"] = arguments.objectName />
				<cfset result["mimeType"] = cfhttp.mimeType />
				<cfset result["size"] = Val(cfhttp.responseheader["Content-Length"]) />
				<cfset result["timestamp"] = cfhttp.responseheader["Last-Modified"] />
				<cfset result["etag"] = cfhttp.responseheader["Etag"] />
				<cfset result["meta"] = _convertResponseMeta(cfhttp.responseheader) />
				<!--- 
				<cfset result["etag_local"] = LCase(Hash(toString(cfhttp.FileContent), "MD5")) />
				--->
				<cfset result["file"] = cfhttp.FileContent />
			</cfcase>

			<!--- object not found --->
			<cfcase value="404">
				<cfthrow type="Mosso.Request.ObjectNotFound" message="Object not found (#arguments.objectName#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
		</cfswitch>
	
		<cfreturn result />
	</cffunction>

	
	<cffunction name="putObject" access="public" returnType="void" output="yes">
		<cfargument name="container" type="string" required="true" /> 
		<cfargument name="objectName" type="string" required="true" />
		<cfargument name="objectPath" type="string" required="true" />
		<cfargument name="objectMimeType" type="string" required="false" default="" />	
		<cfargument name="objectMeta" type="struct" required="false" />
		<cfset var urlstr = "" />
		<cfset var f = ''>
		<cfset var fHandle = ''>
		<cfset var fSize = ''>
		<cfset var digest = ''>
		<cfset var buffer = ''>
		<cfset var md5 = ''>
		<cfset var i  = ''>
				
		<cfset _checkConnection />
		
		<cfif FileExists(arguments.objectPath)>
			<cfscript>
				fHandle = FileOpen(arguments.objectPath, "readBinary");
				fSize = ListFirst(fHandle.size, " ");
				digest = CreateObject("java", "java.security.MessageDigest").getInstance("MD5");
				while(not FileIsEOF(fHandle)) {
					buffer = FileRead(fHandle, 16384);
					digest.update(buffer);	
				}
				FileClose(fHandle);
				md5 = LCase(BinaryEncode(digest.digest(), "Hex"));
			</cfscript>
			
			<cfset f = FileReadBinary(arguments.objectPath) />
		<cfelse>
			<cfthrow type="Mosso.FileNotFound" message="Local file not found (#arguments.objectPath#)." />
		</cfif>
	
		<cfset urlstr = "#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#/#_encodeObjectName(arguments.objectName)#" />
	
		<cfhttp method="PUT" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#/#_encodeObjectName(arguments.objectName)#">
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
			<cfhttpparam type="header" name="ETag" value="#md5#" />
			<cfhttpparam type="header" name="Content-Length" value="#fSize#" />
			<cfif Len(arguments.objectMimeType)>
				<cfhttpparam type="header" name="Content-type" value="#arguments.objectMimeType#" />
			</cfif>
			<cfif isDefined("arguments.objectMeta")>
				<cfloop list="#StructKeyList(arguments.objectMeta)#" index="i">
					<cfhttpparam type="header" name="#variables.MOSSO_META_HEADER_PREFIX##i#" value="#StructFind(arguments.objectMeta, i)#" />
				</cfloop>
			</cfif>
			<cfhttpparam type="body" value="#f#" />
		</cfhttp>

		<cfset _refreshTimeout() />
		
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- object created --->
			<cfcase value="201" />

			<!--- length missing --->
			<cfcase value="412">
				<cfthrow type="Mosso.Request.ObjectLengthMissing" message="Could not determine object length (#arguments.objectName#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
			
			<!--- checksum mismatch --->
			<cfcase value="422">
				<cfthrow type="Mosso.Request.ChecksumMismatch" message="Local and server checksum mismatch (#arguments.objectName#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
		
		</cfswitch>
	</cffunction>


	<cffunction name="setObjectMeta" access="public" returnType="void" output="no">
		<cfargument name="container" type="string" required="true" /> 
		<cfargument name="objectName" type="string" required="true" />
		<cfargument name="objectMeta" type="struct" required="false" />
		<cfset var i = ''>
		
		<cfset _checkConnection />
		
		<cfhttp method="POST" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#/#_encodeObjectName(arguments.objectName)#">
				<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
				<cfif isDefined("arguments.objectMeta")>
					<cfloop list="#StructKeyList(arguments.objectMeta)#" index="i">
						<cfhttpparam type="header" name="#variables.MOSSO_META_HEADER_PREFIX##i#" value="#StructFind(arguments.objectMeta, i)#" />
					</cfloop>
				</cfif>
		</cfhttp>
		<cfset _refreshTimeout() />
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- object meta accepted --->
			<cfcase value="202" />
			
			<!--- object not found --->
			<cfcase value="404">
				<cfthrow type="Mosso.Request.ObjectNotFound" message="Object not found (#arguments.objectName#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
		</cfswitch>		
	</cffunction>
		
		
	<cffunction name="deleteObject" access="public" returnType="void" output="no">
		<cfargument name="container" type="string" required="true" /> 
		<cfargument name="objectName" type="string" required="true" />
	
		<cfset _checkConnection />
		
		<cfhttp method="DELETE" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#/#_encodeObjectName(arguments.objectName)#">
				<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>
		<cfset _refreshTimeout() />
		
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- object deleted --->
			<cfcase value="204" />
			
			<!--- object not found --->
			<cfcase value="404">
				<cfthrow type="Mosso.Request.ObjectNotFound" message="Object not found (#arguments.objectName#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="getObjectInfo" access="public" returnType="struct" output="no">
		<cfargument name="container" type="string" required="true" /> 
		<cfargument name="objectName" type="string" required="true" />
		<cfset var result = StructNew() />
		<cfset _checkConnection />

		<cfhttp method="HEAD" charset="utf-8" url="#variables.mosso_storage_url#/#_encodeContainerName(arguments.container)#/#_encodeObjectName(arguments.objectName)#">
				<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>
		<cfset _refreshTimeout() />
		<cfswitch expression="#ListFirst(cfhttp.statusCode, " ")#">
			<!--- object found --->
			<cfcase value="200">
				<cfset result["name"] = arguments.objectName />
				<cfset result["container"] = arguments.container />
				<cfset result["mimeType"] = cfhttp.responseheader["Content-Type"] />
				<cfset result["size"] = Val(cfhttp.responseheader["Content-Length"]) />
				<cfset result["timestamp"] = cfhttp.responseheader["Last-Modified"] />
				<cfset result["etag"] = cfhttp.responseheader["Etag"] />
				<cfset result["meta"] = _convertResponseMeta(cfhttp.responseheader) />
			</cfcase>
			
			<!--- object not found --->
			<cfcase value="404">
				<cfthrow type="Mosso.Request.ObjectNotFound" message="Object not found (#arguments.objectName#)." errorCode="#ListFirst(cfhttp.statusCode, " ")#" />
			</cfcase>
		</cfswitch>
		
		<cfreturn result />
	</cffunction>
	
	
	<!--- private util functions --->
	
	<cffunction name="_refreshTimeout" access="private" output="no">
		<cfset variables.mosso_last_request = Now () />	
	</cffunction>
	
	<cffunction name="_encodeContainerName" access="private" output="no">
		<cfargument name="container" type="string" required="true" /> 
		<cfset var encodedContainerName = "" />
		<cfif FindOneOf("?/", arguments.container)>
			<cfthrow type="Mosso.ContainerNameInvalid" message="Container names must not contain ? and / characters." />
		</cfif>
		
		<cfset encodedContainerName = Replace(URLEncodedFormat(arguments.container, "utf-8"), "+", "%20", "ALL") />
		<cfif Len(encodedContainerName) gt variables.MOSSO_MAX_CONTAINERNAME_LENGTH>
			<cfthrow type="Mosso.ContainerNameTooLong" message="Container names must have no more than #variables.MOSSO_MAX_CONTAINERNAME_LENGTH# characters." />
		</cfif>		
		
		<cfreturn encodedContainerName />
	</cffunction>
	
	<cffunction name="_encodeObjectName" access="private" output="no">
		<cfargument name="objectName" type="string" required="true" /> 
		<cfset var encodedObjectName = "" />
		<cfif FindOneOf("?", arguments.objectName)>
			<cfthrow type="Mosso.ObjectNameInvalid" message="Object names must not contain ?  character." />
		</cfif>
		
		<cfset encodedObjectName = Replace(URLEncodedFormat(arguments.objectName, "utf-8"), "+", "%20", "ALL") />
		<cfif Len(encodedObjectName) gt variables.MOSSO_MAX_OBJECTNAME_LENGTH>
			<cfthrow type="Mosso.ObjectNameTooLong" message="Object names must have no more than #variables.MOSSO_MAX_OBJECTNAME_LENGTH# characters." />
		</cfif>	
		
		<cfreturn encodedObjectName />
	</cffunction>	
	
	<cffunction name="_getCDNProperties" access="private" returnType="struct" output="no">
		<cfargument name="container" type="string" required="true" />
		<cfset var result2 = StructNew() />
		<cfset _checkConnection />
		
		<cfhttp method="HEAD" charset="utf-8" url="#variables.mosso_cdn_url#/#_encodeContainerName(arguments.container)#">
			<cfhttpparam type="header" name="X-Auth-Token" value="#variables.mosso_auth_token#" />
		</cfhttp>	
		
		<cfscript>
			_refreshTimeout();
			
			switch(ListFirst(cfhttp.statusCode, " ")) {
				case 204:
					result2["enabled"] = IIf(cfhttp.responseheader["X-CDN-Enabled"] eq "True", true, false);
					if(result2["enabled"]) {
						result2["uri"] = cfhttp.responseheader["X-CDN-URI"];
						result2["ttl"] = Val(cfhttp.responseheader["X-TTL"]);
					} else {
						result2["uri"] = "";
						result2["ttl"] = -1;
					}
					break;
				case 404:
					result2["enabled"] = false;
					result2["uri"] = "";
					result2["ttl"] = -1;
					break;
			}
			return result2; 
		</cfscript>	
	</cffunction>


	<cffunction name="_convertResponseMeta" access="private" returnType="struct" output="no">
		<cfargument name="responseheader" type="struct" required="true" />
		<cfset var meta_value = "" />
		<cfset var meta_key = "" />
		<cfset var result = StructNew() />
		<cfset var i = ''>
		
		<cfloop list="#StructKeyList(arguments.responseheader)#" index="i">
			<cfif Find(variables.MOSSO_META_HEADER_PREFIX, i)>
				<cfset meta_value = StructFind(arguments.responseheader, i) />
				<cfset meta_key = Right(i, Len(i)-Len(variables.MOSSO_META_HEADER_PREFIX)) />
				<cfset StructInsert(result, meta_key, meta_value, true) />
			</cfif>
		</cfloop>
		<cfreturn result />
	</cffunction>

	<cffunction name="isContainerNameValid" access="public" returnType="boolean" output="no">
		<cfargument name="container" type="string" required="true" />
		<cfset var result = false />
		<cfscript>
		try {
			_encodeContainerName(arguments.container);
			result = true;
		}
		catch(any exception) {
			result = false;
		}
		
		return result;
		</cfscript>
	</cffunction>
	
	
	<cffunction name="isObjectNameValid" access="public" returnType="boolean" output="no">
		<cfargument name="objectName" type="string" required="true" />
		<cfset var result = false />
		<cfscript>
		try {
			_encodeObjectName(arguments.objectName);
			result = true;
		}
		catch(any exception) {
			result = false;
		}
		
		return result;
		</cfscript>
	</cffunction>	

</cfcomponent>