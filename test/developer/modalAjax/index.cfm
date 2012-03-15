<cfsetting showdebugoutput="false">

<!--- the basics --->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>

<!--- dependencies --->
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="/ckeditor/adapters/jquery.js"></script>
<script type="text/javascript" src="/scripts/jquery.form.js"></script>
<script type="text/javascript" src="/scripts/jquery.livequery.min.js"></script>
<script type="text/javascript" src="/scripts/forms/jquery.validate-1.8.0.min.js"></script>

<!--- load the plugin --->
<script src="/scripts/jquery.modalAjax.js"></script>


<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css"> 
<style type="text/css">
	body { padding: 15px; } 
	legend { padding: 3px; }
	
	form div.error{ 
		background-color: pink;
		border: 1px solid red;
		border-radius: 10px;
		padding: 5px;
	}
	
	fieldset { border-radius: 	5px; } 
	
	form div.error div.errorField{ 
		font-weight: bold;
		color: red;
		padding: 5px;
		margin: 0px 0px 3px 0px;

	}
	
	form div.error div.errorField span.ui-icon{ 
		float: left;
	}
	
	div.ctrlHolder { padding: 5px; margin: 3px 0px;} 
	
	label{  
		float: none; 
		margin: 0 0 .5em 0; 
		padding: 0; 
		line-height: 100%; 
		position: absolute; 
		text-align:right; 
		width:90px;  
	}
	
	.above label{ 
		display: block; 
		width: auto; 
		position:relative; 
		text-align: left; 
		width: auto;
	}
	
	label em.required { 
		display: inline; 
		color: red; 
		font-weight: bold; 
		font-size:8px;
	}

	input[type="text"], input[type="password"], 
	input[type="file"], textarea, select{
	 	border-radius: 5px;  
	 	background: -moz-linear-gradient(center top , #FAFAFA 80%,#CCCCCC ) ;
	 	border-color: #DADADA #C6C6C6  ;  
	 	color: #999999; 
		margin-left: 100px;
	 	width: 250px;
	 	 padding: 3px;
	 	 border-style: solid;
	 	 border-width: 1px;
	 } 
	 
	.above input[type="text"], .above input[type="password"], 
	input[type="file"], .above  textarea, .above select{
	 	margin-left: 0px;  
	 	width: 100%;
	 }
		
	input[type="submit"], 
	input[type="button"], 
	input[type="reset"] {
	    border-radius: 4px 4px 4px 4px;
	    margin: 0px;
	    font-weight: bold;
	}

</style>


<a href='javascript:void(0);' id="testDialog" alt='foo'>Text Only</a> - <a href="#" onclick="$('#testDialog').data('modalAjax').open();">OPEN</A> <a href="javascript:$('#testDialog').data('modalAjax').close();">CLOSE</A><br />
<a href='javascript:void(0);' id="testDialog2">Ajax Form</a><br />
<!---><a href='javascript:void(0);' id="autoOpen" alt='foo'>AutoOpen</a><br />--->
<a href='javascript:void(0);' id="testDialog3">ckEditor</a><br />
<a href='javascript:void(0);' id="testDialog4">Complex Tabset</a><br />
<a href='javascript:void(0);' id="testDialog5">Complex Tabset (ajax)</a><br />
<a href='javascript:void(0);' class="testDialog">Bind By Class</a><br />
<a href='javascript:void(0);' ID="testError">Error</a><br />


<a href='javascript:void(0);' ID="ajaxTarget">AjaxForm target</a><div class="targetDiv"></div><br />



<script>
	$('#testDialog').modalAjax({
			url: 'example/text.cfm?id=!alt!',
			title: 'Dialog 1 - Text / Links',
			width: 800
	});
	
	$('#testDialog2').modalAjax({
			url: 'example/ajaxForm.cfm',
			title: 'Dialog 2 - AJAX Form',
			width: 850
	});

	$('#autoOpen').modalAjax({
			url: 'example/text.cfm',
			title: 'Auto Open',
			width: 200,
			autoOpen: true
	});

	$('#testDialog3').modalAjax({
			url: 'example/CKEditor.cfm',
			title: 'Dialog 3 - CKEditor',
			width: 800
	});
	
	$('#testDialog4').modalAjax({
			url: 'example/tabset.cfm',
			title: 'Dialog 4 - Links, Tabs, CKEditor, AJAX Form',
			width: 1000
	});
	$('#testDialog5').modalAjax({
			url: 'example/tabsetAjax.cfm',
			title: 'Dialog 5 - Links, Tabs, CKEditor, AJAX Form',
			width: 1000
	});
	$('.testDialog').modalAjax({
			url: 'example/text.cfm',
			title: 'Dialog 1 - Text / Links',
			width: 800
	});
	$('#testError').modalAjax({
			url: 'example/error.cfm?id=!alt!',
			title: 'Dialog 1 - Text / Links',
			width: 800
	});
	$('#ajaxTarget').modalAjax({
			url: 'example/ajaxForm.cfm',
			title: 'Dialog 1 - Text / Links',
			width: 1000,
			ajaxFormTarget: '.targetDiv',
			ajaxFormClose: true
	});
</script>
