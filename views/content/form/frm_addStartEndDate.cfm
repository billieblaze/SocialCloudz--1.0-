<cfoutput>
<div class="ui-widget">
	<div class="ui-widget-header">Date / Time</div>
    <div class="ui-widget-content" align="center">
	    <div align="left" class="small">
    	Start Date<BR /> #application.form.calendar('startdate', rc.startdate, '100%')#<BR />
		End Date<BR />#application.form.calendar('enddate', rc.enddate, '100%')#
                <br/>
                <input name="repeat" id="repeat_checkbox" type="checkbox"/> Repeats&nbsp;
                <div id="repeat_checkbox_div" style="display: none;">
                    <select id="repeatInterval" name="repeatInterval">
                        <option value="d">Daily</option>
                        <option value="ww">Weekly</option>
                        <option value="m">Monthly</option>
                    </select> <br/>
                    Until<br/>
                  #application.form.calendar('repeatEndDate', '', '100%')#<BR />
                </div>
        </div>
    </div>
</div>   

<script type="text/javascript">
    $(document).ready(function(){
        if ( $('input[name=repeat_checkbox]').attr('checked')){
            $('##repeat_checkbox').hide();
        };
        $('input[name=repeat_checkbox]').attr('checked', false);
        $('##repeat_checkbox').click(function(){
            $('##repeat_checkbox_div').toggle();
        });

        $('##repeatEnddate').datepicker({
            numberOfMonths: 2,
            showButtonPanel: false
        });
    });
    </script>
</cfoutput>