<cfset includeUDF('layouts/module.cfm')>

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

	<title>#request.community.site# <cfif request.page.title neq ''>- #request.page.title#</cfif></title>

	<script type="text/javascript" src="#application.cdn.js#/script.js"></script>

	<script src="/scripts/forms/uni-form.jquery.js" type="text/javascript"></script>
	
	<script src="/scripts/jquery.modalAjax.js"></script>
	
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
	<link rel="stylesheet" type="text/css" href="#request.layout.skinFile#?c=#event.getValue('c','')#">

	 <!--[if lte ie 8]><link href="/css/uni-form-ie.css" type="text/css" rel="stylesheet" media="all" /><![endif]-->
	<cfif request.layout.width eq 'custom-doc'>
		<style> ##custom-doc {margin:auto;text-align:left;width:#request.layout.widthCustom#px;min-width:600px;}</style>
	</cfif>
	
	
</head>
<body>
<div id="doc3" >
	#renderLayout(layout='branding')#</div>
	#renderLayout(layout='header')#
<cfif  request.layout.columns eq 1> 
	<ul id="list1"  class="list  listSingle" style="padding:0px; margin:0px">
		#constructModules( '1')#
		#renderView()#
		#constructModules( '2')#
	</ul>
<cfelseif request.layout.columns eq 2>
	<div style="clear:both;">
		<ul class="list  listSingle" id="list7">#constructModules('7')#</ul> 
	</div>
	<div id="yui-main" style="padding:0px">
		<div class="yui-b">
	    	<ul class="list listLeft" id="list1" style="padding:0px; margin:0px; ">
	    	#constructModules( 1)#
			#renderView()#
			</ul>
		</div>
	</div>
	<div class="yui-b">
		<ul  class="list listRight" id="list2" style="padding:0px; margin:0px">
			#rc.sidebar#
			#constructModules( '2')#
			
		</ul>
	</div>
	<div style="clear:both;"><ul class="list  listSingle" id="list8">#constructModules( '8')#</ul></div>	    	
<cfelse>


	<div style="clear:both;">
		<ul class="list   listSingle" id="list7">#constructModules( '7')#</ul> 
	</div>
    <div id="yui-main" style="padding:0px">
        <div class="yui-b">		
	    <div class="yui-g#request.layout.right#"> 
	         <div class="yui-u first">
                <ul  class="list listLeft" id="list1" style="padding:0px; margin:0px">
					#constructModules( '1')#
					#rc.sidebar#
					#constructModules( '4')#
				</ul>
	       	</div> 
			<div class="yui-u">
		 		<ul class="list listMiddle" id="list3" style="padding:0px; margin:0px; ">		
        			#constructModules( '3')#
					#renderView()#
        			#constructModules( '5')#
				</ul> 
            </div>  
		</div> 
		</div>
	</div>
    <div class="yui-b">
		<ul class="list listRight" id="list2" style="padding:0px; margin:0px; ">
			#constructModules( '2')#
		</ul>
    </div>
    <div style="clear:both;">
		<ul class="list   listSingle" id="list8">
			#constructModules( '8')#
		</ul>
	</div>	    	
</cfif>
<Cfif request.session.login eq 0>
		<script src="/scripts/eventbinding/guest.js"></script>
	<cfelse>
		<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
		<script type="text/javascript" src="/ckeditor/adapters/jquery.js"></script>
		<script src="/common/dynamicGrid/script.js"></script>
		<script src="/scripts/jqGridFormatters.js"></script>  

		<cfif request.session.accesslevel lt 10 >
			<script src="/scripts/eventbinding/member.js"></script>
		<cfelse>
			<script src="/scripts/eventbinding/admin.js"></script>  
		</cfif> 
	</cfif>
	

#renderLayout(layout='footer')#
<cfprocessingdirective suppresswhitespace="yes">

