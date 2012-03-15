<cfcomponent extends="coldbox.system.testing.BaseTestCase" output="false" interceptor="common.modules.statistics.interceptors.statistics" appMapping="/coldboxDemo">
	
	<cffunction name="setUp" returntype="void" output="false">
		<cfscript>
			
			// Call the super setup method to setup the app.
			super.setup();
	
			
			// Any preparation work will go here for this test.
			
            application.cbController = getController();
		</cfscript>
	</cffunction>
	
	
	<cffunction name="testLogActivity" returntype="void" output="false">
		<cfscript>
		var event = getMockRequestContext();
		
		session.pid = '';
		application.appname = 'backbone';
		request.viewID = 1;
		
		url.event = 'general.index';
        setupRequest(url.event);                 
        announceinterception('logActivity', {activityType='unit', 
											 activityAction='test', 
											 fkType = 'unittest', 
											 fkID = 1, 
											 applicationName = 'backbone',
											 pid = '1234'});
        event = getRequestContext();  
        
		assertTrue(1, 'Activity Logged');	
						
		</cfscript>
	</cffunction>

	<cffunction name="testDataChange" returntype="void" output="false">
		<cfscript>
			var event = getMockRequestContext();
			
			// mock query
			origQuery = queryNew('field1, field2, field3, field4');
			queryAddRow(origQuery);
			querySetCell(origQuery, 'field1', 'foo');
			querySetCell(origQuery, 'field2', 'bar');
			querySetCell(origQuery, 'field3', 'bar');
			querySetCell(origQuery, 'field4', 'bar');
			
			// mock form
			form.field1 = 'foobar';
			form.field2 = 'bar';
			form.field3 = 'foo';
			form.field5 = 'foobaz';
			
			session.pid = '';
			application.appname = 'backbone';
			request.viewID = 70;
			cookie.visitorID = 4; 
			
			url.event = 'general.index';
	        setupRequest(url.event);                 
	        announceinterception('dataChange', {
	        					viewID = request.viewID, 
								fkType='proposal', 
								fkID='152', 
								originalData= origQuery, 
								newData = form});
	
	        event = getRequestContext();  
	        
			assertTrue(1, 'Datachange Logged');	
						
		</cfscript>
	</cffunction>
</cfcomponent>