<cfset html = html & "<div class=""left"">&nbsp;</div>">
<cfset temp = HTMLEditFormat( ARGUMENTS.fieldInfo.defaultval )>
<cfif Len( temp ) IS 0>
	<cfset temp = "http://">
</cfif>
<cfset html = html & "<input type=""text"" name=""" & fieldName & """ class=""" & ARGUMENTS.fieldInfo.size & """">
<cfset html = html & " value=""" & temp & """">
<cfset html = html & ">">