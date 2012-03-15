<cfscript>
	getModule = qGetModules;
	content = application.content.get(contentType='photo',parentID=getModule.displaycontentID, sort="sortorder asc");
</cfscript>
<Cfoutput>
<style type="text/css">
	div##inner-#getModule.msID# div.jcarousel-clip {    height: #getModule.thumbsize#px;}
	div##inner-#getModule.msID# li.jcarousel-item {    width: #getModule.thumbsize#px;    height: #getModule.thumbsize#px;}
</style>

<cfif getmodule.displaycontentID eq ''>
	No Gallery Selected.
<cfelse>
	<ul id="carousel_#getModule.msID#" class="jcarousel-skin-tango">
	   <cfloop query="content">
	    <li>
		    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=content.image, size=thumbsize, showColorBox = 1, colorBoxRel="gallery_#getModule.msID#")#
		
		</li>
		</cfloop>	       	     
 	</ul>

		$(document).ready(function() {
		    $('##carousel_#getModule.msID#').jcarousel();
		});
	</script>
</cfif>
</Cfoutput>