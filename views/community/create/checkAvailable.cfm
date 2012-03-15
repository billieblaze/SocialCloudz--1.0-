<Cfsetting showdebugoutput="false">
<cfscript>
	community=application.community.gateway.get(subdomain=rc.url, domainId = request.community.domain.id);
	if (community.recordcount eq 0){
	writeoutput('<img src="#application.cdn.fam#accept.png" alt="Available"> Available');abort;
	} else { 
	writeoutput('<img src="#application.cdn.fam#action_stop.gif" alt="Not Available"> Not Available');abort;
	}
</cfscript>