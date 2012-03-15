<cfscript>
	getModule = qGetModules;	

	contentCount=rc.contentModuleData.count;
	q_content = rc.contentModuleData.query;
</cfscript>
<cfoutput query="q_content">
	<cfset myurl = "/index.cfm/content/#contentType#/#q_content.contentID#">
		<Cfif startdate neq ''>
			<Cfset myStartDate = application.timezone.castFromServer(startDate, application.community.settings.getValue('timezone'))>
		</cfif>
		<Cfif enddate neq ''>
			 <Cfset myEndDate = application.timezone.castFromServer(endDate, application.community.settings.getValue('timezone'))>
		</cfif>
		<cfif q_content.image neq ''>
          	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
			image=q_content.image, 
			link=myURL,
			size=getmodule.thumbsize,
			align=getmodule.thumbalign)#
          	<cfelse>
		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
    		image=application.members.userpic( q_content.memberID ), 
    		link=myURL,
    		size=getModule.thumbSize,
    		align=getModule.thumbAlign )#
           </cfif>

		<a href="/index.cfm/content/#contentType#/#q_content.contentID#" title="view details">#title#</a>
        <span class="small">
             #dateformat(mystartdate, request.community.dateformat)#
             <cfif dateformat(startdate) neq dateformat(enddate) and enddate neq ''>
              	- #dateformat(myenddate, request.community.dateformat)#
             </cfif>
             <BR />
             #timeformat(mystartdate)#
             <cfif timeformat(startdate) neq timeformat(enddate) and enddate neq ''>
              	- #timeformat(myenddate)#
             </cfif>
             <BR>
			 <cfif venue neq ''>#venue# <br></cfif>
		     <cfif city neq '' and state neq ''>#City#, #state#<BR /></cfif>
	    </span>
	    
		<BR style="clear:both">
</cfoutput>