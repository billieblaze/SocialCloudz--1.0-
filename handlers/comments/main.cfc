<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 comment handler
		
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

	<cffunction name="index">
	  	<cfargument name="event" />
	  	<cfscript>
		  	var rc = event.getCollection();	
			event.setValue('qcomments', application.content.comments.get(fkID=event.getvalue('fkID',''),fkType=event.getvalue('fkType',''), sort='dateEntered', sortOrder='desc', parentID=0));
		</cfscript>
	</cffunction>

	<cffunction name="add">
	  	<cfargument name="event" />
	  	<cfscript> 
		  	var rc = event.getCollection();	
	  		announceInterception('checkLogin');
  			rc.memberID = request.session.memberid;
			rc.communityID = request.community.communityID;
			rc.comment = application.processtext.tagStripper(rc.comment);		
			rc.comment =	 application.processtext.ActivateURL(rc.comment, '_blank'); 
		
			rc.ID = application.content.comments.save(rc);
		
			announceinterception('logActivity', {	activityType='community', 
			 	activityAction='comment', 
				contentType = rc.fkType, 
				contentID = rc.id, 
				memberID = request.session.memberID});
				
			rc.commentID = rc.id;
			
			if(isdefined('rc.attachmentType') and rc.attachmentType neq ''){
				if (rc.attachmentType eq 'Video' and rc.attachmentCode eq ''){
				// video upload
				rc.converted = 0;
				
				} else if (rc.attachmentType eq 'Video' and rc.attachmentURL eq ''){
					// video by URL
					rc.converted = 0;
				} else if (rc.attachmentType eq 'Link'){ 
					// Link 
					rc.attachmentURL = trim(rc.attachmentURL);
					rc.attachmentURL = 'http://' & replacenocase(rc.attachmentURL, 'http://', '');
					// HTTP Get the URL
					http url=rc.attachmentURL method="get" result="content";

					// Parse out the title
		            RegExp = REFindNoCase("(<title[>])(.*)(<\/title>)", content, 1, True);
		            if (RegExp.len[1] gt 0){
		                rc.attachmentTitle = mid(content, RegExp.pos[3], RegExp.len[3]);
		            } else { 
		                rc.attachmentTitle = 'Untitled';
		            }
			
					// Get the Meta Description
					metaData = application.util.getMetaHeaders(content);
					descriptionPointer = application.util.arrayofstructsfind(metaData, 'name', 'description');
					rc.attachmentDescription = metaData[descriptionPointer].content;
					
				}
				// Everything else goes on thru 
				application.content.comments.saveAttachment(rc);
			}	
			
			// Send Notification
			datastruct = structnew();
			datastruct.memberID =event.getvalue('commentMemberID','');
			datastruct.linkURL=event.getvalue('commentReturnURL','');
			datastruct.type = '#rc.fkType#';
			datastruct.message = '#request.session.username# has commented on your #rc.fkType#';
			
			if (datastruct.memberID neq request.session.memberID){
				application.members.notification.save(datastruct);
				request.returnURL = datastruct.linkurl;
				member = application.members.gateway.get(memberID = datastruct.memberID);
				application.emailTemplates.send(to=member.email, template="comment", data = datastruct);
			}
			event.setLayout('layout.AJAX');
			
			if (rc.parentID eq '' or rc.parentID eq 0){
				rc.qcomments = application.content.comments.get(id=rc.id);
				event.setView('comments/main/entry');
			} else { 
				rc.qreplies = application.content.comments.get(id=rc.id);
				event.setView('comments/main/entryReply');
			}
		</cfscript>
	</cffunction> 
	
	<cffunction name="form">
  		<cfargument name="event" />
  		<cfscript>
			var rc = event.getCollection();	
		 	announceInterception('checkLogin');
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name="delete">
  		<cfargument name="event" />
  		<cfscript>
			var rc = event.getCollection();	
		 	announceInterception('checkLogin');
			application.content.comments.delete(rc.id);
			
			announceinterception('logActivity', {	activityType='community', 
			 	activityAction='delete comment', 
				contentType = '', 
				contentID = rc.id, 
				memberID = request.session.memberID});
				
			event.setLayout('layout.None');
			event.setView('dspBlank');
		</cfscript>
	</cffunction>

</cfcomponent>