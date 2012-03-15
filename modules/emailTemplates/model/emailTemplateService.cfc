<cfcomponent extends="/model/baseService">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		<cfargument name="decorator" default="tagDecorator" type="string" required="false"> 
		<cfargument name="debugMode" default="development" type="string" required="false"> 
		<cfscript>
			super.init(argumentCollection=arguments);

			this.gateway = createObject('component', 'templateGateway').init(variables.instance.datasource, variables.instance.dao);
			this.tags = createObject('component', 'tagGateway').init(variables.instance.datasource, variables.instance.dao);
			this.decorator = arguments.decorator;
			this.mapping = createObject('component', 'mappingGateway').init(variables.instance.datasource, variables.instance.dao);
			this.log = createObject('component', 'logGateway').init(variables.instance.datasource, variables.instance.dao);
			this.settings = createObject('component', 'preferenceGateway').init(variables.instance.datasource, variables.instance.dao);
			
			if(arguments.debugMode eq 'true')
				{this.sendEmail = 0;}
			else
				{this.sendEmail = 1;}
				
			this.isLogging = 1;
			
			return this;
		</cfscript>
	</cffunction>
	
	<cffunction name="send">
		<cfargument name="to">
		<cfargument name="cc">
		<cfargument name="bcc">
		<cfargument name="template">
		<cfargument name="data" required="false" type="struct">
		<cfargument name="memberID" default="#request.session.memberid#">
		<cfargument name="instance" default="">
		<cfargument name="applicationName" default="">
		<cfargument name="fkID" default="" hint="I am the primary FK for the main table or business object (ie prop_id)">
		<cfargument name="fkType" default="" hint="I am the fkID table/business object ie (proposal)">
		<cfargument name="testEmailTo" default="">		
		
		<cfscript>
			var qTemplate = this.gateway.get( name=arguments.template, editable=1, instance=arguments.instance);
			var qTags = this.tags.get();
			
			var sTags = this.utils.queryColumnsToStruct(qTags,'tag');
			var decorator = createobject('component', this.decorator).init(data = arguments.data);
			
			var tagCC = this.parseTags(qTemplate.CC, sTags, arguments.data, decorator );
			var tagBCC = this.parseTags(qTemplate.BCC, sTags, arguments.data, decorator );
			var subject = this.parseTags(qTemplate.subject, sTags, arguments.data, decorator );
			var body = this.parseTags(qTemplate.body, sTags, arguments.data, decorator);
				
			var logData = structNew();
			
			if (isDefined('arguments.cc') and arguments.cc neq ''){
				tagCC = arguments.CC & ',' & tagCC;
			}

			if (isDefined('arguments.bcc') and arguments.bcc neq ''){
				tagBCC = arguments.BCC & ',' & tagBCC;
			}

		</cfscript>	
		<cfif arguments.to neq '' and this.sendEmail eq 1>
			<cfmail to="#Arguments.to#"
					from="#application.smtpuser#" 
					subject="#subject#" 
					cc="#tagcc#" 
					bcc="#tagbcc#" 
					type="html">
					#body#
			</cfmail>
		<cfelseif this.sendEmail eq 0 and testEmailTo neq ''>
			<cfmail to="#Arguments.testEmailTo#"
					from="#application.smtpuser#" 
					subject="#subject#" 
					type="html">
					<strong>Test Email</strong> <br>
					CC:#tagcc# <br>
					BCC:#tagbcc# <br>
					Email Body Content Below
					<hr>
					#body#
			</cfmail>
		</cfif>	
		<cfscript>
			if (this.isLogging eq 1){ 
				logData.memberID = arguments.memberID;
				logData.to = arguments.to;
				logData.cc = tagCC;
				logData.bcc = tagbcc;				
				logData.dateSent = now();
				logData.subject = subject;
				logData.body = body;
				logData.emailID = qTemplate.ID;
				logData.fkID = arguments.fkID;
				logData.fkType = arguments.fkType;
				this.log.save(logData);
			}
		</cfscript>
		<cfdump var='#arguments#' label="arguments">	
		<cfdump var='#qTemplate#' label="template">
		<cfdump var='#sTags#' label="tag struct"><br><br>
		<cfdump var='#decorator#' label="populated decorator object">
		CC:<br>
        <cfdump var='#tagCC#' label="CC">
        Subject:<br />
		<cfdump var='#subject#' label="subject">
		<br><br>
		Body:<br />
		<cfdump var='#body#' label="body">

	</cffunction>
	
	<cffunction name="parseTags" hint="i take the list of tags passed into send, and replace the matching fields from the data structure..  i then call a decorator to handle system specific global tags">
		<cfargument name="content">
		<cfargument name="tags">
		<cfargument name="data" default="#structNew()#">
		<cfargument name="tagDecorator">
		
		<cfset var mycontent = arguments.content>
		<cfset var tagData = arguments.data>
		<cfset var decorated = structNew()>
		<cfset var thistag = ''>
		
		<cfif not isdefined('arguments.tagDecorator')>
			<cfset arguments.tagDecorator = createobject('component', this.decorator).init()>
		</cfif>
		<!--- lets apply some application, site and member specific rules that will be globally available --->				
		<cfset decorated = arguments.tagDecorator.getTags()>
		<cfset structappend(arguments.tags,decorated,false)>

		<!--- loop the list of tags, and replace the match from the data argument --->
		<cfloop collection = "#arguments.tags#" item="thisTag">
			<cfif thisTag contains '.'>

				<cfset tagValue = arguments.tagDecorator.getDynamicData(
									type = listFirst(thisTag,'.'),
							      	key = listLast(thisTag,'.'),
							      	data = arguments.data)>
				
				<cfset mycontent = ReplaceNoCase(mycontent, "[#thistag#]", tagValue, "ALL")>		
			<cfelse>
				<cfif isSimpleValue(arguments.tags[thisTag])>
					<cfset mycontent = ReplaceNoCase(mycontent, "[#thistag#]", arguments.tags[thistag], "ALL")>
				<cfelse>
					<cfloop collection="#arguments.tags[thistag]#" item="tag2">
						<cfif isSimpleValue(arguments.tags[thisTag][tag2])>
							<cfset mycontent = ReplaceNoCase(mycontent, "[#thistag#.#tag2#]", arguments.tags[thistag][tag2], "ALL")>
						<cfelse>
							<!--- todo: need a 3rd tier here? --->
						</cfif>
					</cfloop>
				</cfif>
			</cfif>
		</cfloop>
		<cfreturn mycontent>
	</cffunction>

	<cffunction name="getGlobalTags">
		<cfset var tagDecorator = createobject('component', 'tagDecorator').init()>
		<cfreturn tagDecorator.getTags()>
	</cffunction>

	<cffunction name="save">
		<cfargument name="data">
		<cfscript>
			//var tagData = structNew();
			var id = application.emailTemplates.gateway.save(arguments.data);
			if ( isdefined('arguments.data.tags')){
				for(i=1; i lte listlen(arguments.data.tags,','); i = i + 1){
					tagData = structNew();
					tagData.emailID = arguments.data.id;
					tagData.tag = listGetAt(arguments.data.tags, i);
					application.coldfusion.cfdump(tagData);
					if (tagData.tag neq ''){
						application.emailTemplates.tags.save(tagData);
					}
				}
			}
			return id;	
		</cfscript>
	</cffunction>
    
	<cffunction name="getLogs">
		<cfargument name="ID">
		<cfargument name="fkID" default="">
		<cfargument name="fkType" default="">
		<cfargument name="orderby" default="">
		<cfscript>
			return application.emailTemplates.log.get(tableName='emailLog',datastruct=arguments,orderby=arguments.orderBy);
	    </cfscript>
	</cffunction>
	
</cfcomponent>