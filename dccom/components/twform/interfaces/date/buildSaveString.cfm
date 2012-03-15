<cfif NOT IsNumeric( FORM[ REQUEST.formField & "_DD" ] ) OR NOT IsNumeric( FORM[ REQUEST.formField & "_MM" ] ) OR NOT IsNumeric( FORM[ REQUEST.formField & "_YY" ] )>
	<cfset FORM[ REQUEST.formField ] = "">
<cfelse>
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField & "_DD" ] & " " & MonthAsString( FORM[ REQUEST.formField & "_MM" ] ) & " " & FORM[ REQUEST.formField & "_YY" ]>
</cfif>