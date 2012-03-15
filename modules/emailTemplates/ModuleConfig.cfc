<cfcomponent>
	<cfscript>
		// Module Properties
		this.title 			= "Email Templates";
		this.author 			= "Bill Berzinskas";
		this.webURL 			= "http://research.unc.edu";
		this.description 		= "handles templatized emails with dynamic data and logging";
		this.version			= "1.0";
		
		// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
		this.viewParentLookup 	= true;
		
		// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
		this.layoutParentLookup = true;
	</cfscript>

	<cffunction name="configure"></cffunction>
	
</cfcomponent>
