<cfoutput>
	<div class="ui-widget">
		<div class="ui-widget-header">Image</div>
		<div class="ui-widget-content" align="center">
			
				#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
					image=rc.image, 
					size=200,
					id='imagePreview' )#

			<cfmodule template="/customTags/singleUploader.cfm" 
				fkType = "image"
				mediaType = "image"
				autoSubmit = 0
				contentID = "#rc.contentID#"
				previewType = 'image'
				previewElement = 'imagePreview'
				showClear = 1
				value='#rc.image#'
			/>
		</div>
	</div>
</cfoutput>