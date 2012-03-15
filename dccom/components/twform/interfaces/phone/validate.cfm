<cfif ARGUMENTS.fieldInfo.isrequired>
	<cfif ARGUMENTS.fieldInfo.phoneformat EQ "international">
		<cfset vali = vali & "if( f.#fieldName#.value.length < 2 ) errMsg += ""\nPlease fill in '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
	<cfelse>
		<cfset vali = vali & "if( f.#fieldName#_p1.value.length < 3 || f.#fieldName#_p2.value.length < 3 || f.#fieldName#_p3.value.length < 4 ) errMsg += ""\nPlease fill in '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
	</cfif>
</cfif>