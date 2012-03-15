<cfif REQUEST.formItems[ id ].phoneFormat NEQ "international" >
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField & "_p1" ] & "-" & FORM[ REQUEST.formField & "_p2" ] & "-" & FORM[ REQUEST.formField & "_p3" ]>
</cfif>