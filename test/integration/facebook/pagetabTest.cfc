
<cfcomponent name="pagetabTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->
	
	<cffunction name="testindex" access="public" returnType="void">
		<cfscript>
			assertFalse(true,"Test not implemented");
		</cfscript>
	</cffunction>		
	

	<!--- setup and teardown --->
	
	<cffunction name="setUp" returntype="void" access="public">
		<cfscript>
			this.myComp = createObject("component","handlers.facebook.pagetab");		
		</cfscript>
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>

