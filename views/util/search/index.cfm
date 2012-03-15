<cfscript>
content = event.getvalue('sResults');
</cfscript>
<cfoutput>
<div class="mod">
	<div class="hd">
		Search results: #rc.search#
	</div>
    <div class="bd">
		<cfif content.recordcount eq 0>
			No records found matching your search, please try again.
		<cfelse>
			<table width="100%" class="oddEven">
				<cfloop query="content">
					<TR>
						<TD width="60">#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=rc.image, link='##', size=50)#</TD>
						<TD>#title#<br />Posted by: #dateformat(application.timezone.castFromServer(dateEntered, application.community.settings.getValue('timezone')),request.community.dateformat)#</TD>
						<TD>#type#</TD>
					</TR>
				</cfloop>
			</table>
		</cfif>   
	</div>
	<div class="ft"></div>
</div>
</cfoutput>