<cfcomponent extends="../baseGateway">
	<cffunction name="get">

	</cffunction>
	
    <cffunction name="save">
		<cfargument name="data">
		<cfscript>
			return super.save('tags',arguments.data,'skip');
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" returntype="void" hint="delete tags">
		<cfargument name="contentId" required="yes" type="string">
		<cfquery datasource="#this.datasource#">
			delete 	from tags
			where	contentId =#Arguments.contentId#
		</cfquery>
	</cffunction>

</cfcomponent>