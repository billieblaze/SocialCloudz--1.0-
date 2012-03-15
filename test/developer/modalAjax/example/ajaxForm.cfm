<cfsetting showdebugoutput="false">
<form action="example/submit.cfm" method="post" class="ajaxform">
<div style="width: 800px">
		<div style="float: left; width: 400px;">
			<fieldset class="ui-widget ui-widget-content ui-corner-all">
				<legend class="ui-widget ui-widget-header ui-corner-all">Side Labels</legend>
				<div class="ctrlHolder">
					<label for="foo">foo: <em class="required">*</em></label>

					<input type="text" name="foo" value="" class="required">
				</div>
				<div class="ctrlHolder">
					<label for="bar">bar: <em class="required">*</em></label>
					<input type="text" name="bar" value="" >
				</div>
				<div class="ctrlHolder">
					<label for="bart">bart:</label>

					<textarea name="bart"></textarea>
				</div>
			</fieldset>
		</div>
		<div style="float:left; width: 400px;">
			<fieldset class="ui-widget ui-widget-content ui-corner-all">
				<legend class="ui-widget ui-widget-header ui-corner-all">Above Labels</legend>
				<div class="ctrlHolder above">

					<label for="foo2">foo2: <em class="required">*</em></label>
					<input type="text" name="foo2" value="">
				</div>
				<div class="ctrlHolder above">
					<label for="ba2r">bar2:</label>
					<input type="text" name="bar2" value="" >
				</div>

				<div class="ctrlHolder above">
					<label for="bar3">bar3:</label>
					<textarea name="bar3"></textarea>
				</div>

			</fieldset>
		</div>
		<br style="clear:both"/>
		<div align="center" style="padding: 10px; width: 100%">
			<input type="submit">
		</div>
	</div>

</form>