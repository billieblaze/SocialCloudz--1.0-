<cfscript>
	community = event.getvalue('community');
    types = event.getValue('types');
</cfscript>
This section determines which questions appear on a users profile.  Use it to add questions which help users relay their preferences in relation 
to your website.
<script>
	var myURL = '/index.cfm/member/profileAdmin/index/communityID/<cfoutput>#community.communityID#</cfoutput>';
	var myTab = 'div#ui-tabs-4';
	
	function profileSuccess (){	
		$(myTab).load(myURL);
	} 
	
	function questionInit (){	
		$('#questionType').change(function() {
			
	  		if($('#questionType').val() != 'radio')
			{
				if($('#questionType').val() != 'checkbox')
				{
					if($('#questionType').val() != 'select')
					{
						$('#valueListFieldset').hide();
					}
					else
			  		{
			  			$('#valueListFieldset').show();
			  		}
				}
				else
		  		{
		  			$('#valueListFieldset').show();
		  		}	  		
	  		}
	  		else
	  		{
	  		$('#valueListFieldset').show();
	  		}
		});
		
		if($('#questionType').val() != 'radio')
			{
				if($('#questionType').val() != 'checkbox')
				{
					if($('#questionType').val() != 'select')
					{
						$('#valueListFieldset').hide();
					}
				}	  		
	  		}
	  		else
	  		{
	  		$('#valueListFieldset').show();
	  		}
	} 
	
</script>
<cfoutput>
    <div align="right">
        <a href="##" alt="0" class="profileSectionAdd"><img src="#application.cdn.fam#folder_add.png" /> Add a profile section</a> | 
		<a href="##" alt="0" class="profileQuestionAdd"><img src="#application.cdn.fam#note_add.png" /> Add a profile question</a>
    </div>
	<br />
    <table width=100%>
		<cfloop query="types">
		    	<TR bgcolor="##CCCCCC" class='blackText' id='type_#types.typeid#'>
		        	<TD colspan=4><B>Profile Type: #types.name#</B></TD>
		            <TD width="1%"></TD>
					<TD width="1%">
		            </TD>
		        </TR>

			<cfset sections = application.members.profile.getSections(typeID = types.typeid, communityID = event.getValue('communityID'))>
			
			<cfloop query="sections">
		 		 <cfscript>
					questions=application.members.profile.getQuestions(sections.id);
				</cfscript>
		    	<TR bgcolor="##CCCCCC" class='blackText' id="section_#sections.id#">
			        <td width="10"><img src="/images/fam/bullet_go.png"></td>
		        	<TD colspan=3><B>#sections.name#</B></TD>
		            <TD width="1%">
		            	<a href="##" class="profileSectionEdit" alt="#id#"><img src="#application.cdn.fam#folder_edit.png"  /></a>            
		            </TD>
		            <TD width="1%">
		           	 	<a href="javascript: void(0)" onclick="ajaxConfirmDelete('Are you sure you want to delete this profile section?', '#event.buildLink(linkTo='member.profileAdmin.deleteSection', queryString='communityID=#community.communityID#&id=#ID#')#','##section_#sections.id#')" alt="help" id="deleteProfileSection" class="ajaxTabLink"><img src="#application.cdn.fam#folder_delete.png" /></a>
		            </TD>
		            <TD width="1%">
			            <cfif sections.currentrow neq sections.recordcount>
				            <a href="#event.buildLink(linkTo='member.profileAdmin.sectionOrder',queryString='communityID=#community.communityID#&id=#id#&move=1&sortorder=#sections.currentrow#')#" alt="help" id="moveProfileSectionDown" class="ajaxTabLink"><img src="#application.cdn.fam#arrow_down.png" /></a>
						</cfif>            
					</TD>
					<TD width="1%">
						<cfif sections.currentrow neq 1>
							<a href="#event.buildLink(linkTo='member.profileAdmin.sectionOrder',queryString='communityID=#community.communityID#&id=#id#&move=-1&sortorder=#sections.currentrow#')#" alt="help" id="moveProfileSectionUp" class="ajaxTabLink"><img src="#application.cdn.fam#arrow_up.png" /></a> 
						</cfif>
		            </TD>
		        </TR>
		        <cfloop query="questions">
			        <TR id="question_#id#" class="<cfif questions.currentrow mod 2>even<cfelse>odd</cfif>">
				        <td></td>
				        <td></td>
			        	<TD>#question#</TD>
						<TD>#type#</TD>
						<TD width="1%">
			           	 	<a href="##" class="profileQuestionEdit" alt="#ID#"><img src="#application.cdn.fam#note_edit.png" alt="help" id="editProfileQuestion"/></a>
			            </TD>
			            <TD width="1%">
			            	<a href="javascript: void(0);" onclick="ajaxConfirmDelete('Are you sure you want to delete this profile question?', '#event.buildLink(linkTo='member.profileAdmin.deleteQuestion',queryString='communityID=#community.communityID#&id=#id#')#', '##question_#id#');" id="deleteProfileQuestion" alt="help" class="ajaxTabLink"><img src="#application.cdn.fam#note_delete.png" /></a>
			            </TD>
			            <TD width="1%">
			            	<cfif questions.currentrow neq questions.recordcount>
				            	<a href="#event.buildLink(linkTo='member.profileAdmin.questionOrder',queryString='communityID=#community.communityID#&id=#id#&move=1&sectionID=#sectionID#&sortorder=#questions.currentrow#')#" alt="help" id="moveQuestionDown" class="ajaxTabLink"><img src="#application.cdn.fam#arrow_down.png" /></a>
							</cfif>            
						</TD>
						<TD width="1%">
			              	<cfif questions.currentrow neq 1>
				              	<a href="#event.buildLink(linkTo='member.profileAdmin.questionOrder',queryString='communityID=#community.communityID#&id=#id#&move=-1&sectionID=#sectionID#&sortorder=#questions.currentrow#')#" alt="help" id="moveQuestionUp" class="ajaxTabLink"><img src="#application.cdn.fam#arrow_up.png" /></a> 
							</cfif>
			            </TD>
			        </TR>
			        <Cfif questions.type eq 'fieldset'>
			        	<cfset fieldSetFields = application.members.profile.getQuestions(groupID=questions.ID)>
			        	<cfloop query='fieldSetFields'>
				        	<TR>
						        <td></td>
						        <td></td>
					        	<TD><img src="/images/fam/bullet_go.png">#question#</TD>
								<TD>#type#</TD>
								<TD width="1%">
						           	<a href="##" alt="#ID#" class="profileQuestionEdit"><img src="#application.cdn.fam#note_edit.png" alt="help" id="editProfileQuestion"/></a>
					            </TD>
					            <TD width="1%">
					            	<a href="#event.buildLink(linkTo='member.profileAdmin.deleteQuestion',queryString='communityID=#community.communityID#&id=#id#')#" id="deleteProfileQuestion" alt="help" class="ajaxTabLink"><img src="#application.cdn.fam#note_delete.png" /></a>
					            </TD>
					            <TD width="1%">
					            	<cfif questions.currentrow neq questions.recordcount>
						            	<a href="#event.buildLink(linkTo='member.profileAdmin.questionOrder',queryString='communityID=#community.communityID#&id=#id#&move=1&sectionID=#sectionID#&sortorder=#questions.currentrow#')#" alt="help" id="moveQuestionDown" class="ajaxTabLink"><img src="#application.cdn.fam#arrow_down.png" /></a>
									</cfif>            
								</TD>
								<TD width="1%">
					              	<cfif questions.currentrow neq 1>
						              	<a href="#event.buildLink(linkTo='member.profileAdmin.questionOrder',queryString='communityID=#community.communityID#&id=#id#&move=-1&sectionID=#sectionID#&sortorder=#questions.currentrow#')#" alt="help" id="moveQuestionUp" class="ajaxTabLink"><img src="#application.cdn.fam#arrow_up.png" /></a> 
									</cfif>
					            </TD>
					        </TR>
				        </cfloop>
					</cfif>
		        </cfloop>
			</cfloop>
		</cfloop>
    </table>
