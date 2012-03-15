<cfset html = html & "<input type=""hidden"" name=""" & fieldName & """">
<cfset html = html & " value=""">
<cfset html = html & displayDefaultVal( ARGUMENTS.fieldInfo.defaultval )>
<cfset html = html & """>">