<cfset includeUDF('layouts/module.cfm')>
	<cfscript>
	currentEvent = event.getCurrentEvent();
</cfscript>
<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<meta name="keywords" content="#request.page.keywords#" />
	<meta name="description" content="#request.page.description#" />
	<meta name="msvalidate.01" content="#request.community.microsoft#" />
    <META NAME="ROBOTS" CONTENT="INDEX, FOLLOW">

	<title>#request.page.title#</title>

	<script type="text/javascript" src="#application.cdn.js#/script.js"></script>
	<script type="text/javascript" src="/scripts/jquery.toJSON.js"></script>
	<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="/ckeditor/adapters/jquery.js"></script>
	<script src="/scripts/grid.locale-en.js" type="text/javascript"></script>
	<script src="/scripts/jquery.jqGrid.min.js" type="text/javascript"></script>

	<cfif cgi.http_user_agent does not contain 'MSIE'>
		<style type="text/css">
		.bodyContent{border-style:solid;margin-top:30px !important;}
		</style>
	<cfelse>
		<style type="text/css">
		.bodyContent{top: 30px; position: relative;}
		</style>
	</cfif>
	
	<link rel="shortcut icon" type="image/x-icon" href="/favicon.ico">
	<link rel="stylesheet" type="text/css" href="#application.cdn.css#style.css"> 
	<link rel="stylesheet" type="text/css" href="#request.layout.skinFile#">

	<cfif request.layout.width eq 'custom-doc'>
		<style> ##custom-doc {margin:auto;text-align:left;width:#request.layout.widthCustom#px;min-width:600px;}</style>
	</cfif>
	<style>div.mod{border:0px none !important;}</style>
</head>
<body>
	<div id="doc3" >#renderLayout(layout='branding')#</div>
	#renderLayout(layout='header')#
	<ul id="list1"  class="list listSingle" style="padding:0px; margin:30px 0px 0px 0px">
		#constructModules( '1')#
	</ul>
	#renderLayout(layout='footer')#;
</cfoutput>
