<!--- Setup --->
<Cfparam name='attributes.application' default="">
<cfparam name="attributes.datasource" default="config">
<Cfparam name="attributes.pid" default="">
<Cfparam name="attributes.isAdmin" default="0">
<cfparam name="attributes.autoLoad" default="1">

<Cfparam name="attributes.caption" default="">
<Cfparam name='attributes.gridName' default="datatable_#round(randRange(0,1000))#">
<Cfparam name='attributes.defaultView' default="default">
<Cfparam name="attributes.objectName" default="#attributes.gridName#">
<Cfparam name="attributes.width" default="">
<cfparam name="attributes.height" default="auto">
<cfparam name="attributes.paging" default="default">
<cfparam name="attributes.defaultSortField" default="">
<cfparam name="attributes.defaultSort" default="asc">
<!--- Data --->
	<!--- JSON Data URLS --->
	<Cfparam name="attributes.dataURL" default="">
	
	<!--- OR DYNAMIC DATA PROVIDER--->
	<cfparam name="attributes.method" default="">
	<cfparam name="attributes.arguments" default="">
	
	<!--- IF its a new grid dynamic data grid, setup the colmodel --->
	<cfif not isdefined('attributes.dataURL') or attributes.dataURL eq ''>
		
		<cfinclude template="model/saveGrid.cfm">
		
		<cfset attributes.dataURL = '/index.cfm/util/dynamicGrid/index?method=#attributes.method#&#attributes.arguments#'>
	</cfif>


<Cfparam name='attributes.subGridName' default="datatable_subgrid_#round(randRange(0,1000))#">
<cfparam name="attributes.subgridCaption" default="">

<!--- Again, standard url or dynamic --->
	<Cfparam name="attributes.subGridDataURL" default="">

	<!--- OR DYNAMIC DATA PROVIDER--->
	<cfparam name="attributes.subgridMethod" default="">
	<cfparam name="attributes.subgridArguments" default="">
	<cfparam name="attributes.subgridKey" default="">
	<cfparam name="attributes.subgridValue" default="#attributes.subgridKey#">
	<cfif attributes.subGridDataURL eq '' and attributes.subGridMethod neq ''>
		<Cfset subGridData = application.dynamicGrid.grid.get(gridName = attributes.subGridName)>
		<cfif subGridData.recordCount eq 0>
			<cfinclude template="model/saveSubGrid.cfm">
		</cfif>
		<cfset attributes.subGridDataURL = '/index.cfm/util/dynamicGrid/index?method=#attributes.subGridMethod#&#attributes.subGridArguments#'>
	</cfif>


<!--- Pagination / sorting --->
<cfparam name="attributes.rows" default="10">
<cfparam name="attributes.sortName" default="">
<cfparam name="attributes.sortOrder" default="">

<!--- callback functions --->
<cfparam name="attributes.loadComplete" default="">

<!--- Detail URL --->
<Cfparam name="attributes.addURL" default="">
<cfparam name="attributes.editURL" default="">
<cfparam name="attributes.viewURL" default="">
<Cfparam name="attributes.deleteURL" default="">
<cfparam name="attributes.exportURL" default="">

<!--- Enable / disable links --->
<Cfparam name="attributes.showAdd" default="0">
<cfparam name="attributes.showEdit" default="0">
<Cfparam name="attributes.showView" default="0">
<Cfparam name="attributes.showDelete" default="0">
<cfparam name="attributes.showViewAll" default="0">
<cfparam name="attributes.showPrint" default="0">
<cfparam name="attributes.showExcel" default="0">
<cfparam name="attributes.showExcelNonJQGrid" default="0">
<cfparam name="attributes.showCustom" default="0">
<cfparam name="attributes.showHelp" default="0">
<cfparam name="attributes.showSearch" default="0">
<cfparam name="attributes.showHeaderNav" default="1">
<cfparam name="attributes.hiddenGrid" default="0">

<cfparam name="attributes.showGrouping" default="0">
<cfparam name="attribtues.groupBy" default="">
<cfparam name="attribtues.showGroupSummary" default="1">
<cfparam name="attribtues.groupCollapse" default="1">
<Cfparam name="Attributes.editableCells" default="0">
<Cfparam name="Attributes.editCellURL" default="">

