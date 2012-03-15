<cfsetting showdebugoutput="yes">
<cfscript>
today = now();
click = CreateODBCTime (today);
idleTime = DateAdd ("n",-5 ,"#click#");
offlineTime = DateAdd ("n",-10 ,"#click#");
</cfscript>
<!--- Mark as Idle --->
<cfquery datasource="members">
update membersaccount set idle = 1
where idle = 0 and lastClick < #idleTime#
</cfquery>
<!--- Logout idle users --->
<cfquery datasource="members">
update membersaccount set idle = 0, online = 0 
where idle = 1 and lastClick < #offlineTime#
</cfquery>
DONE: #today#
