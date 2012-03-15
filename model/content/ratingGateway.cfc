<cfcomponent extends="../baseGateway">
	
	<cffunction name="addRating" access="remote">
		<cfargument name="fkID">
		<cfargument name="fkType">
		<cfargument name="memberID">	
		<cfargument name="rating">
		<cfset var data = structNew()>
		<cfquery datasource='#this.datasource#'>
			insert into ratings
			(FKID, FKType, memberid, rating, dateEntered)
			values
			(#arguments.fkID#, '#arguments.fkType#', #arguments.memberID#, #arguments.rating#, #createodbcdatetime(now())#)
		</cfquery>
	
		<cfscript>
			if (arguments.fktype eq 'content'){ 
				data.ratingAverage = this.average(argumentcollection = arguments);
				data.contentID = arguments.fkid;
				application.content.save(data);
			}
		</cfscript>
	
	</cffunction>
	
	<cffunction name="checkVote">
		<cfargument name="memberID">	
		<cfargument name="fkID">
		<cfargument name="fkType">
		<cfset var q_checkVote = ''>
		<cfquery name="q_checkVote" datasource='#this.datasource#'>
		select id from ratings
		where memberID = #arguments.memberid#
		and fkid = #arguments.fkID#
		and fkType = '#arguments.fkType#'
		</cfquery>
	
		<cfif q_checkVote.recordcount eq 0>
			<cfreturn 0>
		<cfelse>
			<cfreturn 1>
		</cfif>	
	</cffunction>
	
	<cffunction name="average">
		<cfargument name="fkID">
		<cfargument name="fkType">
		<cfset var q_average = ''>
		<cfquery name="q_average" datasource='#this.datasource#'>
			select ifnull(count(id),1) as count, ifnull(sum(rating),3) as rating
			from ratings
			where fkid = #arguments.fkID#
			and fkType = '#arguments.fkType#'
			group by fkid, fktype
		</cfquery>
		<cfif q_average.recordcount eq 0>
			<cfreturn 3>
		<cfelse>
			<cfreturn round(q_average.rating / q_average.count)> 
		</cfif>
	</cffunction>
</cfcomponent>