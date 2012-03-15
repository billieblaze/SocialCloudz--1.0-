<cfscript>
	q_content = rc.contentModuleData.query;
	contentType = rc.contentFilter.contenttype;
	ratingaccess = application.cms.settings.check('canRate');
</cfscript>

<cfoutput>
	 
      <cfloop query='q_content'>
        <!--- get the link from attributes, and be sure it has http:// on it --->

        <cfset linkurl = application.content.getAttribute(q_content.attribs, 'linkurl')>
        <cfset linkurl = replace(linkurl, 'http://', '')>
        <cfset linkurl = 'http://' & linkurl>
	<div style="float:left;">
          <h3>
			<a href="#linkurl#" onclick="$.get('/index.cfm/content/util/incrementView/#contentID#');" target="_blank" class="aNone">#title#</a>
			<cfif request.session.login eq 1 and request.session.accesslevel gte 10>
			 <A href='##' onclick="confirmDelete('Are you sure you want to delete this entry?','/index.cfm/content/admin/delete/#contentType#/#contentID#');"><img src="#application.cdn.fam#link_delete.png" /></A>
			 <a href="/index.cfm/#contenttype#/form/#contentID#" id="addlink"><img src="#application.cdn.fam#link_add.png" /></a>  
          </cfif>   
			</h3>
			<a href="#linkurl#" onclick="$.get('/index.cfm/content/util/incrementview/#contentID#');" target="_blank" class="small">#linkurl#</a> <br />
           <span class="linkDesc">#desc#</span>
		 <Span class="small"> Added: #dateformat(dateCreated, request.community.dateformat)# - Visits: #views#</span> <BR>
	    <cfif ratingAccess neq 'Noone'>
			<cfset canrate = 1>
			<cfif ratingaccess eq 'members' and request.session.login eq 0>
				<cfset canrate = 0>
			<cfelseif  ratingaccess eq 'Admin' and request.session.login lte 10>
				<cfset canrate = 0>
			</cfif>
			<cfmodule template='/customTags/ratingStars.cfm' FKID='#contentID#' fkType='#contentType#'  canRate='#canrate#' />
		</cfif>
		<br style="clear:both">      
        
			
	</div>
		<BR><BR>
</cfloop>
</table>

</cfoutput>