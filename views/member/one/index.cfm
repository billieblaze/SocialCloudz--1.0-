<cfset fbLogin = application.community.settings.getValue('facebookLogin',request.community.settings)>
<cfset linkedinLogin = application.community.settings.getValue('linkedinLogin',request.community.settings)>
<cfdump var='#request.session.one.getProviders()#'>
<div class="mod">
	<div class="hd">Manage Identities</div>
	<div class="bd">

		<Cfif structCount(request.session.one.getProvider('facebook')) lte 2 and fbLogin neq 0>
			<a href='/index.cfm/member/one/facebook' class="facebook"><img src="/images/connect2.gif"></a><br>
		</cfif>
		
		<Cfif structCount(request.session.one.getProvider('linkedin')) lte 2 and  linkedinLogin neq 0>
			<a href='/index.cfm/member/one/linkedIn' class="linkedIn"><img src="/images/log-in-linkedin-large.png"></a><BR>
		</cfif>
		<br /><br />
		if not an oauth provider, 
		link to those (initially google, soundcloud)
		<br /><br />
		need to allow user to change context / role
		<br /><br />
		need to make privacy flag prevent content syndication
		<BR><BR>
		need to allow multiple links to a service provider - facebook user, facebook group, different role / context of a user, etc.. 



		<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
				gridName = 'identity' 
				objectName = 'Identity'	 
				width="100%" 
				rows="10"
				method = 'application.one.gateway.get' 
				arguments = 'memberID=#request.session.memberID#' 
				defaultSort = 'oneID' 			
				editableCells = 1
				editableCellURL = '/index.cfm/member/one/submit'				
				pid='#request.session.memberID#'
				datasource="community"
				isAdmin='1' 
		> 
</div>
<div class="ft"></div>
</div>