<cfscript>
	q_content = rc.contentModuleData.query;
</cfscript>

<cfoutput>
<div style="float:left;">
		<cfset ratingaccess = application.cms.settings.check('canRate')>
		<cfif ratingAccess neq 'Noone'>
				<cfset canrate = 1>
				<cfif ratingaccess eq 'members' and request.session.login eq 0>
					<cfset canrate = 0>
				<cfelseif  ratingaccess eq 'Admin' and request.session.login lte 10>
					<cfset canrate = 0>
				</cfif>
				<cfmodule template='/customTags/ratingStars.cfm' FKID='#q_content.contentID#' fkType='Content'  canRate='#canrate#' />
		</cfif>
	</div>
<div align="right">
	 <a href="#event.buildLink(linkTo='content.util.flag',queryString='contentID=#q_content.contentID#')#&newstatus=1" class="small"><img src="#application.cdn.fam#exclamation.png" border="0" height="15" alt="report" /></a> 
     <a href="#event.buildLink(linkTo='content.util.flag',queryString='contentID=#q_content.contentID#')#&newstatus=1" class="small">Flag</a>&nbsp;&nbsp;
 <cfif request.session.login eq 1> 
	<cfif q_content.isfavorite eq 1>
    	<a href="#event.buildLink(linkTo='content.favorite.remove',queryString='contentID=#q_content.contentID#')#" class="small" class="aNone small"><img src="#application.cdn.fam#heart_delete.png" height="15" alt="remove favorite" border=0/></a> 
	        <a href="#event.buildLink(linkTo='content.favorite.remove',queryString='contentID=#q_content.contentID#')#" class="small">Remove Favorite</A>
		<cfelse>
	    	<a href="#event.buildLink(linkTo='content.favorite.add',queryString='contentID=#q_content.contentID#')#" class="small"><img src="#application.cdn.fam#heart_add.png" height="15" alt="add to favorites" border=0/></a> 
	        <a href="#event.buildLink(linkTo='content.favorite.add',queryString='contentID=#q_content.contentID#')#" class="small">Add Favorite</A>
		</cfif> 
		  
	    </cfif>
    </div>
    </cfoutput>