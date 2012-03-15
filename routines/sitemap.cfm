<cfset application.lastsitemap= 3>
<cfset url.communityID = application.lastsitemap>

<cfset community = application.community.gateway.get(communityID = application.lastsitemap)>
<cfif community.recordcount eq 1>
<cfscript>
			if (community.dnsmask eq ''){ 
				baseurl = 'http://#community.subdomain#.socialcloudz.com'; 
			} else {
				baseurl = 'http://#community.dnsmask#';
			}

</cfscript>
 
	<cfparam name="url.txtRoot" default="#baseurl#/">
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
</cfif>
<cfset application.lastsitemap = application.lastsitemap + 1> 