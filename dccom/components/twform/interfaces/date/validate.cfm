<cfif ARGUMENTS.fieldInfo.isrequired>
	<cfset vali = vali & "if( f.#fieldName#_DD.value.length < 1 || f.#fieldName#_MM.value.length < 1 || f.#fieldName#_YY.value.length < 1 ) errMsg += ""\nPlease fill in '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
	<cfset vali = vali & "else">
<cfelse>
	<cfset vali = vali & "if( f.#fieldName#_DD.value.length || f.#fieldName#_MM.value.length || f.#fieldName#_YY.value.length )">
</cfif>
<cfset vali = vali & "{">
	<cfset vali = vali & "var d = parseInt( f.#fieldName#_DD.value );">
	<cfset vali = vali & "var m = parseInt( f.#fieldName#_MM.value );">
	<cfset vali = vali & "var y = parseInt( f.#fieldName#_YY.value );">	
	<cfset vali = vali & "if( d < 1 || d > 31 || m < 1 || m > 12 || ( (y < 1 || y > 99) && (y < 1900) ) ) errMsg += ""\nInvalid date for '#JSStringFormat( ARGUMENTS.fieldInfo.title )#'."";">
<cfset vali = vali & "}">