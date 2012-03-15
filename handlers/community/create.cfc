<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 create a site handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();		
			request.layout.template = 6;
			request.layout.edit = 1;
		</cfscript>
	</cffunction>
	
 
   <cffunction name="details">
        <cfargument name="event">
         <cfscript>
			var rc = event.getCollection();
			event.setvalue('category', application.community.category.get());
			rc.sideBar=renderView('community/create/detailsNav')
        </cfscript>    
   </cffunction>

   <cffunction name="detailsSubmit">
        <cfargument name="event">
		<cfscript>
			var rc = event.getCollection();
			var member = structNew();
			var memberData = structNew();
			var community = structNew();
			var plan = application.commerce.plan.get(planID=1); // trial of plan 1
			
			// PROCESS MEMBER
				// New User
				if (rc.ismember eq 0){
					member.error = application.members.validate(rc);
					if (member.error neq '') {
						request.session.message = member.error; 
						runEvent('community.create.details');
						event.setView("community/create/details");						
						//return;
					} else  {
						// Save user
						memberid = application.members.gateway.save(rc);
						rc.existEmail = rc.email;
						rc.existPassword = rc.password;
					}
				}			

				// Authenticate
				member = application.members.authenticate(email=rc.existemail, password=rc.existpassword);
				if (member.success eq 0) {
					request.session.message = member.errorDetail ;
					runEvent('community.create.details');
					event.setView("community/create/details");
					//return;
				}
				// member -> session
				structappend(request.session,member.Data,true);

			
			// PROCESS COMMUNITY
				community.message = application.community.validate(rc);
		
				if (community.message neq ''){
					request.session.message = community.message;
					runEvent('community.create.details');
					event.setView("community/create/details");
				} else {	
					// Setup / Save Community
					structappend(request.session.community, rc, true);
		
					request.session.community.subdomain = rc.url;
					request.session.community.domainID = request.community.domainID;
					request.session.community.parentID = request.community.communityID;
					request.session.community.active = 1;    
						
					request.session.community.storage=plan.storage;
					request.session.community.bandwidth=plan.bandwidth;
					request.session.community.planID = plan.id;
					
					request.session.community.communityid = application.community.gateway.save(request.session.community);
					application.community.settings.save(request.session.community);
					application.community.setupAdmin(request.session.memberID, request.community, request.session.community);
					application.community.domain.saveMask( datastruct = { communityID = request.session.community.communityID, subdomain = request.session.community.subdomain, domain = request.community.domain.domain, startpage = '/', verified = 1});

					application.session.savesession(cookie.token, request.session);
					
						announceinterception('logActivity', {	activityType='app', 
															 	activityAction='create - details', 
																contentType = 'community', 
																contentID = request.session.community.communityID, 
																memberID = request.session.memberID});
																
					setNextEvent('community.create.features');
				}        
		</cfscript>
   	</cffunction>
       
   	<cffunction name="features">
		<cfargument name="event" />
   	        <cfscript>	
	   	        var rc = event.getCollection();
			    event.setvalue('templates',application.cms.templates.get());
				rc.sideBar = renderView('community/create/featuresNav')
		</cfscript>
    </cffunction>  
    
    <cffunction name="features_submit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			request.session.message = application.cms.validate(rc);
			if (request.session.message neq '') {
				runEvent('community.create.features');
				event.setView('community/create/features');
			} else { 

				community = application.community.gateway.get(communityID=request.session.community.communityid);	
				application.cms.changeTemplate(rc.templateid, community.communityID);
	
	        	if ( not isdefined('rc.features')){  	
	        		featureCommunityID = application.cms.getSiteTemplate(rc.configuration);
	        		application.cms.cloneSite(featureCommunityID, community.communityID);
				}
		   	 	
				// email template
				data = structNew();
				data.siteURL = 'http://#community.subdomain#.#request.community.parent.domain.domain#';
				data.siteName = community.site; 
				application.emailTemplates.send(to=request.session.email, template="newSite", data=data);
				
				announceinterception('logActivity', {	activityType='app', 
													 	activityAction='create - features', 
														contentType = 'community', 
														contentID = request.session.community.communityID, 
														memberID = request.session.memberID});
															
				structclear(request.session.community);
				relocate('#data.siteURL#?m=#request.session.memberID#&i=#cookie.token#&welcome=1');
			}
		</cfscript>
	</cffunction> 

	<cffunction name="checkAvailable">
        <cfargument name="event">
        <cfscript>
			var rc = event.getCollection();
			event.setLayout('layout.AJAX');
		</cfscript>    
    </cffunction>
</cfcomponent>