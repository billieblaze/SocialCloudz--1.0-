<cfcomponent name="sessionTest" extends="coldbox.system.testing.BaseTestCase">
	<cffunction name="setUp" returntype="void" access="public">
		<cfscript>
			mockBox = getMockBox();
			memcached = mockbox.createEmptyMock('model.memcached.memcached');
			memcached.$('get').$results(false,'foo');
			memcached.$('set');
			memcached.$('delete');
			
			this.myComp = createObject("component","model.session").init(memcached=memcached);		
		</cfscript>
	</cffunction>

	<!--- Begin specific tests --->
	<cffunction name="testinit" access="public" returnType="void">
		<cfscript>
			assertTrue(isStruct(this.myComp),"Initialized");
		</cfscript>
	</cffunction>	
		
	<cffunction name="testgetSession" access="public" returnType="void">
		<cfscript>
			mySession = this.myComp.getSession(createUUID());
			assertTrue(isStruct(mySession),"New Session");

			mySession = this.myComp.getSession(createUUID());
			assertTrue(isStruct(mySession),"Existing Session");
		</cfscript>
	</cffunction>		
	
	<cffunction name="testsaveSession" access="public" returnType="void">
		<cfscript>
			mySession = this.myComp.saveSession(createUUID(), {foo='bar'});
			assertTrue(true,"Test not implemented");
		</cfscript>
	</cffunction>	
		
	<cffunction name="testdeleteSession" access="public" returnType="void">
		<cfscript>
			mySession = this.myComp.deleteSession(createUUID());
			assertTrue(true,"Test not implemented");
		</cfscript>
	</cffunction>		
	
	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>