<cfif attributes.isAdmin eq 1>
	<Cfset attributes.showCustom = 1>
</cfif>

<cfparam name="attributes.showFooter" default="0">

<cfset attributes.showSubgrid = 'false'>
<Cfif attributes.subGridDataURL neq ''>
	<cfset attributes.showSubgrid = 'true'>
</cfif>
<!--->
<Style type="text/css">
	.ui-multiselect li a.actionEdit { position: absolute; right: 20px; top: 2px; }
</style>--->
<cfoutput>
	<div id="#attributes.gridName#_container" >
		<table id="#attributes.gridName#"></table>
	    <div id="pager_#attributes.gridName#" style="text-align:right;"></div> <br>
	</div>
	
	<span id="#attributes.gridName#_error"></span>
	
	<cfif attributes.showExcel eq 1>
		<form action="/common/dynamicGrid/toExcel.cfm" method="post" id="#attributes.gridName#_excelExporter" name="#attributes.gridName#_excelExporter">
			<input type="hidden" name="excelContent" id="#attributes.gridName#_excelContent" value="#attributes.gridName#">
			<input type="hidden" name="gridName" id="#attributes.gridName#_gridName" value="#attributes.gridName#">
		</form> 
	</cfif>
	<script type="text/javascript">
		var grid = '#attributes.gridName#';
		var subgridName = '#attributes.subgridName#';
		var cmJSON = [];
		var view = '#attributes.defaultView#';
		var dataURL = '#attributes.dataURL#';
		var pid = '#attributes.pid#';
		var datasource = '#attributes.datasource#';
		var isAdmin = '#attributes.isAdmin#';
		var lastsel;
		var exportExcel = 0;
		var doPrint = 0;
		
		var data = '';
			function startGrid(){
				loadGrid(grid, '#attributes.gridName#', view, dataURL, #attributes.showSubGrid#, "##pager_#attributes.gridName#", true);
			}
	
		<Cfif attributes.autoLoad eq 1>
			$(document).ready(function(){
				startGrid();
			});
		</cfif>
		
		function unloadGrid(){
			$('###attributes.gridName#').jqGrid('GridUnload');
		}
		
		function loadGrid(gridID, gridName, view, dataURL, subGrid, pager, topPager){
				
			$.get('/common/dynamicGrid/model/getColModel.cfm?datasource=#attributes.datasource#&application=#attributes.application#&pid=#attributes.pid#&isAdmin=#attributes.isAdmin#&grid='+gridID+'&view=' + view+'&r='+Math.random(),function(data){
				colModel =  data;
				initGrid(gridName, colModel, dataURL, subGrid, pager, topPager);
				<cfif attributes.showSubGrid eq false>
					initButtons(gridName, pager, subGrid);
				<cfelse>
					if (subGrid == true){
						initButtons(gridName, pager, subGrid);
					}
				</cfif>
			});
		}
		
		function initGrid(gridName, colModel, dataURL, showSubGrid, pager, topPager){
				// Load the datagrid into our div
				<cfif attributes.showSubGrid eq true>
				if (showSubGrid == true){
					caption = '#attributes.caption#';
				} else {
					caption = '#attributes.subGridCaption#';
				}
				<Cfelse>
					caption = '#attributes.caption#';
				</cfif>
				
				$("##"+gridName).jqGrid({
					// Sizing
					height: '#attributes.height#',
					<cfif attributes.width does not contain '%' and attributes.width neq ''>
						width: '#attributes.width#',
					<cfelseif attributes.width eq ''>
						autowidth: true,
					</cfif>
					
					<cfif attributes.hiddenGrid eq 1>
					hiddengrid: true,
					</cfif>
					
					// Data
					mtype: 'POST',
					url: dataURL,
					datatype: 'json',
					colModel : eval(colModel),
					<cfif attributes.arguments neq ''>
					postData: 
					{ 		<cfloop list="#attributes.arguments#" index="i" delimiters = '&'>
								#listFirst(i,'=')# : <cfif listLast(i,'=') eq listFirst(i,'=')> '' <cfelse>'#listLast(i,'=')#'</cfif>,
							</cfloop>						
							foo: 'bar'
					},
					</cfif>
					// Setup pagination
					rowNum:#attributes.rows#,
					pager: jQuery(pager),			

					pgbuttons: true,
					
					<cfif attributes.paging eq 'default'>
						toppager: topPager,
						rowList:[10,15,20,50,100,500,1000],
						viewrecords: true,	
						pagerpos: "right",
					    recordpos: "center",
						pagerpos: "right",
					    recordpos: "center",
					<cfelseif attributes.paging eq 'none'>
						viewrecords: false,
						pgbuttons:false,
						pginput: false,
						scroll: true,
					<cfelse>
						pagerpos: "right",
						viewrecords: false,
					</cfif>
					<cfif attributes.showGrouping eq 1>
					shrinkToFit: true,
						//sortname: '#attributes.groupBy#',
						grouping:true, 
						groupingView : { 
							groupField : ['#attributes.groupBy#'],
							
							<cfif attributes.showGroupSummary eq 1>
								groupSummary : [true], 
							<cfelse>
								groupSummary : [false], 
							</cfif>
							
							groupColumnShow : [false], 
							groupText : ['<b>{0}</b>'], 
							
							<cfif attributes.groupCollapse eq 1>
								groupCollapse : true, 
							<cfelse>
								groupCollapse : false, 
							</cfif>
							
							groupOrder: ['asc'] 
						 },
					</cfif>
					<cfif Attributes.editableCells eq 1>
						editurl: '#attributes.editCellURL#',
						onSelectRow: function(id){
						
							if(id && id!==lastsel){ 
								$("##"+gridName).jqGrid('restoreRow',lastsel); 
								$("##"+gridName).jqGrid('editRow',id,true); 
								lastsel=id; 
							} 
						},
					</cfif>
					viewsortcols:[true,'vertical',true],
									    
					// Labels & text
					caption: caption,
					recordtext: "Viewing {0} - {1} of {2} Records",
					emptyrecords: "No records found",
					loadtext: "Loading...",
					pgtext: "Page {0} of {1}",
		
					// sort
					sortable: true,

					sortname: "#attributes.defaultSortField#",
					sortorder: "#attributes.defaultSort#",
				  
					jsonReader: {
							root: "rows",
							page: "page",
							total: "total",
							records:"records",
							cell: "",
							userdata: "userdata",
							id: "0",
							repeatitems: false
					},
					
					<cfif attributes.showSubGrid eq true>
						subGrid : showSubGrid, 
						subGridRowExpanded: function(subgrid_id, row_id) { 
							// we pass two parameters 
							// subgrid_id is a id of the div tag created whitin a table data 
							// the id of this elemenet is a combination of the "sg_" + id of the row
							// the row_id is the id of the row 
							// If we wan to pass additinal parameters to the url we can use 
							// a method getRowData(row_id) - which returns associative array in type name-value 
							// here we can easy construct the flowing 
											 
							var subgrid_table_id = "#attributes.gridName#_subgrid_"+row_id; 
							var pager_id = "#attributes.gridName#_subgridPager_"+row_id; 
							 
							$("##"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div><span id='"+subgrid_table_id+"_error'></span>"); 
							var rowData = $('###attributes.gridName#').jqGrid('getCell',row_id, '#ucase(attributes.subgridValue)#');
							loadGrid(subgridName, subgrid_table_id, 'default', '#attributes.subGridDataURL#&#attributes.subGridKey#='+ rowData, false, '##'+pager_id, false);
							
						},
						subGridRowColapsed: function(subgrid_id, row_id) { 
							var subgrid_table_id = "#attributes.gridName#_subgrid_"+row_id; 
							jQuery("##"+subgrid_table_id).remove(); 
						},
					</cfif>
					
					<!--- Footer tallying - info is passed in thru json - see jqGrid docs --->
					<cfif attributes.showFooter eq 1>
						footerrow : true, 
						userDataOnFooter : true, 
					</cfif>

					// Grid Events 
					<cfif attributes.showView eq 1>				
					ondblClickRow: function () {
							var rowKey = jQuery("##" + gridName).getGridParam("selrow"); // returns null if no row is selected
							popWinDetail('#attributes.viewURL#' + rowKey, gridName);
					},
					</cfif>
					gridComplete:function(){
						
					},
					loadComplete:function(){
						// Perform table striping
						$('tr.ui-widget-content:odd').css('background','##E5E5E5');
						$('tr.ui-widget-content:even').css('background','##F5F5F5');
						
						<Cfif attributes.showHeaderNav eq 1>
							var recordCount = $("##"+gridName).jqGrid('getGridParam',"records");
							if (recordCount == 0){
								$('##'+gridName+'_toppager').hide();
								$('##gview_'+gridName+' .ui-jqgrid-hdiv').hide();
								$('##pager_'+gridName+'_center .ui-paging-info').css('font-weight', 'bold');
							}						
						</cfif>
				
						
						
						<cfif attributes.loadComplete neq ''>#attributes.loadComplete#();</cfif>
						
						if (exportExcel == 1){
							// Parent container of the "list" DIV (In my case, I have a DIV including all elements of a jqGrid table)
						
							var idMasterDiv = $('##'+gridName).parent().parent().attr('id');
				
							// Find jqGrid table to print
							$('div[id^="jqgh"]').each ( function() {
							    var idParentDiv = $(this).parent().parent().parent().parent().parent().parent().attr('id');
							   
							    if (idParentDiv == idMasterDiv) {
							        objectEntity = $(this).parent().parent().parent(); //  THEAD of the header row (title of the fields)
							    }
							});
							
							// Create a hidden div which will contain the data to be printed
							excelContent = '<table>';
							excelContent = excelContent + objectEntity.html();
							excelContent = excelContent + $('###attributes.gridName# tbody:first').html();
							excelContent = excelContent + '</table>';
							
							$('##'+gridName+'_excelContent').val(excelContent);
							$('##'+gridName+'_excelExporter').trigger('submit');
							exportExcel = 0;
						}
						
						if (doPrint == 1){
								
							// Parent container of the "list" DIV (In my case, I have a DIV including all elements of a jqGrid table)
							var idMasterDiv = $('##'+gridName).parent().parent().attr('id');
				
							// Find jqGrid table to print
							$('div[id^="jqgh"]').each ( function() {
							    var idParentDiv = $(this).parent().parent().parent().parent().parent().parent().attr('id');
							   
							    if (idParentDiv == idMasterDiv) {
							        objectEntity = $(this).parent().parent().parent(); //  THEAD of the header row (title of the fields)
							    }
							});
							
							// Create a hidden div which will contain the data to be printed
							$('<div>').attr('id', 'printDiv').css('display', 'none').appendTo('body');
							
							// Add css to custom the printed document
							$('<link rel="stylesheet" href="/common/print.css" media="all" type="text/css"/>').appendTo('##printDiv');
							$('<table>').attr('id', 't_printDiv').appendTo('##printDiv');
							
							// Clone jqGrid table header
							//$('<caption>'+titrePage+'</caption>').appendTo('##t_printDiv');
							objectEntity.clone().appendTo('##t_printDiv');
							
							// Clone jqGrid data
							$('###attributes.gridName# tbody:first').clone().appendTo('##t_printDiv');
							$('</table>').appendTo('##printDiv');
							
							// Open a new window
							var WindowObject = window.open('', "TrackHistoryData","width=900,height=400,top=200,left=150,toolbars=yes,scrollbars=yes,status=no,resizable=no");
				
							// Send the DIV to be printed in the window
							
							WindowObject.document.writeln($('##printDiv').html());
							
							// Clean the current document
							$('##printDiv').remove();
							WindowObject.document.close();
				
							// Print the table
							WindowObject.focus();
							WindowObject.print();
							WindowObject.close();
							
							doPrint = 0;
							
						}
					},
					loadError : function(xhr,st,err) {
						jQuery("##"+gridName+"_error").html("Type: "+st+"<br> Response: "+ xhr.status + " -- "+xhr.statusText+"<br>Error: "+err+"<br>");
					}
				}).navGrid(pager,
					{	 refresh: true, 
						 add: false, 
						 edit: false, 
						 del: false, 
						 search: false, 
						 view:false
					 },
					{width:'400',closeOnEscape:true},
					{width:'400',closeOnEscape:true},
					{width:'400',closeOnEscape:true},
					{width:'400',closeOnEscape:true,multipleSearch:true},
					{width:'400',closeOnEscape:true}		
				);
			}
			
		function initButtons(gridName, pager, hasSubGrid){
				<cfif attributes.showAdd eq 1>			
					$('##'+gridName).jqGrid('navButtonAdd',pager,{
						caption:"",
						buttonicon:"ui-icon-plus",
						id: gridName  +'_add',

						position: "last",
						title:"Add #attributes.objectName#",
						cursor: "pointer"});
						
					$('##'+gridName+'_add').modalAjax({
						title: 'Add #attributes.objectName#',
						url: '#attributes.addURL#',
						width: 400,
						initAjaxForm: true,
						ajaxFormSuccess: function(){
							$('##'+gridName).trigger('reloadGrid');
						},
						ajaxFormClose: true
					});	
				</cfif>

				<cfif attributes.showEdit eq 1>		
					$('##'+gridName).jqGrid('navButtonAdd',pager,{
						caption:"",
						buttonicon:"ui-icon-pencil",
						onClickButton:function () {
							var rowKey = jQuery('##'+gridName).getGridParam("selrow"); // returns null if no row is selected
							if (rowKey==null){
								alert('You must select a row first.');
							} else {
								$('##'+gridName+'_edit').modalAjax({
									title: 'Edit #attributes.objectName#',
									url: '#attributes.editURL#'+rowKey,
									width: 400,
									autoOpen: true,
									initAjaxForm: true,
									ajaxFormSuccess: function(){
										$('##'+gridName).trigger('reloadGrid');
									},
									ajaxFormClose: true
								});	
								
							}
						},
						position: "last",
						title:"Edit #attributes.objectName#",
						cursor: "pointer"});
				</cfif>
				
				<cfif attributes.showDelete eq 1>			
					$('##'+gridName).jqGrid('navButtonAdd',pager,{
						caption:"",
						buttonicon:"ui-icon-trash",
						onClickButton:function () {
							var rowKey = jQuery('##'+gridName).getGridParam("selrow"); // returns null if no row is selected
							if (rowKey==null){
								alert('You must select a row first.');
							} else {
								if (confirm('Are you sure you want to delete this #attributes.objectName#')){
									$.get('#attributes.deleteURL#'+ rowKey, function(){
										$('##'+gridName).trigger("reloadGrid"); 
									})
								}
							}
						},
						position: "last",
						title:"Delete #attributes.objectName#",
						cursor: "pointer"});
				</cfif>				
				
				<cfif attributes.showCustom eq 1>	
					if(hasSubGrid != false || #attributes.showSubgrid# == false){  		
					$('##'+gridName).navSeparatorAdd(pager);
					$('##'+gridName).jqGrid('navButtonAdd',pager,{
					caption:"",
					buttonicon:"ui-icon-disk",
					onClickButton:function () {
						var cM = jQuery('##'+gridName).jqGrid ('getGridParam', 'colModel');
							cmJSON = $.toJSON(cM);
					<cfif attributes.showSubgrid eq true>
							if ( hasSubGrid == false){
								modalAjax('Manage Views', '/common/dynamicGrid/views/config.cfm?isAdmin=#attributes.isAdmin#&datasource=#attributes.datasource#&pid=#attributes.pid#&grid='+subgrid+'&r='+Math.random(),500,280); 
							} else { 
								modalAjax('Manage Views', '/common/dynamicGrid/views/config.cfm?isAdmin=#attributes.isAdmin#&datasource=#attributes.datasource#&pid=#attributes.pid#&grid='+gridName+'&r='+Math.random(),500,280); 
							}							
					<cfelse>
						modalAjax('Manage Views', '/common/dynamicGrid/views/config.cfm?isAdmin=#attributes.isAdmin#&datasource=#attributes.datasource#&pid=#attributes.pid#&grid='+gridName+'&r='+Math.random(),500,280); 
					</cfif>
					},
					position: "last",
					title:"Manage View",
					cursor: "pointer"});
					
					$('##'+gridName).jqGrid('navButtonAdd',pager,{
						caption:"",
						buttonicon:"ui-icon-lightbulb",
						onClickButton:function () {
		
						<cfif attributes.showSubgrid eq true>
							if ( hasSubGrid == false){
								modalAjax('Select a View', '/common/dynamicGrid/views/select.cfm?datasource=#attributes.datasource#&grid='+subgrid+'&view='+view+'&pid=#attributes.pid#&r='+Math.random(),350,100);
							} else { 
								modalAjax('Select a View', '/common/dynamicGrid/views/select.cfm?datasource=#attributes.datasource#&grid='+gridName+'&view='+view+'&pid=#attributes.pid#&r='+Math.random(),350,100);
							}
						<cfelse>
								modalAjax('Select a View', '/common/dynamicGrid/views/select.cfm?datasource=#attributes.datasource#&grid='+gridName+'&view='+view+'&pid=#attributes.pid#&r='+Math.random(),350,100);
						</cfif>
						},
						position: "last",
						title:"Select View",
						cursor: "pointer"
					});
				
					$('##'+gridName).jqGrid('navButtonAdd',pager,{
						caption:"",
						buttonicon:"ui-icon-extlink",
						onClickButton:function() {
							jQuery('##'+gridName).jqGrid('columnChooser',
								{	done : function(perm) { 
										if (perm) {this.jqGrid("remapColumns", perm, true)};
									},
									msel: 'multiselect'
								}
							); 
						},
						position: "last",
						title:"Show/Hide Columns",
						cursor: "pointer"
					});
				}
				</cfif>
				
			
				
				<cfif attributes.showExcel eq 1	>
				if(hasSubGrid != false || #attributes.showSubgrid# == false){  
					$('##'+gridName).navSeparatorAdd(pager);
		
					 $('##'+gridName).jqGrid('navButtonAdd',pager,{
			       		caption:"", 
			       		onClickButton: 
						function () { 
						
						// first, show all
							var recordCount = $("##"+gridName).jqGrid('getGridParam',"records");
							exportExcel = 1;
							$("##"+gridName).setGridParam({
									rowNum: recordCount,
									page: 1
							}).trigger("reloadGrid");
						

							return false; 
						
						},
						position: "last",
						title:"Export to Excel",
						cursor: "pointer"});
				}		
				</cfif>
				
				<cfif attributes.showExcelNonJQGrid eq 1	>
				if(hasSubGrid != false || #attributes.showSubgrid# == false){  
					$('##'+gridName).navSeparatorAdd(pager);
		
					 $('##'+gridName).jqGrid('navButtonAdd',pager,{
			       		caption:"", 
			       		onClickButton: 
						function () { 
						var cM = jQuery('##'+gridName).jqGrid ('getGridParam', 'colModel');
						var	collist = 'ID';
						var labellist = 'ID';
						for ( var i =0;i<cM.length;i++ ) {
							if ( !cM[i].hidden ){
								collist = collist + ',' + cM[i].name;
								labellist = labellist + ',' + cM[i].label;
							}
						}
						labellist = escape(labellist);
			           		//TODO: can we do the excel export similar to the print page? 
			           		window.open('#attributes.exportURL#&columns=' + collist + '&labels=' + labellist + '&print=0&oper=excel');
						},
						position: "last",
						title:"Export to Excel",
						cursor: "pointer"});
				}		
				</cfif>
				<Cfif attributes.showViewAll eq 1>
					var viewAll = 0;
					
					if(hasSubGrid != false || #attributes.showSubgrid# == false){  
						$('##'+gridName).jqGrid('navButtonAdd',pager,{
							caption:"",
							buttonicon:"ui-icon-zoomin",
							onClickButton:function () {
								if (viewAll == 0){
									var recordCount = $("##"+gridName).jqGrid('getGridParam',"records");
						
									$("##"+gridName).setGridParam({
											url:'#attributes.dataURL#',
											rowNum: recordCount,
											page: 1
									}).trigger("reloadGrid");
									viewAll = 1;
																		
								} else {
						
									$("##"+gridName).setGridParam({
											url:'#attributes.dataURL#',
											rowNum: #attributes.rows#,
											page: 1
									}).trigger("reloadGrid");
									
									viewAll = 0;
								}						
							},
							position: "last",
							title:"View All",
							cursor: "pointer"});
					}
				</cfif>
				
				<Cfif attributes.showPrint eq 1>
				if(hasSubGrid != false || #attributes.showSubgrid# == false){  
					$('##'+gridName).jqGrid('navButtonAdd',pager,{
						caption:"",
						buttonicon:"ui-icon-print",
						onClickButton:function () {
							// first, show all
							var recordCount = $("##"+gridName).jqGrid('getGridParam',"records");
							doPrint = 1;
							$("##"+gridName).setGridParam({
									url:'#attributes.dataURL#',
									rowNum: recordCount,
									page: 1
							}).trigger("reloadGrid");
					           		
						},
						position: "last",
						title:"Print",
						cursor: "pointer"});
				}
				</cfif>
				
				
				<cfif attributes.showHelp eq 1>			
					$('##'+gridName).jqGrid('navButtonAdd',pager,{
						caption:"",
						buttonicon:"ui-icon-help",
						onClickButton:function () {
							window.open('/WebHelp/DynamicGrid/Dynamic_Grid.htm', "gridHelp","width=800,height=600,toolbars=yes,scrollbars=yes,status=yes,resizable=yes");							
						},
						position: "last",
						title:"Help",
						cursor: "pointer"});
				</cfif>	
				<Cfif attributes.showHeaderNav eq 1>
					$('##'+gridName+'_toppager_left').replaceWith($(pager+'_left').clone(true));
				</cfif>
				<cfif attributes.showSearch eq 1>
				$('##'+gridName).jqGrid('filterToolbar'); 
				</cfif>
			}

	function SendView(objForm){
		view = $('##view').val();
		unloadGrid();
		loadGrid(grid, grid, view, dataURL, #attributes.showSubGrid#, "##pager_#attributes.gridName#", true);
		modalClose();
	}

	function saveView(grid, view, new_view, pid, datasource,isAdmin){
		if (view != '' && new_view != '' || view == null && new_view == null ){
			alert('You should either select a view to update OR enter a new view name');
			return false;
		} else {
			$.post('/common/dynamicGrid/model/saveView.cfm',
					{grid: grid,
					 view: view, 
					 new_view: new_view,
					 cmJSON: cmJSON, 
					 pid: pid,
					 datasource: datasource,
					 isAdmin: isAdmin
					},
					function(data){
						unloadGrid();
						
						if (new_view != '' && view != 'default'){
							view = new_view;
						}
						
						loadGrid(grid, grid, view, dataURL, #attributes.showSubGrid#, "##pager_#attributes.gridName#", true);
						modalClose();
						window.alert('The view has been saved');
					}
			);
		}
	}
	function deleteView(grid, view, pid, datasource){
		if( view != '' && pid != ''){
			//Delete the view
			var url = '/common/dynamicGrid/model/deleteView.cfm?grid=' + grid + '&view=' + view + '&pid=' + pid + '&datasource=' + datasource;
			
			if(confirm('Are you sure you want to delete ' + view + '?')){
				$.get(url,function(data){
					modalClose();
					unloadGrid();
					loadGrid(grid, grid, 'default', dataURL, #attributes.showSubGrid#, "##pager_#attributes.gridName#", true);
				});
			}
		}else{
			if(view == ''){
				alert('You must select a view first');
			}
		}
	}
	
	// for setup default wizard
	function submitGrid(){
	    // bind 'myForm' and provide a simple callback function 
	    var options = { 
	       success:       showResponse  // post-submit callback 
	   }; 
	   
	   $('##gridForm').ajaxSubmit(options); 
		return false;
	}
	
	function showResponse(responseText, statusText, xhr, form){ 
			unloadGrid();
			loadGrid('#attributes.gridName#', '#attributes.gridName#', 'default', dataURL, #attributes.showSubGrid#, "##pager_#attributes.gridName#", true);
			return false;
	}
	function launchManage(grid){
	    var cM = jQuery('###attributes.gridName#').jqGrid ('getGridParam', 'colModel');
		cmJSON = $.toJSON(cM);
		modalAjax('Manage Views', '/common/dynamicGrid/views/config.cfm?isAdmin=#attributes.isAdmin#&datasource=#attributes.datasource#&pid=#attributes.pid#&grid=#attributes.gridName#&r='+Math.random(),500,280); 
	}
	
	<cfif not isdefined('attributes.dataURL') or attributes.dataURL eq ''>
		<cfif gridData.recordCount eq 0>
				submitGrid();
		</cfif>
	</cfif>
	</script> 
</cfoutput>