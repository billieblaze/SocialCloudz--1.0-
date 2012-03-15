<cfscript>
	contentNav = rc.content.query;
	isfriend = application.members.isfriend(request.session.memberid, contentNav.memberID);
	member  = application.members.gateway.list(memberID=contentNav.memberid);
	getModule = qGetModules;
</cfscript>
<cfoutput> 

   	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
   		id="imagePreview",
		link='/index.cfm/members/#member.username#',
		title='view profile',
   		image=application.members.userpic( contentNav.memberID ), 
   		size=getmodule.thumbSize,
   		align=getModule.thumbAlign )#
	
	<div class="small">			
		Posted By <a href="/index.cfm/members/#member.username#">#member.username#</a><br>
		on 	#dateFormat(application.timezone.castFromServer(contentNav.publishDate, application.community.settings.getValue('timezone')),request.community.dateformat)#
		<br />
		#q_content.views# Views
		<br />
		<br />		
		<a href='/index.cfm/content/#rc.contentType#?memberID=#contentNav.memberid#' class="small">More #rc.contentType#s from #member.username#</a>
	</div>
	<br style="clear:both">
	<cfif contentNav.categories neq ''> 
		<div class="small">Categories:<cfloop list="#contentNav.categories#" index='i'><a href='/index.cfm/content/#contentNav.contentType#?category=#i#' class="small">#i#</a>&nbsp;&nbsp;</cfloop> </div>
	</cfif>
	<cfif contentNav.tags neq ''>
		<div class="small">Tags:  <cfloop list="#contentNav.tags#" index='i'>#application.processtext.parseTag(i)#&nbsp;</cfloop> </div>
	</cfif>
  </cfoutput>