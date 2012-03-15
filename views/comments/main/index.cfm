<Cfscript>
	Comments = event.getvalue('qcomments');
</cfscript>
<cfoutput>
<cfif event.getvalue('displayLayout') neq 0>
<div class="mod">
    <div class="hd"><span id="commentCount">#comments.recordcount#</span> Comments & Responses</div>
    <div class="bd" class="blackText">		 
</cfif>  	
	#renderView('comments/main/form')#
	<div style="max-height:400px; overflow: auto">
		<ol id="update_#event.getvalue('fktype')#" class="timeline">
			<li id="nullfoo" style="border-top: 0px none;"></li>
			 <cfloop query="comments">
				#renderView('comments/main/entry')#
				<ol id="update_#comments.id#" class="timeline" style="padding: 0px 0px 0px 25px;">
					<cfset replies = application.content.comments.get(parentID=comments.id)>
					<cfloop query="replies">
						#renderView('comments/main/entryReply')#
					</cfloop>
					<li style="border-top: 0px none;"></li>
				</ol>
			</cfloop>
		</ol>
	</div>
<cfif event.getvalue('displayLayout') neq 0>
	</div>
    <div class="ft"></div>
    </div>
</cfif>
<script>
	$('textarea.comment').autoResize({
	    onResize : function() {
	        $(this).css({opacity:0.8});
	    },
	    animateCallback : function() {
	        $(this).css({opacity:1});
	    },
	    animateDuration : 300,
	    extraSpace : 40
	});

	$('form##commentForm').ajaxForm({success: showComment});

	function showComment(responseText, statusText, xhr, $form){ 
		$("ol##update_#event.getvalue('fktype')# li:first").before(responseText);
	 	$("ol##update_#event.getvalue('fktype')# li:first").fadeIn("slow");
	 	$('.comment').val(''); 	
		$('##commentAttach').hide();
		$('##commentAttach_content').html('');
	}
	
	var myParentID = 0;
	
	function showReplyForm(divID, parentID){ 
		myParentID = parentID;
		$.get('/index.cfm/comments/main/form/fkType/#rc.fkType#/fkID/#rc.fkID#/commentMemberID/#rc.commentMemberID#/parentID/'+parentID, function(data){
		
			$(divID).before('<li>'+data+'</li>');
			$('##commentForm'+parentID).ajaxForm({success: showReply});
		});

	}

	function showReply(responseText, statusText, xhr, $form){
		$("ol##update_"+myParentID+" li:first").before(responseText);
	 	$("ol##update_"+myParentID+" li:first").fadeIn("slow");
	 	$('.comment').val(''); 	
		$('##commentAttach_content').html('');
		$('##commentAttach').hide();
		$('##commentForm'+myParentID).remove();
	}
	
	function hideReplyForm(parentID){
		$('##commentForm'+parentID).remove();
	}
	
	function attachMedia(div, url, desc){
		$('##'+div+'_content').load(url);
		$('##'+div).show();
		$('##'+div+'_title').html('Attach '+ desc);
	}
	
	function closeAttach(div){
		$('##'+ div +'_content').html('');
		$('##' + div).hide();
	}

	$('.commentReplyForm').hide();
</script>
</cfoutput>