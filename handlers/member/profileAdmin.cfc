
<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/14/2010
Description : 			
 profile admin
		
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">

	<cfscript>
		this.prehandler_only 	= "";
		this.prehandler_except 	= "";
		this.posthandler_only 	= "";
		this.posthandler_except = "index,type,section,question";
		this.allowedMethods = structnew();
	</cfscript>

	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			announceInterception('checkAdmin');
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			setNextEvent('member.profileAdmin.index','communityID=#rc.communityID#');
		</cfscript>
	</cffunction>

	<cffunction name="index" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
	 		event.setvalue('community', application.community.setupCommunity(communityID = event.getValue('communityID')));
			event.setvalue('types',application.members.profile.getTypes(communityID = event.getValue('communityID')));
			
			event.setLayout('layout.AJAX');
		</cfscript>
	</cffunction>
	
	<cffunction name='type'>
		<cfargument name="event" />
  		<cfscript>
			var rc = event.getCollection();	
	 		event.setvalue('type', application.members.profile.getTypes(typeID=rc.typeid,communityID = event.getValue('communityID')));
	 		event.setLayout('layout.AJAX');
	 	</cfscript>
	</cffunction>
	
	<cffunction name='typeSubmit'>
	  	<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.members.profile.saveType(rc);
		</cfscript>
	</cffunction>
	
	<cffunction name='deleteType'>
  		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
		 	application.members.profile.deleteType(rc.typeid);
		 </cfscript>
	</cffunction>
	
	<cffunction name='section'>
		<cfargument name="event" />
  		<cfscript>
			var rc = event.getCollection();	
			event.setvalue('types',application.members.profile.getTypes(communityID = event.getValue('communityID')));
	 		event.setvalue('sections', application.members.profile.getSections(sectionID=rc.id,communityID = event.getValue('communityID')));
	 		event.setLayout('layout.AJAX');
	 	</cfscript>
	</cffunction>
	
	<cffunction name='sectionSubmit'>
	  	<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.members.profile.saveSection(rc);
		</cfscript>
	</cffunction>

	<cffunction name='deleteSection'>
  		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
		 	application.members.profile.deleteSection(rc.id);
		 </cfscript>
	</cffunction>

	<cffunction name="sectionOrder">
  	<cfargument name="event" />
  	<cfscript>
	var rc = event.getCollection();
 		sections = application.members.profile.getSections();

		for (i=1; i lte sections.recordcount; i = i + 1){
			data = structnew();
			data.ID = sections.ID[i];
			data.communityID = rc.communityID;
			if (rc.move eq '-1' and data.ID neq rc.ID){
				if(i eq rc.sortorder){
					data.sortorder = i - 1;
				} else if(i eq rc.sortorder -1){
					data.sortorder = i + 1;
				} else {
					data.sortorder = i;
				}

			// Move Down
			} else if (rc.move eq '1' and data.ID neq rc.ID){
	
				if(i eq rc.sortorder){
					data.sortorder =i + 1;
				}else if(i eq rc.sortorder +1){
					data.sortorder = i - 1;
				} else {
					data.sortorder = i;
				}
			} else if (data.ID eq rc.id) {
				data.sortorder = i + rc.move;
			}
			application.members.profile.saveSection(data);
			structclear(data);
		}
	</cfscript>
	</cffunction>
	
	<cffunction name="question">
	  	<cfargument name="event" />
	  	<cfscript>
		  	var rc = event.getCollection();
	  		event.setvalue('sections', application.members.profile.getSections(communityID = event.getValue('communityID')));
	 		event.setvalue('qQuestion', application.members.profile.getQuestions(questionID=rc.id, communityID = event.getValue('communityID')));
	 		event.setvalue('qFieldSets', application.members.profile.getQuestions(type='fieldSet', communityID = event.getValue('communityID')));

	 		event.setLayout('layout.AJAX');
	 	</cfscript>
	</cffunction>
	
	<cffunction name="questionSubmit">
		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.members.profile.saveQuestion(rc);
		</cfscript>
	</cffunction>

	<cffunction name='deleteQuestion'>
  		<cfargument name="event" />
		<cfscript>
			var rc = event.getCollection();
			application.members.profile.deleteQuestion(rc.id);
	 	</cfscript>
	</cffunction>

	<cffunction name="questionOrder">
		<cfargument name="event" />
  		<cfscript>
		var rc = event.getCollection();
 			questions = application.members.profile.getQuestions(sectionID=rc.sectionID);

			for (i=1; i lte questions.recordcount; i = i + 1){
				data = structnew();
				data.ID = questions.ID[i];
				data.communityID = rc.communityID;
				if (rc.move eq '-1' and data.ID neq rc.ID){
					if(i eq rc.sortorder){
						data.sortorder = i - 1;
		
					}else if(i eq rc.sortorder -1){
						data.sortorder = i + 1;
					} else {
						data.sortorder = i;
					}
				// Move Down
				} else if (rc.move eq '1' and data.ID neq rc.ID){
					if(i eq rc.sortorder){
						data.sortorder =i + 1;
					}else if(i eq rc.sortorder +1){
						data.sortorder = i - 1;
					} else {
						data.sortorder = i;
					}
				} else if (data.ID eq rc.id) {
					data.sortorder = i + rc.move;
				}
				application.members.profile.saveQuestion(data);
				structclear(data);
			}
		</cfscript>
	</cffunction>
</cfcomponent>