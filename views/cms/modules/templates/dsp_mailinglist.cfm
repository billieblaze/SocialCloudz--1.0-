<div align="center" id="mailinglist">
<cfinclude template="../../../emailMarketing/mailingList/index.cfm">	
</div>
<script language="javascript">
	$('#mailingListForm').ajaxForm({
		resetForm: true,
		success: mailSuccess		
	});
	  function mailSuccess ( responseText ){
		$.jGrowl(responseText);
	}
</script>

