<cfcomponent>
	<cffunction name="init" access="public" output="false" >
		<cfargument name="datasource" default="socialcloudz">  
		<cfset variables.myDAO = createobject('component', 'DataMgr.DataMgr_MYSQL').init(arguments.datasource)> 
  		<cfset variables.datasource = arguments.datasource>

		<cfreturn this>
	</cffunction>

    <cffunction name="getHelp">
		<cfargument name="linkID">
		<Cfset var qGet = ''>
		<cfset arguments.linkID = rereplace(arguments.linkID, "[^A-Za-z]+", "", "all")>
		
		<cfquery datasource="#variables.datasource#" name="qGet">
			select text from help
			where linkID = '#arguments.linkID#'
		</cfquery>
		
		<cfif qGet.recordcount eq 0>
			<cfreturn "No help area defined yet">
		<cfelse>
			<cfreturn qGet.text>
		</cfif>
    </cffunction>
	
	<cffunction name='getSupport'>
		<Cfset var qGet = ''>
		<cfquery name='qGet' datasource='#variables.datasource#'>
			select * from support
			where dateEntered > '#dateformat(dateadd('d',-3,application.timezone.castFromServer(now(), application.community.settings.getValue('timezone'))),'yyyy-mm-dd')#'
			order by dateEntered desc
			limit 1
		</cfquery>
		<cfreturn qGet>
	</cffunction>

	<cffunction name="getAllSupport">
		<Cfset var qGet = ''>
		<cfquery name='qGet' datasource='#variables.datasource#'>
			select * from support
			order by dateEntered desc
		</cfquery>
		<cfreturn qGet>
	</cffunction>
	
	<cffunction name="saveSupport">
		<cfargument name="datastruct">
		<cfscript>
			arguments.datastruct.memberID = request.session.memberid;
			variables.myDAO.saverecord('support',arguments.datastruct);
		</cfscript>	
	</cffunction>
	
	<cffunction name="deleteSupport">
		<cfargument name="memberID">
		<cfscript>
			variables.myDAO.deleterecord('support',arguments);
		</cfscript>
	</cffunction>

	<cffunction name="getHelpSections">
		<cfargument name="id" default="">
	    <cfargument name="type" default="">
	    <cfset var qHelp = ''>
	    <cfquery datasource="#variables.datasource#" name="qHelp">
			select *, (select count(id) from helpTopics ht where ht.sectionID = hs.iD) as count from helpSections hs
	        where 1=1
	        
	        <cfif arguments.type neq ''> 
	        	and type = '#arguments.type#'
	        </cfif>
	        
	        <cfif arguments.id neq ''> 
	       		and id = '#arguments.id#'
	        </cfif>
		</cfquery>  
	    <cfreturn qHelp>
	</cffunction>
	
	<cffunction name="getHelpTopics">
		<cfargument name="id" default="">
		<cfargument name="sectionid" default="">     
		<cfargument name="limit" default="">
	   	<cfargument name="order" default="">
	    <cfargument name="type" default="">
	    <Cfset var q_getTopics = ''>
	    <cfquery name="q_getTopics" datasource="#variables.datasource#">
	    	select t.*, s.title as sectionTitle, s.id as sectionID from helpTopics t
	        inner join helpSections s on s.id = t.sectionID
	        where 1=1 
	        
	        <cfif arguments.id neq ''>
	       	 	and t.id = #arguments.id#
	        </cfif>
	        
	        <cfif arguments.sectionid neq ''>
	       	 	and t.sectionid = #arguments.sectionid#
	        </cfif>
	        
	        <cfif arguments.type neq ''>
	       	 	and s.type = '#arguments.type#'
	        </cfif>
	        
	        <cfif arguments.order neq ''>
		        order by #order# desc
	        </cfif>
	        
	        <cfif arguments.limit neq ''>
	       		limit #arguments.limit#
	        </cfif>
	    </cfquery>
		<cfreturn q_getTopics>
	</cffunction>

	<cffunction name="saveHelp">
		<cfargument name="dataStruct">
	    <cfscript>
		return variables.myDAO.saveRecord('helpTopics', arguments.datastruct);
		</cfscript>
	</cffunction>
</cfcomponent>