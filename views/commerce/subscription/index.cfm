<cfscript>
billing = event.getvalue('billing');
communitylist = valuelist(billing.communityID);
</cfscript>
<h2>Upcoming Recurring Payments</h2>

<table width="100%">
<TR bgcolor='gray'>
	<TD>Site</TD>
	<TD>Products</TD>
	<TD>Last Billed</TD>
	<TD>Next Billing</TD>
	<TD>Last Response</TD>        

    <TD>Resources</TD>
</TR>
<cfoutput query="billing">
<cfscript>
	community = application.community.gateway.get(communityid = billing.communityid);
</cfscript>
<cfquery datasource="statistics" name="getBW">
SELECT ifnull(sum(total),0) as total FROM `statistics`.`bandwidth` 
where communityID = #billing.communityID#
and dateEntered > #billing.lastbilled#
</cfquery>
<cfquery datasource="statistics" name="getstorage">
SELECT ifnull(sum(filesize),0) as total FROM `statistics`.`files`  
where communityID = #billing.communityID#
</cfquery>
<TR bgcolor='<cfif billing.currentrow mod 2>silver<cfelse>white</cfif>' valign="top">
	<TD>#community.communityid# - #community.site#</TD>
    <TD>#name#</TD>
    <TD>#dateformat(lastbilled)#</TD>
    <TD>#dateformat(dateadd('m', recurringFrequency, lastbilled))#</TD>
    <TD>#lastresponse#</TD>    

    <TD>Storage: #application.util.byteConvert(getStorage.total)# / #application.util.byteConvert(Storage)#<BR />
    	Bandwidth: #application.util.byteConvert(getbw.total)# / #application.util.byteConvert(Bandwidth)#
</TR>
</cfoutput>
</table>

<h2>Not being billed</h2>
<table width="100%">
<TR bgcolor='gray'>
	<TD>Site</TD>
    <TD>Resources</TD>
</TR>
<cfquery name="getSites" datasource="community">
select site, communityID, bandwidth, storage from community
where communityid not in (#communityList#)
</cfquery>
<cfoutput query="getSites">
<cfquery datasource="statistics" name="getBW">
SELECT ifnull(sum(total),0) as total FROM `statistics`.`bandwidth` 
where communityID = #getsites.communityid#
and dateEntered > #dateadd('d', -30, now())#
</cfquery>
<cfquery datasource="statistics" name="getstorage">
SELECT ifnull(sum(filesize),0) as total FROM `statistics`.`files`  
where communityID = #getsites.communityid#
</cfquery>
<TR bgcolor='<cfif getSites.currentrow mod 2>silver<cfelse>white</cfif>' valign="top">
	<TD>#getSites.site#</TD>
    <TD>Storage: #application.util.byteConvert(getStorage.total)# / #application.util.byteConvert(getSites.Storage)#<BR />
    	Bandwidth: #application.util.byteConvert(getbw.total)# / #application.util.byteConvert(getSites.Bandwidth)#</TD>
</TR>
</cfoutput>
</Table>