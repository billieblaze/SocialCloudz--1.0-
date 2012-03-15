<Cfsetting showdebugoutput="false">
<cfset community = event.getvalue('community')>
<Cfset thisMessage = event.getvalue('messages')>
<h3>Preview Message</h3>

<cfoutput query = "thismessage">
	<div style="background-color:white; width:90%" class="blackText pad10">
		Subject: #thismessage.subject#
		<hr>
		#thismessage.message#
	</div>
	<BR>
	<BR>
	<form action="/" method="post" id="previewForm">
		<input type="hidden" name="event" value="emailMarketing.send.test">
		<input type="hidden" name="communityID" value="#community.communityID#">
		<input type="hidden" name="messageID" value="#thismessage.messageID#">
		<input type="submit" value="Send Test" /> to <input type="text" name="email"> <BR>
		or <BR>
			<a href="/index.cfm/emailMarketing/admin/index" class="ajaxTabLink">Cancel</a> 
	</form>
</cfoutput>
<script>
        // bind 'myForm' and provide a simple callback function 
        $('#previewForm').ajaxForm(function(responseText) { 
			$('#previewForm').parent().html(responseText);            	        	
	     }); 
</script>