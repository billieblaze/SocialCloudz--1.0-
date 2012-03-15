<cfcomponent extends="../baseGateway">
	<cffunction name="get">
		<cfargument name="page" default="">
      	<cfargument name="settingID" default="">
      	<cfargument name="communityID" default="#request.community.communityID#">
    	<cfargument name="settingGroup" default="">  
		<Cfargument name="contentType" default="">
		<Cfset var q_get = ''>
	    <cfquery datasource="#this.datasource#" name="q_get">
		    SELECT     pl.ID as settingID, pl.settingtype, pl.description, pl.name, pl.valuelist, pl.settingGroup,
		   			   IFNULL(p.value, pl.defaultvalue) AS value
			
			FROM      pageSettingList  AS pl 
		    
		    LEFT JOIN   pageSettings  AS p  ON p.settingID = pl.ID and p.communityID = #arguments.communityID# and p.page = '#arguments.page#'
			
		   	where 1=1 
	
		    <cfif arguments.settingID neq ''> 
		    and pl.ID = '#arguments.settingID#'
		    </cfif>
	
		    <cfif arguments.settingGroup neq ''>
		    and pl.settingGroup = '#arguments.settingGroup#'
		    </cfif>
		    
			and  (pl.page = 'any' or pl.page = '#arguments.page#'
				<cfif arguments.contentType neq ''>
					or (
							(pl.page = 'content' and p.page = '#arguments.page#')	
						or 
							(pl.page = 'content')
						)	
				</cfif>
				
			)
			
			
		    order by p.page, settingGroup, sortorder
		
	    </cfquery>

	    <cfreturn q_get>
    </cffunction>

	<cffunction name="check">
		<cfargument name="name">
		<cfargument name="page" default="">		
				<Cfset var q_get = ''>
	     <cfquery dbtype="query" name="q_get">
		     select top 1 value, 
		     		'#arguments.name#' as name 
		     from request.page.settings
		     where name = '#arguments.name#'
	     </cfquery>
	
	     <cfreturn q_get.value>
    </cffunction> 

    <cffunction name="save">
	   	<cfargument name="dataStruct">
		<cfargument name='communityID' default="#request.community.communityID#">
		<Cfset var q_get = ''>
		<Cfset var getSettingList = ''>
		<cfset var idlist = ''>
		<Cfset var fieldList = ''>
		<cfset var typeList = ''>
		<cfset var data = structNew()>
		<cfset var i = 0>
		
	    <cfquery name="getSettingList" datasource="#this.datasource#">
		   	select id, name, settingtype 
		   	from pageSettingList
	        where(page = '#arguments.datastruct.page#'  or page = 'any'
				<cfif isdefined('arguments.datastruct.contentType') and arguments.datastruct.contentType neq ''>
					or page = 'content'
				</cfif>
			)	
	    </cfquery>
		
	    <cfset idlist = valuelist(getSettingList.ID)>
    	<cfset fieldlist = valuelist(getSettingList.name)>
		<cfset typelist = valuelist(getSettingList.settingtype)>
    
        <cfscript>
			for( i=1; i lte listlen(fieldlist); i=i+1){
					if(isdefined('datastruct.#listgetat(fieldlist,i)#')){
						data = structnew();
						data.communityID = arguments.communityID;
						data.settingID =  listgetat(idlist,i);
						data.value = evaluate('datastruct.#listgetat(fieldlist,i)#');
						data.type = listgetat(typelist,i);					
						data.page = arguments.datastruct.page;
						if(data.value neq ''){
							super.save('pageSettings', data);	
						}
						structclear(data);
					}
			}

		</cfscript>

   	</cffunction>
</cfcomponent>