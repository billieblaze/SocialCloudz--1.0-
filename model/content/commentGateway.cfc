<cfcomponent extends="../baseGateway">

    <cffunction name="get">
    	<cfargument name="fkType" default="">
        <cfargument name="fkID" default="">
        <cfargument name="memberID" default="">
        <cfargument name="communityID" default="#request.community.communityID#">
        <cfargument name="limit" default="">
        <cfargument name="sort" default="">
        <cfargument name="sortOrder" default="asc">
        <cfargument name="id" default="">
        <cfargument name="parentid" default="">
		<cfset var qComments = ''>
        <cfquery datasource="#this.datasource#" name="qComments">
        	select * from comments 
			left join commentAttachments on comments.id = commentAttachments.commentid
            where 1 = 1 
            
			<cfif arguments.id neq '' and arguments.id neq 0>
        	    and id = '#arguments.id#'
			<cfelse>
				<cfif arguments.parentid neq ''>
		            and parentid = '#arguments.parentid#'
	            <cfelse>
	    	        and parentID = 0
	            </cfif>
            </cfif>

            
            <cfif arguments.memberID neq ''>
				and memberID = #arguments.memberID#
		    </cfif>
   
        	<cfif arguments.fktype neq ''>
               and fktype = '#arguments.fktype#'
            </cfif>
               
			<cfif arguments.fkid neq ''>
    	       	and fkid = '#arguments.fkID#'
            </cfif>
                
            and communityID = '#arguments.communityID#'
                <!--- TODO:   AND SYNDICATE TO PARENT SITE config variable --->
            <cfif arguments.sort neq ''> 
            	order by #arguments.sort# #arguments.sortOrder#
            </cfif>
		    
            <cfif arguments.limit neq ''>
	             limit #arguments.limit#
            </cfif>
        </cfquery>
        <cfreturn qComments>
    </cffunction>
    
    <cffunction name="save">
    	<cfargument name="datastruct">
       	<cfscript>
			return super.save('comments', arguments.datastruct,'insert');
		</cfscript>
    </cffunction>

    <cffunction name="saveAttachment">
    	<cfargument name="datastruct">
       	<cfscript>
			return super.save('commentAttachments', arguments.datastruct);
		</cfscript>
    </cffunction>

    <cffunction name="delete">
    	<cfargument name="ID">
        <cfscript>
			return super.delete('comments', arguments);
		</cfscript>
    </cffunction>
	
</cfcomponent>