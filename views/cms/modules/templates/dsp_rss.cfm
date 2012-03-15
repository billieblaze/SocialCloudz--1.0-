<cftry>
<cfscript>
	getModule = qGetModules;
	feed = application.cms.modules.getRSS(attributes.id);
</cfscript>
<cfif feed neq ''>
	<cfscript>
	myquery = application.util.cfrssfeed(feed);
	</cfscript>

	<cfset myquery = application.memcached.get(key="module_rss_#attributes.id#")>
	<cfif not isQuery(myquery)>
		<cfset myquery = application.util.cfrssfeed(feed, getmodule.displayrows)>
		<cfset application.memcached.set(key="module_rss_#attributes.id#",value=myquery,expiry=120)>
	</cfif>

	<cfoutput query="myquery" maxrows="#getmodule.displayrows#">
	<a href="#myquery.link#" target="_blank">#myquery.title#</a><BR />
	<cfif getModule.displaytemplate eq 'title' or getModule.displaytemplate eq ''>
		<BR>
	<cfelseif getModule.displaytemplate eq 'preview'>
		#application.processtext.abbreviate(myquery.description,500)# (<a href="#myquery.link#">Read More</a>)
				<cfif myquery.recordcount neq myquery.currentrow>
			<hr>
		</cfif>
	<cfelseif getModule.displaytemplate eq 'detail'>
		#myquery.description#
		<cfif myquery.recordcount neq myquery.currentrow>
			<hr>
		</cfif>
	</cfif>			
	</cfoutput>
</cfif>
<cfcatch>There was an error loading this RSS feed.</cfcatch>
</cftry>