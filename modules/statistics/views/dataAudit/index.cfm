<cfmodule template="/common/dynamicGrid/jqGrid4.cfm" 
							<!--- Setup --->
							caption = '' 
							gridName = 'stats_dataaudit' 
							objectName = ''	 
							rows="10"
							
							method = 'application.statistics.audit.get' 
							arguments = 'visitor=#rc.visitorID#' 
							defaultSort = 'dateEntered' 							
		
							pid='#session.PID#'
							datasource="config"
							applicationName="stats"
							isAdmin='1' 
			> 
