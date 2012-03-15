<cfif isdefined('rc.feedData')>
	<cfoutput>
	<cfloop from="1" to="#arrayLen(rc.feedData)#" index="item">

		<cfif isDefined('rc.feedData[item].link') and rc.feedData[item].type neq 'status'>
		 	 	<cfset link = rc.feedData[item].link>

			<cfif isdefined('rc.feedData[item].object_id')>
				<cfset objectId = rc.feedData[item].object_id>
				<cfset objectData = rc.facebook.getObject(objectID = objectId)>
			</cfif>		
			<cftry>
				<!--- todo: if it hasn't passed or we haven't gotten it already --->
				<cfif rc.feedData[item].type eq 'event' or  link contains 'event'>
					EVENT: <img src="http://graph.facebook.com/#objectid#/picture"> #objectData.name# - #objectData.location# - #objectData.start_time#<br>
					<a href="http://#cgi.http_host#/index.cfm/facebook/import/event/pageid/#rc.targetid#/objectid/#objectId#">copy to socialcloudz</a>
					<hr>
				<cfelseif rc.feedData[item].type eq 'music'>
					MUSIC: #rc.feedData[item].link# - #rc.feedData[item].message#<br />
					<a href="http://#cgi.http_host#/index.cfm/facebook/import/music/pageid/#rc.targetid#">copy to socialcloudz</a>
					<hr>
				<cfelseif rc.feedData[item].type eq 'photo' or  link contains 'photo.php'>
					<cfif isDefined('rc.feedData[item].picture')>
					PHOTO: <img src="#rc.feedData[item].picture#"> #rc.feedData[item].name#<br />
					<a href="http://#cgi.http_host#/index.cfm/facebook/import/photo/pageid/#rc.targetid#/objectid/#objectId#">copy to socialcloudz</a>
					<hr>
					</cfif>
				<cfelseif  rc.feedData[item].type eq 'video' or link contains 'youtube'>
					VIDEO: <img src="http://graph.facebook.com/#rc.feedData[item].id#/picture"> #rc.feedData[item].name#<br />
					<a href="http://#cgi.http_host#/index.cfm/facebook/import/event/pageid/#rc.targetid#/objectid/#objectId#">copy to socialcloudz</a>
					<hr>
				<cfelseif rc.feedData[item].type eq 'link'>
					LINK: 
					<cfif isDefined('rc.feedData[item].picture')>
					 <img src="#rc.feedData[item].picture#">
					</cfif>
					#rc.feedData[item].link# - #rc.feedData[item].name#<br />
					<a href="http://#cgi.http_host#/index.cfm/facebook/import/link/pageid/#rc.targetid#">copy to socialcloudz</a>
					<hr>
				</cfif>
				<cfcatch><cfdump var='#rc.feedData[item]#'><hr></cfcatch>
			</cftry>
		</cfif>
	</cfloop>
	</cfoutput>
</cfif>
