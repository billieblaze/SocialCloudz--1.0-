<cfif Len( FORM[ REQUEST.formField & "_HH" ] ) IS 0 OR NOT IsNumeric( FORM[ REQUEST.formField & "_HH" ] )>
	<cfset FORM[ REQUEST.formField & "_HH" ] = 0>
</cfif>
<cfif Len( FORM[ REQUEST.formField & "_MM" ] ) IS 0 OR NOT IsNumeric( FORM[ REQUEST.formField & "_MM" ] )>
	<cfset FORM[ REQUEST.formField & "_MM" ] = 0>
</cfif>
<cfset FORM[ REQUEST.formField ] = NumberFormat( FORM[ REQUEST.formField & "_HH" ], "00" ) & "." & NumberFormat( FORM[ REQUEST.formField & "_MM" ], "00" )>