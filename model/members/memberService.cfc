<cfcomponent extends="../baseService">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			super.init(argumentCollection=arguments);
			this.datasource = arguments.datasource;
			
			this.gateway = createObject('component', 'memberGateway').init(this.datasource, variables.instance.DAO);
			this.access = createObject('component', 'accessGateway').init(this.datasource, variables.instance.DAO);				
			this.account = createObject('component', 'accountGateway').init(this.datasource, variables.instance.DAO);
			this.ban = createObject('component', 'banGateway').init(this.datasource, variables.instance.DAO);
			this.block = createObject('component', 'blockGateway').init(this.datasource, variables.instance.DAO);
			this.friend = createObject('component', 'friendGateway').init(this.datasource, variables.instance.DAO);
			this.group = createObject('component', 'groupGateway').init(this.datasource, variables.instance.DAO);
			this.invitation = createObject('component', 'invitationGateway').init(this.datasource, variables.instance.DAO);
			this.notification = createObject('component', 'notificationGateway').init(this.datasource, variables.instance.DAO);
			this.profile = createObject('component', 'profileGateway').init(this.datasource, variables.instance.DAO);

			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="authenticate">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="email">
		<cfargument name="password">
	    <cfargument name="memberid">
	
		<cfscript>
		var data = structNew();
		var response = structnew();
		var member = '';
		response.success = 1;
		response.error = '';
		response.errorDetail = '';
	
		// Lookup by Email / Password in a global context
			member = this.gateway.get(argumentcollection = arguments);
		
		
		// Email or Password Error
			if(member.recordcount eq 0){ 
				response.error = 'no account';
				response.errorDetail =  'We could not locate your user account.';
				response.success = 0;
				return response;
			}
	
			if(isdefined('arguments.password') and member.password neq arguments.password){ 
				response.error = 'incorrect password';
				response.errorDetail =  'The password you entered is incorrect.  Please try again';
				response.success = 0;
				return response;
			}
	
		memberAccount = this.gateway.list(communityID = arguments.communityID, memberid=member.memberid);

		if(memberAccount.banned eq 1 and member.globalAdmin eq 0){
			response.error = 'banned';
			response.errorDetail =   'You have been banned from this site.';
			response.success = 0;
			return response;
		}
	
		if(memberAccount.approved eq 0 and member.globalAdmin eq 0){
			response.error = 'pending approval';
			response.errorDetail =  'Your account has not yet been approved.';
			response.success = 0;
			return response;
		}	
	
		if((memberAccount.recordCount eq 0 and application.community.settings.getValue('Signup') eq 1) or  member.globalAdmin eq 1){
			data.memberid = member.memberid;
			data.communityID = arguments.communityID;
			data.accesslevel = 1;
			if (application.community.isPrivate(arguments.communityID)){
				data.approved = 0;				
			} else { 
				data.approved = 1;
			}
	
			if ( member.globalAdmin eq 1){
				data.accesslevel = 100;
				data.approved = 1;
				data.invisible = 1;
			}
			
			this.account.save(data);
			this.access.save(data);
		} else if (memberAccount.recordCount eq 0 and application.community.settings.getValue('Signup') eq 0 and request.community.communityID neq 2 and request.community.communityID neq 100){
			response.error = 'signup not allowed';
			response.errorDetail = 'This site is not accepting new members.'; 
			response.success = 0;
			return response;
		}
	
		memberAccount = this.gateway.list(communityID = arguments.communityID, memberid=member.memberid);

		this.gateway.incrementLogin(member.memberID, arguments.communityID);
		
		response.data = this.utils.queryRowToStruct(memberAccount);
		response.data.login = 1;
		
		if(response.data.signupComplete eq 1){
			response.data.age=application.util.agesincedob(member.birthdate);	
	 	}
	
		return response;
		 
		</cfscript>
	
	</cffunction>
	<cffunction name="joinMemberData">
		<cfargument name="queryStruct">
		<cfargument name="communityID" default="">

		<cfscript>
			var qry = queryStruct;
			var memberlist = valuelist(qry.memberid);
			var getMembers = '';
			var rQry = '';
			
			if (memberlist eq ''){ memberlist = 0;}
	
			memberlist = this.utils.listremoveduplicates(memberlist);
		</cfscript>

	    <cfquery datasource="#this.datasource#" name="getMembers">
	    	select distinct a.memberID, username, gender, city,state,zip,latitude,longitude,country,email, birthdate, accesslevel
		    from members m
		    inner join access a on a.memberID = m.memberID
		    
		    where m.memberid in (#memberlist#)
	    </cfquery>
	
	    <cfquery dbtype="query" name="rQry">
	    select * from qry, getmembers
	    where qry.memberID = getmembers.memberID
	    </cfquery>
	    <cfreturn rQry>
	</cffunction>

	<cffunction name="getUserName" returntype="string" output="no">
	    <cfargument name="memberID">
	    <cfargument name="displayLink" default="0">
		<cfargument name="class" default="">
		<cfset var string = ''>
		<cfset var nameFormat = ''>
		<cfset var qUserName = ''>
		
		<cfif memberID eq 0 or memberid eq ''>
        	<cfset string='Guest'>
			<cfset qUserName = structNew()>
			<cfset qUsername.username = 'Guest'>
        <cfelse>
 			<cfset qUserName = this.gateway.get(memberID = arguments.memberID)>

	        <cfif qusername.recordcount eq 0>
	        	<cfset string = 'Deleted'>
	        <cfelse>
				<cfset nameformat = application.community.settings.getValue('nameFormat')>
				<cfif nameFormat eq 0>
					<cfset string = qusername.username>
				<cfelseif nameformat eq 1>
					<cfset string = '#qUsername.firstName# #qUsername.lastName#'>
				<cfelseif nameformat eq 2>
					<cfset string = '#qUsername.firstName#'>
				<cfelseif nameformat eq 3>
					<cfset string = '#qUsername.lastName#'>
				<cfelseif nameformat eq 4>
					<cfset string = '#left(qUsername.firstName,1)# #qUsername.lastName#'>
				<cfelseif nameformat eq 5>
					<cfset string = '#qUsername.firstName# #left(qUsername.lastName,1)#'>
				</cfif>
		    </cfif>
		</cfif>

        <cfif displaylink eq 1>
	        <cfset string = '<a href="/index.cfm/members/#qusername.username#" class="#arguments.class#">' & string & '</a>'>
        </cfif>
        <cfreturn string>
    </cffunction>
	
	<cffunction name="userPic">
		<cfargument name="memberID">
		<cfargument name="communityID" default="#request.community.communityID#">
        <cfscript>
			var thisImage = this.gateway.list(argumentCollection = arguments );
			if (thisImage.recordcount eq 0){
				return '/images/nothumbnail_icon.png';
			}
			return '#thisImage.image#';
		</cfscript>
	</cffunction>

	
	<cffunction name="flagMember">
		<cfargument name="memberID">
		<cfargument name="flag" default="1">
		<cfset this.account.save(arguments)>
	</cffunction>

	<cffunction name="userClick">
		<cfargument name="memberID" default="#request.session.memberID#">
		<cfargument name="lastClick" default="#createODBCDateTime(now())#">
		<cfargument name="idle" default="0">
		<cfargument name="online" default="1">
	
		<cfset this.account.save(arguments)>
	</cffunction>

	<cffunction name="approveMember">
		<cfargument name="memberID">
		<cfargument name="approved" default="1">

		<cfset this.account.save(argumentCollection = arguments)>
	</cffunction>

	<cffunction name="getFriendList">
		<cfargument name="memberID" default="#request.session.memberid#">
		<cfargument name="online" default="0">
		<cfargument name="limit" default="">
		<cfargument name="approved" default="1">
		<cfset var qry = this.friend.list(argumentcollection = arguments)>
		<cfset var qryJoin = application.member.joinMemberData(qry)>
		<cfreturn qryJoin>
	</cffunction>

	<cffunction name="getFriendsAsList">
		<cfargument name="memberID" default="#request.session.memberid#">
		<cfargument name="online" default="0">
		<cfargument name="limit" default="">
		
		<cfscript>
			var qry = this.friend.list(argumentcollection = arguments);
		    
		    if (qry.recordcount eq 0){
	    		return 0;
			} else  {
				return valuelist(qry.memberID);
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="isFriend">
		<cfargument name="sourceID"  default="#request.session.memberID#">
		<cfargument name="targetID">
		
			<cfset var check = this.friend.get(argumentcollection=arguments)>
		    <!--- Not a friend --->
		     <cfif check.recordcount eq 0>
		    	<cfreturn 0>
		    <cfelse>
		    	<cfif check.approved eq 0>
		    		<cfreturn 2>
		        <cfelseif check.approved eq 1>
		       	    <cfreturn 1>
		        </cfif>
		    </cfif>
	</cffunction>
	
	<cffunction name="isGroupMember">
		<cfargument name="contentid">
		<cfargument name="memberID" default="#request.session.memberid#">
		
		<cfset var qMember = ''>
		<cfset qMember = this.group.getMembers(argumentCollection = arguments)>
		<cfif qMember.recordcount eq 0>
			<cfreturn 0>
		<cfelse>
			<cfreturn 1>
		</cfif>
	</cffunction>

	<cffunction name="joinSite">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="memberID">
		<Cfargument name="accessLevel" default="1">
		<Cfargument name="approved" default="1">
		
		<cfscript>
			application.members.account.save(arguments);
			application.members.access.save(arguments);
		</cfscript>
	</cffunction>
	
</cfcomponent>