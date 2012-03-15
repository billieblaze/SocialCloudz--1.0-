<cfoutput>
	<div align="center">
		<form 
			action="#event.buildLink('emailMarketing/mailingList/saveMailingList')#" 
			id="mailingListForm" 
				class="ajaxform"
				method="POST"
		>
			<input type="hidden" value="Join" name="action">
			<input name="email" isRequired="false" type="text" value="Email Address"  /><br><br>
			<input type="submit" value="subscribe" class="button">
		</form>
	</div>
</cfoutput>	