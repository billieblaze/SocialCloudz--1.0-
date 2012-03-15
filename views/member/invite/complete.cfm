<cfoutput>
<div class="mod">
<div class="hd">Invitation Sent</div>
<div class="bd"> 

<cfif isdefined('rc.invitationCode')>
Congratulations, your invitation code has been created.<BR /><BR />
<div align="center">
URL: http://#request.community.baseurl#/invite<BR />
Invitation Code: #rc.invitationCode#
</div>
<cfelseif isdefineD('rc.campaign')>
Congratulations, your web link has been created. You may distribute the following link: 

<BR /><BR />
<div align="center">
http://#request.community.baseurl#?t=#rc.webID#
</div>
<cfelseif isdefined('rc.emails')>
Congratulations, your invitation email has been sent to the following addresses: <BR /><BR />
<cfloop list="#rc.emails#" index="i" delimiters=";">
#i#<BR /> 
</cfloop>

</cfif>
<BR /><BR />
<a href="#event.buildLink('member.invite.index')#">Back to Invite Center</a>
</div>
<div class="ft"></div>
</div>
</cfoutput>