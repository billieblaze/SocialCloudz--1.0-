<!-----------------------------------------------------------------------
Author 	 :	bill berzinskas
Date     :	10/5/2011
Description : 			
 multi-homed image manipulation module
----------------------------------------------------------------------->
<cfcomponent hint="" 
			 extends="coldbox.system.EventHandler" 
			 output="false">
	<cffunction name="preHandler" access="public" returntype="void" output="false" hint="Executes before any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();

			if (not isdefined('rc.image')){ throw( message = 'you must specify an image to process', type= 'fileNotSpecified');	}
				
			rc.output.overwrite = 1;				// prepare the output object
			rc.output.fileName = listlast(rc.image, '/');

			rc.input.file = '#rc.image#';			//save original requested file info in all its variations
			rc.input.path = replace (rc.image, rc.output.fileName,'');
			rc.input.path = replace(rc.input.path, '/cache', '');
			rc.input.path = replace(rc.input.path, '/http:', 'http:/');
			
			rc.input.extension = listlast(rc.input.file, '.');
			rc.input.fileNoExtension = listfirst(rc.output.fileName, '.');
			rc.input.originalFilename = rc.input.originalFilename = '#rc.input.fileNoExtension#.#rc.input.extension#';

			if (rc.image contains 'resize_to'){
				rc.dimensions = listGetAt(rc.image, listLen(rc.image,'.')-1, '.');
				rc.image = replace(rc.image, '.resize_to.','');
				rc.image = replace(rc.image, rc.dimensions, '');
			}
			
			rc.imgData = imageRead(rc.input.path & urlEncodedFormat(rc.input.originalfilename));			// get image info
			
			
			rc.input.imgInfo = imageInfo(rc.imgData);
			
			rc.output.path = '#getModuleSettings('imageManager').settings.cachePath#/#rc.image##rc.input.fileNoExtension#.#rc.input.extension#';
			rc.output.url = '#getModuleSettings('imageManager').settings.cacheURL#/#rc.image##rc.input.fileNoExtension#.#rc.input.extension#';
			
		</cfscript>
	</cffunction>
	
	<cffunction name="resize" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();

			if (not isdefined('rc.dimensions') 	and (not isdefined('rc.height') and not isdefined('rc.width'))	){ throw( message = 'you must specify an dimensions or height / width for the output image', type= 'parameterNotSpecified');} 
			
			if ( isdefined('rc.dimensions') ){
				rc.height = listfirst(rc.dimensions,'x');
				rc.width = listlast(rc.dimensions,'x');
			} 
			
			if ((not isdefined('rc.width') or rc.width eq 0) and rc.height neq 0){   	ImageScaleToFit(rc.imgData,"",rc.height);    	}
			if ((not isdefined('rc.height') or rc.height eq 0) and rc.width neq 0){   	ImageScaleToFit(rc.imgData,rc.width,"");		}
			if (rc.height neq 0 and rc.width neq 0){ 		
				if (not isDefined('rc.constrain')){
					if (rc.height gt rc.width){
						ImageScaleToFit(rc.imgData,'',rc.height); 
						rc.cropX = 0; // todo:(rc.width - rc.height) / 2;
						rc.cropY = 0;
						imageCrop(rc.imgData, rc.cropX, rc.cropY, rc.width, rc.height);
					} else if (rc.width gte rc.height){ 
						ImageScaleToFit(rc.imgData,rc.width,''); 			
						rc.cropX = 0;
						rc.cropY = (rc.width - rc.height) / 2;
						imageCrop(rc.imgData, rc.cropX, rc.cropY, rc.width, rc.height);
					}
				} else { 
					ImageScaleToFit(rc.imgData,rc.width,rc.height); 
				}
			}
			
			rc.output.path = '#getModuleSettings('imageManager').settings.cachePath#/#rc.input.path##rc.input.fileNoExtension#.resize_to.#rc.height#x#rc.width#.#rc.input.extension#';
			rc.output.url = '#getModuleSettings('imageManager').settings.cacheURL#/#rc.input.path##rc.input.fileNoExtension#.resize_to.#rc.height#x#rc.width#.#rc.input.extension#';
			rc.output.overwrite = 0;
			
		</cfscript>
	</cffunction>
			
	<cffunction name="rotate" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			
			if (not isdefined('rc.angle')){ throw( message = 'you must specify the angle to rotate the output image', type= 'parameterNotSpecified');	}

			imageRotate(rc.imgData, rc.angle);
		</cfscript>
	</cffunction>
				
	<cffunction name="crop" returntype="Void" output="false">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		
			if (not isdefined('rc.x')){ throw( message = 'you must specify the x origin the output image', type= 'parameterNotSpecified');	}
			if (not isdefined('rc.y')){ throw( message = 'you must specify the y origin the output image', type= 'parameterNotSpecified');	}
			if (not isdefined('rc.width')){ throw( message = 'you must specify the width of the output image', type= 'parameterNotSpecified');	}
			if (not isdefined('rc.height')){ throw( message = 'you must specify the height of the output image', type= 'parameterNotSpecified'); }

			imageCrop(rc.imgData, rc.x, rc.y, rc.width, rc.height);
		</cfscript>
	</cffunction>
				
	<cffunction name="watermark">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
			var objWatermark = '';
			
			if (not isdefined('rc.watermark')){ throw( message = 'you must specify a path or url for the watermark image', type= 'parameterNotSpecified');	}
			if (not isdefined('rc.position')){ 	throw( message = 'you must specify a position for the watermark image', type= 'parameterNotSpecified');	}
			if (not listfind('topLeft,topRight,bottomLeft,bottomRight', rc.position)){	throw( message = 'you must specify a valid position for the watermark: topLeft, topRight, bottomLeft, bottomRight', type= 'parameterNotSpecified');	}
			
			objWatermark = ImageRead(rc.watermark);

			ImageSetAntialiasing(rc.imgData,"on");
			ImageSetDrawingTransparency(rc.imgData,0);
		 
			switch(rc.position){
				case 'topLeft': {
					watermarkX = 20;
					watermarkY = 20;
					break;
				}

				case 'topRight': {
					watermarkX = rc.imgData.GetWidth() - objWatermark.GetWidth() - 20;
					watermarkY = 20;
					break;
				}

				case 'bottomLeft': {
					watermarkX = 20;
					watermarkY = rc.imgData.GetHeight() - objWatermark.GetHeight() - 20;
					break;
				}

				case 'bottomRight': {
					watermarkX =rc.imgData.GetWidth() - objWatermark.GetWidth() - 20;
					watermarkY = rc.imgData.GetHeight() - objWatermark.GetHeight() - 20;
					break;
				}
			}
			
			ImagePaste(	rc.imgData,	objWatermark, watermarkX, watermarkY	);
		</cfscript>
	</cffunction>
	
	<cffunction name="postHandler" access="public" returntype="void" output="false" hint="Executes after any event in this handler">
		<cfargument name="event" type="any">
		<cfscript>	
			var rc = event.getCollection();
		
			try {	directoryCreate(getDirectoryFromPath( rc.output.path ));	} catch(Any e) {} 
			imageWrite('rc.imgData', rc.output.path,1);

			if (isDefined('url.debug')){
				writeOutput('Input:');	writeDump(rc.input);
				writeOutput('Output:');	writeDump(rc.output);
				writeOutput('<img src="#rc.output.url#">');
				abort;
			}			
						
			//TODO: store it back to the sourcefile or not?? 
			//if (structKeyExists(rc.output, 'overwrite')){
				// overwrite the original 
					// Local
						// NO IDEA WHAT TO DO HERE, only possible for mapped storage locations
								
					// Cloudfiles
		 	 			// SEND BACK TO CF
			//}
			
			relocate(rc.output.url);
		</cfscript>
	</cffunction>
	
	<cffunction name="onError" access="public" returntype="void" output="false" hint="Executes if ANY error ocurrs in this handler.">
		<cfargument name="event" 		type="any">
		<cfargument name="faultAction" 	type="any" hint="The name of the action that caused the exception">
		<cfargument name="exception" 	type="any" hint="The exception object">
		<cfscript>	
			var rc = event.getCollection();
			writeDump(arguments.exception);
			abort;
		</cfscript>
	</cffunction>

</cfcomponent>