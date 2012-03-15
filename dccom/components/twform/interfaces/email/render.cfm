<cfset html = html & "<div class=""left"">&nbsp;</div>">
<cfset html = html & "<input type=""text"" name=""" & fieldName & """ class=""" & ARGUMENTS.fieldInfo.size & """">
<cfset html = html & " value=""" & HTMLEditFormat( ARGUMENTS.fieldInfo.defaultval ) & """">
<cfset html = html & ">">
<cfinclude template="../../inc_js_assist_twFormTestEmail.cfm">