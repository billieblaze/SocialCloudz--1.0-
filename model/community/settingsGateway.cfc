<cfcomponent extends="../baseGateway" >

 	<cffunction name="getValue" output="false">
    	<cfargument name="settingID">
		<cfargument name="Qrysettings" default="#request.community.settings#">

	    <cfset var q_get = ''>

	    <cfquery dbtype="query" name="q_get">
		     select [value] from arguments.Qrysettings
	    	 where name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.settingID#">
	    </cfquery>

	    <cfreturn q_get.value>
    </cffunction> 

    <cffunction name="get">
	    <cfargument name="settingID" default="">
	    <cfargument name="settingType" default="">
	    <cfargument name="communityID" default="">
		<cfargument name="mode" default="detail" hint="simple|detail">
		
		<cfset var get = ''>
	    
	    <cfquery datasource="#this.datasource#" name="get">
	    SELECT     
		
			cl.settingID, IFNULL(c.value, cl.defaultvalue) AS value, cl.name, cl.valuelist,cl.settingType, cl.description

		FROM      communitysettinglist  AS cl 
	    LEFT JOIN   communitysettings  AS c  ON c.settingID = cl.settingID 
	    	<cfif arguments.communityID neq ''> 
			    and c.communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
		    </cfif>
		    
	   	where 1=1 

	    <cfif arguments.settingID neq ''> 
		    and cl.settingID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.settingID#">
	    </cfif>
	    
	    <cfif arguments.settingType neq ''> 
	    	and cl.settingType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.settingType#">
	    </cfif>
	    order by sortorder
		
	    </cfquery>
		<cfreturn get>
    </cffunction>

    <cffunction name="getChild">
	  	<cfargument name="feature">
    	<cfargument name="communityID" default="#request.community.communityID#">
	    
	    <cfset var get = ''>
	    
	    <cfquery datasource="#this.datasource#" name="get">
	    SELECT     cl.settingID, IFNULL(c.value, cl.defaultvalue) AS value, cl.name, cl.valuelist, cl.description
		FROM      communitysettinglist  AS cl 
	    LEFT JOIN   communitysettings  AS c  ON c.settingID = cl.settingID 
	    		<cfif arguments.communityID neq ''> 
			    and c.communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
			    </cfif>

	   	where 1=1 
	    and cl.settingType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.feature#">
	
	    order by sortorder
		
	    </cfquery>
	    <cfreturn get>
    </cffunction>
	
	<cffunction name="save">
	<cfargument name="datastruct">
    <cfset var idlist = ''>
	<cfset var fieldList = ''>
	<cfset var typeList = ''>
	<cfset var i = 1>
	<cfset var data = structNew()>
	<cfset var getSettingList = ''>
	
	<cfquery name="getSettingList" datasource="#this.datasource#">
	   	select settingid, name, settingtype from communitysettinglist 
    </cfquery>
	
    <cfset idlist = valuelist(getSettingList.settingID)>
    <cfset fieldlist = valuelist(getSettingList.name)>
	 <cfset typelist = valuelist(getSettingList.settingtype)>

        <cfscript>
			for( i=1; i lte listlen(fieldlist); i=i+1){
				if(listcontainsnocase(fieldlist, listgetat(fieldlist,i))){
					if(isdefined('datastruct.#listgetat(fieldlist,i)#')){
					data = structnew();
					data.communityID = arguments.datastruct.communityID;
					data.settingID =  listgetat(idlist,i);
					data.value = evaluate('datastruct.#listgetat(fieldlist,i)#');
					data.type = listgetat(typelist,i);					
					if(Data.value neq ''){
						super.save('communitysettings', data);	
					}
					structclear(data);
					}
				}
			}
			
	</cfscript>

        
    </cffunction>
</cfcomponent>