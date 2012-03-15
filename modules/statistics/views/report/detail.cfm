<cfscript>
	community = event.getValue('community');
	actions = event.getvalue('actions');
</cfscript>

<cfoutput>
	<Table width="100%">
	<TR>
		<td>#application.form.calendar('start_#rc.type#', dateadd('m',-1,now()),'100px',0)#</td>
		<TD>To</td>
		<TD>#application.form.calendar('end_#rc.type#',now(),'100px',0)#</TD>
		<TD>Group By</td>
		<TD>
			<select name="groupBy" id='groupBy_#rc.type#'>
				<option value='hour'>Hour</option>
				<option value='day' selected>Day</option>
				<option value="month">Month</option>
				<option value="year">Year</option>
			</select>
		</TD>
		<TD>
			<select style="width: 150px;" name="activity" id='activity_#rc.type#'>
				<cfloop query='actions'>
				<option value="#activityType#:#activityAction#">#activityType# - #activityAction#</option>
				</cfloop>
			</select>
		</TD>
		<TD><input type='button' value="Update" id='refresh_#rc.type#'></TD>
	</TR>
	</Table>
	
	<div id="container_#rc.type#" style="width: 100%; height: 400px"></div>
	
	<script>
		var type = '#rc.type#';
		var chart = '';
	    
	    function loadChart(){
	    	var activity = $('##activity_'+type).val();
			var groupBy = $('##groupBy_'+type).val();
			var startDate = $('##start_'+type).val();
			var endDate = $('##end_'+type).val();
			var dataURL = '/index.cfm/statistics:report/data?type='+type+'&communityID=#community.communityID#&activity='+activity+'&groupBy='+groupBy+'&startDate='+startDate+'&endDate='+endDate;
			
			$.getJSON(dataURL, function(data) {
				var statisticsOptions = {
				    chart: {
				        renderTo: 'container_'+type,
				        defaultSeriesType: 'line'
				    },
				    title: {
				        text: ''
				    },
				    xAxis: {
				        categories: []
				    },
				    yAxis: {
				        title: {
				            text: ''
				        }
				    },
				    series: [ ]
				};
				
				statisticsOptions.series = [];
			  	statisticsOptions.series.push(data[1]);

	            statisticsOptions.xAxis.categories = data[0];
	            
				chart = new Highcharts.Chart(statisticsOptions);	  	 
		    });	    		
	    }
	    
	    loadChart();
	    	
	    $('##refresh_'+type).click(function(){
		 	loadChart();
	    });	
	</script>	
</cfoutput>