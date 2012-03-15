<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 content form handler
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "child,saveOrder,saveChild";
		this.posthandler_only 	= "";
		this.posthandler_except = "";
		this.allowedMethods = structnew();
	</cfscript>
	
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkLogin');
			announceInterception('checkPrivate');
			if (application.content.type.get(rc.contentType).recordcount eq 0){
				request.session.message = 'Invalid ContentType';
				relocate('/');
			}
		
			rc.content.action = listlast(event.getCurrentEvent(),'.');

			rc.content.approvedOnly = 1;
			rc.content.converted = 0;
			rc.content.operator = '';
			
			request.layout.template = 6;
			request.module.title = rc.contentType;				
		
			// Potential input parameters 
			if(event.getvalue('page','') eq '') { 	rc.content.page = '1';	} 
			rc.content.currentPage = event.getvalue('page','');
						
			// Query the content 
			event.setValue('q_content',
				application.content.get(
					contentType=rc.contenttype,
					contentID=rc.contentID,
					approved=rc.content.approvedonly
				)
			);	
		
			// Now that we have a content object, lets verify access on that
			request.page.comments = rc.q_content.comments;
			request.page.rating = rc.q_content.rating;
			request.page.approval =  application.cms.settings.check('Approval'); 	
	
			// Lookup UI related setting
			UISettings = application.content.template.get(contentType = rc.contentType);
			rc.content.form = uisettings.formTemplate;
			rc.content.childform = uisettings.childformTemplate;
			rc.content.rightnav =  evaluate('uisettings.formRightnav');
			rc.content.sortOrder = uiSettings.sortOrderTemplate;
			rc.content.submitChildPostURL = uisettings.submitChildPostURL;	
	
			if (not isdefined('rc.memberid') or rc.memberid eq ''){ 
				rc.memberid = request.session.memberid;
			}
			
			if ( not isdefined('rc.communityID')) { 
				rc.community = application.content.community.get(rc.contentID);
				rc.communityID = valueList(rc.community.communityID); 
			}
			
			if ( rc.communityID eq ''){   rc.communityID = request.community.communityID; }
			
			
		</cfscript>
	</cffunction>
	
	<cffunction name="index">
		<cfargument name="event" />
    	<cfset	var rc = event.getCollection()>
			<cfset structappend(rc, application.util.queryrowtostruct(rc.q_content),false)>
			<cfset structappend(rc, application.content.getAttributes(rc.q_content.attribs),false)>
			<cfset event.setvalue('mycommunities', application.community.getMine(memberID = request.session.memberId))>
		<cfscript>
		if ( rc.contentID neq 0) { 
			event.setvalue('q_childContent', 
				application.content.get(
					updateviews = 0,
					parentID=rc.contentID,
					sort='sortorder',
					direction='asc'
				)
			);		
		}
		event.setView('content/form/#rc.content.form#');

		rc.sideBar = event.getvalue('sideBar','');
		
		for(i=1; i lte listlen(rc.content.rightnav); i=i+1){
			listvalue = listgetat(rc.content.rightnav, i);
			rc.sideBar = rc.sideBar & renderView('content/form/#listValue#');
		}
		rc.sideBar = rc.sideBar & renderView('content/form/frm_bottom');
		</cfscript>
    </cffunction>

	<cffunction name="child">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			event.setValue('q_childcontent',
				application.content.get(
					parentID=rc.contentID,
					sort='sortorder asc'
				)
			);

			event.setValue('contentCount',
				application.content.get(
					parentID=rc.contentID,
					countonly = 1
				)
			);
			
			event.setValue('q_content',
				application.content.get(
					contentType=rc.contenttype,
					contentID=rc.contentID
				)
			);	
			
			event.setLayout('layout.AJAX');
			UISettings = application.content.template.get(contentType = rc.contentType);
			event.setView('content/form/#uisettings.childFormTemplate#');
	    </cfscript>
    </cffunction>

	<cffunction name="sort">
		<cfargument name="event" />
        <cfscript>
			var rc = event.getCollection();
			event.setValue('q_childcontent',
				application.content.get(
					parentID=rc.contentID,
					sort='sortorder asc',
					approved=rc.content.approvedonly
				)
			);

			event.setValue('contentCount',
				application.content.get(
					parentID=rc.contentID,
					updateviews = 0,
					countonly = 1, 
					approved=rc.content.approvedonly
				)
			);
			
		
			
			
			event.setLayout('layout.AJAX');	
			event.setView('content/form/#rc.content.sortorder#');
	    </cfscript>
    </cffunction>
	
	<cffunction name="save">
	  <cfargument name="event" />
	  <cfscript>
		var rc = event.getCollection();
		UISettings = application.content.template.get(contentType = rc.contenttype);
		
		rc.publishDate =  application.timezone.castToServer(lsParseDateTime(rc.publishDate), application.community.settings.getValue('timezone'));
		
		if(UISettings.submitPreFuseaction neq ''){ 	runEvent(uisettings.submitPreFuseaction);	}
		
		if ((rc.contentID eq 0 or rc.contentID eq '') and (not isdefined('rc.approved') or (isdefined('rc.approved') and rc.approved neq 1))){
			if ( application.cms.settings.check( 'approval') eq 'Auto'){
				rc.approved = 1;
			} else { 
				rc.approved = 0;
				request.session.message = 'This site requires content to be approved.  Your post will become visible upon approval.';
	
				// Send Admin a notification
				userEmail = request.community.owner.email;
				data = structNew();
				data.siteURL = request.community.baseurl;
				data.siteName = request.community.site; 
				application.emailTemplates.send(to=userEmail, template="contentApproval", data=data);
			}

		}

				userEmail = request.community.owner.email;
				data = structNew();
				application.emailTemplates.send(to=userEmail, template="contentPosted", data=data);

			if(isdefined('rc.image') and rc.image neq ''){
				rc.image = urldecode(rc.image);

			}
			
			if(isdefined('rc.file') and rc.file neq ''){
				rc.file = urldecode(rc.file);
			}
			
			if(isdefined('rc.website') and trim(rc.website neq '')){
				rc.website = replace(rc.website,'http://','');
				rc.website = 'http://#rc.website#';
			}
	
			if(isdefined('rc.startdate') and trim(rc.startdate) neq ''){ 
				rc.startdate = replace(rc.startdate, ',', ' ');
				rc.startdate = lsParseDateTime(rc.startdate);
				rc.startDate =  application.timezone.castToServer(rc.startDate, application.community.settings.getValue('timezone'));
			}
			
			if(isdefined('rc.enddate') and trim(rc.enddate) neq ''){ 
				rc.enddate = replace(rc.enddate, ',', ' ');
				rc.enddate = lsParseDateTime(rc.endDate);
				rc.endDate = application.timezone.castToServer(rc.endDate, application.community.settings.getValue('timezone'));
			}
			
			if(isdefined('rc.displayMember') and rc.displayMember neq rc.memberID){
				rc.memberID = rc.displayMember;
			}
			rc.contentID = application.content.save(rc);
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='save content', 
				contentType = 'content', 
				contentID = rc.contentId, 
				memberID = request.session.memberID});
			
			
			if(isdefined('rc.image') and rc.image neq ''){
				application.server.storage.save( data = { id: rc.image, contentID: rc.contentID  }, delete = 0 )
			}

			if(isdefined('rc.file') and rc.file neq ''){
				application.server.storage.save( data = { id: rc.file, contentID: rc.contentID  }, delete = 0 )
			}
				
		if(UISettings.submitPostFuseaction neq ''){ runEvent(uisettings.submitPostFuseaction);	}
	
		relocateurl = uisettings.relocateaftersave;
		relocateurl = replace(relocateurl, '[contentID]', rc.contentID);
		relocateurl = replace(relocateurl, '[memberID]', request.session.memberID);
		relocate(relocateURL);
	  </cfscript>
	</cffunction>
	
	<cffunction name="saveChild">
	  <cfargument name="event" />
	  <cfscript>
			var rc = event.getCollection();
			for(i=1; i lte listlen(rc.contentid); i=i+1){
				data = structNew();
				data.default = 0;
				data.contentID = listgetat(rc.contentID,i);
				
				 if(isdefined('rc.delete_#data.contentID#')){
					application.server.storage.delete(fkType = rc.contentType, contentID = data.contentID);
					application.content.gateway.delete(data.contentID);
				} else { 			
					if (isdefined('rc.default') and rc.default eq data.contentID){
						application.content.clearChildAttributes(rc.parentID, 'default');
						data.default = 1;
						parentdata.image = application.content.get(contentID=data.contentID, updateviews = 0).image;
						parentdata.contentID = rc.parentID;
						parentdata.contentType = rc.parentContentType;
						application.content.save(parentdata);
						
					}			
	
					if (isdefined('rc.title_#data.contentID#')){	data.title = evaluate('rc.title_#data.contentID#');}
					if (isdefined('rc.creator_#data.contentID#')){data.creator = evaluate('rc.creator_#data.contentID#');	}	
					if (isdefined('rc.download_#data.contentID#')){data.download = evaluate('rc.download_#data.contentID#');}
				
					contentID = application.content.save(data);
					announceinterception('logActivity', {	activityType='content', 
					 	activityAction='save child content', 
						contentType = 'content', 
						contentID = data.contentId, 
						memberID = request.session.memberID});

				}
			}
			event.renderData("plain","<script>parent.location.href='/index.cfm/content/#rc.parentContentType#/#rc.parentID#';</script>");
	  </cfscript>
	
	</cffunction>

	<cffunction name="saveOrder">
	  <cfargument name="event" />
	  <cfscript>
			var rc = event.getCollection();
			var content = application.content.get(contentID=rc.parentID, approved=0);
		
			for (i=1; i lte listlen(rc.myorder, ' '); i=i+1){
					data.contentID = listgetat(rc.myorder,i,' ');
					data.sortorder = i;
					data.contentType = '#rc.contentType#';
					application.content.save(data);
			}
			announceinterception('logActivity', {	activityType='content', 
			 	activityAction='change sort order', 
				contentType = 'content', 
				contentID = rc.parentID, 
				memberID = request.session.memberID});
		event.renderData('plain',"<script>parent.location.href='/index.cfm/content/#content.ContentType#/#rc.parentID#';</script>");
		</cfscript>
	</cffunction>
</cfcomponent>