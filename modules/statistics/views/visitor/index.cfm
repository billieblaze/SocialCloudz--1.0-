<cfoutput><div class="mod">
	<div class="hd">Visitors</div>
	<div class="bd">	
		<cfmodule template="/common/dynamicGrid/jqGrid4.cfm" 
							<!--- Setup --->
							caption = ''  <!--- Optional: turns off header bar if blank --->
							gridName = 'stats_visitors'  <!--- Name for this grid / layout..    multiple grids can use the same grid name with different methods or arguments to reuse that gridnames layout / settings --->
							objectName = ''	  <!--- Defaults to grid name.. used for friendly words like "Add Patent", "Delete Proposal" --->
							rows="10"
							
							method = 'application.statistics.visitor.get' 
							arguments = 'timePart=#event.getValue('timePart', 'd')#&timeSpan=#event.getValue('timeSpan', 1)#' 
							defaultSortField = 'visitorID' 							
							defaultSort = 'desc'
							<!--- Turn on / off Features --->
							
							showView = 1
							viewURL = 'index.cfm?event=statistics:visitor.detail&visitorid='	
							

							<!--- pass these in from your application --->
							pid='#session.PID#'
							datasource="config"
							applicationName="statistics"
							isAdmin='1' <!--- Session variable for admin users (ie, session.admin.global)--->
			> 

	</div>
	<div class="ft"></div>
</div></cfoutput>