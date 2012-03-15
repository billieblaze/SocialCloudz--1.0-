<cfif NOT ARGUMENTS.fieldInfo.isrequired>
	<cfexit method="EXITTEMPLATE">
</cfif>
<cfset vali = vali & "if( f.#fieldName#_street.value.length < 1 || f.#fieldName#_city.value.length < 1 || f.#fieldName#_state.value.length < 1  || f.#fieldName#_country.selectedIndex == 0 ) errMsg += ""\n'#JSStringFormat( ARGUMENTS.fieldInfo.title )#' - please complete this address."";">
