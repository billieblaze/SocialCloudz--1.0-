<cfoutput>
	<div  align="right">
				<cfif   request.session.accesslevel gte 20 
				or(
					(application.cms.settings.check('canPost') eq 'members'
						or (application.cms.settings.check('canPost') eq 'Admin' and request.session.accesslevel gte 20) 
						or (application.cms.settings.check('canPost') eq 'Editor' 	and request.session.accesslevel gte 10) 
					)
					and (application.cms.settings.check('canPostProfileType') eq 'Anyone' 	
						or (application.cms.settings.check('canPostProfileType') eq 'Consumer' and request.session.profileType eq 1)									
						or (application.cms.settings.check('canPostProfileType') eq 'Business' and request.session.profileType eq 2)	
					)
				)			
		>
		    <button name="the-menu" type="button" class="menu">
			    <img src="#application.cdn.fam#cog.png" height="12" width="12"> Actions
			</button>
		    <div id="the-menu" class="menu blackText small">
		    <cfif not (request.session.login eq 0)>
		    	<cfif rc.content.query.parentContentType eq ''>
		        	<a href="/index.cfm/content/form/#rc.contentType#/0" class="aNone small"><img src="#application.cdn.fam#add.png" /> Add </a> <BR />
				<cfelse>
					<a href="/index.cfm/content/form/#rc.content.query.parentcontentType#/0" class="aNone small"><img src="#application.cdn.fam#add.png" /> Add </a> <BR />				
				</cfif>
				<cfif rc.contentType eq 'event'>
					<a href="/index.cfm/content/form/#rc.contentType#/0?facebook" class="aNone small"><img src="#application.cdn.fam#date_link.png"> Import from Facebook</a>
				</cfif>
	        </cfif>
			
	        <cfif  event.getvalue('contentID', '') neq ''
				   		and (rc.content.query.memberID eq request.session.memberID 
				 		or request.session.accesslevel gte 10)	>
		 		<cfif rc.content.query.parentContentType eq ''>
		           	<a href="/index.cfm/content/form/#rc.contentType#/#rc.contentID#" class="aNone small"> <img src="#application.cdn.fam#pencil.png" /> Edit</a><BR />
		        <cfelse>
			        <a href="/index.cfm/content/form/#rc.content.query.parentContentType#/#rc.content.query.parentID#" class="aNone small"> <img src="#application.cdn.fam#pencil.png" /> Edit</a><BR />
		        </cfif>
	           	<a href="##" onclick="confirmDelete('Are you sure you want to delete this?',  '/index.cfm/content/admin/delete/#rc.content.query.contentType#/#rc.content.query.parentID#/#rc.content.query.contentId#');" class="aNone small"> <img src="#application.cdn.fam#cross.png" /> Delete</a> <BR />
	        </cfif>
	        
	        <hr width="120" />
	        <a href="/index.cfm/content/#event.getvalue('contenttype')#?memberid=#request.session.memberid#" class="aNone small"><img src="#application.cdn.fam#folder.png" /> My Posts</a> 
			<BR />
			
			<cfif rc.contentModuleData.query.parentContentType eq ''>
		     	<a href='/index.cfm/content/#event.getvalue('contentType')#' class="aNone small"><img src="#application.cdn.fam#book_go.png" /> View All </a><BR />
			</cfif>
				#renderView('content/retrieve/sorting')#
				
			</div>
		<cfelse>
		&nbsp;
		</cfif>
	
		
	</div>

	<script>
		jQuery(function($) {
		    $('button.menu').one('click', openMenu);
		    function openMenu(e) {
		        var button = $(this).addClass('active');
		        var menu = $('##' + button.attr('name'));  
				offset = $('button.menu').position();
			    menu.addClass('active').css('left', offset.left - 85).click(function(e) { e.stopPropagation(); }).show(200, function() {
		            $(document).one('click', {button: button, menu: menu}, closeMenu);
		        });
		    }
		    function closeMenu(e) {
		        e.data.menu.removeClass('active').hide(100, function() {
		            e.data.button.removeClass('active');
		        });
		        e.data.button.one('click', openMenu);
		    }
		});
	</script>
</cfoutput>