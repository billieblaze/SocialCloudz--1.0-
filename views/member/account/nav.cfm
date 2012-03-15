<cfoutput>
	<script>
		function removeProfilePic(){
			$.get('/index.cfm/member/account/clearProfileImage/memberID/#rc.memberID#', function(){
				$.jGrowl('Profile Image Cleared.');
			})
		}
	</script>
	<div class="ui-widget">
		<div class="ui-widget-header" style="padding:5px">
			#application.members.getusername(rc.memberID)#
		</div>
	    <div class="ui-widget-content" align="center">
		   
		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		id="imagePreview",
		    		image=application.members.userpic( rc.memberID ), 
		    		size=150, 
		    		showTools = 1 )#

				<cfmodule template="/customTags/singleUploader.cfm" 
						fkType = "profilepic"
						mediaType = "image"
						autoSubmit = 0
						contentID = "#rc.memberID#"
						previewElement = 'profilepic_preview'
						previewType = 'image'
						uploadProc = 'util.upload.profile'
						showClear = 1
						onClearComplete='removeProfilePic'
				/>
	    </div>
	</div>
</cfoutput>