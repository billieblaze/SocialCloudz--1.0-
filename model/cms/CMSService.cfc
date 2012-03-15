<cfcomponent extends="../baseService">
	<cffunction name="init">
		<cfargument name="datasource" default="" type="string" required="true" >
		<cfargument name="gateway" default="" type="string" required="false"> 
		<cfargument name="xmlDefinition" default="" type="string" required="false">
		<cfargument name="validator" default="" type="string" required="false"> 
		
		<cfscript>
			super.init(argumentCollection=arguments);
			
			this.layout = createObject('component', 'layoutGateway').init(this.datasource, variables.instance.DAO);
			this.page = createObject('component', 'pageGateway').init(this.datasource, variables.instance.DAO);
			this.modules = createObject('component', 'moduleGateway').init(this.datasource, variables.instance.DAO);
			this.settings = createObject('component', 'settingsGateway').init(this.datasource, variables.instance.DAO);
			this.style = createObject('component', 'styleGateway').init(this.datasource, variables.instance.DAO);
			this.templates = createObject('component', 'templateGateway').init(this.datasource, variables.instance.DAO);		
			this.menu = createObject('component', 'menuGateway').init(this.datasource, variables.instance.DAO);
			
			return this;
		</cfscript>
	</cffunction>

    <cffunction name="convertCSSAttribute"> 
		<cfargument name="attribute">
    	<cfscript>
			switch(arguments.attribute) {
            case "textAlign":
              return('text-align');
			case "backgroundColor":
              return('background-color');
            case "backgroundImage":
              return('background-image');
            case "backgroundPosition":
              return('background-position');
            case "backgroundRepeat":
              return('background-repeat');			  			  
            case "padding":
			   return('padding');
            case "paddingTop":
			   return('padding-top');
           case "paddingRight":
			   return('padding-right');
           case "paddingBottom":
			   return('padding-bottom');
           case "paddingLeft":
			   return('padding-left');
			case "display": 
				return('display');
			case "visibility": 
				return('visibility');
			case "fontWeight":
				return "font-weight";
			case "fontSize":
				return "font-size";
			case "fontStyle":
				return "font-style";
			case "fontFamily":
				return "font-family";
			case "textDecoration":
				return "text-decoration";
			case "borderWidth": 
				return "border-width";
			case "borderColor":
				return "border-color";
		    default:
              return(arguments.attribute);
         } 
		</cfscript>
		
    </cffunction>		

	<cffunction name="changeTemplate">
    	<cfargument name="templateID">
        <cfargument name="communityID" default="#request.community.communityID#">
		<cfset var q_get = ''>
		<cfset var dataStruct = structNew()>
		<cfset this.style.delete(arguments.communityID)>
		<cfset q_get = this.templates.getData(arguments.templateID)>

        <cfloop query="q_get">
			<cfscript>
				dataStruct.communityID = arguments.communityID;
				datastruct.selector = q_get.selector;
				dataStruct.attribute = q_get.attribute;
				dataStruct.value = q_get.value;
				this.style.save(dataStruct);
			</cfscript>        
        </cfloop>
    </cffunction>

	<cffunction name="updateModuleOrder">
    	<cfargument name="data" default="">
		<cfargument name="page" default="">

        	<cfscript>
				var tmp = '';
				var newdata = structNew();
				var i = 0;
				var j = 0;
				var modulelist = ''
				var dataStruct = deserializejson(arguments.data);
				
				for(i=1;i lte 8;i=i+1){
					mylist = 'list#i#';
					modulelist='0';
					if(structkeyexists(datastruct,mylist)){
						for(j=1;j lte arraylen(evaluate('datastruct.#mylist#'));j=j+1){
							thisItem = evaluate('datastruct.#mylist#[j]');
							if ( thisItem neq '' and left(thisItem, 6) eq 'module'){
								newdata.list = i;
								
								newdata.moduleSettingID = replace(thisItem, 'module','','all');
								newdata.sortorder=j;
								newdata.page = arguments.page;
								newdata.communityID = request.community.communityID;
								this.modules.savePage( newdata);
								
								modulelist = listappend(modulelist, newdata.modulesettingid);
							}
						}
					}
					this.modules.deletefromlist(modulelist, i, arguments.page);
				}
			this.modules.cleanupPage();				
			</cfscript>	
    </cffunction>

    <cffunction name="addModule">
    	<cfargument name="list" default="1">
        <cfargument name="moduleID" default="">
        <cfargument name="page" default="">
	  	<cfargument name='displaymember' default="">
		<cfargument name='communityID' default = '#request.community.communityID#'>
		<cfargument name='accesslevel' default="">
		<cfargument name="isContent" default="0">
		<cfset var getMaxSortOrder = ''>
		 <cfset arguments.page = urldecode(arguments.page)>
	   	<cfquery datasource="#this.datasource#" name="getMaxSortOrder">
		   select ifNull(max(sortorder),1) as sortorder 
		   from modulepage 
		   where list = #arguments.list# 
		   and page = '#arguments.page#'             
		   and communityID = #arguments.communityID#
	   	</cfquery>
	   	
	   	<cfscript>
			arguments.modulesettingid = this.modules.updateSettings(arguments, 'insert'); 
			arguments.sortorder = getMaxSortOrder.sortOrder;
			this.modules.savePage(arguments);
			return arguments.moduleSettingID;
		</cfscript>	
    
    </cffunction>
	
	<cffunction name="getMyModules">
	    <cfargument name="page" default="">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfscript>
			list = this.modules.getByList(page = arguments.page,  communityID = arguments.communityID);
			return list;
		</cfscript>																
    </cffunction>
	
	<cffunction name="saveStyle">

    	<cfargument name="data">
		<cfargument name='templateID'>
        <cfscript>
			var datastruct = structnew();
			var myData = '';
			var keyList = '';
			var i = 0;
			var myChildren = '';
			var j = 0;
			
			if(arguments.data neq '' and arguments.data neq 'undefined'){
				
				datastruct.communityID = request.community.communityID;
				arguments.data = replace(arguments.data,'##','pound_','all');
				arguments.data = replace(arguments.data,'.','dot_','all');
				arguments.data = replace(arguments.data,' ','space_','all');
				arguments.data = replace(arguments.data,'-','dash_','all');
				arguments.data = replace(arguments.data,':hover','semicolon_hover','all');
				arguments.data = replace(arguments.data,':link','semicolon_link','all');
				arguments.data = replace(arguments.data,':active','semicolon_active','all');
				arguments.data = replace(arguments.data,':visited','semicolon_visited','all');
					mydata = deserializejson(arguments.data);
					keylist = structkeylist(mydata);
				
					for(i=1; i lte listlen(keylist);i=i+1){
						
						dataStruct.selector = listgetat(keylist,i);
						datastruct.selector = replace(datastruct.selector,'pound_', '##','all');
						datastruct.selector = replace(datastruct.selector,'dot_', '.','all');
						datastruct.selector = replace(datastruct.selector,'space_', ' ','all');
						datastruct.selector = replace(datastruct.selector,'dash_', '-','all');
						datastruct.selector = replace(datastruct.selector,'semicolon_hover', ':hover','all');
						datastruct.selector = replace(datastruct.selector,'semicolon_active', ':active','all');
						datastruct.selector = replace(datastruct.selector,'semicolon_link', ':link','all');
						datastruct.selector = replace(datastruct.selector,'semicolon_visited', ':visited','all');
	
						myChildren = structkeylist(evaluate('mydata.#listgetat(keylist,i)#'));
					
						for(j=1; j lte listlen(myChildren); j=j+1){
							dataStruct.attribute = listgetat(myChildren,j);
							dataStruct.value = evaluate('mydata.#listgetat(keylist,i)#.#datastruct.attribute#');
							datastruct.value = replace(datastruct.value,'pound_', '##','all');
							datastruct.value = replace(datastruct.value,'dot_', '.','all');
							datastruct.value = replace(datastruct.value,'space_', ' ','all');
							datastruct.value = replace(datastruct.value,'dash_', '-','all');
							
							dataStruct.attribute = application.cms.convertCSSAttribute(datastruct.attribute);
	
							if (arguments.templateID eq 0){
								this.style.save(dataStruct);
							} else { 
								datastruct.templateID = arguments.templateID;
								this.template.save(dataStruct);
							}					
		 				}
					}
				}
		</cfscript>
    </cffunction>

	<cffunction name="validate">
		<cfargument name="datastruct">
		
		<cfscript>
			var message = '';
		
			if (not isdefined('arguments.datastruct.configuration') and not isdefined('arguments.datastruct.features')){
				message = message & '<li>Please select a configuration.</li>';
			}
	
			if (not isdefined('arguments.datastruct.templateID')){
				message = message & '<li>Please select a template.</li>';
			}
			
			return message;
		</cfscript>
	</cffunction>
	
	<Cffunction name="getSiteTemplate">
		<cfargument name="configuration">
		<cfscript>
			var featureCommunityID = 0;
			
			switch(arguments.configuration){
			
				case "blogs":
					{ featureCommunityID= 56; break;}
				
				case "church":
					{ featureCommunityID= 202; break;}
				
				case "fan":
					{ featureCommunityID= 203; break;}
				
				case "lawyer":
					{ featureCommunityID= 204; break;}
					
				case "media":
					{ featureCommunityID= 205; break;}
				
				case "music":
					{ featureCommunityID= 206; break;}
				
				case "networking":
					{ featureCommunityID= 207; break;}
				
				case "nightclub":
					{ featureCommunityID= 208; break;}
				case "property":
					{ featureCommunityID= 103; break;}
				
				case "restaurant":
					{ featureCommunityID= 213; break;}
				
				case "social":
					{ featureCommunityID= 64; break;}
					
				case "venue":
					{ featureCommunityID= 177; break;}
				
        	}
        	
        	return featureCommunityID;
		</cfscript>
	</cffunction>
	
	<Cffunction name="cloneSite">
		<Cfargument name="sourceCommunityID">
		<Cfargument name="targetCommunityID">
		<cfscript>
			var menu = '';
			var cms = '';
			var modules = '';
			var layouts = '';
			var data = '';
			var i = 0;
			
		// configure community
			menu = this.menu.get(arguments.sourceCommunityID);
			// Menu
			for(i=1; i lte menu.recordcount; i=i+1){
				data=structnew();
				data.Title = menu.title[i];
				data.sortOrder = menu.sortOrder[i];
				data.communityID = arguments.targetCommunityID;
				data.type = menu.type[i];
				data.url = menu.url[i];
				data.newWindow = menu.newWindow[i];
				data.visibleTo = menu.visibleTo[i];
				data.feature = menu.feature[i];
				data.cms = menu.cms[i];
				this.menu.save(data);
			}
			
		// Create CMS Pages
			cms =  this.page.get(communityID=arguments.sourceCommunityID);
			for(i=1; i lte cms.recordcount; i=i+1)	{
				data = structNew();
				data.title = cms.title[i];
			    data.description = cms.description[i];
			  	data.keywords = cms.keywords[i];
			  	data.url = cms.url[i];
			  	data.communityID = arguments.targetCommunityID;
		  	  	this.page.save(data);
			}
		
  
		// Build Modules
			modules = this.getMyModules( communityID = arguments.sourceCommunityID, returnType ='query');
			
			for(i=1; i lte modules.recordcount; i=i+1){
				application.cms.addModule(list=modules.list[i], moduleID=modules.moduleID[i], page=modules.page[i], communityID = arguments.targetCommunityID);
			}

		// Save Page Layout Settings		
			layouts = this.layout.get(communityID=arguments.sourceCommunityID, returntype='query');

			for(i=1; i lte layouts.recordcount; i=i+1){
				data = structNew();
				data.page = layouts.page[i];
				data.columns = layouts.columns[i];
				data.template = layouts.template[i];
				data.right = layouts.right[i];
				data.menu = layouts.menu[i];
						
				this.layout.save(data, arguments.targetCommunityID);
			}
		</cfscript>
	</cffunction>
</cfcomponent>

