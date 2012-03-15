<cfscript>
	getModule = qGetModules;
	q_content = rc.contentModuleData.query;
	contentType = rc.contentFilter.contentType;
</cfscript>
<cfoutput query="q_content">
		<div style="width:48%; float:left;" class="pad5">
        <table width="98%" border="0" cellspacing="0" align="center">
          <tr >
	     <TD rowspan="2" width="#getmodule.thumbsize + 10#" valign="top">
		 <cfif getmodule.thumbsize neq 'none'>
			#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
					image=q_content.image, 
					link='/index.cfm/content/#contentType#/#evaluate('q_content.#q_content.linkID#')#', 
					size=getmodule.thumbsize, 
					title=q_content.title,
					align="left")#
	
		 </cfif>
		</td>
        <td  valign="top">
			<a href="/index.cfm/content/#contentType#/#evaluate('q_content.#q_content.linkID#')#" title="#q_content.title#">
			<h3>#title#</h3></a> 
			#application.processtext.abbreviate(q_content.desc,150)#
		</TD>
          </TR>
<TR><TD valign="bottom" class="padTop5">
       	<div style="float:left" class="xsmall">
			#DateFormat(dateCreated, request.community.dateformat)#
			</div>
              	<div align="right" class="small">Views: #q_content.views# </div>
<BR>
</td></TR>
        </table> 
</div>
<cfif q_content.currentRow mod 2>
		<br style="clear:both">
</cfif>
</cfoutput>
<br style="clear:both">
