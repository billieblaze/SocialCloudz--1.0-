<cfscript>
folders = event.getvalue('folders');
</cfscript>
	<cfparam name="rc.folder" default="1">
	<script>
	checkFormatter = function(cellvalue,options,rowdata){
		src = ('<div align="center"><input type="checkbox" name="messageID" class="messageID" value="'+cellvalue+'"></div');
		return src;
	}
	imgFormatter = function(cellvalue, options, rowdata){ 
	  src = ('<table border=0><TR><TD width="45" style="border:0px none; !important"><img src="' + cellvalue + '" align="left"></td><TD valign="top" style="border:0px none; !important" class="padRight5"><span class="xsmall">'+rowdata[2] + '<BR>'+rowdata[3]  +'</span></td></tr></table>');
	  return src;
	}
	linkFormatter = function(cellvalue, options, rowdata){ 
		src = '<a href="#" onclick="loadMessage('+rowdata[0]+');" class="aNone blackText padLeft5" >'+cellvalue+'</a>';
		return src;
	}
	
	function loadMessage(messageID){
		$('#messageReadingPane').html('<div align="Center"><img src="/images/progress.gif"> Loading...</div>');
		$('#messageReadingPane').load('/index.cfm/mail/message/read/message/'+messageID);
	}
	
	$(document).ready(function(){
				$("#checkboxall").click(function()				
				{
					var checked_status =true;
					$("input.messageID").each(function()
					{
						this.checked = true;
					});
				});					
			});


	</script>

<div class="mod">
	<div class="hd">
	<cfif rc.folder eq 1>
		Inbox
	<cfelseif rc.folder eq 2>
		Sent Items
	<cfelse>
	    	<cfoutput query="folders">
			<cfif rc.folder eq folderID>#folderName#</cfif>
		</cfoutput>
	</cfif>
	</div>
	<div class="bd">
	<cfoutput>
    <form action="#event.buildLink('mail.util.action')#" method="post">
    <div style="float:left">
    <input type="button" value="Select All" class="small" id="checkboxall"/>
    </div>
    <div align="right">
    <select name="folderID">
    	<cfloop query="folders">
        <option value="#folderID#">#folderName#</option>
        </cfloop>
    </select>
    <input type="submit" name="action" value="Move To Folder"  class="small"/>
    <input type="submit" name="action" value="Delete" class="small"/>
    </div>
    <br style="clear:both" />

		<cfmodule template="/common/dynamicGrid/jqGrid.cfm" 
								gridName = 'messageList' 
								objectName = 'Message'	 
								rows="10"
								
								method = 'application.mail.getMail' 
								arguments = 'memberID=#request.session.memberID#&folder=#rc.folder#' 
								defaultSort = 'dateEntered' 							
			
								pid='#request.session.memberID#'
								datasource="community"
								isAdmin='1' 
		> 
	</cfoutput>
    </form>
</div>
	<div class="ft"></div>
</div>
<div id="messageReadingPane"></div > 