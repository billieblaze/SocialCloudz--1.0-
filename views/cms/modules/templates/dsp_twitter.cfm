<style type="text/css">
#juitterContainer{} /*Juitter container*/
#juitterContainer .twittList{margin:0;padding:0;} /* UL that will contain the list of tweets */
/* Bellow the list of tweets "<li>" */
#juitterContainer .twittLI{list-style:none;background:#EEFDEA;margin:0;padding:5px 0 0 0;border-bottom:dashed 1px silver;padding:3px;clear:both;} 
#juitterContainer .twittList A{} /*Links inside the tweets list */
/* Bellow the CSS for the avatar image  */
#juitterContainer .juitterAvatar{float:left;border:solid 1px #D3EECA;background:#FFF;margin-right:5px;padding:2px;width:48px;;height:48px;}
#juitterContainer .jRM{clear:both} /*read it on twitter link*/
#juitterContainer .extLink{} /*CSS for the external links*/
#juitterContainer .hashLink{} /*CSS for the hash links*/
</style>

<cfscript>	
	getModule = qGetModules;
	myurl = 'http://api.twitter.com/1/statuses/user_timeline.json?screen_name=#getModule.displayTemplate#&include_rts=false&exclude_replies=true&count=#getmodule.displayRows#';

	object = application.memcached.get(myURL);
</cfscript>
<cfif isBoolean(object) AND object EQ false>
	<cfsaveContent variable="object">
	<cftry>
		<Cfhttp method="get" url="#myURL#"/>
		
		<cfset results='#deserializeJSON(cfhttp.filecontent)#'>
		<cfoutput>
			<div id="juitterContainer">
				<ul id="twittList0" class="twittList">
				<cfloop from=1 to="#arrayLen(results)#" index="i">
					<li id="twittLI1" class="twittLI" style="display: list-item;">
						<a href="#results[i].user.url#">
							<img class="juitterAvatar" alt="#results[i].user.screen_name#" src="#results[i].user.profile_image_url#">
						</a>
						#application.processtext.activateURL(results[i].text)#
						<a class="jRM" href="http://twitter.com/#results[i].user.screen_name#/status/#results[i].id#">...(Read)</a>
					</li>
				</cfloop>
				</ul>
			</div>
		</cfoutput>
	
		<cfcatch>Invalid Twitter ID or Bad Request</cfcatch>
	</cftry>
	</cfsavecontent>
	<cfset application.memcached.add(myURL, object, '60')>
</cfif>
<cfoutput>#object#</cfoutput>
<div style="clear:both; height:0px;"></div>