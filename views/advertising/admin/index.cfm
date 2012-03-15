<cfsetting showdebugoutput="no">
<cfparam name="rc.global" default="0">
<cfscript>
	sizes = event.getvalue('sizes');
	banners = event.getvalue('banners');
    categories = event.getvalue('categories');
</cfscript>
<cfoutput>
<form action="#event.buildLink('advertising.admin.add')#" method="post" name="form1" id="adForm">
	<input type="hidden" name="id" value="0" />
	<input type="hidden" name="communityID" value="#request.community.communityID#" />
	<input type="hidden" name="global" value="#rc.global#" />
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<TR>
           	<TD><B>Placement:</B></TD>
            <TD>
	          	<select name="placement">
                  	<option value="Leaderboard">Leaderboard</option>
                    <option value="Module">Module</option>
           			<option value="Footer">Footer</option>
                </select>
			</td>
		</tr>
		<tr>
			<td><b>Size:</b>&nbsp;</td>
			<td><select name="adsize">
				<cfloop query="sizes">
					<option value="#id#" >#sizes.width#x#sizes.height#</option>
				</cfloop>
				</select> 
			</td>
		</tr>
		<cfif rc.global eq 1>
		<TR>
			<TD valign="top"><B>Category:</B></TD>
		    <TD>
		    <select name="siteCategory" multiple="multiple">
		    <cfloop query="categories">
		    	<option value="#id#">#category#</option>
		    </cfloop>
		    </select>
			</td>
		</tr>
		</cfif>	                
        <tr>
			<td ><b>Code:</b>&nbsp;</td>
			<td><textarea name="code"></textarea></td>
	    </tr>
	</table>
	<div align="center">
	<input type="submit"  value="submit" >
  	</div>
</form>
</cfoutput>
<BR /><BR />

<Table width="100%" cellspacing="0">
<TR bgcolor="gray"><TD><B>Views</B></TD><TD><B>Detail</B></TD><td></td></TR>
<cfoutput query="banners">
<TR class="<cfif banners.currentrow mod 2>even<cfelse>odd</cfif>">

<TD width="50" valign="top" align="center">#views#</TD>
<TD>#placement# :: #width# x #height# <BR />#code#</td>
<td><A href="#event.buildLink(linkTo='advertising.admin.delete',queryString='id=#id#')#" class="ajaxTabLink">Delete</A></TD>
</TR>

</cfoutput>
</Table>
<script>
        // bind 'myForm' and provide a simple callback function 
        $('#adForm').ajaxForm(function(responseText) { 
			$('#adForm').parent().html(responseText);            	        	
	     }); 
</script>