<Cfset thumbalizrURL = 'http://api.thumbalizr.com/?api_key=#application.thumbalizerkey#'>

<Cffunction name="checkThumbNail">
	<cfargument name="url">
	<Cfargument name="width" default="300">
	<cfhttp url="#thumbalizrURL#&url=#arguments.url#&width=#arguments.width#&output=text">
	</cfhttp>
	<Cfif right(cfhttp.filecontent,2) eq 'OK'>
		<cfreturn 1>
	<cfelse>
		<Cfreturn 0>
	</cfif>
</cffunction>

<Cffunction name="getThumbNail">
	<cfargument name="url">
	<Cfargument name="width" default="300">
	<Cfargument name="communityID">
	
	<Cfset var imageData = ''>
	
	<cfhttp url="#thumbalizrURL#&url=#arguments.url#&width=#arguments.width#" file="#arguments.communityID#.jpg" path="#expandPath('/images/')#">
	</cfhttp>
</cffunction>
<cfscript>
	community = application.community.gateway.get();

	for (i = 1; i lte community.recordcount; i = i + 1){
		if (community.dnsmask[i] eq ''){ 
			baseurl = 'http://#community.subdomain[i]#.socialcloudz.com'; 
		} else {
			baseurl = 'http://#community.dnsmask[i]#';
		}

		
		if (checkThumbNail(baseurl, 300) eq 1){
			getThumbNail(baseURL, 300, community.communityID[i]);
		}
	}
</cfscript>