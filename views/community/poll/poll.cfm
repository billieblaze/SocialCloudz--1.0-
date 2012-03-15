<cfoutput>
#poll.question#

<cfif poll.recordcount gt 0>

<form action="/index.cfm/community/poll/vote" method="post">

	<input type="hidden" name="QuestionID" value="#getmodule.displayContentID#">
<table width="100%" border="0">

    <cfloop query="Poll">
	<tr><td ><input type="radio" name="AnswerID" value="#AnswerID#">&nbsp;&nbsp;#Answer#</td></tr>
	</cfloop>
    <tr><td align="center"><input  type="submit" value="Cast Your Vote" class="button"></td></tr>

</table></form>
</cfif>
<cfif request.session.accesslevel gte 10>
<div align="right"><a href="/index.cfm/community/poll/admin">Admin Poll</a></div>
</cfif>
</cfoutput>

