<cfset symbol = "$">
<cfset notesName = "Dollars">
<cfset centName = "Cent">
<cfswitch expression="#ARGUMENTS.fieldInfo.currency#">
	<cfcase value="euro">
		<cfset symbol = "&euro;">
		<cfset notesName = "Euros">
		<cfset centName = "Cent">
	</cfcase>
	<cfcase value="pounds">
		<cfset symbol = "£">
		<cfset notesName = "Pounds">
		<cfset centName = "Pence">
	</cfcase>
	<cfcase value="yen">
		<cfset symbol = "&##165;">
		<cfset notesName = "Yen">
	</cfcase>
</cfswitch>

<cfif NOT IsNumeric( ARGUMENTS.fieldInfo.defaultval )>
	<cfset ARGUMENTS.fieldInfo.defaultval = "">
</cfif>
<cfif Len( ARGUMENTS.fieldInfo.defaultval )>
	<cfset temp = Int( ARGUMENTS.fieldInfo.defaultval )>
<cfelse>
	<cfset temp = "">
</cfif>

<cfset html = html & "<div class=""left sep"">" & symbol & "</div>">
<cfif ARGUMENTS.fieldInfo.currency EQ "yen">
	<cfset html = html & "<div class=""left""><input type=""text"" name=""" & fieldName & """ class=""small"" value=""#temp#"" onkeypress=""return twFormIsNumberKey(event)""/><div class=""info"">" & notesName & "</div></div>">
<cfelse>
	<cfset html = html & "<div class=""left""><input type=""text"" name=""" & fieldName & "_price"" class=""small"" value=""#temp#"" onkeypress=""return twFormIsNumberKey(event)""/><div class=""info"">" & notesName & "</div></div>">
	<cfif Len( ARGUMENTS.fieldInfo.defaultval )>
		<cfset temp = (ARGUMENTS.fieldInfo.defaultval - temp) * 100>
	<cfelse>
		<cfset temp = "">
	</cfif>
	<cfset html = html & "<div class=""left sep"">.</div>">
	<cfset html = html & "<div class=""left""><input type=""text"" name=""" & fieldName & "_cent"" class=""tiny"" value=""#NumberFormat( temp, "00" )#"" maxlength=""2"" onkeypress=""return twFormIsNumberKey(event)""/><div class=""info"">" & centName & "</div></div>">
</cfif>

<cfinclude template="../../inc_js_assist_twFormIsNumberKey.cfm">