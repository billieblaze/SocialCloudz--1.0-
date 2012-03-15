<cfcomponent extends="/modules/emailTemplates/model/tagDecorator">
	
	<!--- tags that reference session, or other globally available variables should be defined in the base tagDecorator --->
	
	<cffunction name="getDynamicData">
		<cfargument name="type">
		<cfargument name="key">
		<cfargument name="data">
		<cfset var ws = ''>
		<cfparam name="this.tagData" default="#structNew()#">
		
		<!--- Community --->
		<cfif isdefined('arguments.data.communityID') and arguments.type eq 'community' and not isdefined('this.tagData.community') >
			<cfset this.tagData.community = application.community.get(communityID = arguments.data.communityID)>
		</cfif>
		
		<!--- Member --->
		<cfif isdefined('arguments.data.memberID') and arguments.type eq 'member' and not isdefined('this.tagData.member') >
			<cfset this.tagData.member = application.member.get(memberID = arguments.data.memberID)>
		</cfif>

		<cfif isdefined('arguments.data.email') and arguments.type eq 'member' and not isdefined('this.tagData.member') >
			<cfset this.tagData.member = application.member.get(email = arguments.data.email)>
		</cfif>

		
		<!--- Content --->
		<cfif isdefined('arguments.data.contentID') and arguments.type eq 'content' and not isdefined('this.tagData.content') >
			<cfset this.tagData.content = application.content.get(contentID = arguments.data.contentID)>
		</cfif>

		
		<!--- tag evaluation --->		
		<cfif isdefined('this.tagData.#arguments.type#.#arguments.key#')>
			<cfreturn evaluate('this.tagData.#arguments.type#.#arguments.key#')>
		<cfelse>
			<cfreturn 'WARNING: TAG NOT FOUND! '>
		</cfif>	
	</cffunction>
</cfcomponent>