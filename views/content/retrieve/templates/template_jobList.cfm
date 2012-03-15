<!--- <cfscript>
	q_content = rc.contentModuleData.query;
	request.addressArray = arrayNew(2);
</cfscript>
<cfoutput>
	<ul>
		<cfloop query='q_content'>
			<cfscript>
				request.addressArray[currentRow][1] = title;
				request.addressArray[currentRow][2] = '#q_content.city#, #q_content.state#';
			</cfscript>
		<li>
			<a href="/index.cfm/content/#q_content.contentType#/#evaluate('q_content.#q_content.linkID#')#">#q_content.title#</a><br>
			Posted: #dateformat(application.timezone.castFromServer(q_content.publishDate, application.community.settings.getValue('timezone')), request.community.dateformat)# - By: #application.members.getusername(q_content.memberid,1)#<br>
			Location: 
				<cfif city neq ''>#city#,</cfif>
				<cfif state neq ''>#state#</cfif>
				<br>
	 	</li>
		</cfloop>
	</ul>
</cfoutput> --->

<cfscript>
	q_content = rc.contentModuleData.query;
	request.addressArray = arrayNew(2);
</cfscript>
<cfoutput>
		<cfloop query='q_content'>
			<cfscript>
				request.addressArray[currentRow][1] = title;
				request.addressArray[currentRow][2] = '#q_content.city#, #q_content.state#';
			</cfscript>
			<strong>Job Title: <a href="/index.cfm/content/#q_content.contentType#/#evaluate('q_content.#q_content.linkID#')#">#q_content.title#</a></strong><br>
			<i>Position: #subtitle#</i><br>
			<i>Posted:</i> #dateformat(application.timezone.castFromServer(q_content.publishDate, application.community.settings.getValue('timezone')), request.community.dateformat)# - <i>By:</i> #application.members.getusername(q_content.memberid,1)#<br>
			<i>Location:</i>
				<cfif city neq ''>#city#,</cfif>
				<cfif state neq ''>#state#</cfif>
				<br><br>
		</cfloop>
</cfoutput>