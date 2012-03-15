<cfset communityList = event.getValue('communityList')>
<cfset community = event.getvalue('community')>

<cfsetting showdebugoutput="no">
<cfoutput>
<cfparam name="rc.subtab" default="general">
<div class="mod">
	<div class="hd">

		<form action="#event.buildLink('advertising.admin.index')#" method="post">
			<select name="communityID">
				<cfloop query="communityList">
				<option value="#communityList.communityID#" <cfif communityList.communityID eq community.communityID>selected</cfif>>#site#</option>
				</cfloop>
			</select>
			<input type="submit" value="Select Site" class="button">
			<input type="button" value="View Site" onclick="location.href='#community.baseURL#&i=#cookie.token#';">
		</form>

	</div>
	<div class="bd">
	<cfscript>
		config = arrayNew(1);
		config[1] = structnew();
		config[1].title='<img src="#application.cdn.fam#application.png"> Mass Mail';
		config[1].url="#event.buildLink(linkTo='emailMarketing.admin.index',queryString='communityID=#community.communityID#')#";
	
		config[2] = structnew();	
		config[2].title='<img src="#application.cdn.fam#world_link.png"> Advertising';
		config[2].url="#event.buildLink(linkTo='advertising.admin.index',queryString='communityID=#community.communityID#')#";
		
		config[3] = structnew();	
		config[3].title='<img src="#application.cdn.fam#note_delete.png"> Branding';
		config[3].url="#event.buildLink(linkTo='app.branding.index',queryString='communityID=#community.communityID#')#";
	</cfscript>
	<cfmodule template="/customTags/jqueryTabs.cfm" config="#config#">
	</div>
	<div class="ft"></div>
</div>
</cfoutput>
<script type="text/javascript">
		$("#configureTabs").tabs();
</script>