<cfoutput>
	<div class="mod">
		<div class="hd">Invitation</div>
		<div class="bd" align="center">
			Enter your invite code below:<BR><BR>
			<form action="#event.buildLink('member.invite.respondSubmit')#" method="post">
			Invite Code: <input type="text" name="invitationCode"><BR><BR>
			<input type="submit" value="Go">
			</form>
		</div>
		<div class="ft"></div>
	</div> 
</cfoutput>