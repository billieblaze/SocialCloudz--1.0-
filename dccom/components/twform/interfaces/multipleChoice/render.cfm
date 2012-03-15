<cfloop from="1" to="#ArrayLen( ARGUMENTS.fieldInfo.options )#" index="i">
	<cfset temp = HTMLEditFormat( ARGUMENTS.fieldInfo.options[i] )>
	<cfset temp2 = "pv" & ARGUMENTS.id & "opts" & i>
	<cfset html = html & "<div class=""option"">">
	<cfset html = html & "<input type=""radio"" name=""" & fieldName & """ value=""" & temp & """ id=""" & temp2 & """">
	<cfif ARGUMENTS.fieldInfo.defaultOption IS (i-1)>
		<cfset html = html & " checked">
	</cfif>
	<cfset html = html & "><label for=""" & temp2 & """>" & temp & "</label>">
	<cfset html = html & "</div>">
</cfloop>
