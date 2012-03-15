<cfcomponent extends="../baseService">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true"  inject="coldbox:datasource:community">
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			super.init(argumentCollection=arguments);
			
			this.gateway = createObject('component', 'communityGateway').init(this.datasource, variables.instance.DAO);
			this.settings = createObject('component', 'settingsGateway').init(this.datasource, variables.instance.DAO);
			this.domain = createObject('component', 'domainGateway').init( this.datasource, variables.instance.DAO);
			this.category = createObject('component', 'categoryGateway').init( this.datasource, variables.instance.DAO);						

			return this;
		</cfscript>
	</cffunction>

	<cffunction name="getMine">
	   	<cfargument name="memberID">
	   	<Cfargument name="adminOnly" default="0">
	    <cfscript>
			var mySites = application.members.gateway.list(memberid = arguments.memberID, communityID = 0);
			var communities = this.joinCommunityData(mySites);
			var communities2 = '';
		</cfscript>

		<cfif arguments.adminOnly eq 1>
			<Cfquery dbType = 'query' name="communities2">
				select * from communities
				where accesslevel > 1
			</cfquery>
			<Cfset communities = communities2>
		</cfif>
		<cfloop query="communities">
			<cfset	communities.baseurl[currentRow] = this.createBaseURL(		  subdomain = communities.subdomain[currentRow], 
																				  domain = communities.domain[currentRow])>
		</cfloop>

		<cfreturn communities>
    </cffunction>
	
	<cffunction name="joinCommunityData">
		<cfargument name="queryStruct">
	
		<cfscript>
			var getCommunities = '';
			var rQry = '';
			var qry = arguments.queryStruct;
			var communitylist = valuelist(qry.communityid);
			if (communitylist eq ''){ communitylist = 0;}
				
			communitylist = this.utils.listremoveduplicates(communitylist);
		</cfscript>   
	
	    <cfquery datasource="#this.datasource#" name="getCommunities">
	    	select c.communityID, parentId, site,dm.subdomain, dm.domain
	        from community c
	        inner join domains d on c.domainID = d.domainID
	        inner join dnsMask dm on dm.communityID = c.communityID	and startpage = '/'
	        where c.communityid in (#communitylist#)
	    </cfquery>
		
	    <cfquery dbtype="query" name="rQry">
		    select getcommunities.site, getcommunities.parentID, subdomain,domain, qry.*, '' as baseurl from qry, getCommunities
		    where qry.communityID = getcommunities.communityID
		    order by parentId
	    </cfquery>
	    <cfreturn rQry>
	</cffunction>
	
	<cffunction name="isPrivate">
		<cfargument name="communityID"> 
		<cfset var qGetPrivate = ''>
		<cfquery name="qGetPrivate" datasource='#this.datasource#'>
			select ifnull(private,0) as private from community
			where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
			</cfquery>
		<cfreturn qGetPrivate.private>
	</cffunction>
	
	<cffunction name='isOwner'>
		<cfargument name='memberID'>
		<cfif request.community.adminID eq arguments.memberID or request.session.accesslevel gt 10>
			<cfreturn 1>
		<cfelse>
			<cfreturn 0>
		</cfif>
	</cffunction>

	<cffunction name="setupCommunity">
		<cfargument name="host" default="">
		<Cfargument name="CommunityID">
		
		<cfset var community = structNew()>
		<cfset var communityDetail = structNew()>
		<Cfset var host = arguments.host>
		<Cfset var sub = ''>
		<cfset var domain = ''>
		<cfset var domainDetail = structNew()>
		<cfset var domainID = ''>
		<cfset var s_marker = ''>		
		<cfset var d_marker = ''>
		<cfset var getCommunity = ''>

		<cfif host neq ''>
			<cfif host eq 'assets.socialcloudz.com'>
				<cfheader	statuscode="404"	statustext="File Not Found"	/>
				File Not Found
				<cfabort>
			<cfelseif host eq 'localhost'>
				Invalid<CFABORT>
			</cfif>
		</cfif>
	
		<cfscript>

			if (isdefined('arguments.communityID') and arguments.communityID neq ''){
				getCommunity = this.gateway.get(communityID = arguments.communityID);
				sub = getCommunity.subdomain;
				domainID = getCommunity.domainID;
			} else { 
				domainID = '';
				if( listlen(host, '.') eq 2){
					sub = '';
					domain = host;
				} else {
					s_marker = find( ".", host);
					sub = left(host, s_marker-1);
					d_marker = len(host) - s_marker;
					domain = right(host, d_marker);
			    }
			}
			
			domainDetail = this.domain.listMask(subdomain = sub, domain = domain);
			if (domainDetail.recordcount neq 0){
				communityDetail = this.gateway.get(communityID = domainDetail.communityID);
			} else {
				communityDetail = this.gateway.get(subdomain = sub);
			}
			if(communityDetail.recordcount eq 0){
				community.parent.detail = this.gateway.get(communityID = communityDetail.parentID);
				community.parent.domain = this.domain.listMask(communityID = communityDetail.parentID); 					
				location('http://#community.parent.domain.subdomain#.#community.parent.Domain.domain#/index.cfm/app/info/available');
			} else { 
				structAppend(community, this.utils.queryrowtostruct(communityDetail), false);	

				community.domain = this.domain.listMask(communityID = communityDetail.communityID, verified=1); 					
				community.baseurl = this.createBaseURL(subdomain = community.domain.subdomain[1], domain = community.domain.domain[1]);
				community.owner = application.members.gateway.list(communityID=communityDetail.communityID,accesslevel=20);
				community.settings = this.settings.get(communityID = communityDetail.communityID);
				
				community.parent.detail = this.gateway.get(communityID=communityDetail.parentID);
				community.parent.domain = this.domain.listMask(communityID = communityDetail.parentID); 					
				community.parent.baseurl = this.createBaseURL(subdomain = community.parent.domain.subdomain, domain = community.parent.domain.domain);
			}
			
			if (communityDetail.active eq 0){
				location('http://www.#community.parent.domain.domain#/index.cfm/app/info/inactive');
			}
		</cfscript>
		<cfreturn community>
	</cffunction>
	
	<cffunction name="createBaseURL">
		<Cfargument name="subDomain" default="">
		<Cfargument name="Domain" default="">
		<cfscript>
			return  "#arguments.subdomain#.#arguments.domain#";
		</cfscript>
	</cffunction>

	<cffunction name="save">
		<Cfargument name="datastruct">
		
		<cfscript>
			if(isdefined('arguments.datastruct.logo') and arguments.datastruct.logo eq '') { structDelete(arguments.datastruct, "logo"); }
	
			this.gateway.save(arguments.datastruct);
			this.settings.save(arguments.datastruct);	
		</cfscript>
				
	</cffunction>

	<cffunction name="validate">
		<cfargument name="dataStruct">
		
		<Cfscript>
		var message = '';
		
		// Address 
		if (this.gateway.get(subdomain=arguments.datastruct.url).recordcount gt 0)
			message =message & '<li>That URL is already taken.</li>'; 
		
		if (arguments.datastruct.url eq '')
			message =message & '<li>Please enter a URL for your community.</li>';
		
		if (application.processtext.forbiddenwords(arguments.datastruct.url) neq 'clean')
			message =message & '<li>The URL you selected is forbidden. Please select a different URL.</li>';
		
		if (application.processtext.badlanguage(arguments.datastruct.url) neq 'clean')
			message =message & '<li>The URL you selected is forbidden. Please select a different URL.</li>';
			
		if (REFind ("[[:punct:][:cntrl:][:space:]]" ,arguments.datastruct.url) gt 0)
			message =message & '<li>The URL cannot have spaces or punctuation.';
		
		// Name 
		if (arguments.datastruct.site eq '')
			message =message & '<li>Please enter a name for your site.</li>';
		
		// Tagline
		if (arguments.datastruct.tagline eq '')
			message =message & '<li>You must select a tagline for your community.</li>';
		
		// Channel
		if (arguments.datastruct.CategoryID eq '')
			message =message & '<li>You must select a category.</li>';
		
		// Description
		if ( arguments.datastruct.description eq '')
			message =message & '<li>You must select a description for your community.</li>';
		
		// Tags
		if (application.processtext.badLanguage(arguments.datastruct.keywords) neq 'Clean')
			message =message & '<li>Keywords contain inapproprate langauge.</li>';
		
		if (arguments.datastruct.keywords eq '')
			message =message & '<li>Please specify at least 2 descriptive keywords for your site.</li>';
		
		if (not isdefined('arguments.datastruct.terms')){
			message = message & '<li>You must agree to the terms of service.</li>';
		}
		
		return message; 
		</Cfscript>
	</cffunction>

	<Cffunction name="setupAdmin">
		<cfargument name="memberID">
		<Cfargument name="parentCommunity">
		<Cfargument name="targetCommunity">
		
		<cfscript>
			var parent = arguments.parentCommunity;
			var target = arguments.targetCommunity;
			var data = structNew();

			// Join New Site
			application.members.joinSite(communityID = parent.communityID, memberID = arguments.memberID, accessLevel = 1, approved = 1);
			application.members.joinSite(communityID = target.communityID, memberID = arguments.memberID, accessLevel = 20, approved = 1);		

			// save user as creator of new site
			target.adminID = arguments.memberID;
			application.community.gateway.save(target);

			return 1;
		</cfscript>
	</cffunction>

	<cffunction name="flagContent">
		<Cfargument name="contentID">
		<Cfargument name="status">
		<cfargument name="sendNotifcation" default="0">
		<cfscript>
			application.content.gateway.flagContent(arguments.contentid, arguments.status );
			
			if (arguments.sendNotification eq 1){
				application.emailTemplates.send(to=request.community.owner.email, template="contentFlagged");
			}
		</cfscript>
	</cffunction>
</cfcomponent>