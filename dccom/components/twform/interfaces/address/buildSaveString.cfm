<cfset FORM[ REQUEST.formField ] = "">
<!-- Street --->
<cfif Len( FORM[ REQUEST.formField & "_street" ] )>
	<cfif Len( FORM[ REQUEST.formField ] )><cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & chr(13) & chr(10)></cfif>
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & FORM[ REQUEST.formField & "_street" ]>
</cfif>
<!-- Line 2 --->
<cfif Len( FORM[ REQUEST.formField & "_line2" ] )>
	<cfif Len( FORM[ REQUEST.formField ] )><cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & chr(13) & chr(10)></cfif>
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & FORM[ REQUEST.formField & "_line2" ]>
</cfif>
<!-- City --->
<cfif Len( FORM[ REQUEST.formField & "_city" ] )>
	<cfif Len( FORM[ REQUEST.formField ] )><cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & chr(13) & chr(10)></cfif>
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & FORM[ REQUEST.formField & "_city" ]>
</cfif>
<!-- State --->
<cfif Len( FORM[ REQUEST.formField & "_state" ] )>
	<cfif Len( FORM[ REQUEST.formField ] )><cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & chr(13) & chr(10)></cfif>
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & FORM[ REQUEST.formField & "_state" ]>
</cfif>
<!-- Zip --->
<cfif Len( FORM[ REQUEST.formField & "_zip" ] )>
	<cfif Len( FORM[ REQUEST.formField ] )><cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & chr(13) & chr(10)></cfif>
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & FORM[ REQUEST.formField & "_zip" ]>
</cfif>
<!-- Country --->
<cfif Len( FORM[ REQUEST.formField & "_country" ] )>
	<cfif Len( FORM[ REQUEST.formField ] )><cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & chr(13) & chr(10)></cfif>
	<cfset FORM[ REQUEST.formField ] = FORM[ REQUEST.formField ] & FORM[ REQUEST.formField & "_country" ]>
</cfif>