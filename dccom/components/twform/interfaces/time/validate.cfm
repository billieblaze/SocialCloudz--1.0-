<cfif ARGUMENTS.fieldInfo.isrequired>
	<cfset vali = vali & "if( f.#fieldName#_HH.value.length < 1 || f.#fieldName#_MM.value.length < 1 ) errMsg += ""\nPlease fill in '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
</cfif>