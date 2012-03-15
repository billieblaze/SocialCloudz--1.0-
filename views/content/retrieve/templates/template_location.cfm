<cfscript>
	getModule = qGetModules;   
		q_content = rc.contentModuleData.query;
website = application.content.getAttribute(q_content.attribs, 'website');
website = replace(website, 'http://', '');
website = 'http://#website#';
</cfscript>

<cfoutput query="q_content">
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
				image=q_content.image, 
				size=getModule.thumbsize,
				align=getModule.thumbalign)#
     <h2>#q_content.title#</h2>
	<cfif venue neq ''>#venue# <br></cfif>
	<cfif address neq ''>#address#<BR></cfif>
	<cfif q_content.city neq '' and q_content.state neq ''>#q_content.City#, #q_content.state#<BR /></cfif>
	<cfif q_content.country neq ''>#q_content.country#<BR></cfif>
    <cfif address neq '' or (city neq '' and state neq '')>
      	<a href="http://mapof.it/#address# #city# #state# #country#" target="_blank">(Map It)</a><BR>
    </cfif>
	<cfif	 website neq 'http://'>
		Website: <a href="#website#" target="_blank">#website#</a><BR>
	</cfif>
    <cfif desc neq ''>
		<br>
		#wrap(desc,100)#
	</cfif>
</cfoutput>
<BR style="clear:both" /> 

