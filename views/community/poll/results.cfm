<cfscript>

totalVotes = 0;
for(i=1;i lte poll.recordcount; i=i+1){
	totalvotes = totalvotes + poll.votes[i];
}
</cfscript> 

<cfoutput>
<table width="100%" border="0" cellspacing="5">  
<tr><td align="center" ><b><font size="3+">Thanks For Voting.</font></b><br>
</td></tr> 
<tr><td  ><b>#poll.Question#</b></td></tr>
            
<cfloop query="poll">      
	<cfif TotalVotes GT 0><cfset Percent=Round((Votes / TotalVotes) * 100)><cfelse><cfset Percent=0></cfif>
    <tr><td >#Answer#</td></tr>
    <tr><td><div style="background-color:blue; height:5px; width:#Percent#%"/></td></tr>
	<tr><td ><b>#Votes# Total votes - #Percent#%</b></td></tr>
</cfloop> 
<tr><td align="right" >Total:&nbsp;#TotalVotes# votes</td></tr>
     
</table>
<cfif request.session.accesslevel gte 10>
<div align="right"><a href="#event.buildLink('commnuity.poll.admin')#">Admin Poll</a></div>
</cfif>
</cfoutput>