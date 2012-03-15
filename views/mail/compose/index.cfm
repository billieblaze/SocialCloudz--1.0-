<cfparam name="rc.parentID" default="0">
<cfscript>
mail = event.getvalue('mail','');
</cfscript>

<style type="text/css">
input#member.ac_input { padding: 0px 0px 0px 15px; width:95%}
</style>

<cfoutput>
<div class="mod">
	<div class="hd">Compose A Message</div>
	<div class="bd">
	<form action="#event.buildLink('mail.compose.submit')#" method="post">
	<input type="hidden" name="parentID" value="#rc.parentID#">

	<cfif isdefined('rc.memberid')>
	To: #application.members.getUsername(rc.memberID)#
	<input type="hidden" name="to" value="#rc.memberID#"><BR>
	<cfelse>
	<cfif isdefined('rc.parentID') and rc.parentID neq 0>
	To: #application.members.getUsername(mail.sourceID)#
	<input type="hidden" name="to" value="#mail.sourceID#"><BR>
	<cfelse>
	#application.form.membersuggest('member','to', 'To: ')#<BR>
    <span class="xsmall">Begin typing the user name in the box above, then select the member from the dropdown.</span>
	</cfif>
	</cfif>
    <BR /><BR />
	Subject: 
	<cfif isdefined('rc.parentID') and rc.parentID neq 0>
	RE: #mail.subject#
	<input type="hidden" name="subject" value="RE: #mail.subject#">
	<cfelse>
	<input type="Text" name="subject" style="width:97%">
	</cfif>
	<BR><BR>
	Message
	#application.form.textEditor('message')#	
	<BR><BR>
	<input type="submit" value="Send"><input type="button" value="Cancel" onclick="history.back();" class="button" />
	</form>
	</div>
	<div class="ft"></div>
</div>
</cfoutput>
