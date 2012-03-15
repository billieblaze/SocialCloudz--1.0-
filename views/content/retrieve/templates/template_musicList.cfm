<Script>


var Playlist = function(instance, playlist, options) {
		var self = this;

		this.instance = instance; // String: To associate specific HTML with this playlist
		this.playlist = playlist; // Array of Objects: The playlist
		this.options = options; // Object: The jPlayer constructor options for this playlist
		this.current = 0;

		this.cssId = {
			jPlayer: "jquery_jplayer_",
			interface: "jp_interface_",
			playlist: "jp_playlist_"
		};
		this.cssSelector = {};

		$.each(this.cssId, function(entity, id) {
			self.cssSelector[entity] = "#" + id + self.instance;
		});

		if(!this.options.cssSelectorAncestor) {
			this.options.cssSelectorAncestor = this.cssSelector.interface;
		}

		$(this.cssSelector.jPlayer).jPlayer(this.options);

		$(this.cssSelector.interface + " .jp-previous").click(function() {
			self.playlistPrev();
			$(this).blur();
			return false;
		});

		$(this.cssSelector.interface + " .jp-next").click(function() {
			self.playlistNext();
			$(this).blur();
			return false;
		});
	};

	Playlist.prototype = {
		displayPlaylist: function() {
			var self = this;
			$(this.cssSelector.playlist + " ul").empty();
			for (i=0; i < this.playlist.length; i++) {
				var listItem = (i === this.playlist.length-1) ? "<li class='jp-playlist-last'>" : "<li>";
				listItem += "<a href='#' id='" + this.cssId.playlist + this.instance + "_item_" + i +"' tabindex='1'>"+ this.playlist[i].name +"</a>";
				// Create links to free media
				if(this.playlist[i].free) {
					var first = true;
					listItem += "<div class='jp-free-media'>(";
					$.each(this.playlist[i], function(property,value) {
						if($.jPlayer.prototype.format[property]) { // Check property is a media format.
							if(first) {
								first = false;
							} else {
								listItem += " | ";
							}
							listItem += "<a id='" + self.cssId.playlist + self.instance + "_item_" + i + "_" + property + "' href='" + value + "' tabindex='1'>" + property + "</a>";
						}
					});
					listItem += ")</span>";
				}

				listItem += "</li>";

				// Associate playlist items with their media
				$(this.cssSelector.playlist + " ul").append(listItem);
				$(this.cssSelector.playlist + "_item_" + i).data("index", i).click(function() {
					var index = $(this).data("index");
					if(self.current !== index) {
						self.playlistChange(index);
					} else {
						$(self.cssSelector.jPlayer).jPlayer("play");
					}
					$(this).blur();
					return false;
				});

				// Disable free media links to force access via right click
				if(this.playlist[i].free) {
					$.each(this.playlist[i], function(property,value) {
						if($.jPlayer.prototype.format[property]) { // Check property is a media format.
							$(self.cssSelector.playlist + "_item_" + i + "_" + property).data("index", i).click(function() {
								var index = $(this).data("index");
								$(self.cssSelector.playlist + "_item_" + index).click();
								$(this).blur();
								return false;
							});
						}
					});
				}
			}
		},
		playlistInit: function(autoplay) {
			if(autoplay) {
				this.playlistChange(this.current);
			} else {
				this.playlistConfig(this.current);
			}
		},
		playlistConfig: function(index) {
			$(this.cssSelector.playlist + "_item_" + this.current).removeClass("jp-playlist-current").parent().removeClass("jp-playlist-current");
			$(this.cssSelector.playlist + "_item_" + index).addClass("jp-playlist-current").parent().addClass("jp-playlist-current");
			this.current = index;
			$(this.cssSelector.jPlayer).jPlayer("setMedia", this.playlist[this.current]);
		},
		playlistChange: function(index) {
			this.playlistConfig(index);
			$(this.cssSelector.jPlayer).jPlayer("play");
		},
		playlistNext: function() {
			var index = (this.current + 1 < this.playlist.length) ? this.current + 1 : 0;
			this.playlistChange(index);
		},
		playlistPrev: function() {
			var index = (this.current - 1 >= 0) ? this.current - 1 : this.playlist.length - 1;
			this.playlistChange(index);
		}
	};
</Script>

<cfscript>
	getModule = qGetModules;
	q_content = rc.contentModuleData.query;
	contentType = rc.contentFilter.contentType;
</cfscript>

