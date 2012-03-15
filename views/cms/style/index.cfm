<cfsetting showdebugoutput="no">
<cfparam name="rc.type" default="advanced">
<cfoutput>
	<script type="text/javascript">
		var communityid = '#request.community.communityid#';
		var displaytype = '#rc.type#';
		$.getScript('/scripts/siteDesigner.js');
		$.getScript('/yui3/build/yui/yui-min.js');
	
		if (displaytype == 'Template'){
			directory = '/images/templates/'+$('##templateID').val();
		} else {
			directory = '/community/'+communityid;
		}
	</script>

<cfquery datasource="community" name="getItems">
	select * from styleItemList
	where #rc.Type# = 1
</cfquery>

<form action="##"  onsubmit="saveDesign(this); return false;" class="blackText">
	<input type="hidden" name="lastPage" id="lastPage" value="#request.session.lastpage#">
	<div id="designerTabs" class="tabs">
	<ul>
		<li><a href="##tabs-1">Designer</a></li>
	    <cfif rc.type neq 'Simple'>
		    <li><a href="##tabs-2">Extra CSS</a></li>
		    <li><a href="##tabs-3">Flash Header</a></li>
		</cfif>
	</ul>
	<div id="tabs-1" style="width:600px;">
		<table height="281">
			<TR height="180"> 
				<TD valign="top" width="200">
					<cfif rc.dbtable eq 'template'>
						<cfscript>
							templates = event.getvalue('templates');
						</cfscript>
						<B>Template:</B><BR> 
			            <select name="templateID" id='templateID'>
							<cfoutput query='templates'>
			                <option value='#templates.ID#'>#Templates.name#</option>
			                </cfoutput>
						</select>
						<BR>
					<cfelse>
						<input type='hidden' name='templateID' id='templateID' value='0'>
					</cfif>
					<b>Item</b><BR />
		            <select name="myitem" id="myitem"  onChange="updateStyleSelect1('#rc.type#');" onKeyUp="updateStyleSelect1('#rc.type#');">
		                <cfloop query="getItems">
		            	    <option value="#id#">#description#</option>
		                </cfloop>
		            </select><BR />
		            <B>Element</B><BR />
		            <select name="myelement" id="myelement" onChange="updateStyleSelect2('#rc.type#');" onKeyUp="updateStyleSelect2('#rc.type#');"></select><BR />
		            <B>Property</B><BR />
		            <select name="myproperty" id="myproperty"></select><BR />
		            <B>Value</B><br />
		            <input type="text" name="currentValue" id="currentValue">
		            <span id="resetColor"><a href="##" onclick="resetColor();">Clear</a></span><br /><br />        
			    </TD> 
	    		<TD valign="top">
	        		<Div id="colorpicker" style="margin: 0px 0px 0px 50px"></Div>
			 	   	<div id="uploader" style="display:none;">
					<div id="fileQueue" style="width:100%;padding: 0;overflow:auto;margin-bottom: 10px;" class="blackText">&nbsp;</div>
					<input id="layout_file" name="layout_file" type="file" />
					<input id="layout" name="layout" type="hidden" value="" />
		            <a class="rolloverButton" href="##" onclick="resetImage();" id="clearImage" style="display: block;width:98px;height:23px;text-decoration: none;margin-left:135px;	background: url('/images/clearImageButton.png') 0 0 no-repeat;"></a>
					<br style="clear:both"/>
		            <BR /><BR />
					<div>
						Background Repeat<BR />
		        	    <select id="backgroundRepeat">
		            		<option value="repeat">Repeat</option>
		            		<option value="repeat-x">Repeat X</option>
			               	<option value="repeat-y">Repeat Y</option>
			              	<option value="no-repeat">No Repeat</option>                
			            </select>
	    		        <BR /><BR />
			        
			            Background Position<BR />
	    		        <select id="backgroundPosition">
	            		    <option value="center">Center</option>
			            	<option value="top">Top</option>
			                <option value="bottom">Bottom</option>
			                <option value="left">Left</option>
	    		            <option value="right">Right</option>
	            		</select>
		            </div>
		        </div>
			    <div id="text" style="display:none;">
	                Font Family<BR />
	                <select name="fontFamily" id="fontFamily">
	                    <option value="Arial">Arial</option>
	                    <option value="Arial Black">Arial Black</option>
	                    <option value="Courier">Courier</option>
			   			<option value="Comic Sans MS">Comic Sans MS</option>
	                    <option value="Courier New">Courier New</option>
	                    <option value="Georgia">Georgia</option>
	                    <option value="Geneva">Geneva</option>
	                    <option value="Helvetica">Helvetica</option>
	                    <option value="Impact">Impact</option>
					    <option value="Lucida Console">Lucida Console</option>
					    <option value="sans-serif">sans-serif</option>
	                    <option value="Times New Roman">Times New Roman</option>
	                    <option value="Verdana">Verdana</option>
	                </select><br /><br />
	                
	                Font Size<BR />
	                <select name="fontSize"  id="fontSize">
	                    <cfloop list="8,9,10,11,12,14,16,18,20,22,24,26,28,30,32,34,36" index="i">
		                    <option value="#i#px">#i#px</option>
	                    </cfloop>
	                </select><br /><BR />
	                
	                Font Weight<BR />
	                <select name="fontWeight"  id="fontWeight" >
	                    <option value="normal">Normal</option>
	                    <option value="bold">Bold</option>
	                </select><BR /><BR />
					
					Font Style<BR />
	                <select name="fontStyle"  id="fontStyle" >
	                    <option value="normal">Normal</option>
	                    <option value="italic">Italic</option>
	                    <option value="oblique">Oblique</option>
	                </select><BR /><BR />
					
					Text Alignment<BR>
					<select name="textAlignment" id="textAlignment">
						<option value="left">Left</option>
						<option value="center">Center</option>
						<option value="right">Right</option>
						<option value="justify">Justify</option>
					</select><BR><BR>
			
					Text Decoration<BR>
					<select name="textDecoration" id="textDecoration">
						<option value="none">None</option>
						<option value="underline">Underline</option>
						<option value="overline">Overline</option>
						<option value="line-through">Line-Through</option>
						<option value="blink">Blink</option>
					</select><BR><BR>
			        
			        Display Text<BR />
	                <select name="textDisplay" id="textDisplay">
	                    <option value="block">Yes</option>
	                    <option value="none">No</option>
	                </select>
	
	            </div>
			    <div id="slider" style="display: none; width:400px;">
					Coarse:<BR><BR>
					<div id="sizeSlider"></div>
					<BR><BR><BR>
					Fine: <BR><BR>
					<div id="sizeSliderFine"></div>
			    </div>
	   		    <div id="padding" style="display:none; width:400px; text-align:left">
					Top<BR>
					<div id="paddingTop"></div><BR><BR>
					Right<BR>
					<div id="paddingRight"></div><BR><BR>
					Bottom<BR>
					<div id="paddingBottom"></div><BR><BR>
					Left<BR>
					<div id="paddingLeft"></div>
				</div>
		  	</div>
	        <div id="margin" style="display:none; text-align:left">
				Top<BR>
				<div id="marginTop"></div><BR><BR>
				Right<BR>
				<div id="marginRight"></div><BR><BR>
				Bottom<BR>
				<div id="marginBottom"></div><BR><BR>
				Left<BR>
				<div id="marginLeft"></div>
				</div>
		    </div>
			    </TD>
			</TR>
			<TR>
			    <TD colspan="2" class="padTop5">
				  <B>CSS Selector</B> <div id="mystyle">body</div>
			    </TD>
			</tr>
		</table>
	</div>
    <cfif rc.type neq 'Simple'>
		<div id="tabs-2" style="width:600px;">
			<textarea cols="80" rows="15" name="extracss" id="extraCSS" style="width:100%">#application.cms.style.getCSS()#</textarea>
		</div>
		<div id="tabs-3" style="width:600px;">
			Here you can upload a flash file to use in the header of your site. <br>
			We recommend uploading both a flash file and a header image to <br>
			accomodate non-flash browsers.   <br>
			<br>
			The header will not be visible until you save this dialog.<br><br>
			<cfset flashHeader = application.community.settings.getValue('flashHeader')>
			<Cfif flashHeader neq ''>
			<cfoutput>Current Flash Header: <br>#flashHeader#<br></cfoutput>
			</cfif>
			<cfmodule template="/customTags/singleUploader.cfm" 
				fkType = "flashHeader"
				mediaType = "flash"
				autoSubmit = 0
				contentID = "#request.community.communityID#"
				showClear = 1
					uploadProc = 'util.upload.flashHeader'
			/>
			
		</div>
	</cfif>
	</div>
	<BR>
	<div align="center">
		<input type="hidden" name="designtype" value="#rc.type#" id="designtype"/>
		<input type="submit" value="Save"/>
		<input type="button" value="Cancel" onclick="location.href='#request.session.lastpage#';"/>
	    <input type="button" value="Clear all" onclick="confirmDelete('Are you sure you want to clear all styles?', '/index.cfm/cms/style/clear');"/>
	</div>
</form>
</cfoutput>				