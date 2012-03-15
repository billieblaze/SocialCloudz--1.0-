<Cfsetting showdebugoutput="false">
<cfscript>
	community = event.getvalue('community');
</cfscript>
<cfoutput>
	<form action="/index.cfm/emailMarketing/message/submit" method="post" name="emailForm" id="emailForm">
		<input type="hidden" name="messageID" value="#rc.messageID#">
		<input type="hidden" name="communityID" value="#community.communityID#">
		<input type="hidden" name="memberID" value="#request.session.memberID#">
		Subject<BR />
		<input type="text" name="subject" style="width:100%"  value="#rc.subject#"/>
		<BR><BR>
		#application.form.textEditor('message',rc.message)#
		<BR />
		<input type="submit" value="Save" class="button"/>
		<a href="/index.cfm/emailMarketing/admin/index" class="ajaxTabLink">Cancel</a> 
	</form>
</cfoutput>
<script>
        // bind 'myForm' and provide a simple callback function 
        $('#emailForm').ajaxForm(function(responseText) { 
			$('#emailForm').parent().html(responseText);            	        	
	     }); 
</script>