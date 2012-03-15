<cfif FORM[ REQUEST.formField ] EQ "http://">
	<cfset FORM[ REQUEST.formField ] = "">
</cfif>
