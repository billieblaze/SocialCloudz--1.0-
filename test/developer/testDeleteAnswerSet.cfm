<cfdump var="#application#">
<cfset q1 = application.members.profile.getQuestions(answerSet=1,questionID=156,memberID=1)>
<cfdump var="#q1#">
<cfset q2 = application.members.profile.deleteMultiQuestionAnswers(answerSet=1,questionID=156,memberID=1)>
<cfset q3 = application.members.profile.getQuestions(answerSet=1,questionID=156,memberID=1)>
<cfdump var="#q3#">