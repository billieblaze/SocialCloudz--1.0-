<cfoutput>
<script>function showMyDialog(e) {}</script>
<form method="POST" action="#event.buildLink('content.form.save')#" id="content" Name="content">
<input type="hidden" name="contentID" id="contentID" value="#rc.contentID#" />
<input type="hidden" name="contentType" value="#rc.contentType#" />
<input type="hidden" name="memberid" value="#rc.memberid#" />
</cfoutput>