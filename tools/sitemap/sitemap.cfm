	<cfparam name="url.baseurl" default="http://dev.socialcloudz.com">
	<cfparam name="txtStart" default="">
	<cfparam name="txtLevels" default="1">

	<cfset componentType = "_sitemap">
	
	
	<cfset ini_root="#url.baseurl#" />
	<cfset ini_startPage="#txtStart#" />
	<cfset ini_levelMax="#txtLevels#" />

	<cfinvoke component="#componentType#" method="sitemap" returnvariable="qry_sitemap" root="#ini_root#" spider_url="#ini_startPage#" depthMax="#ini_levelMax#">
	<cfinvoke component="#componentType#" method="indexIt" returnvariable="qry_sitemapIndex" root="#ini_root#" query="#qry_sitemap#">
	<cfinvoke component="#componentType#" method="googleSitemap" returnvariable="sitemap" root="#ini_root#" query="#qry_sitemap#">

