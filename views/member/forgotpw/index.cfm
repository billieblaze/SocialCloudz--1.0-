<cfoutput>
  	<form  method="post" action="#event.buildLink('member.forgotpw.submit')#" class="ajaxform">
	<div align="center">
		Email Address: <input name="email" type="text" id="email" size="30" class="required"/><BR><BR>
		<input name="submit " type="submit" value="Send Password" />
	</div>
    </form>	
	</div>
</cfoutput>
