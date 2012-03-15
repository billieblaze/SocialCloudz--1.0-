<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<title>Conforming XHTML 1.0 Transitional Template</title>
	
	
	<script type="text/javascript" src="/scripts/script.js"></script>
	<script type="text/javascript" src="/scripts/jquery.toJSON.js"></script>
	<script src="/scripts/ui.multiselect.js"></script>
	<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="/ckeditor/adapters/jquery.js"></script>
	<script type="text/javascript" src="/ckfinder/ckfinder.js"></script>
	<script src="/scripts/grid.locale-en.js" type="text/javascript"></script>
	<script src="/scripts/jquery.jqGrid.min.js" type="text/javascript"></script>
	<script src="/common/dynamicGrid/script.js"></script>
	<script src="/scripts/jqGridFormatters.js"></script>  
	<script src="/scripts/forms/jquery.validate-1.6.0.min.js" type="text/javascript"></script>	
	<script type="text/javascript" src="/scripts/forms/jquery.datepick-3.7.5.min.js"></script>
	<script type="text/javascript" src="/scripts/forms/jquery.timeentry-1.4.6.min.js"></script>
	<script type="text/javascript" src="/scripts/forms/jquery.maskedinput-1.2.2.min.js"></script>
	<script type="text/javascript" src="/scripts/forms/jquery.prettyComments-1.4.pack.js"></script>
	<script src="/scripts/forms/uni-form.jquery.js" type="text/javascript"></script>
	<script type="text/javascript" src="/scripts/openid-jquery.js"></script>
	<script type="text/javascript" src="/scripts/openid-jquery-en.js"></script>
	<script src="http://connect.facebook.net/en_US/all.js"></script>
	
	<link rel="stylesheet" type="text/css" href="/css/style.css"> 
	<link rel="stylesheet" type="text/css" media="screen" href="/css/ui.multiselect.css" />
 	<link href="/css/uni-form.css" type="text/css" rel="stylesheet" media="all" />
	<link href="/css/uni-form.default.css" type="text/css" rel="stylesheet" media="all" /> 
	<link href="/css/datepick/jquery.datepick.css" rel="stylesheet" media="all" />
	<link href="/css/jquery.timeentry.css" rel="stylesheet" media="all" />


	<style>
	.column { width: 170px; float: left; padding-bottom: 100px; }
	.inactive .portlet-content, .inactive .portlet span.ui-icon { height: 0px; display: none;}
	.portlet { margin: 0 1em 1em 0; }
	.portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
	.portlet-header .ui-icon { float: right; }
	.portlet-content { padding: 0.4em; }
	.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
	.ui-sortable-placeholder * { visibility: hidden; }
	
	#sortable { list-style-type: none; margin: 0; padding: 0; }
	#sortable li { margin: 0 5px 5px 5px; padding: 5px; font-size: 1.2em; height: 1.5em; }
	html>body #sortable li { height: 1.5em; line-height: 1.2em; }
	.ui-state-highlight { height: 1.5em; line-height: 1.2em; }

	</style>
	<script>
	$(function() {
		/* left hand - form fields */
			$( "#sortable" ).sortable({
				placeholder: "ui-state-highlight",
				cancel: ".ui-state-disabled"
			});
			
			$( "#sortable" ).disableSelection();
			
		
		/* right hand - modules */
			$( ".column" ).sortable({
				connectWith: ".column"
			});
	
			$( ".portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
				.find( ".portlet-header" )
					.addClass( "ui-widget-header ui-corner-all" )
					.prepend( "<span class='ui-icon ui-icon-minusthick'></span>")
					.end()
				.find( ".portlet-content" );
	
			$( ".portlet-header .ui-icon" ).click(function() {
				$( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
				$( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
			});
	
			$( ".column" ).disableSelection();
		
		// Add new attribute
			$('#newAttribute').click( function(){
				$('#sortable').append('<li class="ui-state-default">New Attribute</li>');
			});
			
		// Edit form field 
			$('#sortable li .ui-icon-wrench').click( function(){
				ajaxBoxy('edit this field', '/index.cfm')
			});
		
	});
	</script>


</head>

<body>
	<div style="width:600px; float: left; text-align:left">
		<ul id="sortable" >
			<li class="ui-state-default  ui-state-disabled">
				<h3>
					Form Builder 
					<span class='ui-icon ui-icon-plus' style="float:right" id="newAttribute"></span>
				</h3> 
			</li>
			<li class="ui-state-default">Title - Textbox <span class='ui-icon ui-icon-wrench' style="float:right"></span></li>
			<li class="ui-state-default">Subtitle - textbox <span class='ui-icon ui-icon-wrench' style="float:right"></span></li>
			<li class="ui-state-default">Creator - text <span class='ui-icon ui-icon-wrench' style="float:right"></span></li>
			<li class="ui-state-default">Group - Select box <span class='ui-icon ui-icon-wrench' style="float:right"></span></li>
			<li class="ui-state-default">Freeform Attribute <span class='ui-icon ui-icon-wrench' style="float:right"></span></li>
			<li class="ui-state-default" style="height:50px">Description - Rich Text <span class='ui-icon ui-icon-wrench' style="float:right"></span></li>
		</ul>
	</div>
	
	<div class="column" align="left" style="width:200px; float: left; padding: 5px; background-color: silver">
	<h3>Active Modules</h3>
		<div class="portlet">
			<div class="portlet-header">Tags</div>
			<div class="portlet-content">Lorem ipsum dolor sit amet</div>
		</div>
		
		<div class="portlet">
			<div class="portlet-header">Categories</div>
			<div class="portlet-content">Lorem ipsum dolor sit amet</div>
		</div>
	
		<div class="portlet">
			<div class="portlet-header">Location</div>
			<div class="portlet-content">Lorem ipsum dolor sit amet</div>
		</div>
		
	</div>


	<div class="column inactive" align="left" style="width:200px; float: left; padding: 5px; background-color: red">
	<h3>Inactive Modules</h3>
		<div class="portlet">
			<div class="portlet-header">Image</div>
			<div class="portlet-content">Lorem ipsum dolor sit amet</div>
		</div>
		<div class="portlet">
			<div class="portlet-header">File</div>
			<div class="portlet-content">Lorem ipsum dolor sit amet</div>
		</div>
		<div class="portlet">
			<div class="portlet-header">Start / End Date</div>
			<div class="portlet-content">Lorem ipsum dolor sit amet</div>
		</div>
		<div class="portlet">
			<div class="portlet-header">Advanced</div>
			<div class="portlet-content">Lorem ipsum dolor sit amet</div>
		</div>
	</div>

<br style="clear:both">
</body>

</html>
