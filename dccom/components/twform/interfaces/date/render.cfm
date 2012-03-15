<cfif ARGUMENTS.fieldInfo.dateFormat EQ "usdate">
	<cfset html = html & "<div class=""left sp6""><input type=""text"" name=""" & fieldName & "_MM"" class=""tiny"" onkeypress=""return twFormIsNumberKey(event)"" maxlength=""2""/><div class=""info"">MM</div></div><div class=""left sep"">/</div>">
	<cfset html = html & "<div class=""left sp6""><input type=""text"" name=""" & fieldName & "_DD"" class=""tiny"" onkeypress=""return twFormIsNumberKey(event)"" maxlength=""2""/><div class=""info"">DD</div></div><div class=""left sep"">/</div>">
<cfelse>
	<cfset html = html & "<div class=""left sp6""><input type=""text"" name=""" & fieldName & "_DD"" class=""tiny"" onkeypress=""return twFormIsNumberKey(event)"" maxlength=""2""/><div class=""info"">DD</div></div><div class=""left sep"">/</div>">
	<cfset html = html & "<div class=""left sp6""><input type=""text"" name=""" & fieldName & "_MM"" class=""tiny"" onkeypress=""return twFormIsNumberKey(event)"" maxlength=""2""/><div class=""info"">MM</div></div><div class=""left sep"">/</div>">
</cfif>
<cfset html = html & "<div class=""left sp6""><input type=""text"" name=""" & fieldName & "_YY"" class=""small"" onkeypress=""return twFormIsNumberKey(event)"" maxlength=""4""/><div class=""info"">YYYY</div></div><div class=""left sep""></div>">
<cfinclude template="../../inc_js_assist_twFormIsNumberKey.cfm">