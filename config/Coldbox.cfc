<cfcomponent output="false" hint="My App Configuration">
<cfscript>
/**
structures/arrays to create for configuration

- coldbox (struct)
- settings (struct)
- conventions (struct)
- environments (struct)
- ioc (struct)
- models (struct)
- debugger (struct)
- mailSettings (struct)
- i18n (struct)
- bugTracers (struct)
- webservices (struct)
- datasources (struct)
- layoutSettings (struct)
- layouts (array of structs)
- cacheBox (struct)
- interceptorSettings (struct)
- interceptors (array of structs)
- modules (struct)
- logBox (struct)

Available objects in variable scope
- controller
- logBoxConfig
- appMapping (auto calculated by ColdBox)

Required Methods
- configure() : The method ColdBox calls to configure the application.
Optional Methods
- detectEnvironment() : If declared the framework will call it and it must return the name of the environment you are on.
- {environment}() : The name of the environment found and called by the framework.

*/
	
	// Configure ColdBox Application
	function configure(){
	
		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "socialcloudz",
			eventName 				= "event",
			
			//Development Settings
			debugMode				= false,
			debugPassword			= "",
			reinitPassword			= "",
			handlersIndexAutoReload = false,
			configAutoReload		= false,
			
			//Implicit Events
			defaultEvent			= "cms.page.index",
			
			//Extension Points
			UDFLibraryFile 				= "",
			coldboxExtensionsLocation 	= "",
			modulesExternalLocation		= [],
			pluginsExternalLocation 	= "",
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			
			//Error/Exception Handling
			exceptionHandler		= "main.onException",
			onInvalidEvent			= "",
			customErrorTemplate		= "views/error.cfm",
				
			//Application Aspects
			handlerCaching 			= true,
			eventCaching			= true,
			proxyReturnCollection 	= false,
			flashURLPersistScope	= "session"	
		};
	
		// custom settings
		settings = {
			messagebox_style_override = true
			
		};
		
		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "scdevsite.com"
		};
		
		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false
		};
		
		//Layout Settings
		layoutSettings = {
			defaultLayout = "Layout.Main.cfm",
			defaultView   = ""
		};
		
		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = true,
			customInterceptionPoints = ""
		};
		
		//Register interceptors as an array, we need order
		interceptors = [
			//Autowire
			{class="coldbox.system.interceptors.Autowire",
			 properties={}
			},
			
			//SES
			{class="coldbox.system.interceptors.ses",
			properties={}
			},

			{name="imageManager",class="modules.imageManager.interceptors.imageManager"},
			
			//configuration
			{class="interceptors.configuration",
			 properties={}
			},
			{class="modules.emailTemplates.interceptors.emailTemplates",
			 properties={}
			},
			//authCookie
			{class="interceptors.authCookie",
			 properties={}
			},
			//session
			{class="interceptors.session",
			 properties={}
			},

			{class="interceptors.authentication",
			 properties={}
			},
			//page
			{class="interceptors.page",
			 properties={}
			},
			// contentstore
			{class="interceptors.contentstore",
			 properties={}
			},
			//layout
			{class="interceptors.layout",
			 properties={}
			},
			{class="interceptors.mobile",
				properties={}
			},
			//api
			{class="interceptors.api",
			 properties={}
			}
		];
		
		datasources = {
			community   = {name="community"},
			forums   = {name="community"},
			contentStore   = {name="contentStore"},
			members   = {name="members"},
			statistics   = {name="statistics"}
		};
		
		models = {
			objectCaching = true,
			definitionFile = "config/modelMappings.cfm",
			externalLocation = "coldbox.testing.testmodel",
			SetterInjection = false,
			DICompleteUDF = "onDIComplete",
			StopRecursion = "",
			parentFactory 	= {
				framework = "coldspring",
				definitionFile = "config/parent.xml.cfm"
			}
		};

		logBox = {
			// Register Appenders
			appenders = {
				main = {
					class="coldbox.system.logging.appenders.AsyncRollingFileAppender",
					properties={
						filePath=expandPath("/logs"),autoExpand=false,fileMaxArchives=1,fileMaxSize=3000
					}
				},
				upload = {
					class="coldbox.system.logging.appenders.AsyncRollingFileAppender",
					properties={
						filePath=expandPath("/logs"),autoExpand=false,fileMaxArchives=1,fileMaxSize=3000
					}
				},
				contentImport = {
					class="coldbox.system.logging.appenders.AsyncRollingFileAppender",
					properties={
						filePath=expandPath("/logs"),autoExpand=false,fileMaxArchives=1,fileMaxSize=3000
					}
				}
			},
			root = {levelMin="FATAL", levelMax="WARN", appenders="main"},
			categories = {
				"handlers.util.upload" = { levelMin="FATAL", levelMax="debug", appenders="upload"},
				"handlers.content.import" = { levelMin="FATAL", levelMax="debug", appenders="contentImport"}
			}
				
				
				
		};

	}
	
	function development(){
		// Override coldbox directives
		coldbox.debugMode = true;
		coldbox.handlerCaching = false;
		coldbox.eventCaching = false;
		coldbox.debugPassword = "";
		coldbox.reinitPassword = "";
		coldbox.exceptionHandler		= "";
		coldbox.customErrorTemplate		= "";
		return true;
	}
	
	</cfscript>
</cfcomponent>
