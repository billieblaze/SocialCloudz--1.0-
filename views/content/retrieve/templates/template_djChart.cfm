<cfoutput>
<cfset 	q_content = rc.contentModuleData.query>
<h1>#q_content.title#</h1>
				<br /><BR />

			<table width="100%" cellspacing="0" cellpadding="3">
			<TR >
				<td class="pad3"><b>Artist</b></td>
				<td class="pad3"><b>Title</b></td>
				<td class="pad3"><b>Label</b></td>


			</tr>
			<cfloop from="1" to="10" index="i">
			<TR <cfif i mod 2> class="odd"<cfelse>class="even"</cfif>>
				<TD class="pad3">#application.content.getAttribute(q_content.attribs, 'artist_#i#')#</td>
				<TD class="pad3">#application.content.getAttribute(q_content.attribs, 'title_#i#')#</td>
				<TD class="pad3">#application.content.getAttribute(q_content.attribs, 'label_#i#')#</td>
			</tr>
			</cfloop>
			</table>

</cfoutput>