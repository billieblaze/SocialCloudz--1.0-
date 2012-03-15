<cfif ARGUMENTS.fieldInfo.isrequired>
	<cfif ARGUMENTS.fieldInfo.currency EQ "yen">
		<cfset vali = vali & "if( f.#fieldName#.value.length < 1 ) errMsg += ""\nPlease fill in '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
	<cfelse>
		<cfset vali = vali & "if( f.#fieldName#_price.value.length < 1 && f.#fieldName#_cent.value.length < 1 ) errMsg += ""\nPlease fill in '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
	</cfif>
</cfif>