<cfscript>
poll=event.getValue('poll');
totalVotes = 0;
for(i=1;i lte poll.recordcount; i=i+1){
	totalvotes = totalvotes + poll.votes[i];
}
</cfscript> 

<cfoutput>
<div class="mod">
 <div class="hd">#poll.Question#</div>

        <div class="bd">

<table width="100%" border="0" cellspacing="5">  
            
<cfloop query="poll">      
	<cfif TotalVotes GT 0><cfset Percent=Round((Votes / TotalVotes) * 100)><cfelse><cfset Percent=0></cfif>
    <tr><td >#Answer#</td></tr>
    <tr><td><img align="middle" src="/images/poll-graph.gif" width="#Percent#%" height="5"></td></tr>
	<tr><td ><b>#Votes# Total votes - #Percent#%</b></td></tr>
</cfloop> 
<tr><td align="right" >Total:&nbsp;#TotalVotes# votes</td></tr>
     
</table>


	</div>
        <div class="ft"></div>
</div>
</cfoutput> 
