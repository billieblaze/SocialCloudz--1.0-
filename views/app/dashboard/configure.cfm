<cfset communityList = event.getValue('communityList')>
<cfset community = event.getvalue('community')>

<style type="text/css">
	div#configTabs li a{ 
	font-size: 12px !important;
	}
</style>

<cfoutput>
<cfparam name="rc.subtab" default="general">
<div class="mod">
	<div class="hd">
	<form action="#event.buildLink('app.dashboard.configure')#" method="post" >
		<select name="communityID" class="small">
			<cfloop query="communityList">
			<option value="#communityList.communityID#" <cfif communityList.communityID eq community.communityID>selected</cfif>>#site#</option>
			</cfloop>
		</select>
		<input type="submit" value="Configure Site" class="button small">
		<input type="button" value="View Site" onclick="location.href='#community.baseURL#&i=#cookie.token#';" class="small">
	</form>

	</div>
	<div class="bd">
		<cfscript>
		i=1;
		config = arrayNew(1);
		
		config[i] = structnew();
		config[i].title='Information';
		config[i].url="#event.buildLink(linkTo='community.settings.index',queryString='viewName=index&communityID=#community.communityID#')#";
		i++;
		
		config[i] = structnew();
		config[i].title='Images';
		config[i].url="#event.buildLink(linkTo='community.settings.index',queryString='viewName=images&communityID=#community.communityID#')#";
		i++;
		
		config[i] = structnew();
		config[i].title='Settings';
		config[i].url="#event.buildLink(linkTo='community.settings.index',queryString='viewName=settings&communityID=#community.communityID#')#";
		i++;

		config[i] = structnew();
		config[i].title='Integration';
		config[i].url="#event.buildLink(linkTo='community.settings.index',queryString='viewName=integration&communityID=#community.communityID#')#";
		i++;
		
		config[i] = structnew();
		config[i].title='Domain';
		config[i].url="#event.buildLink(linkTo='community.domain.index',queryString='communityID=#community.communityID#')#";
		i++;
		
		config[i] = structnew();
		config[i].title='Profile';
		config[i].url="#event.buildLink(linkTo='member.profileAdmin.index',queryString='communityID=#community.communityID#')#";
		i++;
		
	</cfscript>
	<cfmodule template="/customTags/jqueryTabs.cfm" config="#config#" name='configTabs'>
	
</div>
<div class="ft"></div>
</div>
</cfoutput>