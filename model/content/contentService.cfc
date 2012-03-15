<cfcomponent extends="../baseService" output="false">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			var i = 0;
			
			super.init(argumentCollection=arguments);
			
			this.gateway = createObject('component', 'contentGateway').init(this.datasource, variables.instance.DAO);
			this.attribute = createObject('component', 'attributeGateway').init(this.datasource, variables.instance.DAO);
			this.category = createObject('component', 'categoryGateway').init( this.datasource, variables.instance.DAO);
			this.community = createObject('component', 'communityGateway').init(this.datasource, variables.instance.DAO);
			this.comments = createObject('component', 'commentGateway').init(this.datasource, variables.instance.DAO);
			this.type = createObject('component', 'contentTypeGateway').init( this.datasource, variables.instance.DAO);						
			this.favorite = createObject('component', 'favoriteGateway').init( this.datasource, variables.instance.DAO);						
			this.location = createObject('component', 'locationGateway').init( this.datasource, variables.instance.DAO);						
			this.nestedSet = createObject('component', 'nestedSetGateway').init( this.datasource, variables.instance.DAO);						
			this.rating = createObject('component', 'ratingGateway').init( this.datasource, variables.instance.DAO);	
			this.tag = createObject('component', 'tagGateway').init( this.datasource, variables.instance.DAO);						
			this.template = createObject('component', 'templateGateway').init( this.datasource, variables.instance.DAO);						
		</cfscript>

	 	<cfset variables.contentDefinition = variables.instance.DAO.getTableData("content")>
	   	<cfset variables.standardAttribsDefinition = variables.instance.DAO.getTableData("standardattribs")>
	   	<cfset variables.locationDefinition = variables.instance.DAO.getTableData("location")>
	   	<cfset variables.columnList='submit,communityID,tags,filedata,filesize,fieldnames,the-menu'>
	     	
		<cfloop from="1" to="#arraylen(variables.contentDefinition.content)#" index="i">
	        <cfset variables.columnList = listappend(variables.columnList,variables.contentDefinition.content[i].columnName)>
		</cfloop>

	    <cfloop from="1" to="#arraylen(variables.standardAttribsDefinition.standardAttribs)#" index="i">
	        <cfset variables.columnList = listappend(variables.columnList,variables.standardAttribsDefinition.standardattribs[i].columnName)>
		</cfloop>
	    
	    <cfloop from="1" to="#arraylen(variables.locationDefinition.location)#" index="i">
	        <cfset variables.columnList = listappend(variables.columnList,variables.locationDefinition.location[i].columnName)>
		</cfloop>

		<cfreturn this>
	</cffunction>
	
    <cffunction name="get" access="public" returntype="query" output="false">
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
        <cfargument name="updateViews" default="0">
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
	
        <cfscript>
			var qry_content = '';
	
			if ( arguments.sort eq ''){ 
				arguments.sort = 'publishDate desc';
			}
			//  Get friend list
			arguments.friendlist = 0;
	   		// todo: arguments.friendlist = listappend(arguments.friendlist, application.members.getFriendsAsList(request.session.memberID));

			qry_content = this.gateway.get(argumentcollection=arguments);
	
			if (arguments.updateviews eq 1){ 
				this.gateway.incrementviews(arguments.contentID);
			}
	
			return  qry_content;
		</cfscript>
    </cffunction>

	<cffunction name="GetForInterceptor">
		<Cfargument name="interceptData">
		
		<cfscript>
			var contentData = structNew();
			
			var config = arguments.interceptData;
			
			config.approved = 1;
			config.converted = 1;
			
			if (isdefined('config.contentID') and config.contentID neq '' and config.contentID neq 0){ 
				config.updateViews = 1;
			}
			
			if ( structkeyexists(config,'memberID')){
			  	if (config.memberID eq request.session.memberID) {
					config.approved = 0;
				}
				
				if (isdefined('config.dateRangeStart') and config.dateRangestart eq ''){
					config.operator = '>';
				}
			}
			// Potential input parameters that need defaults
			if( not isdefined('config.page')){	config.page = 1; }
			if (not isdefined('config.limit') or config.limit eq ''){	config.limit = 10; }
			if (not isdefined('config.sort') or config.sort eq ''){ config.sort = 'publishdate'; }
			if (not isdefined('config.sortDirection') or config.sortDirection eq ''){ 	config.sortDirection = 'desc'; 	}
			

			config.sort='#config.sort# #config.sortDirection#'
			
			contentData.query =  this.get( argumentcollection = config );	
		
			configTmp = config;
			configTmp.countOnly = 1;
			configTmp.updateViews = 0;
			configTmp.limit = 0;
			
			contentData.count =  this.get(argumentcollection = configTmp	).count	;		
			// List
			if (isdefined('config.contentID') and config.contentID neq ''){
				contentData.member = application.members.gateway.list(contentData.query.memberID);
				contentData.child = 
					this.get(
						parentID=config.contentID,
						updateviews = 0,
						limit=config.limit, 
						sort='sortorder asc', 
						approved=config.approved
					);
			}
			contentData.UISettings = this.template.get(contentType = config.contentType);
			return contentData;
		</cfscript>
	</cffunction>
	
	
    <cffunction name="save" returntype="numeric" hint="I save the content entry">
 	  	<cfargument name="dataStruct">
	  	<cfargument name="trackStats" default="1">
	  	
	  	<cfscript>
		  	var origContentID = '';
		  	var attribs = structNew();
		  	var i = 0;
		  	var data = structNew();
		  	var thisDelimiter = '';
			var  content = arguments.dataStruct;
			
			if (not isdefined('content.contentid') or (isdefined('content.contentid') and content.contentid eq '')) {
				content.contentid = 0;
			}
			
			origContentID = content.contentID;
			
			if (isdefined('content.publishdate')){
				content.publishdate = replace(content.publishdate, ',', ' ');
			} else { 
				content.publishDate = now();
			}
			   
			// save the content record
			content.contentID = this.gateway.save(content);
	
			if(isdefined('content.communityID') and content.communityID neq ''){	
				this.utils.listremoveduplicates(content.communityID);
				this.community.save(content.contentid, content.communityID);
			}
	
			// Save location data
			this.location.save(content);
			
			// setup' for next phase
			attribs.contentID = content.contentID;
	
			//save the freeform attributes
			for(i=1;i lte listlen(structkeylist(datastruct));i=i+1){
				if(listfindnocase(variables.columnlist, listgetat(structkeylist(datastruct),i)) eq 0 ){
					thisfield = listgetat(structkeylist(datastruct),i);
					attribs.keyname = thisfield;
					attribs.keyvalue = evaluate('datastruct.#thisfield#');
					this.attribute.save(attribs);
				}
			}

			
			// Save Categories
			if(structKeyExists(datastruct,'categoryid') and datastruct.categoryid neq ''){
				this.category.deleteContent(content.contentID); // category gateway - deleteContent
				for(i=1; i lte listlen(datastruct.categoryid); i=i+1){
					data.categoryid = listgetat(datastruct.categoryid, i);
					data.contentID = content.contentid;
					this.category.saveContent(data);
				}
			}
			
			// save current tags
			if(structKeyExists(datastruct,'tags') and datastruct.tags neq ''){
				thisDelimiter = ' ';
				if(arguments.datastruct.tags contains ','){	thisDelimiter = ',';}
				datastruct.tags = this.utils.listRemoveDuplicates(datastruct.tags);
				this.tag.delete(attribs.contentID);
				for(i=1;i lte listlen(datastruct.tags, thisDelimiter);i=i+1){
					attribs.value = trim(replace(listgetat(datastruct.tags,i, thisDelimiter), "'", ""));
					this.tag.save(attribs);
				}		
				
			}
		</cfscript>

  		<cfreturn content.contentid>
	</cffunction>

	<cffunction name="getAttributes" returntype="struct" hint="I take the xml packet of attributes and convert it to a struct">
		<cfargument name="xmlString">
		<cfscript>
			var mystruct=structNew();
			var myXML = '';
			
			if (len(arguments.xmlstring) gt 0){
				myxml=xmlparse(arguments.xmlString);
				application.xml2struct.convertXMLtoStruct(myxml, myStruct);
			}
    	</cfscript>
	    <cfreturn mystruct>
	</cffunction>
	
	<cffunction name="getAttribute" returntype="string" output="false" hint="I take the xml packet of attributes and return the value of the specified key">
		<cfargument name="xmlString">
		<cfargument name="keyName">
		<cfscript>
	        var mystruct=structNew();
	        var rtn = '';
	        var myXML = '';
			if(len(xmlstring) neq 0){
		   		myxml=xmlparse(xmlString);
				application.xml2struct.convertXMLtoStruct(myxml, myStruct);
				if (structKeyExists(mystruct,'#keyName#')){
					rtn=trim(mystruct[keyName]);
				}
			}
			if (arguments.keyname eq 'directory') rtn=replace(rtn,'\','/','all');
			return rtn;
	    </cfscript>
	</cffunction>
	
	<cffunction name="clearChildAttributes">
		<cfargument name="parentID">
	    <cfargument name="attribute">
	    <cfquery datasource="#this.datasource#">
			delete from attribs
		    where contentID in (select contentID from content where parentID = #arguments.parentID# )
		    and keyname = '#arguments.attribute#'
	    </cfquery>
	</cffunction>

</cfcomponent>