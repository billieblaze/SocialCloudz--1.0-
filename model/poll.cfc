<cfcomponent output="no">
	<cffunction name="init" returntype="poll" access="public" output="false">
		<cfargument name="datasource">
		<cfset variables.datasource = arguments.datasource>	
		<cfreturn this />
	</cffunction>
    
    <cffunction name="getCurrentPoll" hint="I get / return the most recent poll ID for a given type">
    <cfargument name="pollType" hint="site, profile, forum">
    <cfset var currentID = ''>
	<cfset var ID = ''>
    <cfquery datasource="#variables.datasource#" name="CurrentID">
        SELECT ifnull(max(questions.ID),0) as questionID
        FROM pollQuestions 
        where type = <cfqueryparam cfsqltype="cf_sql_varchar" value="#pollType#">                
      
        and communityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.community.communityID#">			
      
	</cfquery>
	<cfif currentID.recordcount eq 0>
    	<cfset ID = 0>
    <cfelse>
    	<cfset ID = currentID.questionID>
    </cfif>
    <cfreturn ID>
    </cffunction>
    
    <cffunction name="checkVote" hint="I check to see if the user has voted">
   	 <cfargument name="pollID">
	    <cfset var checkVote = ''>
	    <cfquery datasource="#variables.datasource#" name="checkVote">
			select ID from pollVotes 
			where questionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.pollID#"> 
			and memberID = <cfqueryparam cfsqltype="cf_sql_integer" value="#request.session.memberID#">
		</cfquery>
		<cfreturn checkVote.recordcount>
    </cffunction>
    
    <cffunction name="getPoll">
    <cfargument name="pollID">
    <cfset var Question = ''>
     <cfquery datasource="#variables.datasource#" name="Question">
	  SELECT pollQuestions.ID as questionID, pollQuestions.Question, pollAnswers.ID as answerID, pollAnswers.Answer, ifnull(pollAnswers.votes,0) as votes
	 
	  FROM pollQuestions 
	  left JOIN pollAnswers ON pollQuestions.ID = pollAnswers.QuestionID 
	  WHERE pollQuestions.ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#pollid#">
	  ORDER BY pollAnswers.ID 
	  </cfquery>
	  
	  <cfreturn question>
    </cffunction>
    
    <cffunction name="pastPolls">
    <cfargument name="pollType" default="">
	<cfset var totals = ''>
    <cfquery datasource="#variables.datasource#" name="Totals">
		SELECT ID, question
		 FROM pollQuestions 
		 where 1=1 
			<cfif arguments.pollType neq ''>
			and type= <cfqueryparam cfsqltype="cf_sql_varchar" value="#pollType#"> 
			</cfif>
			and communityID =<cfqueryparam cfsqltype="cf_sql_integer" value="#request.community.communityID#">
		 order by id desc
		
		</cfquery>
		<cfreturn totals>
    </cffunction>
    
    <cffunction name="vote">
 	<cfargument name="questionID">
    <cfargument name="answerID">
		<cfset var lastVote = ''>
		<cfset var newVotes = ''>
        <cfquery datasource="#variables.datasource#" name="LastVote">
            SELECT Votes 
            FROM pollAnswers 
            WHERE QuestionID=<cfqueryparam cfsqltype="cf_sql_integer" value="#questionID#"> AND ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#answerID#"> 
        </cfquery>
        
        <cfset NewVotes=LastVote.Votes + 1>
        
        <cfquery datasource="#variables.datasource#">
            insert into pollVotes (memberid, questionID, answerID)
            values (#request.session.memberid#, #questionID#, #answerID#)
        </cfquery>
        
        <cfquery datasource="#variables.datasource#" >
            UPDATE pollAnswers 
            SET Votes=#NewVotes# 
           WHERE QuestionID=<cfqueryparam cfsqltype="cf_sql_integer" value="#questionID#"> AND ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#answerID#">  
        </cfquery>

    </cffunction>
    
    <cffunction name="delete">
    <cfargument name="ID">


    	<cfquery  datasource="#variables.datasource#">
			 DELETE 
			 FROM pollQuestions
			 WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ID#">
		</cfquery>
		<cfquery datasource="#variables.datasource#">
			 DELETE 
			 FROM pollAnswers
			 WHERE QuestionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ID#">
		</cfquery>
		<cfquery datasource="#variables.datasource#">
			 DELETE 
			 FROM pollVotes
			 WHERE QuestionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#ID#">
		</cfquery>
	</cffunction>        
    
    <cffunction name="insertPoll">
	<cfset var formAnswer = ''>
	<cfset var insertQuestion = ''>
    <cfquery datasource="#variables.datasource#" >
	INSERT
	INTO pollQuestions
	(Question, communityID, memberID, type)
	VALUES
	('#Form.Question#', #request.community.communityID#, #request.session.memberID#,'#form.polltype#') 

</cfquery>

<cfquery datasource="#variables.datasource#" name="insertQuestion">
SELECT @@IDENTITY as identity
</cfquery>

<cfloop list="#form.Answer#" index="FormAnswer" >	
 <cfquery datasource="#variables.datasource#">
   INSERT INTO pollAnswers(QuestionID, Answer)
   VALUES('#insertQuestion.identity#','#FormAnswer#')
 </cfquery>
</cfloop>
<Cfreturn insertQuestion.identity>
</cffunction>

<cffunction name="updatePoll">
	<cfset var a = 0>
<cfquery datasource="#variables.datasource#">
	 UPDATE pollQuestions
	 SET  Question='#Form.Question#'
	 WHERE ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#Form.QuestionID#">
</cfquery>


<cfloop from="1" to="#listlen(form.answer)#" index="A">
<cfif a gt listlen(form.answerID)>
<cfquery  datasource="#variables.datasource#">
	insert into pollAnswers
    (questionID, answer)
    values
    (#form.questionID#, '#listgetat(form.answer,a)#')
</cfquery>
<cfelse>
<cfquery datasource="#variables.datasource#">
	UPDATE pollAnswers
	SET 
	Answer= '#listgetat(Form.Answer,A)#'
	WHERE ID = #listgetat(Form.AnswerID,A)#
</cfquery>
</cfif>
</cfloop>
</cffunction>

<cffunction name="deleteAnswer">
<cfargument name="ID">
<cfquery datasource="#variables.datasource#">
Delete
From pollAnswers
Where Id = <cfqueryparam cfsqltype="cf_sql_integer" value="#Id#">
</cfquery>
</cffunction>

</cfcomponent>  