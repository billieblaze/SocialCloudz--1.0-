<cfset html = html & "<input type=""text"" name=""" & fieldName & """ class=""" & ARGUMENTS.fieldInfo.size & """ onkeypress=""return twFormIsNumberKey(event)""">
<cfset html = html & " value=""" & HTMLEditFormat( ARGUMENTS.fieldInfo.defaultval ) & """">
<cfset html = html & ">">
<cfinclude template="../../inc_js_assist_twFormIsNumberKey.cfm">