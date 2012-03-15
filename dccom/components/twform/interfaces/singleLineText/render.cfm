<cfset html = html & "<input type=""text"" name=""" & fieldName & """ class=""" & ARGUMENTS.fieldInfo.size & """">
<cfset html = html & " value=""" & HTMLEditFormat( ARGUMENTS.fieldInfo.defaultval ) & """">
<cfset html = html & ">">