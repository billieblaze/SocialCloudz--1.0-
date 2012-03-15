<cfcomponent>
	<cfscript>
		// Module Properties
		this.title 			= "forums";
		this.author 			= "Bill Berzinskas";
		this.webURL 			= "http://www.socialcloudz.com";
		this.description 		= "discussion forums";
		this.version			= "1.0";
		
		// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
		this.viewParentLookup 	= false;
		
		// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
		this.layoutParentLookup = false;
		
		function configure(){
			application.forum = createobject('component', '#moduleMapping#/model/forum').init('community');
		}
	</cfscript>

</cfcomponent>
