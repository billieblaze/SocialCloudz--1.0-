<cfscript>
community = event.getvalue('community');
communityCount = event.getvalue('communityCount');
</cfscript>
<style type="text/css">
hr {color: #fff; background-color: #fff; border: 1px dotted gray; border-style: none none dotted; }
</style>
<div class="mod">
	<div class="hd">Directory 
		<cfoutput><cfif isdefined('rc.categoryid')> - #application.community.category.get(rc.categoryID).category#</cfif></cfoutput>
	</div>
	<div class="bd">
    <cfif community.recordcount eq 0>
		No Sites in this category.
	<cfelse>
	    <table width="100%">
		<cfoutput query="community">
			<cfset communityDNS = application.community.domain.listMask(communityId = community.communityID )>
		    <cfscript>
				baseurl = 'http://#communityDNS.subdomain#.#communityDNS.domain#'; 
			</cfscript>
		   	<TR>
		       	<TD width="150" valign="top">
					<img src="http://api.thumbalizr.com/?url=#baseurl#&width=250&api_key=#application.thumbalizerkey#" width="250"/>
				</TD>
		    	<TD valign="top">
			    	<h2><A href="#baseurl#" target="_blank">#community.Site#</A></h2>
		            <cfif community.category neq ''>
		         	   <B>Category:</B> #community.category#<BR /><BR />
		            </cfif>
		            <cfif community.description neq ''>
		         	   #community.description#
		            </cfif>
	          	<BR /><Br />
	            </TD>
	        </TR>
			<TR><TD colspan=2><hr></td></tr>
		</cfoutput>
		</table>
		<cfoutput>#application.util.queryPaging('/index.cfm/app/directory/index', communityCount, 10)#</cfoutput>
	</cfif>
    </div>
	<div class="ft"></div>
</div>