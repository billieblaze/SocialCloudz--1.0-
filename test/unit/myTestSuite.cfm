<cfparam name="URL.output" default="html">

<cfscript>
	DTS = createObject("component","mxunit.runner.DirectoryTestSuite");
	excludes = "";
	results = DTS.run(
				directory     = "/var/share/socialcloudz/src/main/webapp/test/unit/",
				componentPath = "test.unit",
				recurse       = "true",
				excludes      = "#excludes#"
				);
</cfscript>
 
<cfoutput>#results.getResultsOutput(URL.output)#</cfoutput>  			
	
