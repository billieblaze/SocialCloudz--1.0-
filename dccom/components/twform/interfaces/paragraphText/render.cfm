<cfset html = html & "<textarea name=""" & fieldName & """ class=""" & ARGUMENTS.fieldInfo.size & """>">
<cfset html = html & HTMLEditFormat( ARGUMENTS.fieldInfo.defaultval )>
<cfset html = html & "</textarea>">