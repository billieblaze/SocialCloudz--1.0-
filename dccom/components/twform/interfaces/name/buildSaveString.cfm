<cfif REQUEST.formItems[ id ].fieldType NEQ "extended">
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField & "_fname" ] & " " & FORM[ REQUEST.formField & "_lname" ]>
<cfelse>
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField & "_fname" ] & " " & FORM[ REQUEST.formField & "_lname" ]>
	<cfif Len( FORM[ REQUEST.formField & "_title" ] )>
		<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField & "_title" ] & " " & FORM[ REQUEST.formField ]>
	</cfif>
	<cfif Len( FORM[ REQUEST.formField & "_suffix" ] )>
		<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & " " & FORM[ REQUEST.formField & "_suffix" ]>
	</cfif>
</cfif> 

