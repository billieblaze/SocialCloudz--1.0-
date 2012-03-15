<cfcomponent extends="../baseGateway">
	<cffunction name="get" output="no">
		<cfargument name="memberID" default="">
		<cfargument name="sectionID" default="">
		<cfargument name="questionID" default="">
		<cfargument name="answerSet" default="">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfset var qGet = ''>
		<cfquery datasource="#this.datasource#" name="qGet">
			select * from profile 
			where 1=1
			and memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
			and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
		
			<cfif arguments.sectionID neq ''>
			and sectionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sectionID#">
			</cfif>
			
			<cfif arguments.questionID neq ''>
			and questionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.questionID#">
			</cfif>
			
			<cfif arguments.answerSet neq ''>
			and answerSet = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.answerSet#">
			</cfif>

		</cfquery>
		<cfreturn qGet>
	</cffunction>
	
    <cffunction name="save">
		<cfargument name="data">
		
		<cfscript>
			var thisfield = '';
			var data2 = structNew();
			if (not isdefined('arguments.data.answerSet')){arguments.data.answerSet = 1; }
			for(i=1; i lte listlen(data.fieldnames); i=i+1){
				thisfield = listgetat(data.fieldnames, i);
				if(thisfield contains 'question'){
					data2.questionid = replacenocase(thisfield, 'question_', '');
					data2.memberID = arguments.data.memberID;
					data2.value = evaluate('form.#thisfield#');
					data2.answerSet = arguments.data.answerSet;
					super.save('profileAnswers', data2);
				}
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="getTypes">
		<cfargument name='typeID' default = ''>
		<cfscript>
			var profileTypePersonal = application.community.settings.getValue('profileTypePersonal');
			var profileTypeBusiness = application.community.settings.getValue('profileTypeBusiness');
			var myQuery = QueryNew("typeID, name", "Integer,Varchar");
			var newRow = QueryAddRow(MyQuery, 3);
			var qGet = '';
			var temp = QuerySetCell(myQuery, "typeID", "0", 1);			
			
			temp = QuerySetCell(myQuery, "name", "Everyone", 1);
			temp = QuerySetCell(myQuery, "typeID", "1", 2);
			temp = QuerySetCell(myQuery, "name", "#profileTypePersonal#", 2);
			temp = QuerySetCell(myQuery, "typeID", "2", 3);
			temp = QuerySetCell(myQuery, "name", "#profileTypeBusiness#", 3);
		</cfscript>

		<cfquery name="qGet" dbType="query">
			select * from myQuery
		 
			<cfif arguments.typeID neq ''>
				where typeID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.typeID#">
			</cfif>
		
		</cfquery>	
		<cfreturn qGet>
	</cffunction>
	
    <cffunction name="saveType">
		<cfargument name='dataStruct'>
		<cfscript>
			if (not isdefined('arguments.datastruct.communityID')){
				arguments.datastruct.communityID = request.community.communityID;
			}
			super.save('profileTypes', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name='deleteType'>
		<cfargument name='typeid'>
		<cfscript>
			super.delete('profileTypes',arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="getSections">
		<cfargument name='typeID' default = ''>
		<cfargument name='sectionID' default = ''>
		<cfargument name="communityID" default="#request.community.communityID#"> 
		<cfset var qGet = ''>
		<cfquery name="qGet" datasource="#this.datasource#">
		select * from profileSections 
		where communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">

		<cfif arguments.typeID neq ''>
			and (typeid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.typeID#"> or typeid = 0)
		</cfif>
	
		<cfif arguments.sectionID neq ''>
			and id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sectionID#">
		</cfif>
		
		order by sortOrder
		</cfquery>	
		<cfreturn qGet>

	</cffunction>
	
    <cffunction name="saveSection">
		<cfargument name='dataStruct'>
		<cfscript>
			if (not isdefined('arguments.datastruct.communityID')){
				arguments.datastruct.communityID = request.community.communityID;
			}
			super.save('profileSections', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name='deleteSection'>
		<cfargument name='id'>
		<cfscript>
			super.delete('profileSections',arguments);
		</cfscript>
	</cffunction>
	
	<cffunction name="getQuestions">
		<cfargument name="sectionID" default=''> 
		<cfargument name='questionID' default=''>
		<cfargument name='groupID' default=''>
		<cfargument name='memberID' default=''>
		<cfargument name='type' default=''>		
		<cfargument name="answerSet" default="">
		<cfargument name="communityID" default="#request.community.communityID#">
		<cfset var qGet = ''>
		<cfquery name="qGet" datasource="#this.datasource#">
			select * from profileQuestions
			
			inner join profileSections ps on ps.ID = profileQuestions.sectionId
			<cfif arguments.memberId neq ''>
				left join profileAnswers on profileQuestions.id = profileAnswers.questionID 
					and profileAnswers.memberID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">
			</cfif>
			
			where 1=1 
			
			<cfif arguments.sectionID neq ''>
				and sectionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sectionID#">
			</cfif>
		
			<cfif arguments.questionID neq ''>
				and profileQuestions.id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.questionID#">
			</cfif>
	
			<cfif arguments.communityID neq ''>
				and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.communityID#">
			</cfif>
	
			<cfif arguments.groupID neq ''>
				and groupID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.groupID#">
			<cfelseif arguments.questionID eq '' and arguments.groupID eq ''>
				and groupID = 0
			<cfelseif arguments.questionID neq ''>
		
			</cfif>
	
			<cfif arguments.type neq ''>
				and type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.type#">
			</cfif>
		
			<cfif arguments.answerSet neq ''>
				and answerSet = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.answerSet#">
			</cfif>
			
			order by 
			<cfif arguments.memberId neq ''>
				answerSet asc, 
			</cfif>
			
			profileQuestions.sortorder asc

		</cfquery>	
		<cfreturn qGet>
	</cffunction>	
	
    <cffunction name="saveQuestion">
		<cfargument name='dataStruct'>
		<cfscript>
			super.save('profileQuestions', arguments.datastruct);
		</cfscript>
	</cffunction>
	
	<cffunction name='deleteQuestion'>
		<cfargument name='id'>
		<cfscript>
		super.delete('profileQuestions',arguments);
		</cfscript>
	</cffunction>
	<cffunction name="getAnswers">
		<cfargument name="sectionID" default=''> 
		<cfargument name='questionID' default=''>
		<cfargument name='groupID' default=''>
		<cfargument name='memberID' default=''>
		<cfargument name='type' default=''>		
		<cfargument name="answerSet" default="">
		<cfset var qGet = ''>
		<cfquery name="qGet" datasource="#this.datasource#">
			select * from 
				profileAnswers 
				
				where 1=1
				
				and profileAnswers.memberID=<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.memberID#">

			<!--- 
			where 1=1 
			order by 
			
			answerSet asc, 
			
			sortorder asc
			 --->
		</cfquery>	
		<cfreturn qGet>
	</cffunction>	
	<cffunction name="deleteMultiQuestionAnswers">
		<cfargument name="answerSet" default='0' required='yes'> 
		<cfargument name='questionID' default='0' required='yes'> 
		<cfargument name='memberID' default='0' required='yes'> 
		<cfscript>
			super.delete('profileAnswers',arguments);
		</cfscript>		
	</cffunction>
</cfcomponent>