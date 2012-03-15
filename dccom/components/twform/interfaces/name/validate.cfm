<cfif ARGUMENTS.fieldInfo.isrequired>
	<cfif ARGUMENTS.fieldInfo.format NEQ "extended">
		<cfset vali = vali & "if( f.#fieldName#_fname.value.length < 2 ) errMsg += ""\nPlease fill in the first name part of '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
		<cfset vali = vali & "if( f.#fieldName#_lname.value.length < 2 ) errMsg += ""\nPlease fill in the last name part of '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
	<cfelse>
		<cfset vali = vali & "if( f.#fieldName#_fname.value.length < 2 ) errMsg += ""\nPlease fill in the first name part of '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
		<cfset vali = vali & "if( f.#fieldName#_lname.value.length < 2 ) errMsg += ""\nPlease fill in the last name part of '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
	</cfif>
</cfif>