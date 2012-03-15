<Cfsetting showdebugoutput="false">
<cfoutput>
<h2>Your 30-day SocialCloudz trial is ready to go!  </h2>
<div class="pad10" style="width:600px;" id="welcomePopup">
	An email has been sent to the address you provided with confirmation details and other important information regarding your SocialCloudz account.   
	Thanks for trying SocialCloudz!
	<BR /><BR />
	<div align="center" style="width:600px; ">
		<div style="background-color:##dadaec ;text-align: center" align="center" class="pad15">
			<h3>You may access your site via the following URL:</h3>
			<h3><a href="http://#request.community.baseurl#">http://#request.community.baseurl#</a></h3>
			
		</div>
		<div align="center" class="small">
			If you ever need help, refer to our <a href="#event.buildLink('app.help.index')#">help section</a>.
		</div>
	</div>
	<BR />
</Div>
</cfoutput>