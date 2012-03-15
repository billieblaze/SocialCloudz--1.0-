<cfoutput><tr></cfoutput>
<cfoutput><th width="200">#REQUEST.formItems[ id ].title#</th></cfoutput>
<cfoutput><td><a href="#Trim( REQUEST.submissionData[ id ] )#" class="external" target="_blank">#REQUEST.submissionData[ id ]#</a></td></cfoutput>
<cfoutput></tr></cfoutput>
