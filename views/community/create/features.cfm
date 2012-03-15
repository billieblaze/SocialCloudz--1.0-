<cfsetting showdebugoutput="no">
<cfscript>
getTemplates = event.getvalue('templates');
</cfscript>
<cfparam name="rc.features" default="">
<cfoutput>
  <div class="mod">
    <div class="hd">Step 3 - Customization</div>
    <div class="bd">
      <form id="form1" name="form1" method="post" action="#event.buildLink('community.create.features_submit')#">
        <div style="padding: 15px;border: 1px solid silver;-moz-border-radius: 15px;border-radius: 15px;">	
          <table width="100%" border="0" style="padding:10px 0px 0px 0px;">
            <tr>
              <td width="25%">
              		Info /  Blog <span class="small">(<a href="http://blog.#request.community.domain.domain#" target="_blank" class="small">preview</a>)</span>
                    <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/blogThumb.png)">
         	        <input type="radio" name="configuration"  value="blogs" />
					</div>
				</td>
                <td  width="25%">
            	    Sharing <span class="xsmall">(<a href="http://media.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
                	<div style="height:85px; width: 101px; background:url(/socialCloudZ/img/photoThumb.png)">
	                <input  type="radio" name="configuration"  value="media" />
    	            </div>
				</td>
                <td  width="25%">
                Social <span class="xsmall">(<a href="http://social.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
                    <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/socialThumb.png)">
               		<input  type="radio" name="configuration"  value="social"/>			
					</div>
                </td>
                <td  width="25%">
  					Band/Promoter <span class="xsmall">(<a href="http://music.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
                    <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/socialThumb.png)">
          	     	<input  type="radio" name="configuration"  value="music"/>
					</div>
				</div>
                </td>
                </tr>
                <TR><td height="5" colspan="4"></td></TR>
	           <tr>
                 <td  width="25%">
        	         Restaurant <span class="xsmall">(<a href="http://restaurant.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
                               <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/blogThumb.png)">
    	             <input type="radio" name="configuration"  value="restaurant" />
            	     </div>
                </td>
              <td  width="25%">
             	 Nightclub <span class="xsmall">(<a href="http://nightclub.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
                            <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/musicThumb.png)">
	              <input type="radio" name="configuration"  value="nightclub"/>
	              </div>
                </td>
                 <td  width="25%">
                 Lawyer<span class="xsmall">(<a href="http://lawyer.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
                               <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/eventThumb.png)">
                 <input  type="radio" name="configuration"  value="lawyer" />
                 </div>
                </td>
             <td  width="25%">
                Real Estate<span class="xsmall">(<a href="http://realestate.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
                              <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/socialThumb.png)">
               <input  type="radio" name="configuration"  value="property"/>
               </div>
		         </td>
            </tr>
			       <tr>
                 <td  width="25%">
                Venue Listing <span class="xsmall">(<a href="http://venue.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
                              <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/socialThumb.png)">
               <input  type="radio" name="configuration"  value="venue"/>
                 </div>
                </td>
    	        <td  width="25%">
			Fan Site<span class="xsmall">(<a href="http://fan.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
		    <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/socialThumb.png)">
               <input  type="radio" name="configuration"  value="fan"/>
			</div>
                </td>
                 <td  width="25%">
				Church/Group <span class="xsmall">(<a href="http://church.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
				              <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/socialThumb.png)">
               <input  type="radio" name="configuration"  value="church"/>
			</div>
                </td>
             <td  width="25%">
        		Networking <span class="xsmall">(<a href="http://networking.#request.community.domain.domain#" target="_blank" class="xsmall">preview</a>)</span>
		    <div style="height:85px; width: 101px; background:url(/socialCloudZ/img/socialThumb.png)">
               <input  type="radio" name="configuration"  value="networking"/>
			</div>
		         </td>
            </tr>
		  </table>
          </div>
          <BR />
          <span class="xsmall" style="margin: 0px 0px 0px 60px"><input type="checkbox" name="features" value="0" <cfif rc.features eq 0>checked</cfif>/> I would like to skip this step and start with a blank layout</span>
        </div>
		<div class="ft"></div>
		</div>
		 <div class="mod">
    <div class="hd">Step 4 - Template</div>
    <div class="bd">
        <div style="padding: 15px;border: 1px solid silver;-moz-border-radius: 15px;border-radius: 15px;">	
        
		  <table width="100%" border="0" style="padding:10px 0px 0px 0px;">
             <TR>
                <td height="10" colspan="4"></td>
                </TR>
                
	          <cfset cnt = 1>
    	      <cfloop query="getTemplates">  
				<cfif getTemplates.type eq 'basic'>
		         <cfif cnt eq 1> <tr></cfif>
		         <td width="25%">
	              <div style="height:87px; width: 104px; background:url(<cfif thumbnail eq ''>/socialCloudZ/img/feature_icon.png<cfelse>/images/templates/#thumbnail#</cfif>);">
    	          <input type="radio" name="templateID" value="#id#"> #getTemplates.name#
        	      </div>
				</td>
			     <cfif cnt eq 4>
	     			</TR>   
					<TR>
	                	<td height="15" colspan="4"></td>
	                </TR>
			        <cfset cnt = 0>
	     		</cfif>
		     	<cfset cnt = cnt + 1>
			</cfif>
            </cfloop>
		</table>
		</div>
		  <div style="padding:12px 0px 0px 65px">
           <input  type="image" src="/socialCloudZ/img/signupbox_submit.png"/>
          </div>
      </form>
    </div>
    <div class="ft"></div>
  </div>
</cfoutput> 