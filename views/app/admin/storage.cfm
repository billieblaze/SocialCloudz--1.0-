<cfquery datasource="statistics" name="getstorage">
SELECT sum(filesize) as total, communityID FROM `statistics`.`files`  group by communityID order by total desc
</cfquery>
<cfset qry="#application.community.joincommunityData(getStorage)#">

<table width='100%'>
<TR bgcolor='gray'>
	<TD><B>Site</b></TD>
	<TD><B>URL</B></TD>
	<TD><B>Usage</B></TD>
</TR>
<cfoutput query='qry'>
<TR bgcolor='<cfif qry.currentrow mod 2>silver<cfelse>white</cfif>'>
	<TD>#site#</TD>
	<TD><A href='http://<cfif dnsmask eq ''>#subdomain#.socialcloudz.com<cfelse>#dnsMask#</cfif>' target='_blank'><cfif dnsmask eq ''>#subdomain#.socialcloudz.com<cfelse>#dnsMask#</cfif></a></td>
	<TD>#application.util.byteConvert(total)#</TD>
</TR>
</cfoutput>
</table>
