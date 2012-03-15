<cfsetting showdebugoutput="false">
<div class="tabs">
	<ul>
		<li><a href="#tabs-1">Home</a></li>
		<li><a href="#tabs-2#">Text / Links</a></li>
		<li><a href="example/ajaxTab.cfm">Ajax Content</a></li>
		<li><a href="example/tabset.cfm">Nested Tabs</a></li>
		<li><a href="#tabs-4">CKEditor</a></li>
		<li><a href="#tabs-5">Ajax Form</a></li>
	</ul>
	<div id="tabs-1">
		Welcome to the demo for my modalAjax plugin..   
	</div>
	<div id="tabs-2">
		<cfinclude template='text.cfm'>
	</div>
	<div id="tabs-4">
		<cfinclude template='ckEditor.cfm'>
	</div>
	<div id="tabs-5">
		<cfinclude template="ajaxForm.cfm">
	</div>
</div>
