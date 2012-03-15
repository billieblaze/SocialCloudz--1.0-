	<cfmodule template="/common/dynamicGrid/jqGrid4.cfm" 
							<!--- Setup --->
							caption = ''  <!--- Optional: turns off header bar if blank --->
							gridName = 'stats_activity'  <!--- Name for this grid / layout..    multiple grids can use the same grid name with different methods or arguments to reuse that gridnames layout / settings --->
							objectName = ''	  <!--- Defaults to grid name.. used for friendly words like "Add Patent", "Delete Proposal" --->
							rows="10"
							
							method = 'application.statistics.activity.get' 
							arguments = 'visitor=#rc.visitorID#' 
							defaultSort = 'visitorID' 							
		
							<!--- Turn on / off Features --->
							
							showView = 0

							<!--- pass these in from your application --->
							pid='#session.PID#'
							datasource="config"
							applicationName="stats"
							isAdmin='1' <!--- Session variable for admin users (ie, session.admin.global)--->
			> 
