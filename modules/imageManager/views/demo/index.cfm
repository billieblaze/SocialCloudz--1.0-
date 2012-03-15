<cfhtmlhead text='
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css"> 
'>

<cfparam name="rc.image" default="/images/Virgo.png">
<cfoutput>
	<form action="">
	Input Image (relative or URL)<br />
	<input type="text" name="image" id="imageSrc" value="#rc.image#" class="ui-corner-all"><input class="ui-state-default ui-corner-all" type="submit" value="Load Image">
	</form>
	<hr>
	<h1>Image Only</h1>
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=rc.image, link='##', size=150, title='Title', subtitle='Posted By: BBlaze<br>Views:300' )#
	<br style="clear:both"/>
	<h1>Mosaic Only</h1>
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=rc.image, link='##', size=150, title='Title', subtitle='Posted By: BBlaze<br>Views:300', showMosaic = 1 )#
	<br style="clear:both" />
	<h1>Tools Only</h1>
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=rc.image, link='##', size=150, title='Title', subtitle='Posted By: BBlaze<br>Views:300', showTools = 1 )#
	
	<br style="clear:both" />
	<h1>Mosaic + Tools</h1>
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=rc.image, link='##', size=150, title='Title', subtitle='Posted By: BBlaze<br>Views:300', showMosaic = 1, showTools = 1 )#
	<br style="clear:both" />
	
	
		<h1>Colorbox</h1>
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image='/images/Virgo.png', link='##', size=150, title='Title', subtitle='Posted By: BBlaze<br>Views:300', showColorBox = 1, colorboxRel = 'gallery' )#
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image='/images/Aquarius.png', link='##', size=150, title='Title', subtitle='Posted By: BBlaze<br>Views:300', showColorBox = 1, colorboxRel = 'gallery' )#
	#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image='/images/Taurus.png', link='##', size=150, title='Title', subtitle='Posted By: BBlaze<br>Views:300', showColorBox = 1, colorboxRel = 'gallery' )#


</cfoutput>
