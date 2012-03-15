
<cfcomponent name="baseBeanTest" extends="mxunit.framework.TestCase">
	<!--- Begin specific tests --->
	
	<cffunction name="testgetMemento" access="public" returnType="void">
		<cfscript>
			memento = this.myComp.getMemento();
			assertTrue(isStruct(memento),"Retrieved Memento");
		</cfscript>
	</cffunction>		
	
	<cffunction name="testinit" access="public" returnType="void">
		<cfscript>
			this.myComp.init();
			assertTrue(true,"Initialized Successfully");
		</cfscript>
	</cffunction>		
	
	<cffunction name="testsetMemento" access="public" returnType="void">
		<cfscript>
			data = { foo = 'bar', bar = 'baz', baz = 'foo'};
			this.myComp.setMemento(data);
			assertTrue(true,"Updated Bean");
		</cfscript>
	</cffunction>		
	

	<!--- setup and teardown --->
	
	<cffunction name="setUp" returntype="void" access="public">
		<cfscript>
			this.myComp = createObject("component","model.baseBean");		
		</cfscript>
	</cffunction>

	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>

