<Cfset community = event.getValue('community')>
<cfscript>
	bandwidth = application.server.bandwidth.check(community.communityID, 'month').total;
	if (bandwidth neq 0 and bandwidth neq ''){
		bandwidth = application.util.byteConvert(bandwidth);
	}
	bandwidthTotal = application.util.byteConvert(community.bandwidth);
	
	storage = application.server.storage.check(community.communityID, 'month');
	if (storage neq 0 and storage neq ''){
		storage = application.util.byteConvert(storage);
	}
	storageTotal = application.util.byteConvert(community.storage);
	
	pageviews = application.statistics.activity.getCount(community.communityID, 'month').views;
</cfscript>
<cfoutput>
<div class="mod">
    <div class="hd">Navigation</div>
    <div class="bd">
	<a href="#event.buildLink(linkTo='app.dashboard.configure',queryString='communityID=#community.communityID#')#">Configure</a><br />
	<a href="#event.buildLink(linkTo='app.dashboard.manage',queryString='communityID=#community.communityID#')#">Manage</a><br />
	<a href="#event.buildLink(linkTo='app.dashboard.statistics',queryString='communityID=#community.communityID#')#">Statistics</a><br />
	<a href="#event.buildLink(linkTo='app.dashboard.premium',queryString='communityID=#community.communityID#')#">Premium</a><br /><br />
	<a href="#event.buildLink('community.admin.index')#" class="small">Back to My Sites</a>
  </div>
  <div class="ft"></div>
</div>

<div class="mod">
    <div class="hd">Usage</div>
    <div class="bd">
		 <B>This Month</B>
	     <HR />
	     Bandwidth:<br />
		 #bandwidth# / #bandwidthTotal#<br /><br />
	     Storage: <br />
		 #storage# / #storageTotal#    <br /><br />
	     Page Views:<br />
	  	 #pageviews#<br />
		<br />
		<!---<A href="/index.cfm/commerce/upgrade/index/communityID/#community.communityID#">Upgrade your Plan</A><BR />
		<A href="##" onclick="confirmDelete('Are you sure you want to deactivate your site? This will terminate billing after the next billing cycle, and you will be unable to access your site.', '/index.cfm/community/admin/cancel/communityID/#community.communityID#');">Cancel your Account</A>     --->
    </div>
    <div class="ft"></div>
</div>
</cfoutput>