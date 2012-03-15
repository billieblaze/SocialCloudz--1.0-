<cfcomponent extends="../baseGateway">
	
	<cffunction name="get">
       <cfargument name="moduleSettingID" default="">
		<Cfset var q_get = ''>
	        <cfquery datasource="#this.datasource#" name="q_get">
	            select iFnull(ms.title, m.title) as title, file, ifnull(displayrows,6) as displayrows,displaylayout,contenttype,accesslevel,ifnull(thumbsize,75) as thumbsize, ifnull(sort,'dateCreated') as sort, ifnull(displaymember,'') as displayMember, displaycontentID, ifNull(displaytemplate, defaultTemplate) as displayTemplate, m.icon, ms.moduleID, ms.id as modulesettingID, displayTag, displayCategoryID,featured, ms.active, h.html, ms.id as msid, editfile, displaysorting, thumbalign, sortDirection, displayRecordcount, ifNull(displayProfileType,0) as displayProfileType, ifNull(isContent,0) as isContent, operator from modules m
	            inner join modulesettings ms on ms.moduleID = m.moduleID
				left join module_html h on h.id = ms.id

			
				<cfif arguments.moduleSettingID neq ''>
	          	  where ms.ID = #arguments.moduleSettingID#
				<cfelse>
	        	    where ms.communityID = #request.community.communityID#
	            </cfif>
	        </cfquery>
        <cfreturn q_get>
    </cffunction>
	
	<cffunction name="getExisting">
       <cfargument name="moduleSettingID" default="">
	<Cfset var q_Get = ''>
        <cfquery datasource="#this.datasource#" name="q_get">
            select iFnull(ms.title, m.title) as title, file, ifnull(displayrows,6) as displayrows, displaylayout,ifnull(sort,'dateCreated') as sort, ifnull(displaymember,'') as displaymember, displaycontentid, ifNull(displaytemplate, defaultTemplate) as displayTemplate, m.icon, ms.moduleID, ms.id as modulesettingID, editfile,displaysorting, thumbalign, sortDirection, displayRecordcount, ifNull(displayProfileType,0) as displayProfileType, ifNull(isContent,0) as isContent, operator from modules m
            inner join modulesettings ms on ms.moduleID = m.moduleID
			where 1=1
			<cfif arguments.moduleSettingID neq ''>
            and ms.ID = #arguments.moduleSettingID#
			<cfelse>
            and ms.communityID = #request.community.communityID#
            </cfif>
            order by title
        </cfquery>
        <cfreturn q_get>
	</cffunction>
	
	<cffunction name="getContext">
       <cfargument name="moduleSettingID" default="">
	<cfset var q_Get = ''>
       <cfquery datasource="#this.datasource#" name="q_get">
    	   select page from modulepage 
       	where modulesettingID = #arguments.modulesettingID#
       </cfquery>
       <cfreturn valuelist(q_get.page)>
    </cffunction>
	
    <cffunction name="list">
	    <cfargument name="page">
	    <cfargument name="contentType">
   		<Cfset var q_get = ''>
    	<cfquery datasource="#this.datasource#" name="q_get" >
        	select * from modules
            where active = 1
			<Cfif arguments.contentType neq ''>
				and contentType = '#arguments.contentType#'
			<cfelse>
				and (contenttype is null or contentType not like  '%_detail')
			</cfif>	
			
			order by title
        </cfquery>
     
	    <cfreturn q_get>
    </cffunction>
	
	<cffunction name="getByList">
		<cfargument name="page" >
		<cfargument name="list">
		<Cfargument name="communityID" default="#request.community.communityID#">
		<cfset var qGetModules = ''>
		<cfquery datasource="#this.datasource#" name="qGetModules">
        	select ms.ID as msID, m.moduleID, m.contentType, m.editFile, m.file,m.moduleType, displayLayout,ifnull(ms.title, m.title) as title,
			sortorder,accesslevel, ifnull(displayrows,10) as displayrows,sort,displaymember,displaytag, displaycategoryid, 
			ifNull(displaytemplate, defaultTemplate) as displayTemplate, ifNull(thumbsize, 75) as thumbsize, displaycontentid,featured,ms.active,list, mp.page, displaysorting, thumbalign, sortDirection, displayRecordcount, ifNull(displayProfileType,0) as displayProfileType, ifNull(isContent,0) as isContent, operator
			from modulesettings ms
            inner join modules m on ms.moduleID = m.moduleID
            inner join modulepage mp on mp.modulesettingID = ms.id
        
		    where 1=1 

			<cfif isdefined('arguments.page') and  arguments.page neq ''>
				and mp.page = '#arguments.page#' 
			</cfif>
		
			<cfif isdefined('arguments.page') and  arguments.list neq ''>
    	        and list = '#arguments.list#' 
			</cfif>
        
		    and mp.communityID = #arguments.communityID#
        
		    order by list asc, sortorder asc
        </cfquery>

		<cfreturn qGetModules>
	</cffunction>
	
	<cffunction name="savePage">
		<cfargument name="data">
		<cfscript>
				return super.save('modulepage', arguments.data); 
		</cfscript>
	</cffunction>
	
	<cffunction name="updateSettings">
		<cfargument name="data">
		<Cfargument name="action" default="update" hint="insert/update">
      	<cfscript>
			arguments.data.moduleSettingId = super.save('modulesettings', arguments.data, arguments.action);
	
			if(structKeyExists(arguments.data, 'html')){
				super.save('module_html',arguments.data);
			}
			
			if(structKeyExists(arguments.data, 'feed')){
				super.save('module_rss',arguments.data);
			}
			
			return arguments.data.moduleSettingId;
  		</cfscript>  
    </cffunction>
	
    <cffunction name="copy">
    	<cfargument name="list" default="">
        <cfargument name="moduleSettingID" default="">
        <cfargument name="page" default="">
	   		<Cfset var getMaxSortOrder = ''>
	   	<cfquery datasource="#this.datasource#" name="getMaxSortOrder">
		   select ifNull(max(sortorder),0) as sortorder 
		   from modulepage 
		   where list = #arguments.list# 
		   and page = '#arguments.page#'             
		   and communityID = #request.community.communityID#
		</cfquery>

   		<cfscript>
			arguments.communityID = request.community.communityID;
			arguments.sortorder = getMaxSortOrder.sortOrder;
			return this.savePage(arguments); 
		</cfscript>	
    
    </cffunction>
	
	<cffunction name="deleteFromList">
	   	<cfargument name="moduleSettingID">
	    <cfargument name="List">
	    <cfargument name="page">
	    <cfquery datasource="#this.datasource#">
          delete from modulepage 
          where modulesettingid not in (#modulesettingID#) 
          and page = '#arguments.page#'            
          and list = #arguments.list#
          and communityID = #request.community.communityID#
	   </cfquery>	
   </cffunction>

	<cffunction name="cleanupPage">
				<Cfset var q_check = ''>
   		<cfquery datasource="#this.datasource#" name="q_check">
		    delete from modulesettings
		    where ID not in (select modulesettingID from modulepage where communityID = #request.community.communityID#)
		    and communityID = #request.community.communityID#
	    </cfquery>
    </cffunction>
	
	<cffunction name="delete">
		<cfargument name='moduleSettingID'>

		<cfquery datasource='#this.datasource#'>
		delete from modulesettings 
		where ID = #arguments.modulesettingID#
		</cfquery>
	
		<cfquery datasource='#this.datasource#'>
		delete from modulepage 
		where modulesettingID = #arguments.modulesettingID#
		</cfquery>
    </cffunction>
	
    <cffunction name="getHTML">
    	<cfargument name="ID">
		<Cfset var q_get = ''>
			<cfquery datasource="#this.datasource#" name="q_get">
	        	select html from module_html 
				where ID = #arguments.ID#
	        </cfquery>
			
	        <cfreturn q_get.html>
    </cffunction>

    <cffunction name="getRSS">
    	<cfargument name="ID">
        		<Cfset var q_get = ''>
        <cfquery datasource="#this.datasource#" name="q_get">
    	    select feed from module_rss 
			where ID = #arguments.ID#
        </cfquery>
        <cfreturn q_get.feed>
    </cffunction>
	
</cfcomponent>