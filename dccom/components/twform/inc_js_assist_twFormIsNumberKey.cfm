<cfif NOT StructKeyExists( REQUEST, "flagJsInc_twFormIsNumberKey" )>
	<cfset html = html & "<script language=""JavaScript1.2"">function twFormIsNumberKey(evt){var charCode = (evt.which) ? evt.which : event.keyCode;if (charCode > 31 && (charCode < 48 || charCode > 57))return false;return true;}</script>">
	<cfset REQUEST.flagJsInc_twFormIsNumberKey = true>
</cfif>