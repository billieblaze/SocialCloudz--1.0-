<cfcomponent>
	<cffunction name="init">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="autocomplete">
		<cfargument name="term">
		
		<cfscript>
			var members = '';
			var content = '';
			var communities = ''
			var results = '';
			
			arguments.term = replace(arguments.term,'%40','');
			arguments.term = replace(arguments.term,'@','');
			members = application.members.gateway.list(search=arguments.term);
//			communities = application.community.gateway.get(search=arguments.term);
			content = application.content.get(search=arguments.term, mode='simple');
		</cfscript>
		
		<cfquery name="results" dbtype='query'>
			select username as label,  'member_'+memberid as value from members
			union
	<!---		select site as label,  'community_'+communityid as value from communities
			union --->
			select title as label,  'content_'+contentid as value from content
		</cfquery>
		<cfreturn results>
	</cffunction>
	
	<cffunction name="all">
		<cfargument name="term">
		<cfargument name="contentType" default="all">
		<cfscript>
			var members = '';
			var content = '';
			var communities = ''
			var results = '';
			if ( arguments.contentType eq 'all' or arguments.contentType eq 'members')
				members = application.members.gateway.list(search=arguments.search, communityID = request.community.communityID);
				
//			if ( arguments.contentType eq 'all' or arguments.contentType eq '')				
//			communities = application.community.gateway.get(parentId = request.community.parentID, search=arguments.search);

			if ( arguments.contentType neq 'members')
				content = application.content.get(search=arguments.search, contentType=arguments.contentType, communityID = request.community.communityID, mode='simple');
		</cfscript>
		
		<cfif arguments.contentType eq 'all'>
			<cfquery name="results" dbtype='query'>
				select 'member' as type, memberID as ID, username as title, dateEntered  from members
				union
				<!---select 'community' as type, communityID as ID, site as title,  dateCreated as dateEntered from communities
				union---> 
				select contentType  as type, contentID as ID, title as title, publishDate as dateEntered from content
			</cfquery>
		<cfelseif arguments.contentType eq 'members'>
			<cfquery name="results" dbtype='query'>
				select 'member' as type, memberID as ID, username as title, dateEntered  from members
			</cfquery>
		<cfelse>
			<cfquery name="results" dbtype='query'>
				select contentType  as type, contentID as ID, title as title, publishDate as dateEntered from content
			</cfquery>
		</cfif>
		<cfreturn results>
	</cffunction>
	
</cfcomponent>