<cfif NOT isDefined('request.imageManagerInitialized') OR NOT request.imageManagerInitialized>
	<cfhtmlhead text='
		<script src="/modules/imageManager/includes/js/jquery.Jcrop.min.js"></script>
		<script src="/modules/imageManager/includes/js/mosaic.1.0.1.min.js"></script>
		<script src="/modules/imageManager/includes/js/jquery.colorbox-min.js"></script>
		<script src="/modules/imageManager/includes/js/jquery.imageManager.js"></script>
		<link href="/modules/imageManager/includes/css/jquery.Jcrop.css" type="text/css" rel="stylesheet"/>
		<link href="/modules/imageManager/includes/css/mosaic.css" type="text/css" rel="stylesheet"/>
		<link href="/modules/imageManager/includes/css/imageManager.css" type="text/css" rel="stylesheet"/>
		<link href="/modules/imageManager/includes/css/colorbox.css" type="text/css" rel="stylesheet"/>'>
	<cfset request.imageManagerInitialized = true>
</cfif>

<cfoutput>  
	<div id="imageContainer_#arguments.ID#" class="imageContainer ui-widget #arguments.containerClass# align#arguments.align#">
		<cfif arguments.showMosaic eq 1 and arguments.size gt 60>
			<div class="mosaic-block fade ui-corner-all" id='mosaic_#arguments.ID#'>
				<a id='imgLink_#arguments.id#' href="#arguments.link#" class="mosaic-overlay">
					<div class="details"><h4>#arguments.title#</h4><p  class="white xsmall">#arguments.subtitle#</p></div>
				</a>
				<div class="mosaic-backdrop">
					<img src="#arguments.thumbnail#"  width="#arguments.size#" height="#arguments.size#"  style="#imgClass#" <cfif arguments.align neq ''>align="#arguments.align#"</cfif>>
				</div>
			</div>
		<cfelse>
			<cfif arguments.showColorBox eq 1>
				<cfset arguments.link = arguments.image>
			</cfif>
			<cfif arguments.link neq ''>
				<a id="imgLink_#arguments.id#" href="#arguments.link#"  <cfif arguments.showColorbox eq 1>rel='#arguments.colorboxRel#'</cfif>>
			</cfif>
			<img src="#arguments.thumbnail#" id="#arguments.id#" width="#arguments.size#" height="#arguments.size#" style="float:left;" class='#arguments.imgClass# ui-corner-all nomosaic' title = '#arguments.title#'>
			<cfif arguments.link neq ''>
				</a>
			</cfif>
		</cfif>

		<cfif arguments.showTools eq 1>
			<div class="imgtoolbar ui-widget-header ui-corner-all ui-helper-clearfix">
				<span class="ui-icon ui-icon-arrowrefresh-1-w rotateLeft" title="rotate left"></span>
				<span class="ui-icon ui-icon-arrowrefresh-1-e rotateRight" title="rotate right"></span>
				<span class="ui-icon ui-icon-arrowthick-2-se-nw resize" title="resize"></span>
				<span class="ui-icon ui-icon-newwin watermark" title="watermark"></span>
				<span class="ui-icon ui-icon-arrow-4-diag crop" title="crop"></span>
			</div>
		</cfif>
		<cfif arguments.showMosaic eq 1>
		<br style="clear:both">
		</cfif>
	</div>
	<script>
	<cfif arguments.size neq '100%'>
	$('##imageContainer_#arguments.ID#').imageManager({
		id: '#arguments.id#',
		image: '#arguments.image#',
		width: '#arguments.size#',
		height: '#arguments.size#',
		showTools: '#arguments.showTools#',
		showMosaic: '#arguments.showMosaic#',
		showColorbox: '#arguments.showcolorBox#',
		colorboxRel: '#arguments.colorboxRel#'
	});
	</cfif>
	</script>
</cfoutput>