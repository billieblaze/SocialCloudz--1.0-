<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="contentID">
		<cfargument name="contentType">
		<cfargument name="memberID">
	    <cfargument name="level">
	    <Cfset var qFavorites = ''>
	    <Cfquery datasource="#this.datasource#" name="qFavorites">
			select * from favorites f
			inner join content c on c.contentID = f.contentID
			inner join standardattribs sa on sa.contentID = c.contentID
			inner join contenttype ct on ct.contentType = c.contentType
			where 1=1
			
			<cfif isDefined('arguments.contentID') and arguments.contentID neq ''>
				and f.contentID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.contentID#">
			</cfif>

			<cfif isDefined('arguments.contentType') and arguments.contentType neq ''>
				and c.contentType = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#arguments.contentType#">
			</cfif>

			<cfif isDefined('arguments.memberID') and arguments.memberID neq ''>
				and f.memberID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.memberID#">
			</cfif>
			
			<cfif isDefined('arguments.level') and arguments.level neq ''>
				and level = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.level#">
			</cfif>
									
		</cfquery>	    
	    <Cfreturn qFavorites>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="contentID">
		<cfargument name="level" default="1">
		<cfargument name="memberID" default="#request.session.memberID#">
		<cfscript>
			super.save('favorites',arguments,'update');
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" hint="I delete favorites">
		<cfargument name="contentID">
		<cfquery datasource="#this.datasource#">
			delete from favorites 
			where memberID = #request.session.memberID# 
			and contentID = #arguments.contentID#
		</cfquery>
	</cffunction>

</cfcomponent>