<cfscript>	
getModule = qGetModules;
content = application.content.get(contentType=getModule.contenttype, limit=getmodule.displayrows, sort = getmodule.sort, 
memberid = getmodule.displayMember, tag = getModule.displayTag, categoryID = getModule.displayCategoryID);
contentType = application.content.type.get(contentType=getModule.contenttype);
</cfscript>



<cfif getModule.displayTemplate eq 'Thumbnail'>

	<cfoutput query="content"> 
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
			image=content.image, 
			link='/index.cfm/content/#content.contentType#/#evaluate('#linkID#')#', 
			size=getModule.thumbsize, 
			title='#content.title#', 
			subtitle='Posted By: #application.members.getUsername(content.memberID)#<br>Views: #content.views#', 
			showMosaic = 1 )#
	</cfoutput>

<cfelseif getModule.displayTemplate eq 'Title'>
	<cfoutput query="content"> 
	<a href="/index.cfm/content/#content.contentType#/#evaluate('#content.linkID#')#">#title#</a><br />
	<BR>
	</cfoutput>
<cfelse> 
	<cfoutput query="content"> 
	<div>

	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
			image=content.image, 
			link='/index.cfm/content/#content.contentType#/#evaluate('#linkID#')#', 
			size=getModule.thumbsize,
			align=getModule.thumbalign )#
		<div>
		<h3><a href="/index.cfm/content/#content.contentType#/#evaluate('#content.linkID#')#">#title#</a></h3>
	   <span class="small">#subtitle#</span><BR>
</div> 	
	
		
	</div>
<BR style="clear:both">
</cfoutput>
	</cfif>



<div style="height:1px; clear: both"> </div>

<cfoutput>
<div align="right" class="moduleViewAll"><a href="#contenttype.homelink#?categoryid=#getModule.displayCategoryID#&tag=#getmodule.displaytag#&memberid=#getmodule.displaymember#">View All</a></div>
</cfoutput> 