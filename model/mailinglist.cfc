<cfcomponent>
	<cffunction name="init" returntype="mailinglist" access="public" output="false" >
	  <cfargument name="datasource">
	  <cfset variables.myDAO = createobject('component', 'DataMgr.DataMgr_MYSQL').init(arguments.datasource)>
	  <cfset variables.datasource =arguments.datasource>
	

	  <cfreturn this>
	  </cffunction>
	  <cffunction name="get"> 
		<cfargument name="email">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfreturn variables.myDAO.getRecords('mailingList', arguments)>
	</cffunction>

	  <cffunction name="delete"> 
		<cfargument name="id">
		<cfreturn variables.myDAO.deleteRecords('mailingList', arguments)>
	</cffunction>
	
	<cffunction name="save">
	 	<cfargument name="data">
	    
	    <cfscript>
		    var get = '';
		    var message = 'Sucessfully subscribed.';
			get = this.get(form.email);	
			arguments.data.communityID = request.community.communityID;
			
			if (arguments.data.email eq 'Email Address' or not isvalid('email', arguments.data.email)){
		    		message = "Incorrect Email Address.";
			} else {
				if (get.recordcount eq 0 and  arguments.data.action eq 'Join'){      
		        	    variables.myDAO.saveRecord('mailingList', arguments.data);   
			            message = 'Successfully subscribed.';
		        	} else if (get.recordcount eq 1 and arguments.data.action eq 'Remove'){
			            arguments.data.id = get.id;
				   		variables.myDAO.deleteRecord('mailingList', arguments.data);
			            message = 'Successfully unsubscribed.';
		        	} else if (get.recordcount eq 1 and arguments.data.action eq 'Join'){
			            message = 'Already subscribed.';
		        	} else if (get.recordcount eq 0 and arguments.data.action eq 'Remove'){
			            message = 'Not subscribed.';
				}
			}
	    	return message;
		</cfscript>
	  </cffunction> 
	  
	<cffunction name="Send">
			<cfargument name="messageID">
			<cfargument name="email">
			<Cfset var message = ''>
			<cfset message = this.getMessage(messageID = arguments.messageID)>
			<cfset server.mail.send(to=arguments.email, subject=message.subject, body=message.message)>
		</cffunction>
		
	 <cffunction name="getMessage">
	  	<cfargument name="messageID">
	  	<cfargument name="memberID">
	    <cfargument name="communityID" default="#request.community.communityID#">
	    <cfscript>
			return variables.myDAO.getRecords('messages', arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="saveMessage">
	  	<cfargument name="messageID">
		<cfargument name="subject">
		<cfargument name="message">
	    <cfargument name="communityID" default="#request.community.communityID#">
		<cfargument name="createdOn" default="#now()#">
		<cfargument name="memberID" default="#request.session.memberID#">
	    <cfscript>
			return variables.myDAO.saveRecord('messages', arguments);
		</cfscript>
	    
	</cffunction>
	
	<cffunction name="deleteMessage">
	  	<cfargument name="messageID">
	    <cfargument name="communityID" default="#request.community.communityID#">
	    <cfscript>
			return variables.myDAO.deleteRecord('messages', arguments);
		</cfscript>
	    
	</cffunction>
	
	<cffunction name="savelog">
		<cfargument name="messageID">
		<cfargument name="email">
		<cfargument name="dateSent" default="#now()#">
		<cfscript>
			return variables.myDAO.saveRecord('messageLog', arguments, 'insert');
		</cfscript>
	</cffunction>
	 
	<cffunction name="getlog">
	<cfargument name="messageID">
	<cfargument name="email">
	<cfscript>
		return variables.myDAO.getRecord('messageLog', arguments);
	</cfscript>
</cffunction>
</cfcomponent>