<script> 
	var thisPage = "#request.page.id#"; 
	var contentType = "#event.getValue('contentType','')#";
	
	function TWFormValidate(instanceID)
	{
		var errMsg = "";
		var f = document.getElementById('TWForm'+instanceID);
		if( errMsg != "" )
		{
			alert( "Sorry there are some problems:\n" + errMsg );
			return false;
		}
		f.action = "/dccom/components/twform/actions/postForm/index.cfm";
		return true;
	}


	<!--- TODO: integrate w/ an ajax messagebox plugin or something similar --->	
	<cfif request.message neq ''>$.jGrowl('#request.message#');</cfif> 	 
	<cfif request.session.message neq ''>$.jGrowl('#request.session.message#');<cfset request.session.message = ''></cfif> 	
	
	<cfparam name="request.session.showLogin" default=0>
	<cfif request.session.showLogin eq 1>
		$('.showLogin').data('modalAjax').open();
	</cfif> 
	
	<cfparam name='request.session.welcomeMessage' default='0'>
	
	<cfif application.community.isowner(request.session.memberid)>
	
		<cfif request.session.numlogins eq 0 and request.session.welcomemessage eq 0 or isdefineD('rc.welcome')>
			$('body').modalAjax({ 
				url: '/index.cfm/community/admin/welcome',
				title: 'Congratulations - Your site has been created!', 
				modal: true,
				autoOpen: true,
				width: 650
			});
			
			<cfset request.session.welcomeMessage = 1>
		</cfif>

	<!--- TODO: extract "support" alerts into a module 
	<cfif request.session.login eq 1 and request.session.supportMessage eq 0>
		<cfset support = application.help.getsupport()>
		<cfif support.recordcount eq 1>
			$('body').modalAjax({
				url: '/index.cfm/app/support/alert', 
				title: '#support.subject#', 
				modal: true,
				autoOpen: true,
				width: 600
			});
			<cfset request.session.supportMessage = 1>
		</cfif>
	</cfif>
	--->

		<!--- TODO: whenever i actually charge / monitor consumption again 
		<cfparam name='request.session.upgradeMessage' default='0'>
		
		<cfif request.session.upgrademessage eq 0>
			<cfif (request.community.bandwidth lte application.server.bandwidth.check(request.community.communityID, 'month').total or 
			 request.community.storage lte application.server.storage.check(request.community.communityID, 'month')) and event.getCurrentEvent() neq 'commerce.upgrade.index'>
				<cflocation url='/index.cfm/commerce/upgrade/index'>
			<cfelse>
			<cfif (
					request.community.bandwidth *.95 lte application.server.bandwidth.check(request.community.communityID, 'month').total ) or 
			 		request.community.storage *.95 lte (application.server.storage.check(request.community.communityID, 'month')
			 	   )>
			$('body').modalAjax({ 
				url: '/index.cfm/commerce/upgrade/alert',
				title: 'Upgrade your site', 
				modal: true,
				autoOpen: true,
				width: 600
			});

			</cfif>
			<cfset request.session.upgrademessage = 1> 
		</cfif>
	--->
	</cfif>

</script> 
</cfprocessingdirective>

<script type="text/javascript">var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));</script>
<script type="text/javascript">try {var pageTracker = _gat._getTracker("UA-8362413-1");pageTracker._trackPageview();} catch(err) {}</script>

<cfif request.community.google neq ''>
	<script type="text/javascript">	var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");	document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));	</script>
	<script type="text/javascript">	try {	var pageTracker = _gat._getTracker("#request.community.google#");	pageTracker._trackPageview();	} catch(err) {}</script>
</cfif>

<cfif isdefined('rc.debug')>
	<h1>REQUEST</h1>
	<cfdump var='#request#'>
	<cfdump var='#request.session.one.getproviders()#'>
	<h1>CGI</h1>
	<cfdump var='#cgi#'>
</cfif>
</body>
</html>
</cfoutput>