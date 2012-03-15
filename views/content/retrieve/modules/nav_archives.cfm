<cfscript>
archive = application.content.gateway.getArchives(contentType=rc.contentType, communityId = request.community.communityID);		
</cfscript>


<div id="accordion" style="background-color:transparent;">
	<cfoutput query='archive' group='myyear'>
	<h3 class="blackText"><a href="##">#myYear#</a></h3>
	<div><cfquery dbtype='query' name='getMonth'>
		select mymonth, mycount from archive where myyear = #archive.myyear#
		</cfquery>
            <cfloop query='getMonth'>
            <A class="blackText" href='/index.cfm/content/#rc.contentType#?daterangestart=#dateformat(createdate(myyear,mymonth,1), 'yyyy-mm-dd')#&daterangeend=#dateformat(createdate(myyear,mymonth,daysinmonth('#mymonth#/1/#myyear#')),'yyyy-mm-dd')#'>#monthasstring(mymonth)#</a> (#mycount#)<BR>
            </cfloop>
	</div>
    </cfoutput> 
</div>
 
<script type="text/javascript">
	$(function() {
		$("#accordion").accordion({active: false, collapsible: true});
	});
</script>