<div class="mod">
<div class="hd">Send Invitation</div>
<div class="bd">
<cfsetting showdebugoutput="no"> 
<cfoutput>
<div id="manageTabs">
	<ul>
    
       	<li><a href="##tabs-1" class="blackText"><img src="#application.cdn.fam#email.png"> Email</a></li>
<li><a href="##tabs-2" class="blackText"><img src="#application.cdn.fam#email.png"> Invitation Code</a></li>
      	<li><a href="##tabs-3" class="blackText"><img src="#application.cdn.fam#link.png"> Web Link</a></li>
      

    </ul>
   

    <div id="tabs-1" class="ui-tabs-hide" >
Enter the email addresses below of the people you'd like to invite.  Seperate each email address with a semi-colon (;)<BR /><BR />
<div align="center">
 <form action="#event.buildLink('member.invite.sendSubmit')#" method="post">
    <input type="hidden" value="email" name="source"/>
    <textarea name="emails" cols="90" rows="5"></textarea><BR><BR />
    <input type="submit" value="Send">       
     </form>
     </div>
    </div>
 <div id="tabs-2" class="ui-tabs-hide" >
 Invitation Codes allow you to create your own trackable code for distribution to your contacts.   You provide the invitee's with the following URL: http://#request.community.baseurl#/invite and the code you created.
 <BR /><BR />
<div align="center">
 <form action="#event.buildLink('member.invite.sendSubmit')#" method="post">
    <input type="hidden" value="invitationcode"  name="source"/>
    Code: <input type="text" name="invitationCode"><BR>
    <span class="xsmall">(example: Forum2009)</span><BR /><BR />
    <input type="submit" value="Create">      
 </form>
</div>
    </div>
            <div id="tabs-3" class="ui-tabs-hide" >
            By creating a web link, you have a trackable URL that you can distribute to your contacts. The URL will look something like: http://#request.community.baseurl#?invite=facebook2009
            <BR /><BR />
<div align="center">
 <form action="#event.buildLink('member.invite.sendSubmit')#" method="post">
 <input type="hidden" value="web"  name="source"/>
    Name:        <input type="text" name="campaign"><BR>
    <span class="xsmall">(example: Facebook Link)</span><BR /><BR />
    
    <input type="submit" value="Create">
           </form>
            </div>
     </div>
</div>
<script type="text/javascript">
		$("##manageTabs").tabs({
    load: function(event, ui) {
    }
});
</script>
</cfoutput></div>
<div class="ft"></div>
</div>