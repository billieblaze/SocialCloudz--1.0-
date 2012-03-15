<cfscript>
	getModule = qGetModules;
		q_content = rc.contentModuleData.query;
q_childcontent = rc.contentModuleData.child;

price = application.content.getAttribute(q_content.attribs, 'price');
city = application.content.getAttribute(q_content.attribs, 'city');
state = application.content.getAttribute(q_content.attribs, 'state');
</cfscript>

<cfoutput>
<h3>#q_content.title#</h3>
#q_content.subtitle#<BR><BR> 
#application.content.getAttribute(q_content.attribs, 'address')#<BR />
<cfif city neq '' and state neq ''>#city#, #state#<BR /></cfif>
Price: <cfif isnumeric(price)>#dollarformat(price)#<cfelse>#price#</cfif><BR>
Year Built: #application.content.getAttribute(q_content.attribs, 'built')#<BR>

<div align="center">
	<img src="#q_childContent.image#" id="mainImage">
	<br />
	<cfloop query="q_childcontent"> 
		<div style="float:left" class="pad5">
			#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=q_childContent.image, link="javascript: $('##mainImage').attr('src', '#q_childcontent.image#');", size=getmodule.thumbsize, align=getmodule.thumbalign)#
		</div>
	</cfloop>
	</div>
<br style="clear:both">
<HR />
#q_content.desc#
</cfoutput>