<script>
	$(function() {
		$( "#templateTabs" ).tabs({
			cache: false,
			load: function(e, ui) {
				/* setup the ajaxTabLink class to intercept inner tab refreshes */
            	$('a.ajaxTabLink', ui.panel).livequery('click', function() {
               			//showLoading();
                		$(ui.panel).load(this.href+'&r='+Math.random(),'',function(){
                		//	hideLoading();
                		});
                		return false;
            		});
			}
		});
	});

	function insertTag(element,tag,type){
		if (type == 'ckeditor'){
		    var oEditor = CKEDITOR.instances.body;
    		oEditor.insertHtml('['+tag+']');
		}	else	{
			var elementVal = $('#'+element).val();
			$('#'+element).val(elementVal + '['+tag+']');
		}
	}
	
	  function showMyDialog(e) {
	  	<cfoutput>
   	      modalAjax('Insert Tag', '/index.cfm/emailTemplates:tags/picker/emailID/#rc.id#/elementID/body/elementType/ckeditor');
   	     </cfoutput>
	  }
</script>

<cfoutput>
<cfparam name="rc.new" default="1">
<form action="#event.buildLink('emailTemplates:admin.submit')#" method="post" id="emailTemplate">
	<cfif rc.New eq 0>
		<input type="hidden" name="ID" value="#rc.id#">
	<cfelse>
		<input type="hidden" name="ID" value="0">	
	</cfif>
	<input type="hidden" name="new" value="#rc.new#" />
	
	<!--- admin app can see all apps, app can only see its own templates --->
	<input type="hidden" name="communityID" value="#rc.communityID#">
	
	<div class="mod">
		<div class="hd">
			<div style="float:left">Email Template - #rc.name#</div>
			<div align="right">
				<a href="#event.buildLink(linkto='emailTemplates:admin.index', querystring='communityID=#rc.communityID#')#">Back</a>
			</div>
		</div>
		<div class="bd">
			<div id="templateTabs" class="blackText">
				<ul>
					<li><a href="##tabs-1">General</a></li>
					<li><a href="##tabs-2">Body</a></li>
					<li><a href="#event.buildLink(linkto='emailTemplates:tags.index', queryString='emailID=#rc.id#&communityID=#rc.communityID#')#">Tags</a></li>
					<!--- <li><a href="index.cfm?event=emailTemplates:mapping.index&emailID=#rc.id#&applicationName=#rc.applicationName#">Mapping</a></li> --->
					<li><a href="#event.buildLink(linkto='emailTemplates:admin.logs', queryString='emailID=#rc.ID#&commuityID=#rc.communityID#')#">Logs</a></li>
				</ul>
				<div id="tabs-1">
					Name:<br>
					<input type="text" name="name" value="#rc.name#" style="width:99%"><br>
					<br>
					<!--- TODO: this will be used to tie an email and a mapping together
					Event:<BR>
					<input type="text" name="action" value="#rc.action#" style="width:99%"><BR> --->
					<br>
					CC:<br>
					<input type="text" name="cc" value="#rc.cc#" style="width:99%"><br>
					<br>
					BCC:<br>
					<input type="text" name="bcc" value="#rc.bcc#" style="width:99%"><br>
					<br>
					Subject:<br>
					<input type="text" name="subject" id="subject" value="#rc.subject#" style="width:99%">
					<!--- todo: use modalAjax plugin! --->
					<a href="##" onclick="modalAjax('/index.cfm/emailTemplates:tags/picker/emailID/#rc.ID#/elementID/subject/elementType/text','Insert Tag');">
					 <img src="/images/fam/tag.png" border="0">
					</a>
					<br>
					<br>
					<div align="center">
						<input type="submit" value="Save" class="button">
					</div>
				</div>
				<div id="tabs-2">
					<textarea cols="80" id="body" name="body" rows="45">#rc.body#</textarea>
						<script type="text/javascript">
						//<![CDATA[
							var editor = CKEDITOR.replace( 'body',
								{
								
									removePlugins: 'elementspath',
									extraPlugins: 'insertTag',
									width : '99%',
									height : '450',
									skin : 'kama',
									toolbar :
									[
									    ['Source'],
									    ['Cut','Copy','Paste','PasteText','PasteFromWord','-', 'SpellChecker', 'Scayt'],
									    ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
									    '/',
									    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
									    ['NumberedList','BulletedList','-','Outdent','Indent'],
									    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
									    ['BidiLtr', 'BidiRtl'],
									    ['Link','Unlink'],
									    ['HorizontalRule','SpecialChar','PageBreak'],
									    '/',
									    ['Styles','FontSize'],
									    ['TextColor','BGColor'],
									    ['Maximize', 'ShowBlocks'],
									    '/',
									    ['insertTag']
									]
								}
							);
							
								CKEDITOR.config.enterMode = CKEDITOR.ENTER_BR;	
								CKEDITOR.config.fontSize_sizes = "11/11px;12/12px;14/14px;16/16px";
			
			
					 editor.ui.addButton('insertTag',{
                        label: 'Insert Data Tag',
                        command: 'insertTag',
                        icon: '/common/fam/tag.png'
                    });
                     
                    editor.addCommand('insertTag', { exec: showMyDialog });
						//]]>
						</script>
					<br>
					<div align="center">
						<input type="submit" value="Save" class="button">
					</div>
					</form>
				</div>
			</div>
		</div>
		<div class="ft"></div>
	</div>
</cfoutput>