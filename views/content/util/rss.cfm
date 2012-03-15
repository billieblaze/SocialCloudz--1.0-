<cfprocessingdirective suppresswhitespace="true"><cfheader name="Content-type" value="text/xml"><cfscript>
entries = event.getvalue('entries');
 thisurl = '#request.community.domain.subdomain[1]#.#request.community.domain.domain[1]#'; 
</cfscript><cfif entries.contentType eq 'music'><?xml version="1.0" encoding="UTF-8"?>
	<rss xmlns:taxo="http://prc.org/rss/1.0/modules/taxonomy/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:dc="http://prc.org/dc/elements/1.1/" version="2.0">
	<cfoutput>
	<channel>
		<title>#request.community.site# - #rc.contentType#</title>
		<link>http://#thisurl#</link>
		<language>en-us</language>
		<copyright>&##x2117; &amp; &##xA9; #year(now())# #request.community.site#</copyright>
		<description>#request.community.description#</description>
		<cfset logo = request.community.logo>	
		<cfif logo contains '.jpg' or logo contains '.png' or logo contains '.JPG'>
				<itunes:image href="http://#thisurl#/content/community/#request.community.communityID#/#logo#"/>
		</cfif>		

		<itunes:subtitle>#request.community.site# - #rc.contentType#</itunes:subtitle>
		<itunes:author>#application.members.getusername(request.community.adminID)#</itunes:author>
	    <itunes:explicit>no</itunes:explicit>
	    <itunes:block>no</itunes:block>
	    <itunes:summary>#request.community.description#</itunes:summary>
    	<itunes:category text="Music"/>

		<cfloop query="entries">
		<cfset childContent = application.content.get(parentID=entries.contentID)>
		<cfloop query="childContent">
		<cfset tmpCreator = replace(entries.creator, '&', ' ', 'all')>
		<cfset tmpTitle = replace(entries.title, '&', ' ', 'all')>
		<cfset tmpImage = 'http://#thisurl##entries.image#'>
		<item>
			<guid isPermaLink="true">http://#thisurl##entries.link##entries.contentID#</guid>
			<pubDate>#dateformat(entries.dateCreated, 'ddd, d mmm yyyy')# #timeformat(entries.dateCreated, 'hh:mm:ss')# EST</pubDate>
			<title>#xmlFormat(tmpTitle)#</title>

			<description>#xmlFormat(application.processtext.abbreviate(entries.desc,512))#</description>
			<link>http://#thisurl#/index.cfm/content/#q_content.contentType#/#entries.contentID#</link>
			<itunes:author>#xmlFormat(tmpCreator)#</itunes:author>
			<itunes:keywords>#entries.tags#</itunes:keywords>
			<itunes:explicit>#yesNoFormat(entries.explicit)#</itunes:explicit>
			<itunes:subtitle>#tmpTitle#</itunes:subtitle>
			<itunes:summary>#xmlFormat(application.processtext.abbreviate(entries.desc,4000))#</itunes:summary>
			<enclosure url="http://#thisURL##application.content.getAttribute(childContent.attribs,'directory')#/#application.content.getAttribute(childcontent.attribs,'file')#" type="audio/mpeg" />

			<cfif tmpimage contains '.jpg' or tmpimage contains '.png' or tmpimage contains '.JPG'>
				<itunes:image href="#tmpImage#"/>
			</cfif>
		</item>
		</cfloop>
		</cfloop>
	</channel>
	</rss>
</cfoutput>
<cfelse><cfscript>

myStruct = StructNew();

mystruct.link = "http://#thisurl#;";
myStruct.title = "#rc.contentType#";
mystruct.description = "";
mystruct.pubDate = application.timezone.castFromServer(now(), application.community.settings.getValue('timezone'));
mystruct.version = "rss_2.0";
myStruct.item = ArrayNew(1);
</cfscript><cfloop query="entries"><cfscript>
myStruct.item[currentRow] = StructNew();
myStruct.item[currentRow].guid = structNew();
myStruct.item[currentRow].guid.isPermaLink="true";
if ( contentType eq 'Link'){
	 linkurl = application.content.getAttribute(entries.attribs, 'linkurl');
     linkurl = replace(linkurl, 'http://', '');
     linkurl = 'http://' & linkurl;
		myStruct.item[currentRow].guid.value = linkURL;
} else {
	myStruct.item[currentRow].guid.value = '#thisurl#/index.cfm/content/#entries.contentType#/#evaluate('entries.#linkID#')#';
}
myStruct.item[currentRow].pubDate = createDate(year(dateCreated), month(dateCreated), day(dateCreated));
myStruct.item[currentRow].title = xmlFormat(title);
myStruct.item[currentRow].description = StructNew();
myStruct.item[currentRow].description.value = xmlFormat(application.processtext.abbreviate(desc,512));
if ( contentType eq 'Link'){
	myStruct.item[currentRow].link = linkURL;
} else {
	myStruct.item[currentRow].link = 'http://#thisurl#/index.cfm/content/#entries.contentType#/#evaluate('entries.#linkID#')#';
}
</cfscript></cfloop><cffeed action="create" name="#myStruct#" overwrite="true" xmlVar="myXML" /><cfoutput>#myXML#</cfoutput>
</cfif>
</cfprocessingdirective>