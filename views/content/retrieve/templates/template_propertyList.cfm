<cfscript>
	getModule = qGetModules;
		q_content = rc.contentModuleData.query;
</cfscript>
<cfoutput>
	 
      <cfloop query="q_content">
		<cfset myurl = '/index.cfm/content/#rc.contentType#/#evaluate('q_content.#q_content.linkID#')#'>
       <cfset price = application.content.getAttribute(q_content.attribs, 'price')>
	   <cfset address = application.content.getAttribute(q_content.attribs, 'address')>
			<cfif q_content.image eq ''>
			    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( memberID ), 
		    		size=getmodule.thumbsize,
		    		thumbalign=getModule.thumbAlign,
		    		title=q_content.title )#
			<cfelse>
				#getMyPlugin(plugin="imageManager",module="imageManager").displayImage(
					image=q_content.image, 
					size=getmodule.thumbsize, 
					align=getmodule.thumbalign,
		    		title=q_content.title)#
			</cfif>

			<a href="/index.cfm/content/#rc.contentType#/#evaluate('q_content.#q_content.linkID#')#" title="#q_content.title#">
			<h2>#title#</h2></a> 
            #subtitle#<BR />
          	<div style="float:left" class="small">
				Posted by #application.members.getusername(q_content.memberID,1)# on #DateFormat(dateCreated, request.community.dateformat)#
			</div> 
			<br />

            #address# <BR />
            Price: <cfif isnumeric(price)>#dollarformat(price)#<cfelse>#price#</cfif>
            <BR /><BR>
           	#application.processtext.abbreviate(q_content.desc,1024)# 
			
			<a href="/index.cfm/content/#rc.contentType#/#evaluate('q_content.#q_content.linkID#')#" class="small">(Read More)</a>
            	<BR><BR>
	  <cfif q_content.currentrow neq q_content.recordcount><HR /></cfif>
        <br />
      </cfloop>
</cfoutput>