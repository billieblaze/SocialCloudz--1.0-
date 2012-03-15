<cfset myID = 151275797596>

<cfhttp method="get" url="http://graph.facebook.com/#myID#"/>
<Cfdump var='#deserializeJson(cfhttp.filecontent)#'>

<Cfhttp method="get" url='http://graph.facebook.com/#myID#/feed'/>

<Cfdump var='#deserializeJson(cfhttp.filecontent)#'>



<!--- add a subscriber - check / create profile for user / group within the system.. content will get posted from that ID..  this may wind up being the "one userID" --->
	

<!---   loop content --->

	<!--- have i imported already?  (check attributes) --->

		<!---no, process --->
				<!--- which content types do i subscribe to?  --->

				<!--- lets try an event --->
					<cfhttp method="get" url="http://graph.facebook.com/210370252322825"/>
					<Cfdump var='#deserializeJson(cfhttp.filecontent)#'>	
		
				<!--- whos attending --->
					<cfhttp method="get" url="http://graph.facebook.com/210370252322825/attending"/>
					<Cfdump var='#deserializeJson(cfhttp.filecontent)#'>	