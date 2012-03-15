<cffunction name="GetCurrentURL" output="No">
<cfset var theURL = getPageContext().getRequest().GetRequestUrl()>
<cfif len( CGI.query_string )><cfset theURL = theURL & "?" & CGI.query_string></cfif>
<cfreturn theURL>
</cffunction>
<cfset REQUEST.GetCurrentURL = GetCurrentURL>
