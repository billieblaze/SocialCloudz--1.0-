<cfquery datasource="statistics" name="getBW">
SELECT sum(total) as total, sum(hits) as hits, communityID FROM `statistics`.`bandwidth` 
where dateEntered > '#dateformat(dateadd('d', now(), -30), 'yyyy-mm-dd')# #timeformat(now(), 'hh:mm:ss')#'
 group by communityID order by total desc, hits desc
</cfquery>


<cfset qry=application.community.joincommunityData(getbw)>

<table width='100%'>
<TR bgcolor='gray'>
	
	<TD><B>Site</B></TD>
	<TD><B>Usage</B></TD>
	<TD><B>Hits</B></TD>
</TR>
<cfoutput query='qry'>
<TR bgcolor='<cfif qry.currentrow mod 2>silver<cfelse>white</cfif>'>

	<TD><A href='http://<cfif dnsmask eq ''>#subdomain#.socialcloudz.com<cfelse>#dnsMask#</cfif>' target='_blank'>#site#</a></td>
	<TD>#application.util.byteConvert(total)#</TD>
	<TD>#hits#</TD>
</TR>
</cfoutput>
</table>
