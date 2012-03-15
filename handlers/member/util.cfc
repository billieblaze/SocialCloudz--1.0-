<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 member handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
			this.prehandler_only 	= "";
			this.prehandler_except 	= "index,list";
			this.posthandler_only 	= "";
			this.posthandler_except = "index,list,exportCSV,autocomplete";
			this.allowedMethods = structnew();
		</cfscript>
		<!--- preHandler --->
		<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
			<cfargument name="event" type="any">
			<cfscript>	
				var rc = event.getCollection();
				announceInterception('checkLogin');
			</cfscript>
		</cffunction>
		
		<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
			<cfargument name="event" type="any">
			<cfscript>	
				var rc = event.getCollection();
				relocate(request.session.lastpage);
			</cfscript>
		</cffunction>	
					
		<cffunction name="index" returntype="Void" output="false">
			<cfargument name="event" type="any">
			<cfscript>	
				var rc = event.getCollection();
			</cfscript>
		</cffunction>
		
		<cffunction name="list">
			<cfargument name="event" />
	        <cfscript>
				var rc = event.getCollection();
				var showInvisible = 0; 
				
				request.page.title = application.cms.settings.check('Title');
				request.layout.edit = 1;
				announceInterception('checkPrivate');
			
				
				if (request.session.accesslevel gte 20){ 
					showInvisible = 1;
				}

				event.setvalue('members',application.members.gateway.list(
					online=event.getvalue('online',''),
					limit=10, 
					page=event.getvalue('page',''), 
					search=event.getvalue('search',''), 
					radius = event.getvalue('radius',''), 
					latitude=event.getvalue('latitude',''), 
					longitude = event.getvalue('longitude',''), 
					country=event.getvalue('country',''), 
					gender=event.getvalue('gender',''), 
					age1=event.getvalue('age1',''), 
					age2=event.getvalue('age2',''),
					memberid = event.getvalue('memberid',''), 
					flagged= event.getvalue('flagged',''), 
					approved = event.getvalue('approved',''), 
					banned=event.getvalue('banned',''),
					profileType = event.getvalue('profileType', ''),
					sort = event.getValue('sort','m.memberID asc'),
					state=event.getValue('stateSearch', ''),
					questionID = event.getValue('questionID',''),
					questionValue = event.getValue('questionValue',''),
					showInvisible = 0
				));
				
				event.setvalue('membercount',application.members.gateway.list(
					online=event.getvalue('online',''), 
					search=event.getvalue('search',''), 
					radius = event.getvalue('radius',''), 
					latitude=event.getvalue('latitude',''), 
					longitude = event.getvalue('longitude',''), 
					country=event.getvalue('country',''), 
					gender=event.getvalue('gender',''), 
					age1=event.getvalue('age1',''), 
					age2=event.getvalue('age2',''),
					memberid = event.getvalue('memberid',''), 
					flagged= event.getvalue('flagged',''), 
					approved = event.getvalue('approved',''), 
					banned=event.getvalue('banned',''),
					profileType = event.getvalue('profileType', ''),
					state=event.getValue('stateSearch', ''),  					
					questionID = event.getValue('questionID',''),
					questionValue = event.getValue('questionValue',''),
					showInvisible = 0,
					countonly=1)
				);
	
				if (rc.apiCall eq 1 ){
					rc.grid.data = rc.members;
					rc.grid.count = rc.membercount.count;
				}else{
					rc.sideBar=renderView('member/util/nav');
					event.setView('member/util/list');
				}
			</cfscript>
	
	     </cffunction>
	
	    <cffunction name="addBlock">
			<cfargument name="event" />
			<cfscript>
				var rc = event.getCollection();
				application.members.block.save(rc);
				announceinterception('logActivity', {	activityType='members', 
						 	activityAction='blocked', 
							contentType = 'blocks', 
							contentID = rc.memberID, 
							memberID = request.session.memberID});
			</cfscript>
	    </cffunction>
		
	    <cffunction name="addflag">
			<cfargument name="event" />
			<cfscript>
				var rc = event.getCollection();
				application.members.flagmember(memberid = rc.memberID);
				
				announceinterception('logActivity', {	activityType='members', 
						 	activityAction='flagged', 
							contentType = 'members', 
							contentID = rc.memberID, 
							memberID = request.session.memberID});
							
			</cfscript>
	    </cffunction>
	
		<cffunction name="feature">
			<cfargument name="event" />
		    <cfscript>
			    var rc = event.getCollection();
				rc.communityID = request.community.communityID;
				application.members.account.save(rc);
				
				announceinterception('logActivity', {	activityType='members', 
						 	activityAction='featured', 
							contentType = 'members', 
							contentID = rc.memberID, 
							memberID = request.session.memberID});
							
			</cfscript>
		</cffunction>
		
		<cffunction name="exportCSV">
			<cfargument name="event" />
	        <cfset var rc = event.getCollection()>
			<cfset var members = ''>
			<Cfset var csv = ''>
			
		 	<cfcontent type="application/vnd.ms-excel">
			<cfheader name="content-disposition" VALUE="attachment; filename=members.csv">
			
		  	<cfscript>
				members = application.members.gateway.list(communityId = rc.communityID);
				csv = application.util.csvFormat(members,'','username,firstname,lastname,email,city,state,zip,country,gender,birthdate,image,numlogins,profileviews,dateentered,lastclick');
				announceinterception('logActivity', {	activityType='app', 
										 	activityAction='export members', 
											contentType = 'members', 
											contentID = rc.communityID, 
											memberID = request.session.memberID});
				event.renderData('plain', csv);
			</cfscript>
	     </cffunction>
		
		<cffunction name="autocomplete">
			<cfargument name="event" />
			<cfscript>
	        	var rc = event.getCollection();
	        	var rVal = arrayNew(1);
       			var members = application.members.gateway.list(search = rc.term, limit=event.getvalue('limit', 10));
			</cfscript>
			<cfloop query="members">
				<cfset rVal[currentRow] = { label = members.username, memberID = members.memberID, image = application.member.userpic(memberID = members.memberid), location = '#members.city#, #members.state#'}>
			</cfloop>
			<cfset event.renderData('plain', application.utils.jsonEncode(rval))>
	     </cffunction>
		
	</cfcomponent>