<cfscript>
	q_content = rc.contentModuleData.query;
	getModule = qGetModules;	
	
	tagline = application.content.getAttribute(q_content.attribs, 'tagline');
	variables.price = application.content.getAttribute(q_content.attribs, 'price');
	variables.age = application.content.getAttribute(q_content.attribs, 'age');
	variables.type = application.content.getAttribute(q_content.attribs, 'type');
	website = application.content.getAttribute(q_content.attribs, 'website');
	website = replace(website, 'http://', '');
	website = 'http://#website#';
	request.addressArray = arrayNew(2);
	request.addressArray[1][1] = q_content.title;
	request.addressArray[1][2] = '#q_content.venue# #q_content.address#, #q_content.city#, #q_content.state#  #q_content.country#';
</cfscript>
<cfoutput>
<cfloop query="q_content">
			<cfset myStartDate = application.timezone.castFromServer(startDate, application.community.settings.getValue('timezone'))>

        <h2>#q_content.title#</h2>
        <cfif tagline neq ''>
        #tagline#<BR />
        </cfif>
        <BR />
		<div style="float:left">
		<cfif q_content.image neq ''>
			<A href="#q_content.image#" rel="gallery">#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
				image=q_content.image, 
				size=getmodule.thumbsize,
				align=getmodule.thumbalign,
				showColorBox = 1
				)#</a>
                <cfelse>
                <table style="border: 1px solid gray; margin:0px 10px" align="#getModule.thumbAlign#">
                  <TR>
                    <TD style="background-color:silver; width:30px; color:black;" align="center" class="pad3">#left(listgetat(application.monthlist,month(startdate)),3)#</TD>
                  </TR>
                  <TR>
                    <TD style="background-color:white; color: black" align="center" class="pad3">#day(startdate)#</TD>
                  </TR>
                </table>
              </cfif>
              

              #dateformat(mystartdate, request.community.dateformat)#  #timeformat(mystartdate)# 
              <cfif startdate neq enddate and enddate neq ''>
					<Cfset myEndDate = application.timezone.castFromServer(endDate, application.community.settings.getValue('timezone'))>
                - #dateformat(myenddate, request.community.dateformat)# #timeformat(myenddate)#
              </cfif>
	         <BR />
              <BR>
				<cfif variables.type neq ''><B>Event Type: </B> #variables.type#<BR /></cfif>
				<cfif variables.price neq ''><B>Price: </b> <cfif isnumeric(variables.price)>#dollarformat(variables.price)#<cfelse>#variables.price#</cfif><BR></cfif>
				<cfif variables.age neq ''><B>Ages: </b>
				<cfif variables.age eq "0">
				All ages
				<cfelseif variables.age eq "13">
				13-18
				<cfelseif variables.age eq "18">
				18+
				<cfelseif variables.age eq "19">
				18+ or w/ adult
				<cfelseif variables.age eq "20">
				19+
				<cfelseif variables.age eq "21">
				21+
				<cfelseif variables.age eq "22">
				21+ or w/ adult
				</cfif>
				</cfif>
				<BR>

				<br />
                       <Cfif trim(Creator) neq ''>
			  <B>Hosted By:</B> #creator#<BR /><BR />            
			  </cfif>
            
              </span>
		</div>
		<div align="right">
             <cfif q_content.venue neq ''>#q_content.venue# <br></cfif>
		<cfif q_content.address neq ''>#q_content.address#<BR></cfif>
			<cfif q_content.city neq '' and q_content.state neq ''>
           #q_content.City#, #q_content.state# #q_content.zipcode#
            </cfif>
<cfif q_content.country neq ''>
 #q_content.country#
</cfif>

<cfif website neq 'http://' and trim(website) neq ''>
<BR>
Website: <a href="#website#">#website#</a>
</cfif>
<BR>
              #q_content.favoritecount# RSVP's
              </div>

	<br style="clear:both;">
         <cfif trim(desc) neq '' and trim(desc) neq '<br />'>	<hr  size="1px">#wrap(trim(desc),100)#</cfif>

	<br style="clear:both;">
	</cfloop>

        </cfoutput>