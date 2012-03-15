<cfif NOT StructKeyExists( REQUEST, "flagJsInc_twFormIsPhoneKey" )>
	<cfset html = html & "<script language=""JavaScript1.2"">function twFormIsPhoneKey(evt){var charCode = (evt.which) ? evt.which : event.keyCode;if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode!= 32 && charCode!= 43 && charCode!= 45 )return false;return true;}</script>">
	<cfset REQUEST.flagJsInc_twFormIsPhoneKey = true>
</cfif>