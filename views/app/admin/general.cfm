<table width='100%'>
<TR bgcolor='gray' style='font-weight:bold'>
	<TD></TD>
	<TD>Today</TD>
	<TD>Yesterday</TD>
	<TD>7 Days</TD>
	<TD>30 Days</TD>

	<TD>90 Days</TD>	
	<TD>180 Days</TD>	
	<TD>365 Days</TD>	
</TR>

<cfquery datasource='community' name='qGet'>
	select (select count(communityID) from community where dateCreated > '#dateformat(now(), 'yyyy-mm-dd')#') as Today,
(select count(communityID) from community where dateCreated between '#dateformat(dateadd('d',-1, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#'  ) as Yesterday,
(select count(communityID) from community where dateCreated between '#dateformat(dateadd('d',-7, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Week,
(select count(communityID) from community where dateCreated between '#dateformat(dateadd('d',-30, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Month,
(select count(communityID) from community where dateCreated between '#dateformat(dateadd('d',-90, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Quarter,
(select count(communityID) from community where dateCreated between '#dateformat(dateadd('d',-180, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Half,
(select count(communityID) from community where dateCreated between '#dateformat(dateadd('d',-365, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Year
</cfquery>
<cfoutput query="qGet">
<TR bgcolor='silver'>
	<TD>Communities</TD>
	<TD>#qGet.today#</TD>
	<TD>#qGet.yesterday#</TD>
	<TD>#qGet.week#</TD>
	<TD>#qGet.month#</TD>
	<TD>#qGet.quarter#</TD>
	<TD>#qGet.half#</TD>
	<TD>#qGet.year#</TD>

</TR>
</cfoutput>

<cfquery datasource='members' name='qGet'>
	select (select count(memberID) from membersaccount where dateEntered > '#dateformat(now(), 'yyyy-mm-dd')#') as Today,
(select count(memberID) from membersaccount where dateEntered between '#dateformat(dateadd('d',-1, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#'  ) as Yesterday,
(select count(memberID) from membersaccount where dateEntered between '#dateformat(dateadd('d',-7, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Week,
(select count(memberID) from membersaccount where dateEntered between '#dateformat(dateadd('d',-30, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Month,
(select count(memberID) from membersaccount where dateEntered between '#dateformat(dateadd('d',-90, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Quarter,
(select count(memberID) from membersaccount where dateEntered between '#dateformat(dateadd('d',-180, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Half,
(select count(memberID) from membersaccount where dateEntered between '#dateformat(dateadd('d',-365, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Year
</cfquery>
<cfoutput query='qGet'>
<TR bgcolor='white'>
	<TD>Accounts</TD>
	<TD>#qGet.today#</TD>
	<TD>#qGet.yesterday#</TD>
	<TD>#qGet.week#</TD>
	<TD>#qGet.month#</TD>
	<TD>#qGet.quarter#</TD>
	<TD>#qGet.half#</TD>
	<TD>#qGet.year#</TD>
		
</TR>
</cfoutput>
<cfquery datasource='statistics' name='qGet'>
	select (select sum(hits) from bandwidth where dateEntered > '#dateformat(now(), 'yyyy-mm-dd')#') as Today,
(select sum(hits) from bandwidth where dateEntered between '#dateformat(dateadd('d',-1, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#'  ) as Yesterday,
(select sum(hits) from bandwidth where dateEntered between '#dateformat(dateadd('d',-7, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Week,
(select sum(hits) from bandwidth where dateEntered between '#dateformat(dateadd('d',-30, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Month,
(select sum(hits) from bandwidth where dateEntered between '#dateformat(dateadd('d',-90, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Quarter,
(select sum(hits) from bandwidth where dateEntered between '#dateformat(dateadd('d',-180, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Half,
(select sum(hits) from bandwidth where dateEntered between '#dateformat(dateadd('d',-365, now()), 'yyyy-mm-dd')#' and '#dateformat(now(), 'yyyy-mm-dd')#' ) as Year
</cfquery>
<cfoutput query='qGet'>
<TR bgcolor='silver'>
	<TD>Page Views</TD>
	<TD>#qGet.today#</TD>
	<TD>#qGet.yesterday#</TD>
	<TD>#qGet.week#</TD>
	<TD>#qGet.month#</TD>
	<TD>#qGet.quarter#</TD>
	<TD>#qGet.half#</TD>
	<TD>#qGet.year#</TD>	
</TR>
</cfoutput>
<TR bgcolor='white'>
	<TD>Errors</TD>
	<TD></TD>
	<TD></TD>
	<TD></TD>
	<TD></TD>
	<TD></TD>
	<TD></TD>
	<TD></TD>		
</TR>