<cfoutput query="q_content">

	<cfscript>
		q_childContent = application.content.get(parentID = q_content.contentID);
		myurl = "/index.cfm/content/#contentType#/#q_content.contentID#";
		mydate = dateFormat(application.timezone.castFromServer(q_content.publishDate, application.community.settings.getValue('timezone')),request.community.dateformat);
		myuser = application.members.getusername(q_content.memberid,1);
	</cfscript>
	<div id="jquery_jplayer_#q_content.currentRow#" class="jp-jplayer" style="clear:both"></div>
		<div class="jp-audio">
			<div class="jp-type-playlist">
				<h3>
									<a href="/index.cfm/content/#contentType#?creator=#q_content.creator#">#q_content.creator#</a> - <A href="/index.cfm/content/#contentType#/#q_content.contentID#">#q_content.title#</A>
								</h3>
				<div style="display:inline;" class="jp-details">
							<cfif getmodule.thumbsize neq 'none'>
					          
					           <cfif q_content.image eq ''>
								#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
						    		image=application.members.userpic( memberID ), 
						    		link = myurl,
						    		size=getmodule.thumbsize,
						    		align=getModule.thumbalign
						    		 )#
					             <cfelse>
								#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
									image=q_content.image,
									link=myurl,
									size=getmodule.thumbsize,
									align=getModule.thumbalign )#
					           </cfif>
					        </cfif>
							
							
						          <BR />
							<div id="jp_interface_#q_content.currentRow#" class="ui-corner-all jp-interface">	
							<ul class="jp-controls ui-corner-all ">
								<li><a href="##" class="jp-play" tabindex="1">play</a></li>
								<li><a href="##" class="jp-pause" tabindex="1">pause</a></li>
								<li><a href="##" class="jp-previous" tabindex="1">previous</a></li>
								<li><a href="##" class="jp-next" tabindex="1">next</a></li>
							</ul>
				
					
				
					<div class="jp-progress ui-corner-all ">
						<div class="jp-seek-bar ui-corner-all ">
							<div class="jp-play-bar"></div>
						</div>
					</div>
					<div class="jp-volume-bar ui-corner-all ">
						<div class="jp-volume-bar-value"></div>
					</div>
					<div class="jp-current-time"></div>
				</div>

			</div>
			<br style="clear:both;">
			<div id="jp_playlist_#q_content.currentRow#" class="jp-playlist ui-corner-all ">
				<cfif q_childcontent.recordcount gt 0>
					<ul>
						<!-- The method Playlist.displayPlaylist() uses this unordered list -->
						<li></li>
					</ul>
				</cfif>
				<cfif q_content.desc neq ''>
					#q_content.desc#<BR>
				</cfif>
				
			</div>
		</div>
	
	<cfif q_childcontent.recordcount gt 0>

		
	   <script type="text/javascript">
		$(document).ready(function(){
		var audioPlaylist = new Playlist("#q_content.currentRow#", [
		
		<cfloop  query="q_childcontent">
			<cfscript>
				
				
				if (application.content.getAttribute(q_childcontent.attribs,'CONTAINER') eq ''){ 
					directory = application.content.getAttribute(q_childcontent.attribs,'directory');
					myurl = '#directory#/#application.content.getAttribute(q_childcontent.attribs,'file')#';
				} else { 
					myURL = application.content.getattribute(q_childcontent.attribs,'CDNURL') & '/' & application.content.getAttribute(q_childcontent.attribs,'file');
				}
				</cfscript>
		{
			name:"<cfif q_childcontent.creator eq '' and q_childcontent.title eq ''>#application.content.getAttribute(q_childcontent.attribs, 'file')#<cfelse>#q_childcontent.creator# - #q_childcontent.title#</cfif>",
			mp3:"#myURL#"
			<cfif q_childcontent.download eq 1 or request.session.accesslevel gte 10>,free: true</cfif>
		}<cfif q_childcontent.currentrow neq q_childcontent.recordcount>,</cfif>
		</cfloop>

	], {
		ready: function() {
			audioPlaylist.displayPlaylist();
			audioPlaylist.playlistInit(false); // Parameter is a boolean for autoplay.
		},
		ended: function() {
			audioPlaylist.playlistNext();
		},
		play: function() {
			$(this).jPlayer("pauseOthers");
		},
		swfPath: "/flash",
		supplied: "mp3"
	});
	
    });
  </script>
 </cfif>

</cfoutput>
