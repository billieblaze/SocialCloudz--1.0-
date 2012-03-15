<cfscript>
	getModule = qGetModules;  
	content=application.content.get(contentType='link', limit = getmodule.displayrows, sort=getModule.sort, categoryid=getModule.displaycategoryid);
	contentType = application.content.type.get(contentType=attributes.contenttype);
</cfscript>

<cfoutput>
<cfif content.recordcount eq 0>
    No #contentType# have been posted.
    <cfelse>

	<cfif getModule.displayTemplate eq 'List'>

	<ul>
  <cfloop query='content'>
        <!--- get the link from attributes, and be sure it has http:// on it --->
        <cfset linkurl = application.content.getAttribute(content.attribs, 'linkurl')>
        <cfset linkurl = replace(linkurl, 'http://', '')>
        <cfset linkurl = 'http://' & linkurl>
	<li>#title# - <a href="#linkurl#">#linkURL#</a></li>
	</cfloop>
	</ul>
	<cfelseif getModule.displayTemplate eq 'Detail'>
    <table width="99%" cellspacing=0>
      <cfloop query='content'>
        <!--- get the link from attributes, and be sure it has http:// on it --->

        <cfset linkurl = application.content.getAttribute(content.attribs, 'linkurl')>
        <cfset linkurl = replace(linkurl, 'http://', '')>
        <cfset linkurl = 'http://' & linkurl>
        <TR class="<cfif content.currentrow mod 2>even<cfelse>odd</cfif>">
   
          <TD class="pad3" align="justify">
          <h3>
			<a href="#linkurl#" onclick="$.get('/index.cfm/content/util/incrementview/contentID/#contentID#');" target="_blank" class="aNone">#title#</a>         
			  <cfif request.session.login eq 1 and request.session.accesslevel gte 10>
				 <A href='##' onclick="confirmDelete('Are you sure you want to delete this entry?','/index.cfm/content/admin/delete/contentType/#contentType#/contentid/#contentID#');"><img src="#application.cdn.fam#link_delete.png" /></A> <a href="/#contenttype#/form/#contentID#" id="addlink"><img src="#application.cdn.fam#link_add.png" /></a>  
	          </cfif>
		  </h3>
          #desc# <BR>
            <a href="#linkurl#" onclick="$.get('/index.cfm/content/util/incrementview/contentID/#contentID#');" target="_blank" class="small">#linkurl#</a> <Span class="small"> Added: #dateformat(dateCreated, request.community.dateformat)# - Visits: #views#</span> 
		</TD>
   </TR>
</cfloop>
</table>
</cfif>
<BR />
</cfif>
	
	<BR style="clear:both">
	<div align="right" class="moduleViewAll"><a href="#contenttype.homelink#">View All</a>
</div>
</cfoutput>