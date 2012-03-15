<cfscript>
		q_content = rc.contentModuleData.query;
</cfscript>
<Cfoutput>
<cfloop query="q_content" >	
		<h1>#title#</h1>  
	File Type:  #application.content.getAttribute(q_content.attribs, 'filetype')#<BR>
	Size: #application.content.getAttribute(q_content.attribs, 'size')#<BR>
<BR>
<img src="#application.cdn.fam#disk.png"> <a href='#application.content.getAttribute(q_content.attribs, 'directory/')##application.content.getAttribute(q_content.attribs, 'file')#' target="blank">Download File</a>
<cfif q_content.desc neq ''>
<BR><BR>
	#q_content.desc#
</cfif> 

<BR style="clear:both">
</cfloop>

</cfoutput>