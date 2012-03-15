<cfscript>
	thisSection = event.getvalue('thissection');
	topic = event.getvalue('topic');
</cfscript>
<cfoutput>
	<div class="mod">
		<div class="hd">
			<div style="float:left">#thissection.title#</div>
			<div align="right">
				<cfif request.session.accesslevel eq 100>
					<a href="#event.buildLink(linkTo='app.help.form',queryString='ID=#rc.id#')#">Edit</a>
				<cfelse>
					&nbsp;
				</cfif>
			</div>
		</div>
		<div class="bd">
			<div align="right">
				<a href="#event.buildLink(linkTo='app.help.topics',queryString='sectionID=#thissection.id#')#"><< Back to #thissection.title#</a>
			</div>
			<h3>#topic.title#</h3>
			<span class="xsmall">Posted on #dateformat(topic.dateCreated, request.community.dateformat)#</span>
			<BR><BR>
			#topic.description#
		</div>
		<div class="ft"></div>
	</div>
</cfoutput>