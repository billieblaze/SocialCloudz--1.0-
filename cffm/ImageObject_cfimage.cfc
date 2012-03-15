<cfcomponent name="ImageObject">
<!---
	ImageObject_cfimage.cfc written by Rick Root (rick@webworksllc.com)

	This is a customized version specifically used in CFFM 1.21+
	
	see http://www.opensourcecf.com/cffm
	
	LICENSE
	-------
	Copyright (c) 2006, Rick Root <rick@webworksllc.com>
	All rights reserved.

	Redistribution and use in source and binary forms, with or 
	without modification, are permitted provided that the 
	following conditions are met:

	- Redistributions of source code must retain the above 
	  copyright notice, this list of conditions and the 
	  following disclaimer. 
	- Redistributions in binary form must reproduce the above 
	  copyright notice, this list of conditions and the 
	  following disclaimer in the documentation and/or other 
	  materials provided with the distribution. 
	- Neither the name of the Webworks, LLC. nor the names of 
	  its contributors may be used to endorse or promote products 
	  derived from this software without specific prior written 
	  permission. 

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND 
	CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
	INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
	MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
	CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
	SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
	BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
	HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE 
	OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS 
	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--->

<cfset variables.img = "">
<cfset variables.revertimg = "">
<cfset variables.imageInfo = structNew()>
	<cfset variables.imageInfo.width = 0>
	<cfset variables.imageInfo.height = 0>
	<cfset variables.imageInfo.colorModel = "">
	<cfset variables.imageInfo.colorspace = "">
	<cfset variables.imageInfo.objColorModel = "">
	<cfset variables.imageInfo.objColorspace = "">
	<cfset variables.imageInfo.sampleModel = "">
	<cfset variables.imageInfo.imageType = 0>
	<cfset variables.imageInfo.misc = "">
	<cfset variables.imageInfo.canModify = false>

<cffunction name="init" access="public" output="false" returnType="void">
	<cfargument name="source" type="string" required="yes">

	<cfset var LOCAL = StructNew()>
	
	<cfif fileExists(arguments.source)>
		<cfimage action="read" name="variables.img" source="#arguments.source#">
		<cfimage action="info" structName="variables.imageinfo" source="#variables.img#">
	<cfelse>
		<cfthrow message="Image Error" detail="File Not Found.">
	</cfif>
	<cfreturn>
</cffunction>

<cffunction name="flipHorizontal" access="public" output="true" returnType="void" hint="Flip an image horizontally.">
	<cfset var LOCAL = structNew()>
	
	<cfset LOCAL.imageResults = variables.img>
	<cfset ImageFlip(LOCAL.imageResults,"horizontal")>
	
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = LOCAL.imageResults>
	<cfset variables.imageInfo = getImageInfo()>

</cffunction>

<cffunction name="getImageInfo" access="public" output="true" returntype="struct" hint="Returns image information.">
	<cfimage action="info" structName="variables.imageinfo" source="#variables.img#">
	<cfreturn variables.imageInfo>
</cffunction>
<cffunction name="getImageObject" access="public" output="true" returntype="struct" hint="Returns a java Buffered Image Object.">
	<cfreturn variables.img>
</cffunction>

<cffunction name="flipVertical" access="public" output="true" returntype="void" hint="Flop an image vertically.">
	<cfset var LOCAL = structNew()>
	
	<cfset LOCAL.imageResults = variables.img>
	<cfset ImageFlip(LOCAL.imageResults,"vertical")>
	
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = LOCAL.imageResults>
	<cfset variables.imageInfo = getImageInfo()>

</cffunction>

<cffunction name="scaleWidth" access="public" output="true" returntype="void" hint="Scale an image to a specific width.">
	<cfargument name="newWidth" required="yes" type="numeric">

	<cfset var LOCAL = structNew()>
	<cfset LOCAL.ratio = arguments.newWidth / variables.imageinfo.width>
	<cfset LOCAL.newHeight = round(variables.imageinfo.height * LOCAL.ratio)>

	<cfimage source="#variables.img#" action="resize" height="#LOCAL.newHeight#" width="#arguments.newWidth#" name="LOCAL.imageResults">
	
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = imageResults>
	<cfset variables.imageInfo = getImageInfo()>

</cffunction>
<cffunction name="scaleHeight" access="public" output="true" returntype="void" hint="Scale an image to a specific height.">
	<cfargument name="newHeight" required="yes" type="numeric">

	<cfset var LOCAL = structNew()>
	<cfset LOCAL.ratio = arguments.newHeight / variables.imageinfo.height>
	<cfset LOCAL.newWidth = round(variables.imageinfo.width * LOCAL.ratio)>

	<cfimage source="#variables.img#" action="resize" height="#arguments.newHeight#" width="#LOCAL.newWidth#" name="LOCAL.imageResults">
	
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = LOCAL.imageResults>
	<cfset variables.imageInfo = getImageInfo()>

</cffunction>


