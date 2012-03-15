<cfcomponent name="ImageObject">
<!---
	ImageObject_imagecfc.cfc written by Rick Root (rick@webworksllc.com)

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
<cfset variables.imageCFC = createObject("component","image")>
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
<cfset variables.imageCFC.setOption("throwonerror",true)>

<!---

	init(filename)        Initialize object from a file.
	init(width, height)   Initialize with a blank image
	init(bufferedImage)   Initiailize with an existing object
--->
<cffunction name="init" access="public" output="false" returnType="void">
	<cfargument name="source" type="string" required="yes">

	<cfif fileExists(arguments.source)>
		<cfset imageResults = variables.imageCFC.readImage(arguments.source, "no")>
		<cfset variables.img = imageResults.img>
	<cfelse>
		<cfthrow message="Image Error" detail="File Not Found.">
	</cfif>
	<cfif variables.revertimg eq "">
		<cfset variables.revertimg = variables.img>
	</cfif>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>
	<cfreturn>
</cffunction>

<cffunction name="flipHorizontal" access="public" output="true" returnType="void" hint="Flip an image horizontally.">
	<cfset var imageResults = imageCFC.flipHorizontal(variables.img,"","")>
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = imageResults.img>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>
</cffunction>

<cffunction name="getImageInfo" access="public" output="true" returntype="struct" hint="Returns image information.">
	<cfreturn variables.imageInfo>
</cffunction>
<cffunction name="getImageObject" access="public" output="true" returntype="struct" hint="Returns a java Buffered Image Object.">
	<cfreturn variables.img>
</cffunction>

<cffunction name="flipVertical" access="public" output="true" returntype="void" hint="Flop an image vertically.">
	<cfset var imageResults = imageCFC.flipVertical(variables.img,"","")>
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = imageResults.img>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>
</cffunction>

<cffunction name="scaleWidth" access="public" output="true" returntype="void" hint="Scale an image to a specific width.">
	<cfargument name="newWidth" required="yes" type="numeric">
	<cfset var imageResults = imageCFC.scaleWidth(variables.img,"","", newWidth)>
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = imageResults.img>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>

</cffunction>

<cffunction name="scaleHeight" access="public" output="true" returntype="void" hint="Scale an image to a specific height.">
	<cfargument name="newHeight" required="yes" type="numeric">
	<cfset var imageResults = imageCFC.scaleHeight(variables.img,"","", newHeight)>
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = imageResults.img>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>
</cffunction>

<cffunction name="resize" access="public" output="true" returntype="void" hint="Resize an image to a specific width and height.">
	<cfargument name="newWidth" required="yes" type="numeric">
	<cfargument name="newHeight" required="yes" type="numeric">
	<cfargument name="preserveAspect" required="no" type="boolean" default="FALSE">
	<cfargument name="cropToExact" required="no" type="boolean" default="FALSE">

	<cfset var imageResults = imageCFC.resize(variables.img,"","",newWidth,newHeight,preserveAspect,cropToExact)>
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = imageResults.img>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>
</cffunction>

<cffunction name="crop" access="public" output="true" returntype="void" hint="Crop an image.">
	<cfargument name="fromX" required="yes" type="numeric">
	<cfargument name="fromY" required="yes" type="numeric">
	<cfargument name="newWidth" required="yes" type="numeric">
	<cfargument name="newHeight" required="yes" type="numeric">
	<cfset var imageResults = imageCFC.crop(variables.img,"","",fromX,fromY,newWidth,newHeight)>
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = imageResults.img>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>

</cffunction>

<cffunction name="rotate" access="public" output="true" returntype="void" hint="Rotate an image (+/-)90, (+/-)180, or (+/-)270 degrees.">
	<cfargument name="degrees" required="yes" type="numeric">
	<cfset var imageResults = imageCFC.rotate(variables.img,"","",degrees)>
	<cfset variables.revertimg = variables.img>
	<cfset variables.img = imageResults.img>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>

</cffunction>

<cffunction name="save" access="public" output="false" returnType="void">
	<cfargument name="filename" type="string" required="no">
	<cfargument name="jpegCompression" type="numeric" required="no">
	<cfif isDefined("arguments.jpegCompression") and isNumeric(arguments.jpegCompression)>
		<cfset imageCFC.writeImage(filename,variables.img,jpegCompression)>
	<cfelse>
		<cfset imageCFC.writeImage(filename,variables.img)>
	</cfif>
</cffunction>

<cffunction name="revert" access="public" output="true" returntype="void" hint="Undo the previous manipulation.">
	<cfset variables.img = variables.revertimg>
	<cfset variables.imageInfo = imageCFC.getImageInfo(variables.img,"")>
</cffunction>

<cffunction name="internalThrow" access="private" output="false" returnType="void">
	<cfargument name="detail" type="string" required="yes">

	<cfset var retVal = StructNew()>
	
	<cfthrow detail="#arguments.detail#" message="#arguments.detail#">
</cffunction>

</cfcomponent>
