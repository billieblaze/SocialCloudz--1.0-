<cfoutput>	
	Tags allow datapoints to be dynamically injected into the content of the email.   
	This area is for the developer to briefly describe the tags for presentation in the tag selector UI.   
	<BR><BR>
	<h2>System-wide Tags</h2>
	These are global tags defined in the applications tag decorator cfc.   They map application, request and session values to tags.
	<BR><BR>
	<table class="table oddEven" width="100%">	
		<thead>
			<th>Tag</th>
			<th>Current Value</th>
		</thead>
		<cfloop collection="#rc.globalTags#" item="tag">
			<tr>
				<td valign="top">#tag#</td>
				<td valign="top">
					<cfif isSimpleValue(rc.globalTags[tag]) >	
						#rc.globalTags[tag]#
					<cfelse>
						<cfloop collection="#rc.globalTags[tag]#" item="tag2">
								#tag2#<BR>
						</cfloop>
					</cfif>
				
				</td>
			</tr>
		</cfloop>
	</table>
	<br>
	<h2>Developer Specified Tags</h2>
	These are defined datapoints that will be passed into the email service and become dynamic tags.  
	The developer will manage passing the values in the code, and is responsible for registering them here.  
	<BR><BR>
	<form action="#event.buildLink('emailTemplates:tags.submit')#" method="post" id="templateTagForm">
		<input type="hidden" name="communityID" value="#rc.communityID#">

		<input type="hidden" name="emailid" value="#rc.emailid#">
		<input type="hidden" name="id" value="#rc.id#">
		<table class="table oddEven" width="100%">	
			<thead>
				<th>Tag</th>
				<th>Description</th>
				<th></th>
			</thead>
			<tr>
				<td><input type="text" name="tag" value="#rc.tag#"></td>
				<td><input type="text" name="description" value="#rc.description#"></td>
				<td><input type="submit" value="Add" class="button"></td>
			</tr>
			<cfloop query="rc.tags">
				<tr>
					<td>#tag#</td>
					<td>#description#</td>
					<td>
						<a href="#event.buildLink(linkTo='emailTemplates:tags.index', querystring='emailID=#rc.emailID#&id=#id#&communityID=#rc.communityId#')#" class="ajaxTabLink">Edit</a> | 
						<a href="#event.buildLink(linkTo='emailTemplates:tags.delete', querystring='emailID=#rc.emailID#&id=#id#&communityID=#rc.communityID#')#" class="ajaxTabLink">Delete</a>
					</td>
				</tr>
			</cfloop>
		</table>
	</form>
</cfoutput>
<script>
	// bind 'myForm' and provide a simple callback function 
	$('form#templateTagForm').ajaxForm(function(responseText) { 
		$('form#templateTagForm').parent().html(responseText);
	 }); 
</script>