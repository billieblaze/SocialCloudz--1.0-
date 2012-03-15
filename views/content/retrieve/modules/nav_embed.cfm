<cfscript>
qry_content = rc.content.query;
</cfscript>
<cfoutput>
</cfoutput>
	Copy and paste this code to your favorite sites to display this Video in Flash!<BR>
<textarea style="width:99%; height:50px" id="embed" name="embed">
<cfif application.content.getAttribute(qry_content.attribs,'embed') neq ''>
<cfoutput>#application.content.getAttribute(qry_content.attribs,'embed')#</cfoutput>
<cfelse><cfoutput><object width="251" height="200" data="http://#request.community.baseurl#/flash/video/flowplayer-3.1.0.swf??0.3650005926529897" type="application/x-shockwave-flash">
<param name="movie" value="http://#request.community.baseurl#/flash/video/flowplayer-3.1.0.swf?0.3650005926529897" />
<param name="allowfullscreen" value="true" />
<param name="wmode" value="transparent" />
<param name="allowscriptaccess" value="always" />
<param name="flashvars" value='config={"clip":{"autoPlay":false,"loop":false,"url":"#application.content.getAttribute(qry_content.attribs,'file')#"},"playlist":[{"url":"http://#request.community.baseurl##application.content.getAttribute(qry_content.attribs,'file')#","baseUrl":"http://#request.community.baseurl#"}],"plugins":{"controls":{"time":false,"volume":false,"fullscreen":false},"content":{"url":"http://#request.community.baseurl#/flash/flowplayer-3.1.0.swf","html":"Flash plugins work too"}}}' />
</object></cfoutput></cfif></textarea>
<div align="center">
<input type="button" value="Copy To Clipboard" id="copyEmbed">
</div>
	

<script>
$(document).ready(function(){ 
	ZeroClipboard.setMoviePath( '/flash/ZeroClipboard.swf' );
	clip = new ZeroClipboard.Client();
	clip.setHandCursor( true );
			
	clip.addEventListener('complete', my_complete);
	embedText = $('#embed').val();
	clip.setText( embedText );
	clip.glue( 'copyEmbed' );


});
function my_complete(client, text) {
	window.alert('Copied to clipboard');
}



</script>
