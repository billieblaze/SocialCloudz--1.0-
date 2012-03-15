<cfoutput>
	<div class="mod">
		<div class="hd">Details for #rc.visitorID#</div>
		<div class="bd">
	
			<cfscript>
				config = arrayNew(1);
			
				config[1] = structnew();
				config[1].title="Activity";
				config[1].color="green";
				config[1].url="index.cfm?event=statistics:activity.index&visitorID=#rc.visitor.visitorID#";
			
				config[2] = structnew();	
				config[2].title="Views";
				config[2].color="green";
				config[2].url="index.cfm?event=statistics:view.index&visitorID=#rc.visitor.visitorID#";
			
				config[3] = structnew();	
				config[3].title="Data Audit";
				config[3].color="green";
				config[3].url="index.cfm?event=statistics:dataAudit.index&visitorID=#rc.visitor.visitorID#";
				
			</cfscript>
			
			<cfdump var='#rc.visitor#'>
			<cfmodule template="/common/jqueryTabs/jqueryTabs.cfm" config="#config#" title="foo">
		
		</div>
		<div class="ft"></div>
	</div>
</cfoutput>