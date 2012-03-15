<cfoutput>
	<script>
		inviteFormat = function(cellvalue, options, rowdata){
		if ( rowdata['INVITATIONCODE'] != '') { 
		src = 'URL: http://#request.community.baseurl#/invite<BR>Invite Code: ' + rowdata['INVITATIONCODE'];
		} 
		
		if ( rowdata['EMAIL'] != '') { 
		src = 'Email to: ' + rowdata['EMAIL'];
		} 
		
		if ( rowdata['CAMPAIGN'] != '') { 
		src = 'Campaign Name: ' + rowdata['CAMPAIGN'] + '<BR>URL: http://#request.community.baseurl#?t=' + rowdata['ID'];
		} 
		 returnResult = 'Sent on: ' + cellvalue + '<BR>' + src;
			return returnResult;
		}
	</script>

	<div class="mod">
		<div class="hd">Invite</div>
		<div class="bd">
			Welcome to the invite center.  Here you have a number of options for inviting your friends.   You can send invitations via email, create unique web links or setup an invitation code.  Once sent, you can use this area to stay up-to-date on the status of your invites.
			<br /> 
			<div align="right">
				<img src="#application.cdn.fam#email.png" /> <a href="#event.buildLink('member.invite.send')#">Send Invitation</A>
			</div><BR />

			<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
									gridName = 'memberInvite' 
									objectName = 'Invitation'	 
									width="100%" 
									rows="10"
									
									method = 'application.members.invitation.get' 
									arguments = 'memberID=#request.session.memberID#' 
									defaultSort = 'ID' 							
				
									pid='#request.session.memberID#'
									datasource="community"
									isAdmin='1' 
			> 
		</div>
		<div class="ft"></div>
	</div>
</cfoutput>