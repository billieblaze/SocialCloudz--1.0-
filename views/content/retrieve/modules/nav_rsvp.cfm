<cfscript>
q_content = rc.content.query;
getModule = qGetModules;
rsvplist_yes =application.content.favorite.get(q_content.contentID,'1');		
rsvplist_no =application.content.favorite.get(q_content.contentID,'0');		
rsvplist_maybe= application.content.favorite.get(q_content.contentID,'-1');		
</cfscript>
<cfoutput>
	<cfif request.session.login eq 1 and q_content.startdate gte now()>
		<form action="/index.cfm/content/favorite/add" method="post">
			<input type="hidden" name="contentID" value="#q_content.contentID#">
			<B>Will You Be Attending?</b> <BR>
			<input type="radio" value="1" name="level" onclick="this.form.submit()"> Yes<BR>
			<input type="radio" value="0" name="level" onclick="this.form.submit()"> No<BR>
			<input type="radio" value="-1" name="level" onclick="this.form.submit()"> Maybe<BR><BR>
		</form>
		</div>
		<div class="ft"></div>
	</div>
	</cfif>
	
	
	<div class="mod">
		<div class="hd">
			<div style="float:left">Whos Attending</div>
			<div align="right">
				<cfif  (rc.content.query.memberID eq request.session.memberID or request.session.accesslevel gte 10)>
			      	<a href="#event.buildLink(linkTo='content.util.printRSVPList',queryString='contentID=#rc.content.query.contentID#')#" target="_blank" class="aNone small" title="Print Guest List"><img src="#application.cdn.fam#printer.png" /></a>
			    </cfif>
		    </div>
		</div>
		<div class="bd">
			
	
			<cfif rsvplist_yes.recordcount gt 0>
			<strong>Attending</strong> (#rsvplist_yes.recordcount#)<HR>
			
			<cfloop query="rsvplist_yes">
			
				    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( rsvplist_yes.memberID ), 
		    		size=rc.contentFilter.thumbSize, 
		    		title =  application.members.getusername(rsvplist_yes.memberID))#
				
		
			</cfloop>
			<br style="clear:left"/>
			</cfif>
			<cfif rsvplist_maybe.recordcount gt 0>
			<strong>May Be Attending</strong> (#rsvplist_maybe.recordcount#)<HR>
			
			<cfloop query="rsvplist_maybe">
			    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( rsvplist_maybe.memberID ), 
		    		size=getModule.thumbSize,
		    		title= application.members.getusername(rsvplist_maybe.memberID,1))#
				
			</cfloop>
			<br style="clear:left"/>
			</cfif>
		<cfif rsvplist_no.recordcount gt 0>
			<strong>Not Attending</strong> (#rsvplist_no.recordcount#)<HR>
			
			<cfloop query="rsvplist_no">
			
				    #getMyPlugin(plugin="imageManager",module="imageManager").displayImage( 
		    		image=application.members.userpic( rsvplist_no.memberID ), 
		    		size=getModule.thumbSize,
		    		title=application.members.getusername(rsvplist_no.memberID))#
		
		</cfloop>
		<br style="clear:left"/>
	</cfif>
</cfoutput>