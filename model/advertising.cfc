<cfcomponent>
	<cffunction name="init" returntype="advertising">
		<cfargument name="datasource" type="string">

		<cfset variables.myDAO = createobject('component', 'DataMgr.DataMgr_MYSQL').init(arguments.datasource)>
		<cfset variables.datasource = arguments.datasource>
		
        

		<cfreturn this>
	</cffunction>
    
    <cffunction name="getAdSizes">
		<cfset var qGet = ''>
    	<cfquery name="qGet" datasource="#variables.datasource#">
        	select * 
			from bannerSize
        </cfquery>
        <cfreturn qGet>
    </cffunction>
    
    <cffunction name="showBanner">
    	<cfargument name="bwidth">
		<cfargument name="bheight">
   		<cfargument name="placement">
   		
        <cfscript>
			var returnContent = '';
			var mybanner = this.getBanner(arguments.bwidth, arguments.bheight, arguments.placement);
		</cfscript>
      	<cfsavecontent variable='returnContent'>
	   		<cfif myBanner.recordcount neq 0>
				<cfif arguments.placement eq 'footer'>	<br /><br /></cfif>
		    	<cfoutput>#mybanner.code#</cfoutput> 
			</cfif>
		</cfsavecontent>
		<cfreturn returnContent>
    </cffunction>
    
  	<cffunction name="getBanners">
	  	<cfargument name="global" default="0">
	    <cfset var bannerDetail = ''>
	    
	    <cfquery datasource="#variables.datasource#" name='bannerDetail'>
	        Select  code,b.ID,adsize,views, b.placement, height, width, clicks 
	        from banners b
	        inner join bannerSize a on a.id = b.adsize
	        Where  active = 1
	
	    	<cfif arguments.global eq 1>
		        and global = 1 
	        <cfelse>
		        and communityID = #request.community.communityID#
	        </cfif>
	    </cfquery>
	
		<cfreturn bannerDetail>
	</cffunction>

    <cffunction name="getBanner">
    	<cfargument name="width">
    	<cfargument name="height">
        <cfargument name="placement">

    	<cfset var bannerDetail = ''>
	
	    <cfquery datasource="#variables.datasource#" name='bannerDetail'>
	        Select  code,b.ID,adsize,views 
	        from banners b
	        inner join bannerSize a on a.id = b.adsize and a.height = #arguments.height# and a.width = #arguments.width#
	        Where  active = 1
			and b.placement = '#arguments.placement#'
	
	        <!--- Community Specific or Global depending on ads setting ---> 
	        <cfif application.community.settings.getValue('Ads') eq 1>
	        	and communityID = #request.community.communityID#
	        <cfelse>
		        and global = 1  
		        and siteCategory like '%#request.community.categoryid#%'
	        </cfif>
	    
	        Order by views
	        limit 1
	    </cfquery>

	    <!--- if we ran a banner, lets update its stats --->
    	<cfif bannerDetail.recordcount neq 0>   
		    <cfquery datasource="#variables.datasource#">
		       update banners
		       set views = views + 1
		       where ID = #bannerdetail.id#
	     	</cfquery>
		</cfif>
		<cfreturn bannerDetail>
	</cffunction>

    <cffunction name="saveBanner">
    	<cfargument name="data">
        <cfscript>
			return variables.myDAO.saverecord('banners', arguments.data);
		</cfscript>
    </cffunction>
	
    <cffunction name="deleteBanner">
    	<cfargument name="ID">
        <cfscript>
			return variables.myDAO.deleterecord('banners', arguments);
		</cfscript>
    </cffunction>
</cfcomponent>