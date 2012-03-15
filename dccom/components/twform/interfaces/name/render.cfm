<cfif ARGUMENTS.fieldInfo.format NEQ "extended">
	<cfset html = html & "<div class=""left sp2""><input type=""text"" name=""" & fieldName & "_fname"" id=""twForm" & REQUEST.instanceId & fieldName & "_fname"" class=""medium""><div class=""info"">First Name</div></div>">
	<cfset html = html & "<div class=""left sp2""><input class=""text"" name=""" & fieldName & "_lname"" class=""medium""><div class=""info"">Last Name</div></div>">
<cfelse>
	<cfset html = html & "<div class=""left sp2""><input type=""text"" name=""" & fieldName & "_title"" class=""tiny""><div class=""info"">Title</div></div>">
	<cfset html = html & "<div class=""left sp2""><input type=""text"" name=""" & fieldName & "_fname"" class=""medium""><div class=""info"">First Name</div></div>">
	<cfset html = html & "<div class=""left sp2""><input type=""text"" name=""" & fieldName & "_lname"" class=""medium""><div class=""info"">Last Name</div></div>">
	<cfset html = html & "<div class=""left sp2""><input type=""text"" name=""" & fieldName & "_suffix"" class=""tiny""><div class=""info"">Suffix</div></div>">
</cfif>		
