<cfscript>
	getModule = qGetModules;
		q_content = rc.contentModuleData.query;
</cfscript>
<cfoutput>
	<cfloop query="q_content" >	
			<h1>#title#</h1>  
		<cfif subtitle neq ''>#subtitle#<BR><BR></cfif>
	
				#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
						image=q_content.image, 
						title=q_content.title,
						size=getModule.thumbsize,
						align=getModule.thumbAlign,
						showColorBox = 1
			 )#
	     	#q_content.desc# 
	</cfloop>
</cfoutput>
