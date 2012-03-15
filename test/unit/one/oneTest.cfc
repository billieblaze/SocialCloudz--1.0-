
<cfcomponent name="oneTest" extends="mxunit.framework.TestCase">

	<cffunction name="setUp" returntype="void" access="public">
		<cfscript>
			this.myComp = createObject("component","model.one.one");		
		</cfscript>
	</cffunction>
	
	<!--- Begin specific tests --->
	<cffunction name="testinit" access="public" returnType="void">
		<cfscript>
			one = this.myComp.init();
			assertTrue(isStruct(one),"Initialized");

			one = this.myComp.init(createUUID());
			assertTrue(isStruct(one),"Initialized");
		</cfscript>
	</cffunction>	
	
	<cffunction name="testgetOneID" access="public" returnType="void">
		<cfscript>
			one = this.myComp.init();
			oneID = one.getOneID();
			assertTrue(isValid('uuid',oneID),"OneID retrieved from bean");
		</cfscript>
	</cffunction>		
	
	<cffunction name="testsetOneID" access="public" returnType="void">
		<cfscript>
			one = this.myComp.init();
			oneID = createUUID();
			one.setOneID(oneID);
			
			newOneID = one.getOneID();
			assertTrue(oneID eq newOneID, "Set");
		</cfscript>
	</cffunction>	
	
	<cffunction name="testgetProviders" access="public" returnType="void">
	<cfscript>
			one = this.myComp.init();
			
			providers = one.getProviders();
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(provider = 'facebook');
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(context = 'personal');
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(role = 'consumer');
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(category = 'social');
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(category = 'social');
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(context='business', role='consumer');
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(context='business', category='music');
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(context='business', category='music');
			assertTrue(isArray(providers),"get providers");
			
			providers = one.getProviders(context='business', role='producer', category='music');
			assertTrue(isArray(providers),"get providers");
		</cfscript>
	</cffunction>		
	
	<cffunction name="testapplyFilter" access="public" returnType="void">
		<cfscript>
			one = this.myComp.init();
			providers = one.getProviders(context='business');
			filter = one.applyFilter(providers, 'role', 'producer');
			assertTrue(isArray(providers),"get providers");
		</cfscript>
	</cffunction>	
	
	<cffunction name="testaddProvider" access="public" returnType="void">
		<cfscript>
			one = this.myComp.init();
			provider = {
					provider = 'facebook', 
					authKey = '123456', 
					context='personal', 
					role='consumer', 
					privacy = 0, 
					category='social'
				};
				
			one.addProvider(provider);
			
			providers = one.getProviders();
			assertTrue(arrayLen(providers) eq 1,"Added / Retrieved");
		</cfscript>
	</cffunction>		
	
	<cffunction name="testdeleteProvider" access="public" returnType="void">
		<cfscript>
			one = this.myComp.init();
			provider = {
					provider = 'facebook', 
					authKey = '123456', 
					context='personal', 
					role='consumer', 
					privacy = 0, 
					category='social'
				};
				
			one.addProvider(provider);
			
			providers = one.getProviders();
			assertTrue(arrayLen(providers) eq 1,"Added / Retrieved");	
			
			provider = {
						provider = 'facebook'
					};
			one.deleteProvider(provider);
			assertTrue(arrayLen(providers) eq 0,"Deleted");	
		
		</cfscript>
	</cffunction>		
	
	<cffunction name="testgetProvider" access="public" returnType="void">
		<cfscript>
			one = this.myComp.init();
			provider = {
					provider = 'facebook', 
					authKey = '123456', 
					context='personal', 
					role='consumer', 
					privacy = 0, 
					category='social'
				};
				
			one.addProvider(provider);

			providers = one.getProvider('facebook');
			assertTrue(isStruct(providers),"Added / Retrieved");	
		</cfscript>
	</cffunction>		
	
	<cffunction name="testupdateMemberID" access="public" returnType="void">
		<cfscript>
			one = this.myComp.init();
			provider = {
					provider = 'facebook', 
					authKey = '123456', 
					context='personal', 
					role='consumer', 
					privacy = 0, 
					category='social'
				};
				
			one.addProvider(provider);

			providers = one.updateMemberID('facebook', '43');
			
			providerDetail = one.getProvider('facebook');
			
			assertTrue(providerDetail.memberID eq 43,"updated");	
		</cfscript>
	</cffunction>		
	
	<cffunction name="testarrayOfStructsFind" access="public" returnType="void">
		<cfscript>
			testArray = arrayNew(1);
			
			testArray[1] = { provider = 'facebook'};
			testArray[2] = { provider = 'linkedin'};	
			
			one = this.myComp.init();
			result = one.arrayOfStructsFind(testArray, 'provider', 'facebook');
			
			assertTrue(isNumeric(result),"Searched");
		</cfscript>
	</cffunction>	
	
	<cffunction name="tearDown" returntype="void" access="public">
		<!--- Any code needed to return your environment to normal goes here --->
	</cffunction>

</cfcomponent>

