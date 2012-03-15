<cfscript>
	getPhoto = rc.contentModuleData.query;
		sibling = 
						application.content.gateway.get(
							parentID=getPhoto.parentID,
							updateviews = 0,
							sort='sortorder asc',
							approved=1,
							mode='simple'
						);
		
				parent = 
						application.content.gateway.get(
							contentID=getPhoto.parentID,
							updateviews = 0,
							approved=1
						);

	photoArray = arraynew(1);
	pointer = 1;
	for(i=1; i lte sibling.recordcount; i=i+1){
		arrayAppend(photoArray,sibling.contentid[I]);
		if (sibling.contentID[i] eq getphoto.contentID){ pointer = i; }
	}
</cfscript>
<Cfoutput>
	 

<cfloop query="getPhoto">
	<h2>#getphoto.title#</h2>
	#desc#
	<a href="#image#" rel="gallery" title="#title#" class="aNone small">
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=image, size='100%', title='#title#',showColorBox=1)#
	</a>
	<div align="Center">
		<cfif pointer neq 1><a href="/index.cfm/content/#getPhoto.contenttype#/#photoarray[pointer-1]#"><<</a></cfif>  
		#pointer# of #sibling.recordcount#
		<cfif pointer neq arraylen(photoarray)><a href="/index.cfm/content/#getPhoto.contenttype#/#photoarray[pointer+1]#">>></a> </cfif>
	</div>
</cfloop>
</cfoutput>