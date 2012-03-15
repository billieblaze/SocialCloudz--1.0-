<cfset html = html & "<select name=""" & fieldName & """ class=""" & ARGUMENTS.fieldInfo.size & """">
<cfset html = html & " id=""twForm#REQUEST.instanceId#f#id#"">">
<cfset html = html & ">">
<cfloop from="1" to="#ArrayLen( ARGUMENTS.fieldInfo.options )#" index="i">
	<cfset temp = HTMLEditFormat( ARGUMENTS.fieldInfo.options[i] )>
	<cfset html = html & "<option value=""" & temp & """">
	<cfif StructKeyExists( ARGUMENTS.fieldInfo, "defaultOption" ) AND ARGUMENTS.fieldInfo.defaultOption IS i-1>
		<cfset html = html & " selected">
	</cfif>
	<cfset html = html & ">">
	<cfset html = html & temp>
	<cfset html = html & "</option>">
</cfloop>
<cfset html = html & "</select>">