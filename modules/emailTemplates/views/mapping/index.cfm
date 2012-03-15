<cfoutput>	
	Mapping is used to link the current message to a specific set of data requirements such as a status.  
	Choose the tags and values which are required to trigger this email.  
	You may select multiple values for a tag, and they will be joined with an "OR".
	<BR><BR>
	<form action="#event.buildLink('emailTemplates:mapping.submit')#" method="post" id="templateMappingForm">
		<input type="hidden" name="emailid" value="#rc.emailid#">
		<input type="hidden" name="id" value="#rc.id#">
		<table class="table oddEven" width="100%">	
			<thead>
				<th>Tag</th>
				<th>Value</th>
				<th></th>
			</thead>
			<tr>
				<td>
					<select name="tagID">
						<cfloop query="rc.tags">
							<option value="#rc.tags.id#">#rc.tags.tag#</option>
						</cfloop>	
					</select>
				</td>
				<td><input type="text" name="value" value="#rc.value#"></td>
				<td><input type="submit" value="Add" class="button"></td>
			</tr>
			<cfloop query="rc.mappings">
				<tr>
					<td>#tag#</td>
					<td>#value#</td>
					<td>
						<a href="#event.buildLink(event='emailTemplates:mapping.index', queryString='emailID=#emailid#&id=#id#')#" class="ajaxTabLink">Edit</a> | 
						<a href="#event.buildLink(event='emailTemplates:mapping.delete', queryString='emailID=#emailID#&id=#id#')#" class="ajaxTabLink">Delete</a>
					</td>
				</tr>
			</cfloop>
		</table>
	</form>
</cfoutput>
<script>
	// bind 'myForm' and provide a simple callback function 
	$('form#templateMappingForm').ajaxForm(function(responseText) { 
		$('form#templateMappingForm').parent().html(responseText);
	 }); 
</script>