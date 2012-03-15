<cfparam name='rc.polltype' default=''> <!--- TODO: ticket ##966 - test the polling system, looks like type is not being taken into accounts --->
<cfscript>
	getModule = qGetModules;
	poll=application.poll.getPoll(getModule.displayContentID);
</cfscript>

<cfif application.poll.checkVote(getModule.displayContentID) neq 0 or request.session.login eq 0>
	<cfinclude template="/views/community/poll/results.cfm">
<cfelse>
	<cfinclude template="/views/community/poll/poll.cfm">
</cfif>