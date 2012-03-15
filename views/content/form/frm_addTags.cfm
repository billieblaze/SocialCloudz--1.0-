<script src="/scripts/jquery.tagger.js"></script>
<cfoutput>
<div class="ui-widget">
	<div class="ui-widget-header">Tags</div>
	<div class="ui-widget-content" >
		<input type="text" size="20" class="tagger" name="tags_add" id="tags_add">
	    <input type="hidden" name="tags" id="tags" value='#rc.tags#' />
	        <Style type="text/css">
			.tagger { float:left; }
			.tagAdd { margin:0 0 0 6px;}
			.tagList { list-style:none; padding:0; margin:0; clear:both; border-left:3px solid ##ddd; padding-left:4px; float:left; margin:5px 10px;}
			.tagName { cursor:pointer; float:left; clear:both; padding:0.1em 1.5em 0.1em 0.4em;}
			.tagName:hover { background:##efefef url(/images/bullet_toggle_minus.png) right 2px no-repeat; color: black;-moz-border-radius:4px; }
			</style>
		
			<script type="text/javascript" charset="utf-8">
				$(document).ready(function(){
					$('.tagger').keypress(function(event) {
					  if (event.which == '64') {
					
						$( ".tagger" ).autocomplete({
							source: "/index.cfm/util/search/autocomplete",
							minLength: 2,
							select: function(event,ui){
								var i = $('<input type="hidden" class="tags_add" name="tags_add" />').val( '@' + ui.item.value);
								var t = $('<li />').text(ui.item.label).addClass('tagName')
									.click(function(){
										var hidden = $(this).data('hidden');
										$(hidden).remove();
										$(this).remove();
									})
									.data('hidden',i);
								var l = $(this).data('list');
								$(l).append(t).append(i);
								$('.tagger').val('');			
								$('.tagger').autocomplete('destroy');
								return false;
							}
						});
						}
					});
					
					// add to element by ID
					$('.tagger').addTag('#rc.tags#');
		
					function copyTags(){ 
					objTags = $('.tags_add').val();
					 $.each($('.tags_add'), function (){ 
						v =  $('##tags').val();
						$('##tags').val(  v + ',' +this.value);
					 });
					}
	
					$('##content').bind('submit', copyTags);
				});
			</script>
				<br style="clear:both">
		</div>
	</div>

	</cfoutput>