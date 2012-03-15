<Cfset rc.sTags =  application.utils.queryColumnsToStruct(rc.qTags,'tag')>

<cfoutput query='rc.template'>
	To: user@user.com<BR>
	<BR>
	
	<Cfif cc neq ''>
		CC: #cc#<BR>
		<BR>
	</cfif>
	
	<Cfif bcc neq ''>
		BCC: #bcc#<BR>
		<BR>
	</cfif>
	
	Subject: #application.emailTemplates.parseTags(rc.Template.subject, rc.sTags, structNew() )#<BR>
	<BR>
	Body: <BR>
	 #application.emailTemplates.parseTags(rc.Template.body, rc.sTags, structNew() )#<BR>
</cfoutput>