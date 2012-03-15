<cfcomponent>
	<cfprocessingdirective pageencoding="UTF-8">
	<cfsetting requesttimeout="53000">

	<cffunction access="private" name="scan" output="false" returntype="any" description="
		Scan page and extract all html link (<a href=""..."" ...>...</a>)
		">
		<cfargument name="root" required="yes" type="string" hint="Root of analyzed site: http + domain + path (es.: http://www.example.com/site1/page)">
		<cfargument name="spider_url" required="yes" type="string" hint="Start page of site (es.: index.cfm)">
		<cfargument name="depth" required="yes" type="numeric" hint="Click number (depth) of the page from start page">

		<!--- local variables --->
		<cfset var reg="<a [^>]*href=""([^""]+)""[^>]*>">
		<cfset var res="">
		<cfset var rootTmp="">
		<cfset var text="">
		<cfset var link="">
		<cfset var temp="">
		<cfset var levelNew = depth + 1>
		<cfset var startPos=0>
		<cfset var qry_insert="">
		<cfset var qry_update="">
		<cfset var qry_check="">

		<!--- verify of path syntax. if wrong it repairs it --->
		<cfif (root is not "") and (right(root,1) is not "/") and (left(url,1) is not "/")>
			<cfset rootTmp = root & "/">
		<cfelse>
			<cfset rootTmp = root>
		</cfif>
		<!--- call the first page for its contents --->
		<cftry>
			<cfhttp url="#rootTmp##spider_url#" useragent="#CGI.HTTP_USER_AGENT#"></cfhttp>
			<cfset text=cfhttp.FileContent>
			<cfcatch>
				<!--- scan wrong --->
				<cfset registro=registro & rootTmp & " - " & depth & " - " & "<b>lettura fallita</b><br>">
				<cfreturn>
			</cfcatch>
		</cftry>
		
		<cfset registro=registro & "<br>">

		<!---  verify if page is indexable --->
		<cfif text contains "<noindex>">
			<cfreturn>
		</cfif>
		
		<!--- set page checked on result query (remove it from memory query and create new one checked) --->
		<cfquery name="qry_pageList" dbtype="query">
			SELECT *
			FROM qry_pageList
			WHERE page<>'#spider_url#'
		</cfquery>
		
		<cfset temp=queryAddRow(qry_pageList)>
		<cfset temp=querySetCell(qry_pageList,"page",spider_url)>
		<cfset temp=querySetCell(qry_pageList,"depth",depth)>
		<cfset temp=querySetCell(qry_pageList,"analyzed",1)>
		<cfset temp=querySetCell(qry_pageList,"time",GetTickCount())>
		<!--- search all matches (link) with regular expression and save them on result query --->
		<cfloop condition="true">
			<!--- search match --->
			<cfset res=REFindNoCase(reg,text,startPos,true)>
			<cfif res.pos[1] is 0>
				<!--- noone --->
				<cfreturn>
			<cfelse>
				<!--- search link and saves match on temp variables --->
				<cfset startPos = res.pos[1] + res.len[1]>
				<cfset link= mid(text,res.pos[2],res.len[2])>
				<!--- se il link è senza il nome della pagina, lo aggiungo --->
				<cfif left(link,1) is "?">
					<cfset link = spider_url & link>
				</cfif>
			</cfif>

	
	            <cfif (len(link) gt 5) and
	          	(link does not contain "://") and
  	            (link does not contain "mailto:") and
	            (link does not contain "javascript:") >
					<!--- sava match --->
                    <cfif not (right(link,4) is ".pdf" OR
                    	      right(link,4) is ".doc" OR
						      right(link,4) is ".xls" OR
                              right(link,4) is ".doc" OR
                              right(link,4) is ".txt")>

		<!--- save page if doesn't still exist --->
			<cfquery name="qry_check" dbtype="query">
				SELECT *
				FROM qry_pageList
				WHERE page = '#link#'
			</cfquery>
			<cfif qry_check.recordCount is 0>
			<!--- check fully qualified link and remove root --->
			<cfif link CONTAINS root>
				<cfset link = "#replace(link,root,de(''))#">
			</cfif>
	                              	<cfset temp=queryAddRow(qry_pageList)>
									<cfset temp=querySetCell(qry_pageList,"page",link)>
                                    <cfset temp=querySetCell(qry_pageList,"depth",levelNew)>
	                                <cfset temp=querySetCell(qry_pageList,"analyzed",0)>
									<cfset temp=querySetCell(qry_pageList,"time",GetTickCount())>
					</cfif>       
				</cfif>
			</cfif>
		</cfloop>
	</cffunction>

	<!--- cerco links --->
	<cffunction access="remote" name="sitemap" output="true" returntype="query" description="
		Start spider to scan all pages from start page
		to all link reachable with *depthMax* click number
		">
		<cfargument name="root" required="yes" type="string" hint="Root of analyzed site: http + domain + path (es.: http://www.example.com/site1/page)">
		<cfargument name="spider_url" required="yes" type="string" hint="Start page of site (es.: index.cfm)">
		<cfargument name="depthMax" required="yes" type="numeric" hint="Max click number (depth) of the page from start page">

		<!--- regular exprezzion --->
		<cfset var reg="<a [^>]*href=""([^""]+)""[^>]*>">

		<!--- local variables --->
		<cfset var temp="">
		<cfset var qry_root="">
		<cfset var qry_cerca="">
		<cfset var depth=0>

		<!--- algorith registry --->
		<cfset registro="">

		<!--- result query creation --->
		<cfset qry_pageList=queryNew("page,depth,analyzed,time","VarChar,Integer,Bit,Time")>

		<!--- insert root on result query (not analyzed) --->
		<cfset temp=queryAddRow(qry_pageList)>
		<cfset temp=querySetCell(qry_pageList,"page",spider_url)>
		<cfset temp=querySetCell(qry_pageList,"depth",0)>
		<cfset temp=querySetCell(qry_pageList,"analyzed",0)>
		<cfset temp=querySetCell(qry_pageList,"time",GetTickCount())>

		<cfset registro=registro & "<h3>Inizio scansione</h3>">
		<cfset session.intStartTime = GetTickCount() />
		<!--- start spider scan (loop since depth less then depthMax) --->
		<cfloop condition="depth lt depthMax">
			<!--- load scannable pages --->
			<cfquery name="qry_cerca" dbtype="query">
			SELECT *
			FROM qry_pageList
			WHERE analyzed=0
			</cfquery>
			<!--- start page scan --->
			<cfloop query="qry_cerca">
				
					<cfset registro=registro & root & " - " & page & " - " & depth & " - ">
					<cfset temp=scan(root,page,depth,indexIt)>
			
			</cfloop>
			
			<!--- depth increment --->
			<cfset depth=depth+1>
		</cfloop>
		<cfreturn qry_pageList>
	</cffunction>

	<cffunction name="googleSitemap" access="remote" output="true" description="
		Google Sitemap Creation from sitemap result query
		Page who called ""googleSitemap"" functon may prepend:
			<cfcontent type=""text/xml; charset=UTF-8"">
		">
		
		<cfargument name="query" required="yes" type="query" hint="Result query: it needs ""page"" data column">
		<cfargument name="root" required="yes" type="string" hint="Root of analyzed site: http + domain + path (es.: http://www.example.com/site1/page)">
		<cfset var qry_view="">
		<cfset var SitemapTime = GetTickCount() />
		<!--- build sitemap xml --->
		<cfquery name="qry_view" dbtype="query">
			SELECT *
			FROM query
			ORDER BY depth
		</cfquery>
		<cfset sitemap = arrayNew(1)>
		<cfxml variable="xSiteMap">
			<urlset xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		         xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9"
		         url="http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"
		         xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
				<cfoutput query="qry_view">
					<url>
					<!--- Entity Escaping --->
					<cfset cleanURL = replace(page,'&','&amp;',"all") >
					<cfset cleanURL = replace(cleanURL,"'",'&apos;',"all") >
					<cfset cleanURL = replace(cleanURL,'"','&quot;',"all") >
					<cfset cleanURL = replace(cleanURL,'>','&gt;',"all") >
					<cfset cleanURL = replace(cleanURL,'<','&lt;',"all") >
					<cfset cleanURL = replace(cleanURL,'&quot;&quot;','',"all") >
					<cfset cleanURL = trim(cleanURL)>
					<cfset cleanURL = replace(cleanURL, '//', '/', 'all')>
					
					<cfif left(cleanurl,1) eq '/'>
						<cfset cleanurl = right(cleanurl, len(cleanurl)-1)>
					</cfif>
						<loc>#root##cleanURL#</loc>
						<changefreq>daily</changefreq>
						<priority>0.5</priority>
					</url>
				</cfoutput>
			</urlset>	
		</cfxml>
		<cfset sitemap[1] = xSitemap>
		<cfset sitemap[2] = SitemapTime>
		<cfset sitemap[3] = qry_view.RecordCount>
		<cfreturn sitemap>
	</cffunction>

	<cffunction name="indexIt" access="remote" output="false" description="
	Spider who builds query with pages name and all texts in plain/text format
	starting from navigation tree query (page column)
	Result query may insert on a verity collection to create search engine data source
	">
		<cfargument name="root" required="yes" type="string" hint="Root of analyzed site: http + domain + path (es.: http://www.example.com/site1/page)">
		<cfargument name="query" required="yes" type="query" hint="Result query: it needs ""page"" data column">
		<cfargument name="maxrows" required="no" type="numeric" default="500" hint="Max number of indexed pages">

		<cfset var date=now()>
		<cfset var pagine="">
		<cfset var qry_indice = QueryNew("date, page, text, titleS") >
		<cfset var i=1>
		<cfset var text="">
		<cfset var tmp="">

		<cfloop query="query" startrow="1" endrow="#maxrows#">
 			<cfthread action="RUN" name="thread2#Replace(mid(time,6,15),' ','','all')##CurrentRow#">
			<!--- verify of path syntax. if wrong it repairs it --->
			<cfif (root is not "") and (right(root,1) is not "/") and (left(page,1) is not "/")>
				<cfset rootTmp = root & "/">
			<cfelse>
				<cfset rootTmp = root>
			</cfif>

			<!--- load page contents --->
			<cfif findNoCase("?",page) gt 0>
				<cfset pageTmp = page & "&debug=false">
			<cfelse>
				<cfset pageTmp = page & "?debug=false">
			</cfif>
			<cfhttp url="#rootTmp##pageTmp#" useragent="#CGI.HTTP_USER_AGENT#"></cfhttp>
			<cfset text=cfhttp.FileContent>
			<cfif cfhttp.errorDetail is "">
				<!--- rewrite title appending variable --->
				<cfset temp=ReFindNoCase("<title>(.*)</title>",text,1,true)>
				<!--- check if some occurence exist --->
				<cfif isDefined("temp.len") and temp.len[1] gt 0>
					<cfset titleS=mid(text,temp.pos[2],temp.len[2])>
				<cfelse>
					<cfset titleS="">
				</cfif>

				<!--- remove comment head & script tags --->
				<cfset text=ReReplaceNoCase(text, "<head>.*</head>","","all")>
				<cfset text=ReReplaceNoCase(text, "<script>.*</script>","","all")>

				<!--- remove html tags --->
				<cfset text=ReReplaceNoCase(text, "<[^>]*>", "", "ALL")>

				<!--- result query building --->
				<cfset temp = QueryAddRow(qry_indice)>
				<cfset temp = QuerySetCell(qry_indice,"date",date)>
				<cfset temp = QuerySetCell(qry_indice,"page",page)>
				<cfset temp = QuerySetCell(qry_indice,"text",text)>
				<cfset temp = QuerySetCell(qry_indice,"titleS",titleS)>
			</cfif>
			 </cfthread> 
		</cfloop>
		<cfloop query="query" startrow="1" endrow="#maxrows#">
			<cfthread action="JOIN" name="thread2#Replace(mid(time,6,15),' ','','all')##CurrentRow#"/>
		</cfloop>
	
		<cfreturn qry_indice>
	</cffunction>
	<cffunction name="submitSitemap" access="remote" output="false" description="
	Submits sitemap.xml to Ask.com, Google, and Yahoo
	">
		<cfargument name="spider_url" required="yes" type="string" hint="Location of sitemap.xml (es.: http://www.domain.com/sitemap.xml)">
		<cfargument name="checkboxes" required="yes" type="any" hint="form object of the checkboxes selected">
		<cfset statusMessage = ArrayNew(1)>
		<!--- Ask.com --->
		<cfif isDefined("chkASK")>
			<cfhttp url="http://submissions.ask.com/ping?sitemap=#urlencodedformat(spider_url, 'utf-8')#" >
			<cfset ArrayAppend(statusMessage,cfhttp.responseheader.status_code)>
		</cfif>
		<!--- Google --->
		<cfif isDefined("chkGoogle")>
			<cfhttp url="http://www.google.com/webmasters/sitemaps/ping?sitemap=#urlencodedformat(spider_url, 'utf-8')#">
			<cfset ArrayAppend(statusMessage,cfhttp.responseheader.status_code)>
		</cfif>
		
		<!--- Yahoo --->
		<cfif isDefined("chkYahoo")>
			<cfhttp url="http://search.yahooapis.com/SiteExplorerService/V1/updateNotification?appid=YahooDemo&url=#spider_url#">
			<cfset ArrayAppend(statusMessage,cfhttp.responseheader.status_code)>
		</cfif>
		
		<!--- MSN (moreover.com for inclusion within the MSN Content Search)--->
		<cfif isDefined("chkMSN")>
			<cfhttp url="http://api.moreover.com/ping?u=#spider_url#">
			<cfset ArrayAppend(statusMessage,cfhttp.responseheader.status_code)>
		</cfif>
		
		<!--- blogsearch.google.com --->
		<cfif isDefined("chkBlogsearch")>
			<cfhttp url="http://blogsearch.google.com/ping?URL=#urlencodedformat(spider_url, 'utf-8')#">
			<cfset ArrayAppend(statusMessage,cfhttp.responseheader.status_code)>
		</cfif>
		<!--- Technorati --->
		<cfif isDefined("chkBlogsearch")>
			<cfhttp url="http://technorati.com/ping/?url=#urlencodedformat(spider_url, 'utf-8')#">		
			<cfset ArrayAppend(statusMessage,cfhttp.responseheader.status_code)>
		</cfif>
		<cfreturn statusMessage>
	</cffunction>

</cfcomponent>

