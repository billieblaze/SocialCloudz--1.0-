<cfcomponent>
	<cffunction name="init" returntype="forum">
    	<cfargument name="datasource">
        <cfset variables.myDAO = createobject('component', 'model.DataMgr.DataMgr_MYSQL').init(arguments.datasource)>
		<cfset variables.datasource = arguments.datasource>
        <cfreturn this>
    </cffunction>
	
	<cffunction name="getSections">
	    <cfargument name="sectionID" default="">
        <cfargument name="communityID" default="#request.community.communityID#">
		<cfset var q_get = ''>
        <cfquery datasource="#variables.datasource#" name="q_get">
		select * from forumSections fs
		where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
        <cfif arguments.sectionID neq ''>
        and ID = #arguments.sectionID#
        </cfif>
        order by sortOrder
		</cfquery>

		<cfreturn q_get>
    </cffunction>

    <cffunction name="saveSection">
		<cfargument name="data">
        <cfscript>
			variables.myDAO.saverecord('forumSections', arguments.data);
		</cfscript>
    </cffunction>
	
    <cffunction name="deleteSection">
		<cfargument name="data">

        <cfscript>
		variables.myDAO.deleterecord('forumSections', arguments.data);
		</cfscript>
    </cffunction>

    <cffunction name="getForums">

        <cfargument name="section" type="string" required="no">
   		<cfargument name="communityID" default="#request.community.communityID#">
		<cfset var getForums = ''>
		<cfquery datasource="#variables.datasource#" name="getForums">
		select *
		 from forum_list f


		where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
        <cfif isdefined('arguments.section')>
	<cfif section neq 0>
	    	and sectionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#section#">
    	<cfelse>
     		and sectionID = 0
	    </cfif>
	</cfif>
    	order by sortOrder

        </cfquery>

		<cfreturn getForums>

    </cffunction>

    <cffunction name="saveForum">
    		<cfargument name="data">

        <cfscript>
		variables.myDAO.saverecord('forums', arguments.data);
		</cfscript>

    </cffunction>
    <cffunction name="deleteForum">
    		<cfargument name="data">

        <cfscript>
		variables.myDAO.deleterecord('forums', arguments.data);
		</cfscript>
    </cffunction>

 <cffunction name="GetForum">
	<cfargument name="forumID">
			<cfset var forum = ''>
	<cfquery name="forum" datasource="#variables.datasource#">
	select * from forums where ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#forumID#">
	</cfquery>

	<cfreturn forum>
	</cffunction>
    <cffunction name="getThread">
	<cfargument name="ID" default="">
		<cfset var topics = ''>
	<cfquery name="topics" datasource="#variables.datasource#">
	select * from forumPosts
	where

    ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ID#">
    or postID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ID#">
    order by postID



	</cfquery>

	<cfreturn topics>
	</cffunction>



    <cffunction name="getTopics">
	<cfargument name="forumID" default="">
	<cfargument name="limit" default="">
	<cfargument name="sticky" default="1">
			<cfset var topics = ''>
	<cfquery name="topics" datasource="#variables.datasource#">
	select distinct fp.* from postlist fp
	inner join forums f on f.id = fp.forumID
	where 1=1
    <cfif arguments.forumID neq ''>
    and forumID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.forumID#">
	</cfif>
	and f.communityID = #request.community.communityID#
    order by <cfif arguments.sticky eq 1>sticky desc,</cfif>  maxdate desc

	 <cfif arguments.limit neq ''> limit #arguments.limit#</cfif>
</cfquery>

	<cfreturn topics>
	</cffunction>

    <cffunction name="savePost">
    <cfargument name="data">

    <cfscript>
		return variables.myDAO.saveRecord('forumPosts', arguments.data);
	</cfscript>
    </cffunction>

    <cffunction name="deletePost">
    	<cfargument name="data">
        <cfscript>
			variables.myDAO.deleterecord('forumPosts', arguments.data);
		</cfscript>

    </cffunction>

    <cffunction name="getTopic">
    <cfargument name="ID">
	<cfscript>
	return variables.myDAO.getRecords('forumPosts', arguments);
	</cfscript>

	<cfreturn Topic>
    </cffunction>

    <cffunction name="checkSubscription">
    <cfargument name="topicID">
  	<cfargument name="memberID" default="#request.session.memberID#">
		<cfset var checkSubscription = ''>
        <cfquery datasource="#variables.datasource#" name="checkSubscription">
                select * from forumSubscriptions
                where memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
                and topicID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicID#">
        </cfquery>
    <cfreturn checkSubscription>
    </cffunction>
    <cffunction name="getSubscriptions">
   	 <cfargument name="topicID">
		<cfset var checkSubscription = ''>
        <cfquery datasource="#variables.datasource#" name="checkSubscription">
                select s.memberID,title from forumSubscriptions s
                inner join forumPosts p on p.id = s.topicid
                where topicID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicID#">
        </cfquery>
    <cfreturn checkSubscription>
    </cffunction>

    <cffunction name="subscribeTopic">
		<cfargument name="memberID">
        <cfargument name="topicID">
        <cfargument name="action">

		<cfscript>
        if (arguments.action eq 1){
			variables.myDAO.saverecord('forumSubscriptions', arguments);
		} else {
			variables.myDAO.deleterecord('forumSubscriptions', arguments );
		}
		</cfscript>
    </cffunction>
    <cffunction name="stickyTopic">
		<cfargument name="action">
    	<cfargument name="topicID">

    	<cfquery datasource="#variables.datasource#">
		update forumPosts
		set sticky = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.action#">
		where ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicID#">
		</cfquery>


    </cffunction>
    <cffunction name="lockTopic">
		<cfargument name="action">
    	<cfargument name="topicID">

    	<cfquery datasource="#variables.datasource#">
		update forumPosts
		set locked = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.action#">
		where ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicID#">
		</cfquery>

    </cffunction>
   	<cffunction name="updateViews">
		<cfargument name="topicID">
		<cfquery datasource="#variables.datasource#">
		update forumPosts
		set views = views + 1
		where ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.topicID#">
		</cfquery>
	</cffunction>
    	<cffunction name="getforumsection" access="public" returntype="query">
		<cfargument name="forumID" type="string" required="yes">
		<cfset var getSections = ''>

        <cfquery datasource="#variables.datasource#" name="getSections">
		select *
		 from forumSections fs
		inner join forums f on f.sectionID = fs.id

		where f.ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.forumID#">

		</cfquery>


		<cfreturn getSections>
	</cffunction>
	<cffunction name="getModerators">
		<cfargument name="forumID">
		<cfset var qGet = ''>
		<cfquery  name="qGet" datasource="#variables.datasource#">
			select memberID, id from forumModerators
			where forumID = #arguments.forumID#
		</cfquery>
		
		<cfreturn qGet>
	</cffunction>
<cffunction name="saveModerator">
<cfargument name="datastruct">
<cfscript>
variables.myDAO.saverecord('forumModerators', arguments.datastruct);
</cfscript>
</cffunction>
<cffunction name="deleteModerator">
<cfargument name="datastruct">
<cfscript>
	variables.myDAO.deleterecord('forumModerators', arguments.datastruct);
</cfscript>
</cffunction>
<cffunction name="ismoderator">
	<cfargument name="memberID">
	<cfargument name="forumID">
	<cfset var qGet = ''>
	<cfquery datasource="#variables.datasource#" name="qGet">
	select count(id) as count from forumModerators
	where memberID = '#arguments.memberID#'
	and forumID = '#arguments.forumID#'
	</cfquery>
	<cfreturn qGet.count>
</cffunction>
</cfcomponent>
