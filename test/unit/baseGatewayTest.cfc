<cfcomponent name="baseGatewayTest" extends="coldbox.system.testing.BaseTestCase">
	
	<cffunction name="setUp" returntype="void" access="public">
		<cfscript>
			mockBox = getMockBox();

			// Mock DataMGR
			myDAO = mockbox.createEmptyMock(className='model.DataMgr._DataMgr');
			myDAO.$('getRecords', queryNew('foo,bar'));
			myDAO.$('saveRecord', 12);
			myDAO.$('insertRecord', 12);
			myDAO.$('getTableData', {foo = 'foo', bar='bar'});
			
			// Create Mock + Init Component Under Test
			baseGateway = mockbox.createMock('model.baseGateway');
			baseGateway.init(datasource='community', dao = myDAO);
		</cfscript>
	</cffunction>
	
	<!--- Begin specific tests --->
	<cffunction name="testinit" access="public" returnType="void">
		<cfscript>
			assertTrue(isStruct(baseGateway),"Initialized Successfully");
		</cfscript>
	</cffunction>	
	
	<cffunction name="testget" access="public" returnType="void">
		<cfscript>
			data = baseGateway.get('community');
			assertTrue(isQuery(data),"Query Successful");
			
			data = baseGateway.get('community', {foo='bar'});
			debug(data);
			assertTrue(isQuery(data),"Query Successful");

			data = baseGateway.get('community', {foo='bar'}, 'foo');
			assertTrue(isQuery(data),"Query Successful");
			
			data = baseGateway.get('community', {foo='bar'}, 'foo', 10);
			assertTrue(isQuery(data),"Query Successful");
		</cfscript>
	</cffunction>		

	<cffunction name="testsave" access="public" returnType="void">
		<cfscript>
			data = baseGateway.save('community', {foo='bar'});
			assertTrue(isNumeric(data),"Saved");

			data = baseGateway.save('community', {foo='bar'}, 'insert');			
			assertTrue(isNumeric(data),"Saved");
		</cfscript>
	</cffunction>		

	<cffunction name="testdelete" access="public" returnType="void">
		<cfscript>
			data = baseGateway.delete('community', {communityID = 1500});
			assertTrue(data eq 1,"Deleted");
		</cfscript>
	</cffunction>		
	
	<cffunction name="testgetTableData" access="public" returnType="void">
		<cfscript>
			data = baseGateway.getTableData('community');
			assertTrue(isStruct(data),"Table Definition Successful");
		</cfscript>
	</cffunction>		
	
	<cffunction name="testqueryRowToStruct" access="public" returnType="void">
		<cfscript>
			data = queryNew('foo,bar');
			queryAddRow(data,1);
			querySetCell(data,'foo','bar',1);
			querySetCell(data,'bar','baz',1);
			
			returnData = baseGateway.queryRowToStruct(data,1);
			
			assertTrue(isStruct(returnData),"Row Converted to Struct");
		</cfscript>
	</cffunction>		
	
	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>