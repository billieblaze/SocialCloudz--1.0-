/**
* QRcode writer coldbox plugin
*/
component singleton="true"{
	property name="javaloader" inject="coldbox:plugin:javaloader" scope="instance";
	
	
	instance = {};
	any function init(){
		
		// Plugin Properties
		setPluginName("QRCodeWriter");
		setPluginVersion("1.0");
		setPluginDescription("QRcode writer coldbox plugin");
		setPluginAuthor("Alagukannan");
		setPluginAuthorURL("http://www.alagukannan.com/");	
		return this;
	}
	
	
	/**
	* @hint returns the QR Code coldfusion image for the given contents.
	**/	
	any function getQRCodeImage(required string contents,
								required numeric width=160,
								required numeric height=160){
		var bitMatrix = getQRCodeWriter().encode(arguments.contents,getQRBarCodeFormatCode(),arguments.width,arguments.height);
		var imageBuffer = getMatrixToImageWriter().toBufferedImage( bitMatrix );							
	    return ImageNew(imageBuffer);
	}

	/**
	* @hint writes the QR Code coldfusion image to the destination.
	**/	
	void function writeQRCodeImage(required string contents,
								required numeric width=160,
								required numeric height=160,
								required destination,
								boolean overwrite=true){
		var QRImage = 	getQRCodeImage(argumentCollection=arguments);
		if (isImage(QRImage))
			imageWrite(QRImage,arguments.destination,arguments.overwrite);
		else
			throw(type="QRCodeWriter.NotImageType",message="QRCodeWriter getQRCodeImage() did not return a valid image.");
	}

	/**
	* @hint get the QR Code format code.
	**/	
	any function getQRBarCodeFormatCode(){
		return instance.QRBarCodeFormatCode;
	}

	/**
	* @hint get the QR Code writer.
	**/	
	any function getQRCodeWriter(){
		return instance.QRCodeWriter;
	}	

	/**
	* @hint get the MatrixToImageWriter objects.
	**/	
	any function getMatrixToImageWriter(){
		return instance.MatrixToImageWriter;
	}	

	/**
	* @hint get the JavaLoader plugin. For advanced Use.
	**/		
	any function getJavaLoader(){
		return instance.javaloader;
	}
	
	/**
	* @hint Setting up the Zxing QR Code writer
	**/
	void function setup() onDIComplete{
		instance.javaloader.setup(instance.javaloader.queryJars(getDirectoryFromPath(getCurrentTemplatePath()) & '/zxing-1.7'));
		instance.BarcodeFormat = instance.javaloader.create("com.google.zxing.BarcodeFormat");
		instance.QRBarCodeFormatCode = instance.BarcodeFormat.QR_CODE;
		instance.QRCodeWriter = instance.javaloader.create("com.google.zxing.qrcode.QRCodeWriter");
		instance.MatrixToImageWriter = instance.javaloader.create("com.google.zxing.client.j2se.MatrixToImageWriter");
	}
}