</cfoutput>

<script>
	$('.profileSectionAdd').modalAjax({
		width:500,
		title:'Add Section',
		url:'/index.cfm/member/profileAdmin/section/communityID/<cfoutput>#community.communityID#</cfoutput>/ID/!alt!',
		initAjaxForm: true,
		initValidate: true,
		ajaxFormTarget: '',
		ajaxFormSuccess: profileSuccess,
		ajaxFormClose: true
	});
	
	$('.profileSectionEdit').modalAjax({
		width:500,
		title:'Edit Section',
		url:'/index.cfm/member/profileAdmin/section/communityID/<cfoutput>#community.communityID#</cfoutput>/ID/!alt!',
		initAjaxForm: true,
		initValidate: true,
		ajaxFormTarget: '',
		ajaxFormSuccess: profileSuccess,
		ajaxFormClose: true
	});
	
	$('.profileQuestionAdd').modalAjax({
		width:500,
		title:'Add Question',
		url:'/index.cfm/member/profileAdmin/question/communityID/<cfoutput>#community.communityID#</cfoutput>/ID/!alt!',
		initAjaxForm: true,
		initValidate: true,
		initFunction: questionInit,
		ajaxFormTarget: '',
		ajaxFormSuccess: profileSuccess,
		ajaxFormClose: true
	});
	
	$('.profileQuestionEdit').modalAjax({
		width:500,
		title:'Edit Question',
		url:'/index.cfm/member/profileAdmin/question/communityID/<cfoutput>#community.communityID#</cfoutput>/ID/!alt!',
		initAjaxForm: true,
		initValidate: true,
		initFunction: questionInit,
		ajaxFormTarget: '',
		ajaxFormSuccess: profileSuccess,
		ajaxFormClose: true
	});

</script>