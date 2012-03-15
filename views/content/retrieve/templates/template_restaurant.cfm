<cfscript>
		q_content = rc.contentModuleData.query;
getModule = qGetModules;
website = application.content.getAttribute(q_content.attribs, 'website');
website = replace(website, 'http://', '');
website = 'http://#website#';
yelp = application.content.getAttribute(q_content.attribs, 'yelp');
yelp = replace(yelp , 'http://', '');
yelp = 'http://#yelp#';

phone = application.content.getAttribute(q_content.attribs, 'phone');
request.addressArray[1][1] = q_content.title;
request.addressArray[1][2] = '#q_content.address#, #q_content.city#, #q_content.state#';

neighborhood = application.content.getAttribute(q_content.attribs, 'area');
cuisine = application.content.getAttribute(q_content.attribs, 'food');
</cfscript>
<Cfoutput>
	 
<cfloop query="q_content">
    

        <cfset cnt = 0>
        <h2>#q_content.title#</h2>
		
    <hr>
<table width="100%">
<TR><TD>
<cfif neighborhood neq ''>
Neighborhood: <a href="/index.cfm/content/#contentType#?attribute=area&attributeValue=#neighborhood#">#neighborhood#</a><BR>
</cfif>
	<cfif cuisine neq ''>
	Cuisine: 
	<cfset cnt = 1>
	<cfloop list="#cuisine#" index="i">
	<a href="/index.cfm/content/#contentType#?attribute=food&attributeValue=#trim(i)#">#trim(i)#</a><cfif cnt neq listlen(cuisine)>,</cfif>	<cfset cnt = cnt + 1>
	</cfloop>
<BR><BR>
</cfif>

	<cfif categories neq ''>
Category: 
<cfset cnt = 1>
<cfloop list="#categories#" index="category">
<a href="/index.cfm/content/contentType?category=#category#">#category#</a> <cfif listlen(Categories) neq cnt>,</cfif>
<cfset cnt = cnt + 1>
</cfloop>
<BR><BR>
</cfif>
	
	
	<cfif address neq ''>#address#<BR></cfif>
<cfif city neq ''>#city#,</cfif>
<cfif state neq ''>#state#</cfif>
<cfif zipcode neq ''> #zipcode#</cfif>
  <cfif address neq '' or (city neq '' and state neq '')>
          	<a href="http://mapof.it/#address# #city# #state# #country#" target="_blank">(Map It)</a>
          </cfif>
<cfif city neq '' or state neq '' or zipcode neq ''><BR></cfif>

<cfif phone neq ''><BR>#phone#<BR></cfif>

<BR>
<cfif website neq 'http://'>
<a href="#website#" target="_blank">#website#</a><BR>
</cfif>
<cfif yelp neq 'http://'>
Yelp: <a href="#yelp#" target="_blank">#yelp#</a><BR>
</cfif>
</TD><TD>      
		#getMyPlugin(plugin="imageManager",module="imageManager").displayImage( image=q_content.image,  size=getmodule.thumbsize, align=getmodule.thumbAlign)#
	<BR><BR>
	<cfset ratingaccess = application.cms.settings.check('canRate')>

<cfif ratingAccess neq 'Noone'>
<BR />
		<cfset canrate = 1>
		<cfif ratingaccess eq 'members' and request.session.login eq 0>
			<cfset canrate = 0>
		<cfelseif  ratingaccess eq 'Admin' and request.session.login lte 10>
			<cfset canrate = 0>
		</cfif>

		<cfmodule template='/customTags/ratingStars.cfm' FKID='#q_Content.contentID#' fkType='Content'  canRate='#canrate#' />


</cfif>

</TD></TR>
</table>
    <hr>
        <BR />
                    <cfif desc neq ''>
			
#wrap(desc,100)#
</cfif><BR><BR>
<table width="100%">
	<TR>
		<TD width="33%"><strong>Rating:</strong>   
		<cfset ratingLevel = application.content.getAttribute(q_content.attribs, 'ratingLevel')>
		<cfif ratingLevel eq ''>
			3
		<cfelse>
			#ratingLevel#
		</cfif>
		</TD>
		<TD width="33%"><strong>Price:</strong>   #application.content.getAttribute(q_content.attribs, 'price')#</TD>
		<TD width="34%"><strong>## of outside tables:</strong>   #application.content.getAttribute(q_content.attribs, 'tables')#</TD>
		
	</TR>
	<TR>
		<TD><strong>Lunch:</strong>   #yesnoformat(application.content.getAttribute(q_content.attribs, 'lunch'))#</TD>
		<TD><strong>Umbrella's:</strong>   #yesnoformat(application.content.getAttribute(q_content.attribs, 'umbrellas'))#</TD>
		<TD><strong>Sunny At Lunch:</strong> #yesNoFormat(application.content.getAttribute(q_content.attribs, 'sunny'))#</TD>
	</TR>
	<TR>
		<TD><strong>Brunch:</strong>   #yesnoformat(application.content.getAttribute(q_content.attribs, 'brunch'))#</TD>
		<TD><strong>Shade:</strong> #yesnoformat(application.content.getAttribute(q_content.attribs, 'shade'))#</TD>
		<TD width="33%"><strong>Pet Friendly:</strong> #yesnoformat(application.content.getAttribute(q_content.attribs, 'pets'))#</TD>
	</TR>
	<TR>
		<TD><strong>Dinner:</strong>   #yesnoformat(application.content.getAttribute(q_content.attribs, 'dinner'))#</TD>
		<TD><strong>Under Cover:</strong>   #yesnoformat(application.content.getAttribute(q_content.attribs, 'undercover'))#</TD>
		<TD><strong>Patio Heaters:</strong>   #yesnoformat(application.content.getAttribute(q_content.attribs, 'heaters'))#</TD>
	</TR>
	<TR>
		<TD><strong>Romantic:</strong>   #yesnoformat(application.content.getAttribute(q_content.attribs, 'romantic'))#</TD>
		<TD></TD>
		<TD></TD>
	</TR>
</table>


        </cfloop>
		
       <BR style="clear:both" /> 
	

		<cfinclude template="template_restaurantMenu.cfm">

</cfoutput>	