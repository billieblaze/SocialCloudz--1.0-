<cfscript>
community =  application.community.gateway.get( private=0, directory = 1, limit=qGetModules.displayRows,parentID=request.community.communityID);
</cfscript>

  <cfif community.recordcount eq 0>
		No Sites in this category.
	<cfelse>

		<cfoutput query="community">
			<cfset communityDNS = application.community.domain.listMask(communityId = community.communityID )>
		    <cfscript>
				baseurl = 'http://#communityDNS.subdomain#.#communityDNS.domain#'; 
			</cfscript>
			<cfset title = "#community.Site#<BR />#community.description#">
			
			<div style="float:left; width: #qGetModules.thumbsize#px" class="pad5" title="#title#">
					<A href="#baseurl#" target="_blank"><img src="http://api.thumbalizr.com/?url=#baseurl#&width=#qGetModules.thumbsize#&api_key=#application.thumbalizerkey#" width="#qGetModules.thumbsize#"/></a>
			</div>
			    	
	          
		</cfoutput>
		<br style="clear:both">
		</cfif>