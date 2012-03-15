<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="categoryID">
		
	    <cfset var qGetCategory = ''>
	
		<cfquery name="qGetCategory" datasource='#this.datasource#'>
			select * from category c
			where c.id = #arguments.categoryid#
		</cfquery>
		<cfreturn qGetCategory>
	</cffunction>

	<cffunction name="list">
		<cfargument name="contentType"> 
		<cfargument name="memberID" default="">	
		<cfargument name="hasEntries" default="1">
		<cfargument name="limit" default="0">
		<cfargument name="page" default="1">
	
		<cfset var qGet = ''>
		<cfset var startRow = 0>
		<cfscript>
			if (isdefined('arguments.limit')) startrow = arguments.page * arguments.limit - arguments.limit;
		</cfscript>
	
		<cfquery datasource="#this.datasource#" name="qGet">
			select category, count(cc.contentID) as count , ct.homelink, cat.id
			from category cat 
		
		    left join contentcategory cc on cat.id = cc.categoryid
			
			<cfif arguments.hasEntries eq 1>
				inner join content c on c.contentID = cc.contentID 
			</cfif>
			
			left join community com on cc.contentID = com.contentID and com.communityID = #request.community.communityID# 
			left join contenttype ct on ct.contentType = cat.contentType
			where cat.contenttype = '#arguments.contentType#'	
			and(cat.communityID =#request.community.communityID# or cat.communityID in (select communityID from community.community where parentID = '#request.community.communityID#')) <!--- TODO:   AND SYNDICATE TO PARENT SITE config variable --->

			<cfif arguments.memberID neq ''>
				and memberID = #arguments.memberID#
			</cfif>

		  	<cfif arguments.hasEntries eq 1>
			  	and approved = 1 and isdeleted = 0
			</cfif>

			group by category
			order by category, count
		
			<cfif arguments.limit neq 0 and arguments.limit neq ''>
				limit #startrow#, #arguments.limit#
			</cfif>
		</cfquery>
		<cfreturn qGet>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="datastruct">
	    <cfscript>
			return super.save('category', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name="delete">
		<cfargument name="id">
	    <cfscript>
			super.delete('category', arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="saveContent">
		<cfargument name="data">
		<cfscript>
			return	super.save('contentcategory', arguments.data);
		</cfscript>
	</cffunction>
	
	<cffunction name="deleteContent"> 
		<cfargument name="contentID">
	
		<cfquery datasource='#this.datasource#'>
			delete from contentcategory 
			where contentID = #arguments.contentID#
		</cfquery>
	</cffunction>
</cfcomponent>