<cfif REQUEST.formItems[ id ].currency EQ "yen">
	<cfexit method="EXITTEMPLATE">
</cfif>

<cfif Len( FORM[ REQUEST.formField & "_price" ] ) IS 0 OR NOT IsNumeric( FORM[ REQUEST.formField & "_price" ] )>
	<cfset FORM[ REQUEST.formField & "_price" ] = 0>
</cfif>
<cfif Len( FORM[ REQUEST.formField & "_cent" ] ) IS 0 OR NOT IsNumeric( FORM[ REQUEST.formField & "_cent" ] )>
	<cfset FORM[ REQUEST.formField & "_cent" ] = 0>
</cfif>
<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField & "_price" ] & "." & FORM[ REQUEST.formField & "_cent" ]>