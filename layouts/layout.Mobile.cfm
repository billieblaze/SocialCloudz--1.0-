<cfset includeUDF('layouts/module.cfm')>
<cfsetting showdebugoutput="false">
<cfset event.showdebugpanel("false")>
<cfoutput>
<!DOCTYPE html>
<html>
<head>
	<meta name="keywords" content="#request.page.keywords#" />
	<meta name="description" content="#request.page.description#" />
    <META NAME="ROBOTS" CONTENT="INDEX, FOLLOW">
	<meta name="HandheldFriendly" content="true" />
	<meta name="viewport" content="width=device-width, initial-scale=1"> 

	<title>#request.community.site# <cfif request.page.title neq ''>- #request.page.title#</cfif></title>
	
	<script type="text/javascript" src="/scripts/script.mobile.js"></script>
	

	<link rel="shortcut icon" type="image/x-icon" href="/favicon.ico">
	<link rel="stylesheet" type="text/css" href="#application.cdn.css#style.mobile.css"> 
	<link rel="stylesheet" type="text/css" href="#request.layout.skinFile#?c=#event.getValue('c','')#">
	
</head>
<body>
<div data-role="header" data-position="fixed" >
	<h1>#request.page.title#</h1>
	<cfif request.session.login eq 0>
		<a href="#event.buildLink('member.auth.index')#" data-ajax="false">Login</a>
		
	  	<cfif application.community.settings.getValue('Signup')> 
	    	<a  href="#event.buildLink('member.signup.details')#" data-position="inline"data-ajax="false">Signup</a>
		</cfif>
	<cfelse>
		 <a data-role="button" data-icon="gear">#request.session.username#</a>
		 <a href="/?logout" data-ajax="false">Logout</a>
	</cfif>
</div> 

		<A href="/" style="text-decoration:none">
		<div id="hd" <cfif application.community.settings.getValue('menu_position') eq 'above'>style="margin:0;"</cfif>>
			<Cfif request.layout.headerFile eq ''>
					<div id="siteLogo"></div>
					<div id="siteName">#request.community.site#</div>
				    <div id="siteTagLine">#request.community.tagline#</div>
			<cfelse>
				<cfinclude template ='#request.layout.headerFile#'>	
			</cfif>
		</div>
		</A>
		<cfif not (request.session.login eq 0 and request.community.private eq 1)>
			<div data-role="collapsible" style="padding:0px !important;">
				<h3>Navigation Menu</h3>
				<p><cfinclude template="menu.cfm"></p>
			</div>
		</cfif>

		<div id="bd">
			
<cfif  request.layout.columns eq 1> 
	<ul id="list1"  class="list  listSingle" style="padding:0px; margin:0px">
		#constructModules( '1')#
		#renderView()#
		#constructModules( '2')#
	</ul>
<cfelseif request.layout.columns eq 2>
	
		<ul class="list  listSingle" id="list7">#constructModules('7')#</ul> 

	    	<ul class="list listLeft" id="list1" style="padding:0px; margin:0px; ">
	    	#constructModules( 1)#
			#renderView()#
		
		<ul  class="list listRight" id="list2" style="padding:0px; margin:0px">
			#rc.sidebar#
			#constructModules( '2')#
			
		</ul>
	
	<ul class="list  listSingle" id="list8">#constructModules( '8')#</ul></div>	    	
<cfelse>


	
		<ul class="list   listSingle" id="list7">#constructModules( '7')#</ul> 
	
   
                <ul  class="list listLeft" id="list1" style="padding:0px; margin:0px">
					#constructModules( '1')#
					#rc.sidebar#
					#constructModules( '4')#
				</ul>
	       
		 		
          <ul class="list   listSingle" id="list8">
			#constructModules( '8')#
		</ul>  
		<ul class="list listRight" id="list2" style="padding:0px; margin:0px; ">
			#constructModules( '2')#
		</ul>
   
		<ul class="list listMiddle" id="list3" style="padding:0px; margin:0px; ">		
        			#constructModules( '3')#
					#renderView()#
        			#constructModules( '5')#
				</ul> 
	
</cfif>
</div>

	    <div id="ft" align="center">
		    <a href="/?ismobile=0" id="leaveMobileLink">Click Here</a> to exit mobile version.<br /><br />
		   	 Copyright &copy; #year(now())# #request.community.site#. All Rights Reserved. 			   	<BR />
		   	<cfif application.community.settings.getValue('Branding') eq 0>
				 Social CMS Platform by <a href="http://#request.community.parent.baseurl#">#request.community.parent.detail.name#</a>			   	<BR />
			</cfif>
				<a href="mailto:#request.community.owner.email#">Contact</a> |  <a href="#event.buildLink('app.help.index')#">Help</a> 
				<br />
				 <a href="#event.buildLink('app.info.terms')#">Terms of Service</a> | <a href="#event.buildLink('app.info.privacy')#">Privacy Policy</a> 
	    </div>

<!--- 
<cfif request.session.login neq 0>
<div class="ui-bar ui-footer ui-bar-a" data-role="footer" role="contentinfo" data-position="fixed">
	<div data-type="horizontal" data-role="controlgroup" class="ui-corner-all ui-controlgroup ui-controlgroup-horizontal">
		<a data-role="button" data-icon="alert">Notifications</a>
		<a data-role="button" data-icon="grid">Network</a>
		<a data-role="button" data-icon="search">Mail</a>
	</div>
</div> --->
<!--- </cfif> --->

<script> 
<!--- TODO: integrate this with some sort of ajax messagebox hybrid X
	<cfif request.message neq ''>$.jGrowl('#request.message#');</cfif> 	 
	<cfif request.session.message neq ''>$.jGrowl('#request.session.message#');<cfset request.session.message = ''></cfif> 	
	 --->
	var thisPage = "#request.page.id#"; 
	var contentType = "#event.getValue('contentType','')#";
</script> 

</body>
</html>
</cfoutput>