<cfif NOT StructKeyExists( REQUEST, "flagJsInc_twFormTestEmail" )>
	<cfset html = html & "<script language=""JavaScript1.2"">function twFormTestEmail(x){var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;if (filter.test(x))return true;return false;}</script>">
	<cfset REQUEST.flagJsInc_twFormTestEmail = true>
</cfif>