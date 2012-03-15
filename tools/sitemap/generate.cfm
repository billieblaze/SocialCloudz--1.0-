<cfparam name="url.communityID" default="#cgi.http_host#">
	<cfparam name="url.txtRoot" default="http://#cgi.http_host#/">
	<cfparam name="txtStart" default="">
	<cfparam name="txtLevels" default="2">

	<cfset componentType = "tools.sitemap._sitemap">
	
	
	<cfset ini_root="#txtRoot#" />
	<cfset ini_startPage="#txtStart#" />
	<cfset ini_levelMax="#txtLevels#" />

	<cfinvoke component="#componentType#" method="sitemap" returnvariable="qry_sitemap" root="#ini_root#" spider_url="#ini_startPage#" depthMax="#ini_levelMax#">
	<cfinvoke component="#componentType#" method="indexIt" returnvariable="qry_sitemapIndex" root="#ini_root#" query="#qry_sitemap#">
	<cfinvoke component="#componentType#" method="googleSitemap" returnvariable="sitemap" root="#ini_root#" query="#qry_sitemap#">

	<cffile action="write" file="#expandpath('/tools/sitemap/files/#url.communityID#.xml')#" output="#trim(tostring(Sitemap[1]))#">
