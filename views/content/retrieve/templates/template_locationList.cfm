<cfscript>
getModule = qGetModules;   
q_content = rc.contentModuleData.query;
contentType = rc.contentFilter.contentType;
</cfscript>
<cfoutput query="q_content">
	<cfscript>
		website = application.content.getAttribute(q_content.attribs, 'website');
		website = replace(website, 'http://', '');
		website = 'http://#website#';
		myURL = '/index.cfm/content/#contentType#/#evaluate('q_content.#q_content.linkID#')#';
	</cfscript>
  		#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
			image=q_content.image, 
			link=myURL, 
			size=getModule.thumbsize, 
			align=getModule.thumbalign,
			title=q_content.title)#

	<div style="float:left">
		<h2><a href="#myURL#" title="#q_content.title#">#title#</a></h2>
     	<cfif q_content.desc neq ''>
	     	#application.processtext.abbreviate(q_content.desc,1024)# 
			<a href="/#contentType#/detail/#q_content.contentID#" class="small">(Read More)</a>
		</cfif>
	</div>
	<div align="right">
		<cfif website neq ''>
			<a href="#website#" id="locationWebsite">View Website</a>
			<BR>
		</cfif>
		<a href="/index.cfm/content/#contentType#/#evaluate('q_content.#q_content.linkID#')#" id="locationAddComment">Add a Comment</a>
		<BR>
		<a href="/index.cfm/content/#contentType#/#evaluate('q_content.#q_content.linkID#')#"  id="locationViewComments">View Comments</a>
	  	<br />
  	</div>

  	<cfif q_content.currentrow neq q_content.recordcount><HR /></cfif>
	<br style="clear:both"/>
</cfoutput>