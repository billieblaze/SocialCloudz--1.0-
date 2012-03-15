<cfif ARGUMENTS.fieldInfo.isrequired>
	<cfset vali = vali & "if( f.#fieldName#.value.length < 6 ) errMsg += ""\nPlease fill in '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
</cfif>
<cfset vali = vali & "if( f.#fieldName#.value.length && !twFormTestEmail( f.#fieldName#.value ) ) errMsg += ""\n'#JSStringFormat( ARGUMENTS.fieldInfo.title )#' - email looks invalid."";">