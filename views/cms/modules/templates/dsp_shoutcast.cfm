<script type="text/javascript" src="/scripts/jquery.jplayer.min.js"></script>
<link href="/css/jplayer.blue.monday.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){
$("#jquery_jplayer_1").jPlayer({
ready: function () {
$(this).jPlayer("setMedia", {
mp3: "<cfoutput>#qGetModules.displayTag#;stream/1</cfoutput>"
}).jPlayer("play");
},
swfPath: "/flash",
supplied: "mp3"
});
});
$(document).ready(function() {
pollstation();
//refresh the data every 30 seconds
setInterval(pollstation, 30000);
});
function pollstation(){
$.get('/tools/shoutcast.cfm?shoutcastFeed=<cfoutput>#qGetModules.displayTag#</cfoutput>', function(data) {
var update = new Array();
update = data.split(',');
if (update[1] == 1) {
$('#nowplaying').html(update[6]+'<BR>'+ update[0] + ' listeners');
} else {
$('#nowplaying').html('Server Offline.');
}
});
}
//]]>
</script><div class="jp-jplayer" id="jquery_jplayer_1">
	&nbsp;</div>
<div class="jp-audio">
	<div class="jp-type-single">
		<div class="jp-interface" id="jp_interface_1">
			<ul class="jp-controls">
				<li>
					<a class="jp-play" href="#" tabindex="1">play</a></li>
				<li>
					<a class="jp-pause" href="#" tabindex="1">pause</a></li>
				<li>
					<a class="jp-stop" href="#" tabindex="1">stop</a></li>
				<li>
					<a class="jp-mute" href="#" tabindex="1">mute</a></li>
				<li>
					<a class="jp-unmute" href="#" tabindex="1">unmute</a></li>
			</ul>
			<div class="jp-progress">
				<div class="jp-seek-bar">
					<div class="jp-play-bar">
						&nbsp;</div>
				</div>
			</div>
			<div class="jp-volume-bar">
				<div class="jp-volume-bar-value">
					&nbsp;</div>
			</div>
			<div class="jp-current-time">
				&nbsp;</div>
			<div class="jp-duration">
				&nbsp;</div>
		</div>
		<div class="jp-playlist" id="jp_playlist_1">
			<ul>
				<li id="nowplaying">
					&nbsp;</li>
			</ul>
		</div>
	</div>
</div>
