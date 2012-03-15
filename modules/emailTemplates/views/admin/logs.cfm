<table width="100%" class="table oddEven">
	<thead>
		<th>Sent</th>
		<th>Recipients</th>
		<th>Content</th>
	</thead>
	<cfoutput query="rc.logs">
	<tr>
		<td width="10%" valign="top">
			#dateFormat(rc.logs.dateSent,'mm-dd-yy')#<br>
			#timeFormat(rc.logs.dateSent)#
		</td>
		<td width="20%" valign="top">
			<cfif rc.logs.to neq ''>
				<cfset tolist = ReplaceNoCase(rc.logs.to, ';', '; ','all')>
				<strong>To:</strong> #tolist#<br>
			</cfif>
			<cfif rc.logs.cc neq ''>
				<cfset cclist = ReplaceNoCase(rc.logs.cc, ';', '; ','all')>
				<strong>CC:</strong> #cclist#<br>
			</cfif>
			<cfif rc.logs.bcc neq ''>
				<cfset bcclist = ReplaceNoCase(rc.logs.bcc, ';', '; ','all')>
				<strong>BCC:</strong> #bcclist#<br>
			</cfif>
		</td>
		<td width="70%" valign="top">
			<b>Subject: </b>#rc.logs.subject#<br />
			
			<b>Body</b><hr />
			#rc.logs.body#
		</td>				
	</tr>
	</cfoutput>
</table>