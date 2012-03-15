<cfscript>
qContent = event.getvalue('qContent');
qRSVPLIst = event.getvalue('qRSVPLIST');
</cfscript>

<cfoutput>
<h1>Guestlist for #qContent.title# on #dateformat(qContent.startDate, request.community.dateformat)#<h1>
<hr />
<cfif qRSVPList.recordcount eq 0>
	No guests have RSVP'd.
<cfelse>
    <cfloop query="qRSVPList">
    #username# - #email#<BR />
    </cfloop>
</cfif>

</cfoutput>