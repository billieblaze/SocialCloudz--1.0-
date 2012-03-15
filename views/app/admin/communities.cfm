<cfscript>
communities = event.getvalue('communities');
</cfscript>

<table width='100%'>
	<TR bgcolor='gray'>
		<TD>Name</td>
		<TD>Url</td>
	</tr>
	<cfoutput query='communities'>
		<TR bgcolor='<cfif communities.currentrow mod 2>silver<cfelse>white</cfif>'>
			<TD valign="top">#site#</td>
			<TD>
				<cfset dnsMask = application.community.domain.listMask(communityID = communities.communityID)>
				<Cfloop query="dnsMask">
					<cfset myurl = 'http://'>
					<cfif subdomain neq ''>	<cfset myurl = myurl & subdomain & '.'>	</cfif>
					<cfset myurl = myurl & domain>
					
					<A href='#myurl#' target='_blank'>#myurl#</a><br>
				</cfloop>
			</td>
		</tr>
	</cfoutput>
</table>