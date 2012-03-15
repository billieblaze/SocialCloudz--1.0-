<cfif NOT StructKeyExists( FORM, REQUEST.formField )>
	<cfset FORM[ REQUEST.formField ] = "">
</cfif>