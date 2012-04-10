<!---
********************************************************************************
ContentBox - A Modular Content Platform
Copyright 2012 by Luis Majano and Ortus Solutions, Corp
www.gocontentbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
Apache License, Version 2.0

Copyright Since [2012] [Luis Majano and Ortus Solutions,Corp]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
********************************************************************************
 --->
<cfcomponent output="false" hint="My App Configuration">
<cfscript>
	// Configure ColdBox Application
	function configure(){
	
		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "ContentBox",

			//Development Settings
			debugMode				= false,
			//debugPassword			= "bblaze",
			//reinitPassword			= "bblaze",
			handlersIndexAutoReload = false,

			//Implicit Events
			defaultEvent			= "General.index",
			requestStartHandler		= "Main.onRequestStart",
			requestEndHandler		= "Main.onRequestEnd",
			applicationStartHandler = "Main.onAppInit",
			sessionStartHandler 	= "Main.onSessionStart",
			sessionEndHandler		= "Main.onSessionEnd",
			missingTemplateHandler	= "Main.onMissingTemplate",
			
			//Extension Points
			UDFLibraryFile 				= "includes/helpers/ApplicationHelper.cfm",
			coldboxExtensionsLocation 	= "",
			modulesExternalLocation		= [],
			pluginsExternalLocation 	= "",
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "",
			
			//Error/Exception Handling
			exceptionHandler		= "Main.onException",
			onInvalidEvent			= "Main.onInvalidEvent",
			customErrorTemplate		= "",
				
			//Application Aspects
			handlerCaching 			= true,
			eventCaching			= true
		};
		
		// custom settings
		settings = {
			PagingMaxRows = 3,
			PagingBandGap = 10
		};

		
		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			development = "^scdevsite."
		};
		
		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false,
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = [] 
		};
		
		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				coldboxTracer = { class="coldbox.system.logging.appenders.ColdboxTracerAppender" },
				// Database Appender Registration
		        dbAppender = {
		            class="coldbox.system.logging.appenders.DBAppender",
		            properties = {
		                // The datasource to connect to
		                dsn = "socialcloudz", 
		                // The table to log to
		                table="api_logs", 
		                // If the table does not exist, then create it
		                autocreate=true, 
		                // The type to use for long text inserting.
		                textDBType="longtext"
		            }
		        }
			},
			
			// Root Logger
			root = { levelmax="INFO", appenders="*" },
			// Implicit Level Categories
			//info = [ "coldbox.system" ]
		};
		
		//Layout Settings
		layoutSettings = {
			defaultLayout = "Layout.Main.cfm"
		};

		// ORM
		orm = {
			// Enable Injection
			injection = {
				enabled = true
			}
		};
		
		//i18n & Localization
		i18n = {
			defaultResourceBundle = "includes/i18n/main",
			defaultLocale = "en_US",
			localeStorage = "session",
			unknownTranslation = "**NOT FOUND**"		
		};
		
		//Register interceptors as an array, we need order
		interceptors = [
			//SES
			{class="coldbox.system.interceptors.SES"}
		];

	}

	// ORTUS DEVELOPMENT ENVIRONMENT, REMOVE FOR YOUR APP IF NEEDED
	function development(){
		//coldbox.debugmode=true;
		coldbox.handlersIndexAutoReload = true;
		coldbox.handlerCaching = false;
		coldbox.reinitpassword = "";
		coldbox.debugpassword = "";
		coldbox.debugmode = true;
		//wirebox.singletonreload = true;



		// ses debugging
		logbox.appenders.files={class="coldbox.system.logging.appenders.RollingFileAppender",
			properties = {
				filename = "ContentBox", filePath="../logs"
			}
		};
		//logbox.debug = ["coldbox.system.interceptors.Security"];
		//logbox.debug = [ "coldbox.system.aop" ];

	}
	
</cfscript>
</cfcomponent>