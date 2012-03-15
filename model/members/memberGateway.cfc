<cfcomponent extends="../baseGateway">
	<cffunction name="get" access="remote" output="no">
		<cfargument name="memberID" default="">
		<cfargument name="email" default="">
		<cfargument name="password" default="">
		<cfargument name="username" default="">
		<cfargument name="page" default="1">
		<cfargument name="limit" default="0">
	     <cfargument name="countonly" default="">
		<cfargument name="identity" default="">
		<cfscript>
			var qry = '';
		if (arguments.page eq '') {arguments.page = 1;}
		
			if (isdefined('arguments.limit')) startrow = arguments.page * arguments.limit - arguments.limit;
		</cfscript>
	
	    <cfquery datasource="#this.datasource#" name="qry">
	        select <cfif arguments.countonly eq ''>*<cfelse>count(memberid) as count</cfif> from members m
	
	        where 1=1
	        
	        <cfif arguments.memberID neq ''>
	        	and m.memberid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
	        </cfif>
	
	        <cfif arguments.email neq ''>
	        	and email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
	        </cfif>

	        <cfif arguments.password neq ''>
		        and password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#">
	        </cfif>
	
	        <cfif arguments.username neq ''>
		        and username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
	        </cfif>
	        
			<cfif arguments.identity neq ''>
		        and identity = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.identity#">
	        </cfif>
	        
			<cfif arguments.limit neq 0 and arguments.limit neq ''>
				limit #startrow#, #arguments.limit#
			</cfif>
	
	    </cfquery>
		<cfreturn qry>
	</cffunction>
	
	<cffunction name="list" access="remote" returntype="query">
		<cfargument name="memberID" default="">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="email" default="">
		<cfargument name="password" default="">
		<cfargument name="username" default="">
		<cfargument name="limit" default="0">
		<cfargument name="sort" default="m.memberid asc">
		<cfargument name="groupid" default="">
		<cfargument name="banned" default="">
		<cfargument name="approved" default="">
		<cfargument name="flagged" default="">
		<cfargument name="online" default="0">
		<cfargument name="search" default="">
		<cfargument name="countonly" default="">
		<cfargument name="page" default="1">
		<cfargument name="featured" default="0">
		<cfargument name="country" default="">
		<cfargument name="radius" default="">
		<cfargument name="latitude" default="">
		<cfargument name="longitude" default="">
		<cfargument name="gender" default="">
		<cfargument name="age1" default="">
		<cfargument name="age2" default="">
		<cfargument name="accesslevel" default="">
		<cfargument name="profileType" default="">
		<cfargument name="rows" default="">
		<cfargument name="state" default="">
		<cfargument name="questionID" default="">
		<cfargument name="questionValue" default="">
		<cfargument name="showInvisible" default="1">
		
		<cfscript>
			var qry = '';
			if (arguments.rows neq ''){ arguments.limit = arguments.rows;}
			if (arguments.page eq '') {arguments.page = 1;}
			if (isdefined('arguments.limit')) startrow = arguments.page * arguments.limit - arguments.limit;
		</cfscript>
		
		<cfquery datasource="#this.datasource#" name="qry">
			select  SQL_NO_CACHE
			<cfif arguments.countonly neq ''>
		    		COUNT(distinct(m.memberID)) as count
		     <cfelse>
				*, (select count(memberID) as b1 from ban b  where b.memberID = ma.memberID and b.communityID = ma.communityID) as banned
		        <cfif arguments.latitude neq '' and arguments.longitude neq ''>
		        , getDistance( m.latitude,m.longitude, '#arguments.latitude#', '#arguments.longitude#') as distance
		        </cfif>
						        
			</cfif>

		   	from members m
		    inner join membersaccount ma on 
		    	m.memberid = ma.memberID 
		    	
				and ma.communityID = (select communityID from membersaccount ma2 where ma2.memberID = ma.memberID <cfif arguments.communityId neq 0>
			    	and (
			    		ma2.communityID = #arguments.communityID# 
			    		or 
			    		ma2.communityID in (select communityID from community.community where parentID = '#arguments.communityID#')
			    		)
				</cfif> order by lastclick desc limit 1)
				
		    inner join access a on a.memberID = ma.memberID and a.communityID = ma.communityID
		 	
		 	<cfif arguments.questionID neq '' and arguments.questionValue neq ''>
			inner join profileAnswers pa on m.memberID = pa.memberID and pa.questionID = #arguments.questionID#
			</cfif>

			where 1=1
			<cfif showInvisible eq 0>
				and ma.invisible = 0 
			</cfif>
			
		    <cfif arguments.memberID neq ''>
		   		and m.memberid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
		    </cfif>
	
			<cfif arguments.username neq ''>
		   		and m.username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
		    </cfif>
		
		    <cfif arguments.banned neq ''>
			   	and banned != 0	
		    </cfif>
		    
		    <cfif arguments.approved neq ''>
			    and ma.approved = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.approved#">
		    </cfif>
		    
		    <cfif arguments.flagged neq ''>
		    	and ma.flagged = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.flagged#">
		    </cfif>
		    
			<cfif arguments.online eq 1>
		    	and ma.online = 1
		    </cfif>
		    
			<cfif arguments.featured eq 1>
			and ma.featured = 1
			</cfif>
			
			<cfif arguments.search neq ''>
				and (m.firstname like '%#arguments.search#%' or m.lastname like '%#arguments.search#%' or m.username like '%#arguments.search#%')
			</cfif>
			
			<cfif arguments.state neq '' and arguments.state neq 0>
				and m.state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.state#">
			</cfif>
			
			<cfif arguments.country neq '' and arguments.country neq 'US'>
		    	and m.country = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.country#">
		    <cfelse>
				<cfif arguments.radius neq '' and arguments.latitude neq '' and arguments.longitude neq ''> 
		           and getDistance( m.latitude,m.longitude, '#arguments.latitude#', '#arguments.longitude#') <= <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.radius#">
		        </cfif>
			</cfif>
		    
		    <cfif arguments.gender neq ''>
		    	and gender = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.gender#">
		    </cfif>
		    
		    <cfif arguments.accesslevel neq ''>
		    	and accesslevel = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.accesslevel#">
		    </cfif>
		    
		    <cfif arguments.profileType neq '' and arguments.profileType neq 0>
		    	and profileType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.profileType#">
		    </cfif>
		    
		    <cfif arguments.age1 neq '' and arguments.age2 neq ''>
		    	and (YEAR(CURDATE())-YEAR(birthdate)) - (RIGHT(CURDATE(),5) < RIGHT(birthdate,5))
		 			between <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.age1#"> 
			        and <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.age2#">
		    </cfif>
		    
		    <cfif arguments.questionID neq '' and arguments.questionValue neq ''>
		    	and pa.value like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.questionValue#%">
		    </cfif>
		    
			order by  #arguments.sort#
			
			<cfif arguments.countOnly eq '' and arguments.limit neq 0 and arguments.limit neq ''>limit <cfqueryparam cfsqltype="cf_sql_integer" value="#startrow#">
				, <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.limit#">
			</cfif>
		</cfquery>

		<cfreturn qry>
	</cffunction>
	
	<cffunction name="getCount" returntype="string" output="no">
    	<cfargument name="communityID" default="#request.community.communityID#">
	    <cfargument name="online" default="">
	    <Cfset var members = ''>
        <cfquery datasource="#this.datasource#" name="members">
            select count(ma.memberID) as count 
			from membersaccount ma
            inner join access a on ma.memberid = a.memberID and ma.communityID = a.communityID
            where 1=1
			 <cfif arguments.communityId neq 0>and (ma.communityID =#arguments.communityID# or ma.communityID in (select communityID from community.community where parentID = '#arguments.communityID#'))</cfif>
            and accessLevel between 0 and 199
            <cfif arguments.online neq ''>
           	 and online = 1
            </cfif>
        </cfquery>
        <cfreturn members.count>
    </cffunction>
	
    <cffunction name="save">
		<cfargument name="dataStruct">
		<cfscript>
			return super.save('members', arguments.datastruct);
	    </cfscript>
	</cffunction>
	
	<cffunction name="delete">

	</cffunction>
	
	<cffunction name='incrementLogin'>
		<cfargument name='memberID'>
		<cfargument name="communityID" default="#request.community.communityID#">
	
		<cfquery datasource='#this.datasource#'>
			update membersaccount 
			set numlogins = numlogins + 1 
			where memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
			and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
		</cfquery>
	</cffunction>
	
	<cffunction name='incrementProfileView'>
		<cfargument name='memberID'>
	
		<cfquery datasource='#this.datasource#'>
			update membersaccount 
			set profileviews = profileviews + 1 
			where memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
			and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.community.communityID#">
		</cfquery>
	</cffunction>

</cfcomponent>