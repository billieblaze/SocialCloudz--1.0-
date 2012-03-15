<cfcomponent extends="/model/baseService" output="false">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true"  wireit="coldbox:datasource:myDSN" >
		<cfargument name="gateway" default="" type="string" required="false"  wireit="model:listGateway" > 
		<cfargument name="xmlDefinition" default="" type="string" required="false" >
		<cfargument name="validator" default="" type="string" required="false"> 
		<cfargument name="permissions" default="" type="string" required="false">	
	
			<cfset super.init(argumentcollection = arguments)>		
			<Cfset this.utils = createobject('component', '/udf/util').init()>
			<cfset this.grid = createobject('component', 'gridGateway').init(this.datasource, variables.instance.dao)>
			<cfset this.column = createobject('component', 'columnGateway').init(this.datasource,variables.instance.dao)>

		<cfreturn this>
	</cffunction>
	
	<cffunction name="loadGridView">
		<cfargument name="grid">
		<cfargument name="view" default="default">
		<cfargument name="pid" default="">
		<cfargument name="application" default="">
		<cfargument name="isAdmin" default="0">

		<cfscript>
			var colModel = '';
			var getColumns = '';
			var i = 0;
			var thisFormatter = '';
			var thisSearch = '';
					
			arguments.view = URLDECODE(arguments.view);

			getColumns = this.column.get(argumentCollection = arguments);
			if(getColumns.recordcount eq 0 and view eq 'Default'){
				arguments.pid = '';
				getColumns = this.column.get(argumentCollection = arguments);
			}

			for ( i=1; i lte getColumns.recordCount; i=i+1){
				thisSearch = getColumns.searchBit[i];
				if (thisSearch eq 1){
					getColumns.search[i] = 'true'; 
				} else { 
					getColumns.search[i] = 'false';
				}
			
				thisEdit = getColumns.editableBit[i];
				if (thisEdit eq 1){
					getColumns.editable[i] = 'true'; 
				} else { 
					getColumns.editable[i] = 'false';
				}
				thisSort = getColumns.sortableBit[i];
				if (thisSort eq 1){
					getColumns.sortable[i] = 'true'; 
				} else { 
					getColumns.sortable[i] = 'false';
			}					
				if ( arguments.isAdmin eq 1){
					getColumns.hideDlg[i] = 'false';
				}
			}
			colModel = this.utils.QueryToArrayOfStructures(getColumns);
			colModel = this.utils.jsonencode(colModel);
			
			for ( i=1; i lte getColumns.recordCount; i=i+1){
				thisFormatter = getColumns.formatter[i];
				if (thisFormatter neq ''){	
					colModel = replace(colModel, '"#thisFormatter#"', '#thisFormatter#','all' );			
				}
			}

			colModel = replace(colModel , 'summarytype', 'summaryType','all');				
			colModel = replace(colModel , 'summarytpl', 'summaryTpl','all');				
			return colModel;
		</cfscript>
	</cffunction>

	<cffunction name="getViewList">	
		<cfargument name="grid">
		<cfargument name="pid">
		<cfscript>
			var qViews = this.column.list(argumentcollection=arguments);
			return valueList(qViews.viewName);
		</cfscript>
	</cffunction>	
	
	<Cffunction name="saveView">
		<Cfargument name="grid" default="">
		<Cfargument name="view" default="default">
		<Cfargument name="new_view" default="default">
		<cfargument name="cmJSON" default="[]">
		<Cfargument name="pid" required = "true">
		<cfargument name="isAdmin" default="0">
		
		<Cfscript>
		var checkViews = '';
		var colModel = deserializeJSON(arguments.cmJSON);
		var data = structNew();
		var column = '';
		var formatter = '';


		data.gridName = arguments.grid;
		data.viewName = arguments.view;
		if (arguments.new_view neq '' and arguments.new_view neq 'default'){
			data.viewName = arguments.new_view;
		}
		
		data.pid = arguments.pid; 
		data.colOrder = 0;

		if (data.gridName NEQ '' and arrayLen(colModel) GT 0){

			for( i = 1; i lte arrayLen(colModel); i=i+1){
              	data.name = colModel[i].name;
               	if ( structKeyExists(colModel[i], 'label')){
               		data.label = colModel[i].label;
               	} else { 
               		data.label = data.name;
               	}
				data.width = colModel[i].width;
 				if ( structKeyExists(colModel[i],'formatter') and colModel[i].formatter neq '' ) {
 					// get the existing formatter from the default 
	                data.formatter = colModel[i].formatter;
	            }
            	// JQGrid is not passing back formatters, so go look them up from the default
				if (data.pid neq ''){
   		            column = this.column.get(grid = data.gridName, view = 'default', field = data.name,pid='');
   		            data.formatter = column.formatter;
	            }

                if(colModel[i].hidden){
                    data.hidden = 1;
                } else {
                    data.hidden = 0;
                }
				if ( isdefined('colModel[i].classes'))		data.classes = colModel[i].classes;
				if ( isdefined('colModel[i].align')) 		data.align = colModel[i].align;
				if ( isdefined('colModel[i].summaryType'))	data.summaryType = colModel[i].summaryType;
				if ( isdefined('colModel[i].summaryTpl'))	data.summaryTpl = colModel[i].summaryTpl;
				if ( isdefined('colModel[i].editType'))		data.editType = colModel[i].editType;
				if ( isdefined('colModel[i].editOptions'))	data.editOptions = colModel[i].editOptions;

				if(colModel[i].search){
                    data.search = 1;
                } else {
                    data.search = 0;
                }
                
                if(isdefined ('colModel[i].editable') and colModel[i].editable){
                    data.editable = 1;
                } else {
                    data.editable = 0;
                }
                
                if(isdefined ('colModel[i].sortable') and colModel[i].sortable){
                    data.sortable = 1;
                } else {
                    data.sortable = 0;
                }
				if(data.name neq 'subgrid'){                
	                column = this.column.get(grid=arguments.grid, view=arguments.view, pid=arguments.pid, field=data.name);
        			if(column.recordcount gt 0){
        				data.id = column.id;
        				this.column.update(data);
        			} else {         	
     	           		this.column.save(data);
    	           	}
                }
      
           		data.colOrder = data.colOrder + 1;
			}
		}
		</cfscript>
	</cffunction>
</cfcomponent>