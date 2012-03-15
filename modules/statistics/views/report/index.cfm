<cfsetting showdebugoutput="no">
<cfscript>
	community = event.getValue('community');
	contentTypes = application.content.type.get();
</cfscript>
<cfquery name="q_get" datasource="contentStore">
	call contentstore.countContent(#rc.communityID#);
</cfquery>

<cfoutput>
	<script>
		var chart1; // globally available
		$(document).ready(function() {
	      chart1 = new Highcharts.Chart({
	         chart: {
	            renderTo: 'container',
	            type: 'bar',
       			zoomType: 'y'
	         },
	         title: { text: 'Todays Summary'},
	         xAxis: {
	            categories: ['Total Members', 'Online Members' <cfloop query="contentTypes"><cfif evaluate('q_get.#contentTypes.contentType#') neq 0>,'#contentTypes.description#'</cfif></cfloop>]
	         },
	         yAxis: {
	            title: {  text: '' }
	         },
	         plotOptions: {
		        series: {
		            minPointLength: 3
		        }
		     },
	         series: [{
	            name: 'Count',
	            data: [#application.members.gateway.getCount()#, #application.members.gateway.getCount(online=1)#<cfloop query="contentTypes"><cfif evaluate('q_get.#contentTypes.contentType#') neq 0>,#evaluate('q_get.#contentTypes.contentType#')#</cfif></cfloop>]
	         }]
	      });
	   });
	</script>
	<div id="container" style="width: 100%; height: 400px"></div>
</cfoutput>