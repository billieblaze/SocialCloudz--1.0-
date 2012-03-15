<script language="javascript" src="/scripts/form_autofocus.js"></script>

<cfparam name="rc.tagline" default="">
<cfparam name="rc.price" default="">
<cfparam name="rc.age" default="">
<cfoutput>
	#renderView('content/form/frm_top')#
	<div class="ui-widget">
	<div class="ui-widget-header">Add an Event</div>
    <div class="ui-widget-content">

<div id="tabs">
   	<ul>
       	<li ><a href="##tabs-1" class="blackText">Add Event</a></li>
		<cfif rc.contentID eq 0 and not isDefined('rc.import')>
				<li><a href="##tabs-4" class="blackText">Import Events from ICS</a></li>
		</cfif>

    </ul>            
	<div id="tabs-1" class="ui-tabs-hide">
		Event Name<BR> <input name="title" maxlength="255"  style="width:100%" value="#rc.title#"><br>
		Tagline<BR> <input name="tagline" maxlength="255"  style="width:100%"  value="#rc.tagline#"><br>
		<BR>
		Host<BR /> <input name="creator" size="33" value="#rc.creator#"><br>
		Price<BR> <input name="price" size="40" maxlength="35" value="#rc.price#"><br>
		Age Limit<BR>
		<select id="age" name="age">
			<option value="0" <cfif rc.age eq 0>selected</cfif>>All ages</option>
			<option value="13" <cfif rc.age eq 13>selected</cfif>>13-18</option>
			<option value="18" <cfif rc.age eq 18>selected</cfif>>18+</option>
			<option value="19" <cfif rc.age eq 19>selected</cfif>>18+ or w/ adult</option>
			<option value="20" <cfif rc.age eq 20>selected</cfif>>19+</option>
			<option value="21" <cfif rc.age eq 21>selected</cfif>>21+</option>
			<option value="22" <cfif rc.age eq 22>selected</cfif>>21+ or w/ adult</option>
		</select> 
		<BR><BR>
		<B>Description:</B><br />
		 #application.form.textEditor('desc', rc.desc)#
		<br />
		<br />
		<div align="center">
			By submitting this entry, you agree to the <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions">Terms & Conditions</a>.<br />
			<br />
			<input type="submit" value="Save" /> <input type="button" value="Cancel"  onclick="history.back();"/>
		</div>
	</div>
<cfif rc.contentID eq 0 and not isDefined('rc.import')>
	
	<div id="tabs-3" class="ui-tabs-hide">
	Enter the Google Calendar Feed URL:  <input type="text" name="googleFeed" value="" style="width:90%">

		To find your calendar's "magic cookie" feed URL:

   1. In the list of calendars on the left side of the page, find the calendar you want to interact with. You can create a new calendar for this purpose if you want to.
   2. Click the arrow button to the right of the calendar. Select "Calendar settings" from the drop-down menu. The Calendar Details page appears.
   3. Scroll down to the Private Address section and select the XML button. The feed URL appears.
   4. Copy the URL. This is the URL of your calendar's read-only "magic cookie" private feed; it includes a special coded string that lets you read the private feed without having to do authentication. This is the URL you'll use to request a feed from Calendar, so you won't have to do authentication just to view the feed.
		<div align="center">
			By submitting this entry, you agree to the <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions">Terms & Conditions</a>.<br />
			<br />
			<input type="submit" value="Save" /> <input type="button" value="Cancel"  onclick="history.back();"/>
		</div>
	</div>
	<div id="tabs-4" class="ui-tabs-hide">
	
		Here you can import events from Facebook or Google Calendar via .ICS file. Note: It will only import Facebook events that you are attending. <BR><BR>
		
		ICS URL: <input type="text" name="icsURL" value="" style="width:90%"><BR><BR>
		<div align="center">
			By submitting this entry, you agree to the <a href="#event.buildLink('app.info.terms')#" title="Terms & Conditions">Terms & Conditions</a>.<br />
			<br />
			<input type="submit" value="Save" /> <input type="button" value="Cancel"  onclick="history.back();"/>
		</div>
	</div>
</cfif>


</div>
	</div></div>
</cfoutput>
