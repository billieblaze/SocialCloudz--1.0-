<Cfset contentTypes = application.content.type.get()>
<FORM ACTION="/index.cfm/util/search" method="get">
	Keyword<br />
	<input type="text" name="search"><br /><br />
	Type<br />
	<select name="searchType">
		<option value="">ALL</option>
		<option value="members">Members</option>
		<Cfoutput query='contentTypes'>
			<option value='#contentType#'>#description#</option>
		</cfoutput>
	</select>
	<br />
<input type="submit" value="search" class="button">
</form>