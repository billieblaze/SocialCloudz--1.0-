<cfscript>
	q_content = rc.contentModuleData.query;
	getmodule = qGetModules;
	request.addressArray = arrayNew(2);
	request.addressArray[currentRow][1] = title;
	request.addressArray[currentRow][2] = '#q_content.city#, #q_content.state#';
	website = application.content.getAttribute(q_content.attribs, 'website');
</cfscript>
<cfoutput>	
		<h3>#q_content.title#</h3>
		<h4>Position: #q_content.subtitle#</h4>
		<br />
		<br />	
		#q_content.desc#
		<br />
		<br />
		<b>Compensation Package:</b> #application.content.getAttribute(q_content.attribs, 'salary')#
		<br />
		<b>NMLS License Required:</b> 	<cfif application.content.getAttribute(q_content.attribs, 'licensed') eq 1> Yes <cfelse> No </cfif>
		<br />
		<b>States:</b> 	#application.content.getAttribute(q_content.attribs, 'States')#
		<br />	
		<b>Start Date:</b> 	#application.content.getAttribute(q_content.attribs, 'jobStartDate')#
		<br />			
		<b>How To Apply:</b> 	#application.content.getAttribute(q_content.attribs, 'howToApply')#
		<br />
		<hr>
		<b>Location:</b>
		<br />
		<cfif q_content.address neq ''>#q_content.address#<BR></cfif>
			<cfif q_content.city neq '' and q_content.state neq ''>
           #q_content.City#, #q_content.state#<BR />
            </cfif>
		 <cfif q_content.address neq '' or (q_content.city neq '' and q_content.state neq '')>
          	<a href="http://mapof.it/#q_content.address# #q_content.city# #q_content.state# #q_content.country#" target="_blank">(Map It)</a><br /><br />
          </cfif>
		<cfif q_content.phone neq ''>
			<strong>Phone: </strong>#q_content.phone#<br />
		</cfif>
		
		<cfif website neq 'http://'>
			<strong>Website:</strong> <a href="#website#" target="_blank">#website#</a><BR>
		</cfif>
										
</cfoutput>