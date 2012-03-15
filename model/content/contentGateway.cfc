<cfcomponent extends="../baseGateway">
	<cffunction name="get" returntype="query" hint="I retrieve content based on any or all arguments..  there is no required arguments and it is recommended that you interface with me using named arguments.">
		<cfargument name="communityid" default="#request.community.communityID#">
		<cfargument name="contentid" default="">
		<cfargument name="contenttype" default="">
		<cfargument name="memberID" default="">
		<cfargument name="parentID" default="0">
		<cfargument name="featured" default="">
		<cfargument name="favorite" default="">
		<cfargument name="sort" default="publishdate desc">
		<cfargument name="tag" default="">
		<cfargument name="attribute" default="">
		<cfargument name="attributevalue" default="">
		<cfargument name="creator" default="">
		<cfargument name="limit" default="0">
		<cfargument name="groupid" default="">
		<cfargument name="search" default="">
		<cfargument name="taglist" default="">
		<cfargument name="page" default="1">
        <cfargument name="flagged" default="">
        <cfargument name="updateViews" default="1">
        <cfargument name="operator" default="">
        <cfargument name="countonly" default="">
        <cfargument name="categoryID" default="">
        <cfargument name="category" default="">
	   	<cfargument name="dateRangeStart" default = "">
		<cfargument name="dateRangeEnd" default = "">
		<cfargument name="approved" default =""> 
		<cfargument name="converted" default="1">
		<cfargument name="city" default="">
	    <cfargument name="state" default="">
	    <cfargument name="country" default="">
	    <cfargument name="radius" default="">
	    <cfargument name="latitude" default="">
	    <cfargument name="longitude" default="">
    	<cfargument name="friendlist" default="0">
		<cfargument name="mode" default="detail">
		<cfargument name="subtitle" default="">

		<cfscript>
		 	var qry = '';
			var selectclause = '';
			var joinclause = '';
			var whereClause = '';
			var orderClause = '';
			var nowTime  = application.timezone.castFromServer(now(), application.community.settings.getValue('timezone'));
			
			if (arguments.page eq '') {arguments.page = 1;}
			if (arguments.limit eq 0 or arguments.limit eq '') { startrow = 1;} else { startrow = arguments.page * arguments.limit - arguments.limit; }
			
			
			if (arguments.contentType neq ''){
				whereclause = whereclause & "and c.contentType = '#arguments.contentType#' ";
			}
			if (arguments.contentid neq ''){
				whereclause = whereclause & "and c.contentid = #arguments.contentid# ";
			}
			if (arguments.memberID neq ''){
				whereclause = whereclause & "and c.memberID  = '#arguments.memberid#' ";
			}
		
			if (isdefined('arguments.parentid') and arguments.parentID neq '' and arguments.parentID neq 0 and arguments.parentID neq -1){
				whereclause = whereclause & "and c.parentid = '#arguments.parentid#' ";
			} 
			
			if (isdefined('arguments.parentid') and arguments.parentid eq -1){
				whereclause = whereclause & "and c.parentid = 0 ";
			} 
			if (arguments.flagged neq ''){
				whereclause = whereclause & "and c.flagged = '#arguments.flagged#' ";
			}
			if (arguments.creator neq ''){
				whereclause = whereclause & "and sa.creator = '#arguments.creator#' ";
			}
			if (arguments.subtitle neq ''){
				whereclause = whereclause & "and sa.subtitle = '#arguments.subtitle#' ";
			}
			if (arguments.featured neq ''){
				whereclause = whereclause & "and c.featured = '#arguments.featured#' ";
			}
		
			if (arguments.favorite neq ''){
				whereclause = whereclause & "and case ifnull(f.memberid,0) when 0 then 0 else 1 end = 1 ";
			}
		
			if (arguments.attribute neq '' and arguments.attributevalue neq ''){
				selectclause = selectclause & ', a.keyvalue as #arguments.attribute#';
				joinclause = joinclause & "left join attribs a   on a.contentID = c.contentID and a.keyname = '#arguments.attribute#'";
				if (isdefined('arguments.attributeValue')){
					if (arguments.contentType eq 'Restaurant' and arguments.attribute eq 'food'){
						whereclause = whereclause & "and a.keyvalue like '%#arguments.attributevalue#%' ";
					} else { 
						whereclause = whereclause & "and a.keyvalue = '#arguments.attributevalue#' ";
					}
				}
			}
		
			if (arguments.tag neq ''){
				joinclause = joinclause & "inner join tags t  on t.contentID = c.contentID  and t.value = '#arguments.tag#' ";
			}
		
			if (arguments.contentType eq 'Video'){
					joinclause = joinclause & "left join attribs aConverted  on aConverted.contentID = c.contentID and aConverted.keyname = 'converted' ";
				    if((arguments.converted eq 1 and arguments.memberID neq request.session.memberID)){
						whereclause = whereclause & "and (aConverted.keyvalue = '1' or c.memberID = '#request.session.memberID#')";
					}
			}
		
			
			if (arguments.contentType eq 'Event'){

				if( arguments.operator neq '' and arguments.contentID eq ''){
					whereclause = whereclause & 'and (startDate #arguments.operator# #dateadd('w',-1,nowTime)#  or endDate #arguments.operator# #dateAdd('w', -1, nowTime)#)';
				} else { 
					if (arguments.dateRangeStart neq ''){
						whereclause = whereclause & " and startDate >= '#arguments.dateRangeStart#'";
					}
				
					if (arguments.dateRangeEnd neq ''){
						whereclause = whereclause & " and startDate <= '#arguments.dateRangeEnd#'";
					}
				}
			} else { 
				if (arguments.dateRangeStart neq ''){
					whereclause = whereclause & " and publishdate >= '#arguments.dateRangeStart#'";
				}
			
				if (arguments.dateRangeEnd neq ''){
					whereclause = whereclause & " and publishdate <= '#arguments.dateRangeEnd#'";
				}
			
			}
		
			if (arguments.taglist neq ''){
				whereclause = whereclause & " and c.contentID in (
		            select t2.contentID from tags t2
		            inner join content c3 on c3.contentID = t2.contentID and c3.isdeleted = 0  AND c3.contentType = '#arguments.contentType#'
		            inner join community c4 on c4.contentID = c3.contentID  and c4.communityID = #request.community.communityID#
		            where  t2.value in (#listqualify(arguments.taglist,"'",",")#)
		        )";	}
		
			if (arguments.search neq ''){
				arguments.search = replace(arguments.search, "'", "''", "all");
				whereclause = whereclause & " and (title like '%#arguments.search#%'
				 or sa.desc like '%#arguments.search#%'
				 or `contentstore`.`tagsbycontentid`(c.contentID) like '%#arguments.search#%'
				 or `contentstore`.`categoriesbycontentid`(c.contentID) like '%#arguments.search#%'
				 )";
		
			}
		
			if (arguments.categoryID neq ''){
			joinclause = joinclause & " inner join contentcategory ccat1 on ccat1.contentID = c.contentID";
			whereclause = whereclause & " and ccat1.categoryId = #arguments.categoryID#";
		
			}
		
			if (arguments.category neq ''){
			joinclause = joinclause & " inner join contentcategory cc on cc.contentID = c.contentID inner join category ccat on ccat.id = cc.categoryID";
			whereclause = whereclause & " and ccat.category = '#arguments.category#'";
		
			}
		
		
	
			if (arguments.approved eq ''){
			whereclause = whereclause & ' and approved = 1';
			}
		
			if (Arguments.radius neq '' and arguments.latitude neq '' and arguments.longitude neq ''){ 
				selectclause = selectclause & ", getDistance( l.latitude,l.longitude, '#arguments.latitude#', '#arguments.longitude#') as distance";
				whereclause = whereclause & " and l.latitude != '' and l.longitude != '' and getDistance( l.latitude,l.longitude, '#arguments.latitude#', '#arguments.longitude#')  <= #arguments.radius#"
			} else { 
				if (arguments.city neq '') { 
				whereclause = whereclause & " and city = '#arguments.city#'";
			} 
			
			if (arguments.state neq '') { 
				whereclause = whereclause & " and state = '#arguments.state#'";
			} 
			
			if (arguments.country neq '') { 
				whereclause = whereclause & " and country = '#arguments.country#'";
			} 
		
			}
			
			orderclause = "order by #arguments.sort#";
	    </cfscript>
    	<cfquery datasource="#this.datasource#" name="qry">
			select
		    <cfif arguments.countonly neq ''>
		    	COUNT(c.contentID) as count
		     <cfelse>
			    c.memberid, c.contentid, c.dateCreated, c.private, c.download, c.comments,  c.explicit, c.flagged,c.approved, c.parentID, c.views, c.featured, c.contentType, ifNull(c.publishdate, c.dateCreated) as publishdate,c.rating,c.ratingaverage,c.commentCount,c.isdeleted,
				ct.linkID,ct.homelink,ct.type,ct.parentContentType,
	    		sa.title, sa.desc, sa.creator,sa.image,sa.sortOrder,sa.startdate, sa.enddate, sa.subtitle,

	   			`contentstore`.`attributesByContentID`(c.contentID) as attribs,
	            `contentstore`.`tagsbycontentid`(c.contentID) as tags,
			    `contentstore`.`categoriesbycontentid`(c.contentID) as categories,

				<cfif arguments.mode eq 'detail'>
	    	        l.venue,l.city, l.state, l.country, l.latitude, l.longitude, l.zipcode,l.phone,l.address,
	
	        	   	case ifnull(f.memberid,0) when 0 then 0 else 1 end as isFavorite,
				    `contentstore`.`categoryIDbycontentid`(c.contentID) as categoryID,
	        	    `contentstore`.`childCountByContentID`(c.contentID) as childcount,
				</cfif>
				
                (select count(memberid) from favorites where contentID = c.contentID and level = 1) as favoritecount
	            #selectClause#
			</cfif>

		    from content  c
		    inner join contenttype ct on ct.contentType = c.contentType
		    inner join standardattribs sa  on sa.contentID = c.contentID
		    
		   	 	inner join community com   on c.contentID = com.contentID  
		   	 	
				and (
		   	 		com.communityID =#request.community.communityID#
			    	or  com.communityID in (select communityID from community.community where parentID = '#request.community.communityID#')
			    	<!--- TODO:   AND SYNDICATE TO PARENT SITE config variable --->
			    	)
			    		
				<cfif arguments.mode eq 'detail'>
		
			left join location l on l.contentID = c.contentID
 		   	left join favorites f on f.contentID = c.contentID and f.memberID = #request.session.memberID#
			</cfif>  
		    #preservesinglequotes(joinClause)#

		    where 1=1 
		    
		    <cfif arguments.contentID eq ''>
		    and isdeleted = 0
		    </cfif>
 
			and (private = 0
		    	or (private = 1 and c.memberID in (#request.session.memberid#,#arguments.friendlist#))
		        or (private =1 and #request.session.accesslevel# > 9)
	        )
			<cfif arguments.approved eq ''>
				and (publishdate is null or publishdate < #now()#)
			<cfelse>
				and (publishdate is null or publishdate < #now()# or c.memberid = #request.session.memberid# or #request.session.accesslevel# > 9)
			</cfif>

		  	#preservesinglequotes(whereclause)#
			#orderclause#

			<cfif arguments.limit neq 0 and arguments.limit neq '' and arguments.countOnly neq 0>
				limit #startrow#, #arguments.limit#
			</cfif>
	    </cfquery>

	    <cfreturn qry>
	</cffunction> 
	
	<cffunction name="getArchives"> 
		<cfargument name="contentType">
		<cfargument name="memberID" default="">	
		<cfargument name="communityID" default="">	
	    <cfset var qGet = ''>
		
		<cfquery datasource="#this.datasource#" name="qGet">
			select distinct
			<cfif arguments.contentType eq 'Event'>
				month(startDate) as mymonth, year(startDate) as myyear, 
			<cfelse>
				month(ifNull(publishDate, dateCreated)) as mymonth, year(ifNull(publishDate, dateCreated)) as myyear, 
			</cfif>		
			count(c.contentID) as mycount, ct.homelink
			from content c 
			inner join contenttype ct on ct.contentType = c.contentType
			inner join standardattribs sa on sa.contentID = c.contentID 
			inner join community com on c.contentID = com.contentID and 
			(com.communityID = #arguments.communityID# 
			    		or 
			    		com.communityID in (select communityID from community.community where parentID = '#arguments.communityID#')
			    		)<!--- TODO:   AND SYNDICATE TO PARENT SITE config variable --->
			where c.contentType = '#arguments.contentType#'	
			and approved = 1 
			and isdeleted = 0

			<cfif arguments.memberID neq ''>
				and memberID = #arguments.memberID#
			</cfif>

			group by mymonth, myyear
			order by myyear desc,mymonth desc
		</cfquery>
		<cfreturn qGet>
	</cffunction>
	
	<cffunction name="getRelated" hint="I return tags related to the content you are currently viewing">
		<cfargument name="contenttype">
	    <cfargument name="taglist">
	    <cfargument name="categoryid" default="">
	    <cfset var qry = ''>
	    <cfset var friendlist = application.members.getFriendsAsList(request.session.memberID)>
	
	    <cfquery datasource="#this.datasource#" name="qry">
	    	select 1 as newID, t.value as label,count(t.value) as cnt from tags t
	        inner join content c on  c.contentID = t.contentID and c.isdeleted = 0  and c.contentType = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="20" value="#arguments.contentType#">
	        left join contentcategory cc1 on cc1.contentID=c.contentID
			inner join community c2 on 
			(c2.contentID = c.contentID or c2.contentID = c.parentID) and 
			(c2.communityID = #request.community.communityID# 
			or	    c2.communityID in (select communityID from community.community where parentID = '#request.community.communityID#')
		   	     		or 
			    		c2.communityID in (select communityID from community.community where parentID = '#request.community.communityID#')
			    		)
		
	        inner join standardattribs sa on sa.contentid = c.contentid
			<cfif (arguments.contentType eq 'Video')>
				inner join attribs aConverted  on aConverted.contentID = c.contentID and aConverted.keyname = 'converted'
	        </cfif>
	      
	        where 1=1
			and approved = 1 
			and isdeleted = 0
			<cfif (arguments.contentType eq 'Video')>
				and aConverted.keyvalue = 1
			</cfif>
			
			and (private = 0 or (private = 1 and memberID in (#request.session.memberID#,#friendlist#)) or (private = 1 and #request.session.accesslevel# > 9))
	
	        <cfif isdefined('arguments.taglist') and len(arguments.taglist) gt 0>
		        and t.contentID in (
		            select distinct t2.contentID from tags t2
		            inner join content c3 on c3.contentID = t2.contentID and c3.isdeleted = 0  AND c3.contentType = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="20" value="#arguments.contentType#">
			        left join contentcategory cc2 on cc2.contentID=c3.contentID
		            inner join community c4 on c4.contentID = c3.contentID 
		            and( c4.communityID =#request.community.communityID#
		   	 			 or c4.communityID in (select communityID from community.community where parentID = '#request.community.communityID#')
					)
				inner join standardattribs sa2 on sa2.contentid = c3.contentid
		            where  t2.value in (#listqualify(arguments.taglist,"'",",")#)
					and (private = 0 or (private = 1 and memberID in (#request.session.memberID#,#friendlist#)) or (private = 1 and #request.session.accesslevel# > 9))
		
			       	<cfif arguments.categoryid neq ''>
			        	and cc1.categoryid = #arguments.categoryid#
			        </cfif>
		        )
			</cfif>
	
	       	<cfif arguments.categoryid neq ''>
		        and cc1.categoryid = #arguments.categoryid#
	        </cfif>
	
	        group by t.value
			order by cnt desc
	    </cfquery>
	    <cfreturn qry>
	</cffunction>

	<cffunction name="save">
		<cfargument name="data">
		<cfscript>
			arguments.data.contentid = super.save('content',arguments.data);
			super.save('standardattribs',arguments.data);
			return arguments.data.contentID;
		</cfscript>
	</cffunction>
	
	<cffunction name="delete" hint="I delete content by contentID">
	    <cfargument name="contentID">
		<!--- <cfscript>
			super.delete('content',arguments);
		</cfscript> --->
		<cfquery datasource="#this.datasource#">
			update content 
			set isdeleted = 1
			where contentID = #arguments.contentID# or parentID = #arguments.contentID#
		</cfquery>
	</cffunction>
	
	<cffunction name="flag" hint="I toggle the flagged bit">
		<cfargument name="contentID">
		<cfargument name="status" default="1">
		
		<cfquery datasource="#this.datasource#">
			update content 
			set flagged = #arguments.status# 
			where contentID = #arguments.contentID#
		</cfquery>
	</cffunction>

	<cffunction name="incrementviews">
		<cfargument name="contentID">
    	<cfquery datasource="#this.datasource#">
	        update content 
	        set views = views + 1
	        where contentID = #arguments.contentID#
        </cfquery>
	</cffunction>
</cfcomponent>