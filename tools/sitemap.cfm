<cfsetting showdebugoutput="false">
<cfif fileexists(expandpath('/tools/sitemap/files/#cgi.http_host#.xml'))>
	<cfinclude template="/tools/sitemap/files/#cgi.http_host#.xml">
<cfelse>
	<cfinclude template='/tools/sitemap/generate.cfm'>
	<cfinclude template="/tools/sitemap/files/#cgi.http_host#.xml">
</cfif>