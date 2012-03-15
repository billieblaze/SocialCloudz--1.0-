<cfset request.session.memberID = 1>
<cfset request.session.accesslevel = 100>

<cfset theFile = expandPath("/tests/sample.ics")>
<cffile action="read" file="#theFile#" variable="data">

<cfset ical = createObject("component","/udf/ical").init(data)>
<cfset results = ical.getEvents()>
<cfdump var='#results#'>
<cfloop index="x" from="1" to="#arraylen(results)#">

	<cfset eventData = results[x]>
	<cfif not structKeyExists(eventData,"summary")>
		<cfset title = 'Unnamed Event'>
	<cfelse>
		<cfset title = eventData.summary.data>
	</cfif>
	
	<cfset startDate = ical.icalParseDateTime(eventData.dtstart.data)>
	<cfif structKeyExists(eventData,"dtend")>
		<cfset endDate = ical.icalParseDateTime(eventData.dtend.data)>
	<cfelseif structKeyExists(eventData,"duration") and eventData.duration.data is not "P1D">
		<cfset endDate = ical.icalParseDuration(eventData.duration.data,startdate)>
	<cfelse>
		<cfset enddate = startdate>
	</cfif>

	<cfif structKeyExists(eventData,"description")>
		<cfset description=eventData.description.data>
	</cfif>
	
	<cfscript>
		checkEvent = application.content.get(attribute='uid', attributeValue=eventData.UID.data, trackstats=0);
		
		if (checkEvent.recordCount){
			writeoutput('Skipped - #eventData.UID.data#<BR>');
		} else {
			data = structNew();
			data.publishDate = eventData.created.data;
			data.desc = description;
			data.endDate = endDate;
			data.startDate = startDate;
			data.venue = eventData.location.data;
			data.creator = eventData.organizer.data;
			data.title = eventData.summary.data;
			data.uid = eventData.uid.data;
			data.website = eventData.URL.data;
			data.communityID = 3;
			data.memberID = 1;
			data.contentType = 'Event';
			application.content.save(data);
		}
	</cfscript>
</cfloop>