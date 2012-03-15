<cfset html = html & "<div class=""left"">&nbsp;</div>">
<cfif ARGUMENTS.fieldInfo.phoneFormat EQ "international" >
	<cfset html = html & "<div class=""left""><input type=""text"" name=""" & fieldName & """ class=""phone medium"" onkeypress=""return twFormIsPhoneKey(event)"" maxlength=""30""></div>">
<cfelse>
	<cfset html = html & "<div class=""left""><input type=""text"" name=""" & fieldName & "_p1"" class=""phone small"" onkeypress=""return twFormIsPhoneKey(event)"" maxlength=""3""><div class=""info"">(######)</div></div><div class=""left sep"">-</div>">
	<cfset html = html & "<div class=""left""><input type=""text"" name=""" & fieldName & "_p2"" class=""small"" onkeypress=""return twFormIsPhoneKey(event)"" maxlength=""3""><div class=""info"">######</div></div><div class=""left sep"">-</div>">
	<cfset html = html & "<div class=""left""><input type=""text"" name=""" & fieldName & "_p3"" class=""small"" onkeypress=""return twFormIsPhoneKey(event)"" maxlength=""10""><div class=""info"">########</div></div>">
</cfif>
<cfinclude template="../../inc_js_assist_twFormIsPhoneKey.cfm">