<cffunction name="resize" access="public" output="true" returntype="void" hint="Scale an image to a specific height.">
	<cfargument name="newWidth" required="yes" type="numeric">
	<cfargument name="newHeight" required="yes" type="numeric">
	<cfargument name="preserveAspect" required="no" type="boolean" default="FALSE">
	<cfargument name="cropToExact" required="no" type="boolean" default="FALSE">

	<cfset var LOCAL = structNew()>
	<cfset var w = variables.imageInfo.width>
	<cfset var h = variables.imageinfo.height>
	<cfset var specifiedWidth = arguments.newWidth>
	<cfset var specifiedHeight = arguments.newHeight>
	
	<cfscript>
		if (preserveAspect and cropToExact and newHeight gt 0 and newWidth gt 0)
		{
			if (w / h gt newWidth / newHeight){
				newWidth = 0;
			} else if (w / h lt newWidth / newHeight){
				newHeight = 0;
		    }
		} else if (preserveAspect and newHeight gt 0 and newWidth gt 0) {
			if (w / h gt newWidth / newHeight){
				newHeight = 0;
			} else if (w / h lt newWidth / newHeight){
				newWidth = 0;
		    }
		}
		if (newWidth gt 0 and newHeight eq 0) {
			scale = newWidth / w;
			w = newWidth;
			h = round(h*scale);
		} else if (newHeight gt 0 and newWidth eq 0) {
			scale = newHeight / h;
			h = newHeight;
			w = round(w*scale);
		} else if (newHeight gt 0 and newWidth gt 0) {
			w = newWidth;
			h = newHeight;
		} else {
			internalthrow("Cannot resize an image to 0x0.");
		}
	</cfscript>
	<cfimage source="#variables.img#" action="resize" height="#h#" width="#w#" name="LOCAL.imageResults">
	<cfscript>
		LOCAL.imgInfo = getImageInfo();
		// There is a chance that the image is exactly the correct 
		// width and height and don't need to be cropped 
		if 
			(
			arguments.preserveAspect and arguments.cropToExact
			and
			(LOCAL.imgInfo.width IS NOT specifiedWidth OR LOCAL.imgInfo.height IS NOT specifiedHeight)
			)
		{
			// Get the correct offset to get the center of the image
			LOCAL.cropOffsetX = max( Int( (LOCAL.imgInfo.width/2) - (specifiedWidth/2) ), 0 );
			LOCAL.cropOffsetY = max( Int( (LOCAL.imgInfo.height/2) - (specifiedHeight/2) ), 0 );
			
			ImageCrop(LOCAL.imageResults, LOCAL.cropOffsetX, LOCAL.cropOffsetY, specifiedWidth, specifiedHeight);
		}
	</cfscript>
	
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = LOCAL.imageResults>
	<cfset variables.imageInfo = getImageInfo()>

</cffunction>


<cffunction name="crop" access="public" output="true" returntype="void" hint="Crop an image.">
	<cfargument name="fromX" required="yes" type="numeric">
	<cfargument name="fromY" required="yes" type="numeric">
	<cfargument name="newWidth" required="yes" type="numeric">
	<cfargument name="newHeight" required="yes" type="numeric">

	<cfset var LOCAL = structNew()>
	
	<cfset LOCAL.imageResults = variables.img>
	<cfset ImageCrop(LOCAL.imageResults, arguments.fromX, arguments.fromY, arguments.newWidth, arguments.newHeight)>
	
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = LOCAL.imageResults>
	<cfset variables.imageInfo = getImageInfo()>


</cffunction>

<cffunction name="rotate" access="public" output="true" returntype="void" hint="Rotate an image (+/-)90, (+/-)180, or (+/-)270 degrees.">
	<cfargument name="degrees" required="yes" type="numeric">

	<cfimage action="rotate" angle="#arguments.degrees#" source="#variables.img#" name="LOCAL.imageresults">
	
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = LOCAL.imageresults>
	<cfset variables.imageInfo = getImageInfo()>

</cffunction>

<cffunction name="save" access="public" output="false" returnType="void">
	<cfargument name="filename" type="string" required="no">
	<cfargument name="jpegCompression" type="numeric" required="no">

	<cfif isDefined("arguments.jpegCompression") and isNumeric(arguments.jpegCompression)>
		<cfimage action="write" destination="#filename#" source="#variables.img#" quality="#arguments.jpegCompression/100#" overwrite="True">
	<cfelse>
		<cfimage action="write" destination="#filename#" source="#variables.img#" overwrite="True">
	</cfif>
</cffunction>

<cffunction name="revert" access="public" output="true" returntype="void" hint="Undo the previous manipulation.">
	<cfset variables.img = variables.revertimg>
	<cfset variables.imageInfo = getImageInfo()>
</cffunction>

<cffunction name="internalThrow" access="private" output="false" returnType="void">
	<cfargument name="detail" type="string" required="yes">

	<cfset var retVal = StructNew()>
	
	<cfthrow detail="#arguments.detail#" message="#arguments.detail#">
</cffunction>

</cfcomponent>
