<cfscript>
q_content = rc.contentModuleData.query;
getModule = qGetModules;
contentType = rc.contentFilter.contentType;
myurl = '/index.cfm/content/#contentType#/#evaluate('q_content.#q_content.linkID#')#';
</cfscript>

<cfoutput query="q_content">
			<cfif q_content.image eq ''>
			    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( memberID ),
		    		link = myurl,
		    		size=getmodule.thumbsize,
					align=getmodule.thumbAlign)#
			<cfelse>
				#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
					image=q_content.image, 
		    		link = myurl,
					size=getmodule.thumbsize,
					align=getModule.thumbAlign)#
			</cfif>
			<h2><a href="/index.cfm/content/#contenttype#/#evaluate('q_content.#q_content.linkID#')#" title="#q_content.title#">#title#</a> </h2>
			<cfif subtitle neq ''><h4>#subtitle#</h4></cfif>
		  	<span class="small">
				Posted by #application.members.getusername(q_content.memberID,1)# 
				on #DateFormat(application.timezone.castFromServer(q_content.publishDate, application.community.settings.getValue('timezone')), request.community.dateformat)#
			</span>
		   	<cfif q_content.desc neq ''>
			    <br />
		     	#application.processtext.abbreviate(q_content.desc,1024)# 
				<a href="/index.cfm/content/#contenttype#/#evaluate('q_content.#q_content.linkID#')#" class="small">(Read More)</a>
		       	<BR><BR>
			</cfif>
		<cfif q_content.currentrow neq q_content.recordcount><HR /></cfif>
		<br />
</cfoutput>