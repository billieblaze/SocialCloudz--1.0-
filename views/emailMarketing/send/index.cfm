<Cfsetting showdebugoutput="false">
<cfscript>
	community = event.getValue('community');
	members = event.getvalue('members');
	mailinglist = event.getvalue('mailinglist');
</cfscript>
<cfoutput>
	<form action="/index.cfm" method="post" id="sendMailForm">
		<input type="hidden" name="event" value='emailMarketing.send.send'>
		<input type="hidden" name="messageID" value="#rc.messageID#">
		<input type="hidden" name="communityID" value="#community.communityID#">
		<div id="manageTabs">
			<ul>
		       	<li><a href="##tabs-2" class="blackText"><img src="#application.cdn.fam#email.png"> Site Members</a></li>
		      	<li><a href="##tabs-3" class="blackText"><img src="#application.cdn.fam#book_addresses.png"> Mailing List</a></li>
		    </ul>
		  
		    <div id="tabs-2" class="ui-tabs-hide" >
				<cfloop query="members">
					<input type="checkbox" name="email" value="#members.email#"> #members.username#<BR>
				</cfloop>	
		    </div>
		    <div id="tabs-3" class="ui-tabs-hide" >
				<cfloop query="mailinglist">
					<input type="checkbox" name="email" value="#mailinglist.email#"> #mailinglist.email#<BR>
				</cfloop>	
		    </div>
		</div>
		<BR>
		<input type="submit" value="Send Message">
	</form>
</cfoutput>
<script type="text/javascript">
		
// wait for the DOM to be loaded 
	$(document).ready(function() { 
    	$("#manageTabs").tabs();
  
        // bind 'myForm' and provide a simple callback function 
        $('#sendMailForm').ajaxForm(function(responseText) { 
			$('#sendMailForm').parent().html(responseText);            	        	
	     }); 
	}); 
</script> 
