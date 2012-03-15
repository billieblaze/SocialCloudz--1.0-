<cfcomponent>
	<cffunction name="init">
		<cfscript>return this;</cfscript>
	</cffunction>
	   <cffunction name="texteditor">

    <cfargument name="instancename">
    <cfargument name="value">
	<cfargument name="showTagger" default="0">
    <cfoutput>
		<div>
			<textarea cols="80" class="richtexteditor" id="#arguments.instancename#" name="#arguments.instancename#" rows="10">#arguments.value#</textarea>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
			$( 'textarea###arguments.instancename#' ).ckeditor( function() { 
				
				<cfif arguments.showTagger eq 1>	
					editor = $('textarea###arguments.instancename#').ckeditorGet(); 
					editor.ui.addButton('insertTag',{
		                label: 'Insert Data Tag',
		                command: 'insertTag',
		                icon: '/images/fam/tag.png'
		            });
					
					editor.addCommand('insertTag', { exec: showMyDialog });
				</cfif>
			 },{
				filebrowserBrowseUrl : '/cffm/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=file',
				filebrowserImageBrowseUrl : '/cffm/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=image',
				filebrowserFlashBrowseUrl : '/cffm/cffm.cfm?editorType=cke&EDITOR_RESOURCE_TYPE=flash',
				filebrowserUploadUrl : '/cffm/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=file',
				filebrowserImageUploadUrl : '/cffm/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=image',
				filebrowserFlashUploadUrl : '/cffm/cffm.cfm?action=QuickUpload&editorType=cke&EDITOR_RESOURCE_TYPE=flash'
			 });
			 
			 });
		</script>
	</cfoutput>

    </cffunction>
	
	<cffunction name="calendar">
    	<cfargument name="fieldName">
        <cfargument name="datevalue" default="#now()#">
		<Cfargument name="width" default="100px">
		<cfargument name="displayTime" default="1">
		<cfoutput>
			<cfif isValid('date', arguments.datevalue)>
				<cfset arguments.dateValue = application.timezone.castFromServer(arguments.datevalue, application.community.settings.getValue('timezone'))>
			</cfif>
			<input type="text" 
				id="#arguments.fieldname#" 
				name="#arguments.fieldname#" 
 				<cfif isValid('date', arguments.datevalue)>
					value="#dateformat(arguments.datevalue,'mm/dd/yyyy')#
					<cfif displayTime eq 1>&nbsp;#timeformat(arguments.datevalue, 'hh:mm tt')#</cfif>"				
				<cfelse>
					value="#arguments.datevalue#"
				</cfif>						
				class="anyTimePicker"
				style="width:#arguments.width#;"  
				readonly/>
			<cfif displayTime eq 1>
			<script type="text/javascript">
				  $("###arguments.fieldname#").AnyTime_picker( { 
				  		format: "%m/%d/%Z %h:%i %p",
				  		askSecond: false
				  } );
			</script>
			<cfelse>
			<script type="text/javascript">
				  $("###arguments.fieldname#").AnyTime_picker( { 
				  		format: "%m/%d/%Z",
				  		askSecond: false
				  } );
			</script>
			</cfif>
		</cfoutput>
    </cffunction>
	
	<cffunction name="membersuggest">
		<cfargument name="acName">
		<cfargument name="formfield">
		<cfargument name="label" default="">

		<cfoutput>
		#arguments.label# <input id="#arguments.acname#" type="text"/>
		<input name= "#arguments.formfield#" id="#arguments.formfield#" type="hidden">
		<script>
			function formatItem(row){ 
				output = '<table><TR><TD width="50" ><img src="'+row[2]+'"></td><TD valign="top" class="small">'+row[1]+'<BR>'+row[3]+'</td></tr></table>';
				return output;
			}
				
			$( "input###arguments.acname#" ).autocomplete({
				source: "/index.cfm/member/util/autocomplete",
				minLength: 2,
				select: function( event, ui ) {
					$('input###arguments.formfield#').val(ui.item.memberid);
				}
			});
		</script>

		</cfoutput>
	</cffunction>
	
	<cffunction name="ajaxFormSubmit">
	<cfargument name="formID">
	<cfargument name="callback" default="">
	<cfargument name="clearForm" default="false">

 <script>
// prepare the form when the DOM is ready 

    var options = { 
        beforeSubmit:  showRequest,  // pre-submit callback 
        success:       showResponse,  // post-submit callback 
 	clearForm: <cfoutput>#arguments.clearform#</cfoutput>
        // other available options: 
        //url:       url         // override for form's 'action' attribute 
        //type:      type        // 'get' or 'post', override for form's 'method' attribute 
        //dataType:  null        // 'xml', 'script', or 'json' (expected server response type) 
        //clearForm: true        // clear all form fields after successful submit 
        //resetForm: true        // reset the form after successful submit 
 
        // $.ajax options can be used here too, for example: 
        //timeout:   3000 
    }; 
 
    // bind to the form's submit event 
    $('#<cfoutput>#arguments.formID#</cfoutput>').submit(function() { 
        // inside event callbacks 'this' is the DOM element so we first 
        // wrap it in a jQuery object and then invoke ajaxSubmit 
        $(this).ajaxSubmit(options); 
 
        // !!! Important !!! 
        // always return false to prevent standard browser submit and page navigation 
        return false; 
    }); 

// pre-submit callback 
function showRequest(formData, jqForm, options) { 
    // formData is an array; here we use $.param to convert it to a string to display it 
    // but the form plugin does this for you automatically when it submits the data 
 //   var queryString = $.param(formData); 
 
    // jqForm is a jQuery object encapsulating the form element.  To access the 
    // DOM element for the form do this: 
    // var formElement = jqForm[0]; 
 
   // alert('About to submit: \n\n' + queryString); 
 
    // here we could return false to prevent the form from being submitted; 
    // returning anything other than false will allow the form submit to continue 


    return true; 
} 
 
// post-submit callback 
function showResponse(responseText, statusText)  { 
    // for normal html responses, the first argument to the success callback 
    // is the XMLHttpRequest object's responseText property 
 
    // if the ajaxSubmit method was passed an Options Object with the dataType 
    // property set to 'xml' then the first argument to the success callback 
    // is the XMLHttpRequest object's responseXML property 
 
    // if the ajaxSubmit method was passed an Options Object with the dataType 
    // property set to 'json' then the first argument to the success callback 
    // is the json data object returned by the server 
 
$.jGrowl('Save Complete!');
    <cfoutput>#arguments.callback#</cfoutput>
} 

</script>
</cffunction>
</cfcomponent>