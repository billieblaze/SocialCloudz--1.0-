<cfset community = event.getValue('community')>
<cfset dnsmask = event.getValue('dnsmask')>
<cfset menuFeatures = event.getValue('menuFeatures')>
<cfset cmsPages = event.getValue('cmsPages')>
<cfoutput>
	<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform" />
	<h3>Setup your domain name</h3>
		DNS Masking is a technique that you can use to customize the URLs of your site. <BR>
		Prior to activating this feature, you must add what is called a CNAME record that points to #request.community.parent.baseurl#.<br /><br />
		
		<h4>Step 1. Enter your domain name</h4>
			Enter the domain or subdomain that you CNAMEd to #request.community.parent.baseurl#. <BR>
			To deactivate DNS masking for your site, clear the contents of the first field below, and click Save.<br />
			<br />

		<div class="cfUniForm-form-container">
			<uform:form action="#event.buildLink('community.domain.submit')#" id="domainNameForm" errors="#rc.errors#" errorMessagePlacement="inline" loadValidation="true">
				<input type="hidden" name="communityID" value="#community.communityID#">
				<input type="hidden" name="domain.ID" value="#rc.domain.id#">
				<uform:fieldset legend="">
					<uform:field label="Subdomain" name="domain.subdomain" value="#rc.domain.subDomain#" type="text" isRequired="true" hint="example: www"/>
					<uform:field label="Domain" name="domain.domain" value="#rc.domain.domain#" type="text" isRequired="true" hint="example: mysite.com"/>
					<uform:field label="Start Page" name="domain.startPage" type="select" isRequired="true">
						<cfloop query="menuFeatures">
							<uform:option display="#menuFeatures.name[currentRow]#" value="#menuFeatures.url[currentRow]#" isSelected="#rc.domain.startPage EQ menuFeatures.url[currentRow]#" />
						</cfloop>
						<cfloop query="cmsPages">
							<uform:option display="#cmsPages.title[currentRow]#" value="#cmsPages.url[currentRow]#" isSelected="#rc.domain.startPage eq cmsPages.url[currentRow]#" />
						</cfloop>
					</uform:field>

				</uform:fieldset>
			</uform:form>
		</div>
		<BR>
	<script>
		verify = function(cellvalue, options, rowdata){ 
			if ( rowdata['VERIFIED'] == 0 ){
				src= '<a href="/index.cfm/community/domain/verify/id/'+rowdata["ID"]+'/communityID/'+rowdata["COMMUNITYID"]+'" class="ajaxTabLink">Verify</a>';
			} else { 
				src = '<img src="/images/fam/accept.png">';
			}
		  return src;
		}
	</script>
	<h4>Step 2. Add the CNAME record to the DNS for your domain</h4><br />
	<h4>Step 3. Wait approximately 30 minutes and verify your domain</h4><br />
	<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
							<!--- Setup --->
							gridName = 'domainAdmin' 
							objectName = 'DNS Entry'	 
							rows="10"
							
							method = 'application.community.domain.listMask' 
							arguments = 'communityID=#community.communityID#' 
							defaultSort = 'subdomain, domain' 							
							
							showEdit= 1 
							editURL = '/index.cfm/community/domain/index/communityID/#community.communityID#/id/'		
														
							showDelete = 1
							deleteURL = '/index.cfm/community/domain/delete/communityID/#community.communityID#/id/'		
							
							pid='#request.session.memberID#'
							datasource="community"
							isAdmin='1' 
							
			> 
		</cfoutput>
<script>
	<cfif request.session.message neq ''>
		$.jGrowl('<cfoutput>#request.session.message#</cfoutput>');
		<cfset request.session.message = ''>
	</cfif>
	// bind 'myForm' and provide a simple callback function 
    $('#domainNameForm').ajaxForm(function(responseText) { 
		$('#domainNameForm').parent().parent().html(responseText);            	        	
   	}); 
</script>