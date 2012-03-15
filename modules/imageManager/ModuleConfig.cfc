<cfcomponent>
	<cfscript>
		// Module Properties
		this.title 			= "imageManager";
		this.author 			= "Bill Berzinskas";
		this.webURL 			= "http://www.socialcloudz.com";
		this.description 		= "multi-homed image manipulation module";
		this.version			= "1.0";
		
		// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
		this.viewParentLookup 	= false;
		
		// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
		this.layoutParentLookup = false;
		
		function configure(){
			settings = { 
				cachePath = '/mnt/cache',
				cacheURL = '/cache',
				tmpPath = '/mnt/cache'
			}
			
			routes = [
				{pattern="/rotate", handler="general",action="rotate"},
				{pattern="/resize", handler="general",action="resize"},		
				{pattern="/crop", handler="general",action="crop"},						
				{pattern="/watermark", handler="general",action="watermark"},
				{pattern="/demo", handler="demo",action="index"}
			];	
			/* register this in the app config - after SES, but before any other app interceptors
			interceptors = [
				{name="imageManager",class="modules.imageManager.interceptors.imageManager"}
			];*/
		}
	</cfscript>

</cfcomponent>
