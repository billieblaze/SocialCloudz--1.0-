<cfparam name="rc.tab" default="General">
<div class="mod">
    <div class="hd">Application Admin</div>
    <div class="bd">
		<a href="#event.buildLink(linkTo='emailTemplates:admin.index',queryString='communityID=#community.communityID#')#">Manage Email Templates</a>
	    <cfscript>
			i=1;
			config = arrayNew(1);
			
			config[i] = structnew();
			config[i].title='General';
			config[i].url="#event.buildLink('app.admin.general')#";
			i++;
			
			config[i] = structnew();
			config[i].title='Communities';
			config[i].url="#event.buildLink('app.admin.communities')#";
			i++;
			
			config[i] = structnew();
			config[i].title='Bandwidth';
			config[i].url='#event.buildLink('app.admin.bandwidth')#';
			i++;
			
			config[i] = structnew();
			config[i].title='Storage';
			config[i].url='#event.buildLink('app.admin.storage')#';
			i++;
			
			config[i] = structnew();
			config[i].title='Sessions';
			config[i].url='#event.buildLink('app.admin.sessions')#';
			i++;
		
						
			config[i] = structnew();
			config[i].title='Ads';
			config[i].url='#event.buildLink(linkTo='advertising.admin.index',queryString='global=1')#';
			i++;
			
			config[i] = structnew();
			config[i].title='Bots';
			config[i].url='#event.buildLink('statistics:bots.index')#';
			i++;
		</cfscript>
		<cfmodule template="/customTags/jqueryTabs.cfm" config="#config#">
    </div>
    <div class="ft"></div>
</div>