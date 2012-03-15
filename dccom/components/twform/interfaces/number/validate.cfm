<cfif ARGUMENTS.fieldInfo.isrequired>
	<cfset vali = vali & "if( f.#fieldName#.value.length < 1 ) errMsg += ""\nPlease fill in '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
</cfif>