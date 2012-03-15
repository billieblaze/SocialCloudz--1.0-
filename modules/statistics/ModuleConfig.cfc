<cfcomponent>
	<cfscript>
		// Module Properties
		this.title 			= "Statistics / Logging / Data Audit";
		this.author 			= "Bill Berzinskas";
		this.webURL 			= "http://research.unc.edu";
		this.description 		= "tracks visitors, page views, bots, activities and data changes";
		this.version			= "1.0";
		
		// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
		this.viewParentLookup 	= false;
		
		// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
		this.layoutParentLookup = false;
	</cfscript>

	<cffunction name="configure">
		<cfscript>
			interceptors = [
				{name="statistics",class="modules.statistics.interceptors.statistics",
				 properties={ }
				}
			];	
		</cfscript>
	</cffunction>
	
	<cffunction name="onLoad">
		<cfscript>
			application.statistics = createobject('component','model.statisticsService').init(datasource='statistics');
		</cfscript>
	</cffunction>
	
</cfcomponent>
