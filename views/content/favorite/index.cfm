<Cfscript>
	content = event.getvalue('favorites');
</Cfscript>
<Cfquery dbType = 'query' name="contentTypes">
	select distinct contentType from content
</Cfquery>
		
<div class="mod">
	<div class="hd">My Favorites</div>
	<div class="bd">
		<form action="/index.cfm/content/favorite/index" method="post">
		Type: 
		<select name="ContentType">
			<option value="">All</option>
			<cfoutput query="contentTypes">
			<option value="#contentType#" <cfif event.getValue('contentType') eq contentType>selected</cfif>>#contentType#</option>			
			</cfoutput>
		</select>
		<input type="submit" value="Go">
		</form>
<BR>
		<table width="100%">
		<cfoutput query="content">
			<TR class="<cfif content.currentrow mod 2>even<cfelse>odd</cfif>">
				<TD width="60" align="center">
						#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
			image=content.image, 
			link='#content.link##/#evaluate('#content.linkID#')#', 
			size=50 )#

					<BR>#contentType#</TD>
				<TD>
					<A href="#content.link##evaluate(content.linkID)#">#title#</A><br />
					Posted by: #application.members.getusername(memberID)# on #dateformat(dateCreated,request.community.dateformat)#
				</TD>
				<TD>
			        <a href="#event.buildLink(linkTo='content.favorite.remove',queryString='contentID=#content.contentID#')#" class="small">Remove from favorites</A>
				</TD>
			</TR>
		</cfoutput>
		</table>   
	</div>
	<div class="ft"></div>
</div>