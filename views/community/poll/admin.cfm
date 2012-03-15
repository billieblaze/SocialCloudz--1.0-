<cfscript>
poll = event.getValue('poll');
polls = event.getValue('pollList');
</cfscript>


<div class="mod">

        <div class="hd">
			<cfif poll.questionid eq ''>New Poll<cfelse>Update Poll</cfif>
		</div>
	
        <div class="bd">
			<table  border="0" >
	<cfoutput>
		<cfif event.getValue('pollID', '') neq ''>
		<form method="post" action="/index.cfm/community/poll/update">
		<cfelse>
    	<form method="post" action="/index.cfm/community/poll/add">
		</cfif>
			  <tr>
				<td colspan="2" >Enter your poll question here.</td>
			  </tr>
			  <tr>
				<td colspan="2" height="3"></td>
			  </tr>
			 
              <input type="hidden" name="polltype" value="#event.getValue('pollType','module')#" />
		
			  <tr> 
			  	
			  	<td   colspan="">
				
						<input type="Hidden" name="QuestionID" Value="#poll.questionid#">
						<input class="normalHelp" type="text" name="Question" size="55" maxlength="200" Value="#poll.Question#"> 
					
					<br><b>Sample:</b> Do you blog?
				</td>   
			  </tr> 
			  <tr>
				<td colspan="2" height="7"></td>
			  </tr>
              	<tr>
				<td colspan="2" >Enter up to 10 poll answers.</td>
			  </tr>
              
              <cfloop from="1" to="10" index="i">
              <tr>	
				<td >  
                <input class="normalHelp" type="text" name="Answer" size="55" maxlength="200" Value="#poll.Answer[i]#">
				<input type="Hidden" name="AnswerID" Value="#poll.AnswerID[i]#">
                </td><TD  ><cfif poll.questionID neq '' and poll.answerID[i] neq ''><a href="#event.buildLink(linkTo='community.poll.deleteAnswer',queryString='pollType=#event.getvalue('pollType')#&pollID=#event.getvalue('pollID')#&answerId=#poll.Answer[i]#')#" title="delete answer" onclick="return confirm('Are you sure you want to delete this question?');">Delete</a></cfif></td>			
						
			  </td>
			  </tr>
              </cfloop>
              
			
			
				
			
				
			  <tr>
				<td colspan="2" height="15"></td>
			  </tr>
			  <tr>
				<td colspan="2" align="center">
					
						<input type="submit"  value="Submit" class="button">
						<cfif poll.questionid neq ''><input type="button" value="cancel" onclick="location.href='/index.cfm/community/poll/admin/pollType/#event.getValue('pollType')#" class="button"/></cfif>
				</td>
			  </tr>
			  </form>
			</table>	</cfoutput>
		</div>
        <div class="ft"></div>
</div>
	<div class="mod">
        <div class="hd">Edit Polls</div>

        <div class="bd">
			
			<table width="100%">	
				<cfoutput query="polls">
			
					<tr> 
						<td width="150" nowrap>
                        <a href="#event.buildLink(linkTo='community.poll.admin',queryString='pollType=#event.getvalue('pollType','module')#&pollID=#Polls.ID#')#" title="edit poll">Edit</a> |  <a href="#event.buildLink(linkTo='community.poll.delete',queryString='pollType=#event.getvalue('pollType','module')#&pollID=#Polls.ID#')#" title="delete poll" onclick="return confirm('Are you sure you want to delete this poll?');">Delete</a></td>
						<td >#Polls.Question#</td>		
					</tr>
				 
				</cfoutput> 
             
			</table>
		</div>
        <div class="ft"></div> 
</div>