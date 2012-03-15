<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>                     
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>jqGrid DynamicGrid Custom Tag</title>

		<!--- Load the Styles --->
		<link  rel="stylesheet" href="/common/jquery/jquery-ui-1.8.5.custom.css" type="text/css"></link>
		<link rel="stylesheet" type="text/css" media="screen" href="/common/jquery/multiselect/ui.multiselect.css" />
		<link rel="stylesheet" type="text/css" media="screen" href="/common/jquery/jqGrid 3.7.2/css/ui.jqgrid.css" />
		<link  rel="stylesheet" href="/common/skin.css" type="text/css"></link>
		
		<!--- The relevant JavaScripts --->
		<script src='/common/jquery/jquery-1.4.2.min.js'></script>
		<script src='/common/jquery/jquery-ui-1.8.5.custom.min.js'></script>
		<script src='/common/jquery/jquery.toJSON.js'></script>
		<script src="/common/jquery/multiselect/ui.multiselect.js"></script>
		<script src="/common/jquery/jqGrid 3.7.2/js/grid.locale-en.js" type="text/javascript"></script>
		<script src="/common/jquery/jqGrid 3.7.2/js/jquery.jqGrid.min.js" type="text/javascript"></script>
		<script src="/common/jquery/jquery.form.js"></script>
		<script src='/common/script.js'></script>
		<script src="/common/dynamicGrid/script.js"></script>
		
		<!---App specific formatters - this demonstrates how to add your own formatters --->
		<script src="/common/dynamicGrid/example/formatters.js"></script>  
		
		<style type="text/css">
			body { font-size: 14px !important; } 
		</style>
	</head>                     
	<body>
			<!--- 
			Data may be provided with one of the following methods: 
			
			dataURL - url to a JSON data feed, you will have to populate the dynamicGridColumns table yourself
			
			standard CFFunction - specify only a methodName to run a CFINCLUDED function 
			
			application scoped cfc - enter the className (path w/ dot notation) and the methodName
			
			with Function driven data, the grid is able to setup the column model itself.  it will run the function once to get 
			a listing of all fields in the returned query.  It will add all fields to the database, and you can begin customizing from there
			
			--->
			
			<script>
	$(function() {
		$( "#accordion" ).accordion({
			clearStyle: true,
			 change: function(event, ui) {
				var clicked = ui.newHeader.text();
				
				if (clicked == 'Section 2'){
			 		startGrid(); // exposed in jqGrid - pass in autoLoad = 0 for this example
			 	} else { 
			 		unloadGrid();
			 	}
		 	 }
		
		});
	});
	</script>


			<div id="accordion">
				<h3><a href="#">Section 1</a></h3>
				<div>foo</div>
				<h3><a href="#">Section 2</a></h3>
				<div id="gridExpander">

					<cfmodule template="../jqGrid.cfm" 
									<!--- Setup --->
									caption = 'DynamicGrid Demo'  <!--- Optional: turns off header bar if blank --->
									gridName = 'dept3'  <!--- Name for this grid / layout..    multiple grids can use the same grid name with different methods or arguments to reuse that gridnames layout / settings --->
									objectName = 'Department'	  <!--- Defaults to grid name.. used for friendly words like "Add Patent", "Delete Proposal" --->
									width="100%" <!--- px or % --->
									rows="10"
									autoLoad = '0'
									
									<!--- dataURL = '/dynamicGrid/example/testAPI.cfm'   NOTE: COLMODEL MUST BE MANUALLY CONFIGURED --->
									<!--- OR  via the dynamic functionrunner --->
									method = 'application.department.get'  <!--- example: application.classname.methodname  or func_method --->
									arguments = '' <!--- example: id=123&foo=bar --->
									defaultSort = 'dept_code' 							

									application = 'ramses'
									datasource='config'	
									pid='123456'
									isAdmin='1' <!--- Session variable for admin users (ie, session.admin.global)--->
					> 
				</div>
				<h3><a href="#">Section 3</a></h3>
				<div>foo</div>
			</div>

	</body>
</html>