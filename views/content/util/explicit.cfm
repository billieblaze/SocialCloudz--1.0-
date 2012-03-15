<cfoutput>
<div class="mod">
<div class="hd">Warning</div>
<div class="bd">
This entry may contain <b>explicit language</b> and <b>content</b> that is inappropriate for some users.<br /><br />
By clicking <b>"Confirm"</b> you are agreeing that you understand what you are about to see is not suitable for everyone. 
You will have to "Confirm" Explicit Language and Content Warning at <b>every</b> log in.<br /><br />

<cfif request.session.login eq 1>
<div align="center">
<input type="button" class="button" value="Confirm" onclick="location.href='index.cfm?#cgi.QUERY_STRING#&confirm=1';" /> <input type="button"  class="button" value="Cancel" onclick="history.back();"/></div>
</div>
<cfelse>
<B>You must be logged in to see this entry.</B><br />
<br />

<div align="center">
<input type="button"  class="button" value="Back" onclick="history.back();"/></div>
</div>

</cfif>
<div class="ft"></div>
</div>
</cfoutput>