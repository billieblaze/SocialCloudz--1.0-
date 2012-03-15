<cfcomponent extends="/model/baseGateway" output="false">
	<cffunction name="get">
		<cfargument name="grid">
		<cfargument name="view">
		<cfargument name="pid">
		<cfargument name="field">
		
		<cfset var qColumns = ''>
		<cfquery name="qColumns" datasource="#this.datasource#">
			SELECT id, name, label, width, formatter, colOrder,summaryType, summaryTpl,
			ifNull(sortable,1) as sortableBit,
			'' as sortable,
			ifNull(editable, 0) as editableBit,
			'' as editable,
			editType,
			editOptions,
			ifNull(search,'false') as searchBit,
			'' as search,
			ifNull(align, 'left') as align, 
			ifNull(classes, 'copy') AS classes,
		    CASE `key`
				WHEN 0 THEN 'false' 
				WHEN 1 THEN 'true' 
				ELSE 'false' 
				END AS `key`,
		    CASE hidden 
				WHEN 0 THEN 'false' 
				WHEN 1 THEN 'true' 
				ELSE 'false' 
				END AS hidden,
			CASE hideDlg 
				WHEN 0 THEN 'false' 
				WHEN 1 THEN 'true' 
				ELSE 'false' 
				END AS hideDlg

		    FROM dynamicGridColumns
		    WHERE gridName = '#grid#' 
		    AND viewName = '#view#' 
		    
		    <cfif isdefined('arguments.field')>
		    	and name = '#arguments.field#'
		    </cfif>
		    
		    <cfif isDefined('arguments.pid')>
		    	AND (PID <cfif arguments.pid eq ''>
			    			is Null or pid = ''
			    		 <cfelse>
			    		 	='#arguments.PID#'
						</cfif>
					)
		    </cfif>
		    
		    ORDER BY colOrder ASC
		</cfquery>
		<cfreturn qColumns>
	</cffunction>
	
	<cffunction name="list">
		<cfargument name="grid">
		<cfargument name="view">
		<cfargument name="pid">	
		<cfset var qViews =''>
		<cfquery name="qViews" datasource="#this.datasource#">
			SELECT DISTINCT viewName
		    FROM dynamicGridColumns 
		    WHERE (gridName = '#arguments.grid#'  and viewName = 'default' and (pid is null or pid = '') )
	
				or (gridName = '#arguments.grid#' 
					<cfif isdefined('arguments.view')>
						and viewName = '#arguments.view#')
					</cfif>
					
					<cfif isdefined('arguments.pid')>	
					    AND (PID <cfif arguments.pid eq ''>
							    	is Null
							    	or pid = ''
						    	<cfelse>
						    		='#arguments.PID#'
								</cfif>
							)
					</cfif>
				)
			
		</cfquery>
		
		<cfreturn qViews>
	</cffunction>
	
	<cffunction name="save">
		<cfargument name="datastruct">
		<Cfparam name="arguments.datastruct.formatter" default="">
		<Cfparam name="arguments.datastruct.key" default="false">
		<Cfparam name="arguments.datastruct.classes" default="">
		<Cfparam name="arguments.datastruct.hidedlg" default="false">
		<Cfparam name="arguments.datastruct.align" default="left">
		<Cfparam name="arguments.datastruct.search" default="0">
		<Cfparam name="arguments.datastruct.summaryType" default="">
		<Cfparam name="arguments.datastruct.summaryTpl" default="">
		<Cfparam name="arguments.datastruct.editable" default="">
		<Cfparam name="arguments.datastruct.editType" default="">
		<Cfparam name="arguments.datastruct.editOptions" default="">
		<Cfparam name="arguments.datastruct.sortable" default="0">						
		
		<Cfquery datasource='#this.datasource#'>
		INSERT INTO dynamicGridColumns
           (
			gridName
           ,name
           ,hidden
           ,viewName
           ,colOrder
           ,width
           ,PID
           ,label
           ,formatter
			,`key`
			,classes
			,align
			,hidedlg
			
			,search
			,summaryType
			,summaryTpl
			,editable
			,editType
			,editOptions
			,sortable
			)
    		 VALUES
           ('#arguments.datastruct.gridName#',
			'#arguments.datastruct.name#',
			#arguments.datastruct.hidden#,
			'#arguments.datastruct.viewName#',
			'#arguments.datastruct.colOrder#',
			'#arguments.datastruct.width#',
			<Cfif arguments.datastruct.pid eq ''>NULL<cfelse>'#arguments.datastruct.pid#'</cfif>,
			'#arguments.datastruct.label#',
			'#arguments.datastruct.formatter#',
			#arguments.datastruct.key#,
			'#arguments.datastruct.classes#',
			'#arguments.datastruct.align#',
			#arguments.datastruct.hidedlg#,
			#arguments.datastruct.search#,
			'#arguments.datastruct.summaryType#',
			'#arguments.datastruct.summaryTpl#',
			#arguments.datastruct.editable#,
			'#arguments.datastruct.editType#',
			'#arguments.datastruct.editOptions#',
			#arguments.datastruct.sortable#
			)
		</cfquery>		
	</cffunction>
	
	<cffunction name="update">
		<cfargument name="datastruct">
		<cfreturn super.save('dynamicGridColumns', arguments.datastruct)>
	</cffunction>
	<cffunction name="delete">
		<cfargument name="gridName">
		<cfargument name="viewName">
		<cfargument name="pid">	
		<cfargument name="name">
		
		<cfquery datasource="#this.datasource#">
            DELETE
            FROM dynamicGridColumns 
            WHERE gridName = '#arguments.gridName#'
			
            <cfif isDefined('arguments.viewname')>
				AND viewName = '#arguments.viewName#' 
			</cfif>

            <cfif isDefined('arguments.name')>
				AND name = '#arguments.name#'
			</cfif>

            <cfif isDefined('arguments.pid')>
				AND PID = '#arguments.PID#'
			</cfif>
     	</cfquery>

	</cffunction>

</cfcomponent>