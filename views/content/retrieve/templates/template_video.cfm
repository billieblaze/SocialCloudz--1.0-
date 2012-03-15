<cfscript>
		q_content = rc.contentModuleData.query;
		videoFile = application.content.getAttribute(q_content.attribs,'file');
		videoFile = replace(videoFile, '.cf', '.stream.cf');
</cfscript>
<cfoutput>
    <h1>#q_content.title#</h1>

	<div align="center">
	
	<div id="description">#contentNav.desc#</div>
	
	<cfif application.content.getAttribute(q_content.attribs,'converted') neq 1>
		This video has not been converted yet.  Conversion generally takes a few minutes, but if it's been more then an hour, you should delete this video and try again.
	<cfelse>
		<cfif application.content.getAttribute(q_content.attribs,'embed') neq ''>
			<BR>
			<cfoutput>#application.content.getAttribute(q_content.attribs,'embed')#</cfoutput>
		<cfelse>
			<script type="text/javascript" src="/scripts/flowplayer-3.2.6.min.js"></script>
			<div style="display:block;width:99%;height:385px; background-color:black" id="player"></div> 
	
		<script>
			$f("player", {src: "/flash/flowplayer-3.2.7.swf", wmode: 'transparent'}, {
					clip: {
						url: '#videoFile#',
						autoPlay: true,
						provider: 'akamai'
					} ,
					plugins: {			
		           		akamai: {
		   					   url: '/flash/AkamaiFlowPlugin.swf'
		           		}
		   			}
					 
			});	
		</script>
		</cfif>
	</cfif>
</div>
</cfoutput>
