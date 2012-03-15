<cfsetting showdebugoutput="no">
<cfset communityList = event.getValue('communityList')>
<cfset community = event.getValue('community')>
<cfsetting showdebugoutput="no"> 
<cfoutput>
	<script src="/scripts/highcharts.js" type="text/javascript"></script>
<div class="mod">
	<div class="hd">
		<form action="#event.buildLink('statistics.main')#" method="post">
		<select name="communityID" class="small">
			<cfloop query="communityList">
			<option value="#communityID#" <cfif community.communityID eq communityID>selected</cfif>>#site#</option>
			</cfloop>
		</select>
		<input type="submit" value="View Statistics" class="button small">
		<input type="button smal" value="View Site" onclick="location.href='#community.baseURL#&i=#cookie.token#';">
	</form>
	</div>
	<div class="bd">
		<div id="statisticsTabs" class="ui-tabs">
			<ul>
		    	<li><a href="#event.buildLink(linkTo='statistics:report.index',queryString='communityID=#community.communityID#')#"  title="tabs-1">General</a></li>
		    	<cfif request.session.accesslevel gte 20>
		    	<li><a href="#event.buildLink(linkTo='statistics:report.detail',queryString='communityID=#community.communityID#&type=app')#" title="tabs-2">Application</a></li>
		    	<li><a href="#event.buildLink(linkTo='statistics:report.detail',queryString='communityID=#community.communityID#&type=messages')#" title="tabs-2">Mail</a></li>
		    	</cfif>
		    	<li><a href="#event.buildLink(linkTo='statistics:report.detail',queryString='communityID=#community.communityID#&type=community')#" title="tabs-3">Community</a></li>
		    	<li><a href="#event.buildLink(linkTo='statistics:report.detail',queryString='communityID=#community.communityID#&type=content')#" title="tabs-4">Content</a></li>
		      	<li><a href="#event.buildLink(linkTo='statistics:report.detail',queryString='communityID=#community.communityID#&type=cms')#" title="tabs-5">CMS</a></li>                
			</ul>
		</div>
	</div>
	<div class="ft"></div>
</div>
</cfoutput>
<script type="text/javascript">
		$("#statisticsTabs").tabs();
</script>
