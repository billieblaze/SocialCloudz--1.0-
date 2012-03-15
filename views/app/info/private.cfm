<div class="mod">
	<div class="hd">Private Site</div>
	<div class="bd">
		The site you are trying to visit is private.  <BR><BR>
		<cfif isdefined('rc.pending')>
		Your membership request is still pending.  When the site administrator accepts or declines your request, you will be notified via email.
		<cfelseif isdefined('rc.signup')>
		Your membership request has been submitted.	 When the site administrator accepts or declines your request, you will be notified via email.
		<cfelse>
		You may signup, however, the site administrator must approve your membership.
		</cfif>
	</div>
	<div class="ft"></div>
</div>