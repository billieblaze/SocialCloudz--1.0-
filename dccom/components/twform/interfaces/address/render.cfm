<cfset html = html & "<div class=""address"">">
<cfset html = html & "<div><input type=""text"" name=""" & fieldName & "_street"" class=""large""><div class=""info"">Street Address#IIF( ARGUMENTS.fieldInfo.isrequired, DE("<span class=""req"">*</span>"), DE("") )#</div></div>">
<cfset html = html & "<div><input type=""text"" name=""" & fieldName & "_line2"" class=""large""><div class=""info"">Address Line 2</div></div>">
<cfset html = html & "<div class=""half left""><input type=""text"" name=""" & fieldName & "_city"" class=""large""><div class=""info"">City#IIF( ARGUMENTS.fieldInfo.isrequired, DE("<span class=""req"">*</span>"), DE("") )#</div></div>">
<cfset html = html & "<div class=""half right""><input type=""text"" name=""" & fieldName & "_state"" class=""large""><div class=""info"">State / Province / Region#IIF( ARGUMENTS.fieldInfo.isrequired, DE("<span class=""req"">*</span>"), DE("") )#</div></div>">
<cfset html = html & "<div class=""clear half left""><input type=""text"" name=""" & fieldName & "_zip"" class=""large""><div class=""info"">Zip / Post Code</div></div>">
<cfset html = html & "<div class=""half right""><select class=""large"" name=""" & fieldName & "_country"">">


<cfset html = html & "<option value=""""></option>">
<cfset html = html & "<optgroup label=""North America"">">
<cfset html = html & "<option value=""Antigua and Barbuda"">Antigua and Barbuda</option>">
<cfset html = html & "<option value=""Bahamas"">Bahamas</option>">
<cfset html = html & "<option value=""Barbados"">Barbados</option>">
<cfset html = html & "<option value=""Belize"">Belize</option>">
<cfset html = html & "<option value=""Canada"">Canada</option>">
<cfset html = html & "<option value=""Costa Rica"">Costa Rica</option>">
<cfset html = html & "<option value=""Cuba"">Cuba</option>">

<cfset html = html & "<option value=""Dominica"">Dominica</option>">
<cfset html = html & "<option value=""Dominican Republic"">Dominican Republic</option>">
<cfset html = html & "<option value=""El Salvador"">El Salvador</option>">
<cfset html = html & "<option value=""Grenada"">Grenada</option>">
<cfset html = html & "<option value=""Guatemala"">Guatemala</option>">
<cfset html = html & "<option value=""Haiti"">Haiti</option>">
<cfset html = html & "<option value=""Honduras"">Honduras</option>">
<cfset html = html & "<option value=""Jamaica"">Jamaica</option>">
<cfset html = html & "<option value=""Mexico"">Mexico</option>">

<cfset html = html & "<option value=""Nicaragua"">Nicaragua</option>">
<cfset html = html & "<option value=""Panama"">Panama</option>">
<cfset html = html & "<option value=""Saint Kitts and Nevis"">Saint Kitts and Nevis</option>">
<cfset html = html & "<option value=""Saint Lucia"">Saint Lucia</option>">
<cfset html = html & "<option value=""Saint Vincent and the Grenadines"">Saint Vincent and the Grenadines</option>">
<cfset html = html & "<option value=""Trinidad and Tobago"">Trinidad and Tobago</option>">
<cfset html = html & "<option value=""United States"">United States</option>">
<cfset html = html & "</optgroup>">

<cfset html = html & "<optgroup label=""South America"">">

<cfset html = html & "<option value=""Argentina"">Argentina</option>">
<cfset html = html & "<option value=""Bolivia"">Bolivia</option>">
<cfset html = html & "<option value=""Brazil"">Brazil</option>">
<cfset html = html & "<option value=""Chile"">Chile</option>">
<cfset html = html & "<option value=""Columbia"">Columbia</option>">
<cfset html = html & "<option value=""Ecuador"">Ecuador</option>">
<cfset html = html & "<option value=""Guyana"">Guyana</option>">
<cfset html = html & "<option value=""Paraguay"">Paraguay</option>">
<cfset html = html & "<option value=""Peru"">Peru</option>">

<cfset html = html & "<option value=""Suriname"">Suriname</option>">
<cfset html = html & "<option value=""Uruguay"">Uruguay</option>">
<cfset html = html & "<option value=""Venezuela"">Venezuela</option>">
<cfset html = html & "</optgroup>">

<cfset html = html & "<optgroup label=""Europe"">">
<cfset html = html & "<option value=""Albania"">Albania</option>">
<cfset html = html & "<option value=""Andorra"">Andorra</option>">
<cfset html = html & "<option value=""Armenia"">Armenia</option>">
<cfset html = html & "<option value=""Austria"">Austria</option>">

<cfset html = html & "<option value=""Azerbaijan"">Azerbaijan</option>">
<cfset html = html & "<option value=""Belarus"">Belarus</option>">
<cfset html = html & "<option value=""Belgium"">Belgium</option>">
<cfset html = html & "<option value=""Bosnia and Herzegovina"">Bosnia and Herzegovina</option>">
<cfset html = html & "<option value=""Bulgaria"">Bulgaria</option>">
<cfset html = html & "<option value=""Croatia"">Croatia</option>">
<cfset html = html & "<option value=""Cyprus"">Cyprus</option>">
<cfset html = html & "<option value=""Czech Republic"">Czech Republic</option>">
<cfset html = html & "<option value=""Denmark"">Denmark</option>">

<cfset html = html & "<option value=""Estonia"">Estonia</option>">
<cfset html = html & "<option value=""Finland"">Finland</option>">
<cfset html = html & "<option value=""France"">France</option>">
<cfset html = html & "<option value=""Georgia"">Georgia</option>">
<cfset html = html & "<option value=""Germany"">Germany</option>">
<cfset html = html & "<option value=""Greece"">Greece</option>">
<cfset html = html & "<option value=""Hungary"">Hungary</option>">
<cfset html = html & "<option value=""Iceland"">Iceland</option>">
<cfset html = html & "<option value=""Ireland"">Ireland</option>">

<cfset html = html & "<option value=""Italy"">Italy</option>">
<cfset html = html & "<option value=""Latvia"">Latvia</option>">
<cfset html = html & "<option value=""Liechtenstein"">Liechtenstein</option>">
<cfset html = html & "<option value=""Lithuania"">Lithuania</option>">
<cfset html = html & "<option value=""Luxembourg"">Luxembourg</option>">
<cfset html = html & "<option value=""Macedonia"">Macedonia</option>">
<cfset html = html & "<option value=""Malta"">Malta</option>">
<cfset html = html & "<option value=""Moldova"">Moldova</option>">
<cfset html = html & "<option value=""Monaco"">Monaco</option>">

<cfset html = html & "<option value=""Montenegro"">Montenegro</option>">
<cfset html = html & "<option value=""Netherlands"">Netherlands</option>">
<cfset html = html & "<option value=""Norway"">Norway</option>">
<cfset html = html & "<option value=""Poland"">Poland</option>">
<cfset html = html & "<option value=""Portugal"">Portugal</option>">
<cfset html = html & "<option value=""Romania"">Romania</option>">
<cfset html = html & "<option value=""San Marino"">San Marino</option>">
<cfset html = html & "<option value=""Serbia"">Serbia</option>">
<cfset html = html & "<option value=""Slovakia"">Slovakia</option>">

<cfset html = html & "<option value=""Slovenia"">Slovenia</option>">
<cfset html = html & "<option value=""Spain"">Spain</option>">
<cfset html = html & "<option value=""Sweden"">Sweden</option>">
<cfset html = html & "<option value=""Switzerland"">Switzerland</option>">
<cfset html = html & "<option value=""Ukraine"">Ukraine</option>">
<cfset html = html & "<option value=""United Kingdom"">United Kingdom</option>">
<cfset html = html & "<option value=""Vatican City"">Vatican City</option>">
<cfset html = html & "</optgroup>">

<cfset html = html & "<optgroup label=""Asia"">">

<cfset html = html & "<option value=""Afghanistan"">Afghanistan</option>">
<cfset html = html & "<option value=""Bahrain"">Bahrain</option>">
<cfset html = html & "<option value=""Bangladesh"">Bangladesh</option>">
<cfset html = html & "<option value=""Bhutan"">Bhutan</option>">
<cfset html = html & "<option value=""Brunei Darussalam"">Brunei Darussalam</option>">
<cfset html = html & "<option value=""Myanmar"">Myanmar</option>">
<cfset html = html & "<option value=""Cambodia"">Cambodia</option>">
<cfset html = html & "<option value=""China"">China</option>">
<cfset html = html & "<option value=""East Timor"">East Timor</option>">

<cfset html = html & "<option value=""India"">India</option>">
<cfset html = html & "<option value=""Indonesia"">Indonesia</option>">
<cfset html = html & "<option value=""Iran"">Iran</option>">
<cfset html = html & "<option value=""Iraq"">Iraq</option>">
<cfset html = html & "<option value=""Israel"">Israel</option>">
<cfset html = html & "<option value=""Japan"">Japan</option>">
<cfset html = html & "<option value=""Jordan"">Jordan</option>">
<cfset html = html & "<option value=""Kazakhstan"">Kazakhstan</option>">
<cfset html = html & "<option value=""North Korea"">North Korea</option>">

<cfset html = html & "<option value=""South Korea"">South Korea</option>">
<cfset html = html & "<option value=""Kuwait"">Kuwait</option>">
<cfset html = html & "<option value=""Kyrgyzstan"">Kyrgyzstan</option>">
<cfset html = html & "<option value=""Laos"">Laos</option>">
<cfset html = html & "<option value=""Lebanon"">Lebanon</option>">
<cfset html = html & "<option value=""Malaysia"">Malaysia</option>">
<cfset html = html & "<option value=""Maldives"">Maldives</option>">
<cfset html = html & "<option value=""Mongolia"">Mongolia</option>">
<cfset html = html & "<option value=""Nepal"">Nepal</option>">

<cfset html = html & "<option value=""Oman"">Oman</option>">
<cfset html = html & "<option value=""Pakistan"">Pakistan</option>">
<cfset html = html & "<option value=""Philippines"">Philippines</option>">
<cfset html = html & "<option value=""Qatar"">Qatar</option>">
<cfset html = html & "<option value=""Russia"">Russia</option>">
<cfset html = html & "<option value=""Saudi Arabia"">Saudi Arabia</option>">
<cfset html = html & "<option value=""Singapore"">Singapore</option>">
<cfset html = html & "<option value=""Sri Lanka"">Sri Lanka</option>">
<cfset html = html & "<option value=""Syria"">Syria</option>">

<cfset html = html & "<option value=""Taiwan"">Taiwan</option>">
<cfset html = html & "<option value=""Tajikistan"">Tajikistan</option>">
<cfset html = html & "<option value=""Thailand"">Thailand</option>">
<cfset html = html & "<option value=""Turkey"">Turkey</option>">
<cfset html = html & "<option value=""Turkmenistan"">Turkmenistan</option>">
<cfset html = html & "<option value=""United Arab Emirates"">United Arab Emirates</option>">
<cfset html = html & "<option value=""Uzbekistan"">Uzbekistan</option>">
<cfset html = html & "<option value=""Vietnam"">Vietnam</option>">
<cfset html = html & "<option value=""Yemen"">Yemen</option>">

<cfset html = html & "</optgroup>">

<cfset html = html & "<optgroup label=""Oceania"">">
<cfset html = html & "<option value=""Australia"">Australia</option>">
<cfset html = html & "<option value=""Fiji"">Fiji</option>">
<cfset html = html & "<option value=""Kiribati"">Kiribati</option>">
<cfset html = html & "<option value=""Marshall Islands"">Marshall Islands</option>">
<cfset html = html & "<option value=""Micronesia"">Micronesia</option>">
<cfset html = html & "<option value=""Nauru"">Nauru</option>">
<cfset html = html & "<option value=""New Zealand"">New Zealand</option>">

<cfset html = html & "<option value=""Palau"">Palau</option>">
<cfset html = html & "<option value=""Papua New Guinea"">Papua New Guinea</option>">
<cfset html = html & "<option value=""Samoa"">Samoa</option>">
<cfset html = html & "<option value=""Solomon Islands"">Solomon Islands</option>">
<cfset html = html & "<option value=""Tonga"">Tonga</option>">
<cfset html = html & "<option value=""Tuvalu"">Tuvalu</option>"> 
<cfset html = html & "<option value=""Vanuatu"">Vanuatu</option>">
<cfset html = html & "</optgroup>">

<cfset html = html & "<optgroup label=""Africa"">">

<cfset html = html & "<option value=""Algeria"">Algeria</option>">
<cfset html = html & "<option value=""Angola"">Angola</option>">
<cfset html = html & "<option value=""Benin"">Benin</option>">
<cfset html = html & "<option value=""Botswana"">Botswana</option>">
<cfset html = html & "<option value=""Burkina Faso"">Burkina Faso</option>">
<cfset html = html & "<option value=""Burundi"">Burundi</option>">
<cfset html = html & "<option value=""Cameroon"">Cameroon</option>">
<cfset html = html & "<option value=""Cape Verde"">Cape Verde</option>">
<cfset html = html & "<option value=""Central African Republic"">Central African Republic</option>">

<cfset html = html & "<option value=""Chad"">Chad</option>"> 
<cfset html = html & "<option value=""Comoros"">Comoros</option>"> 
<cfset html = html & "<option value=""Congo"">Congo</option>">
<cfset html = html & "<option value=""Djibouti"">Djibouti</option>">
<cfset html = html & "<option value=""Egypt"">Egypt</option>">
<cfset html = html & "<option value=""Equatorial Guinea"">Equatorial Guinea</option>">
<cfset html = html & "<option value=""Eritrea"">Eritrea</option>">
<cfset html = html & "<option value=""Ethiopia"">Ethiopia</option>">
<cfset html = html & "<option value=""Gabon"">Gabon</option>">

<cfset html = html & "<option value=""Gambia"">Gambia</option>">
<cfset html = html & "<option value=""Ghana"">Ghana</option>">
<cfset html = html & "<option value=""Guinea"">Guinea</option>">
<cfset html = html & "<option value=""Guinea-Bissau"">Guinea-Bissau</option>">
<cfset html = html & "<option value=""C&ocirc;te d\'Ivoire"">C&ocirc;te d\'Ivoire</option>">
<cfset html = html & "<option value=""Kenya"">Kenya</option>">
<cfset html = html & "<option value=""Lesotho"">Lesotho</option>">
<cfset html = html & "<option value=""Liberia"">Liberia</option>">

<cfset html = html & "<option value=""Libya"">Libya</option>">
<cfset html = html & "<option value=""Madagascar"">Madagascar</option>">
<cfset html = html & "<option value=""Malawi"">Malawi</option>">
<cfset html = html & "<option value=""Mali"">Mali</option>">
<cfset html = html & "<option value=""Mauritania"">Mauritania</option>">
<cfset html = html & "<option value=""Mauritius"">Mauritius</option>">
<cfset html = html & "<option value=""Morocco"">Morocco</option>">
<cfset html = html & "<option value=""Mozambique"">Mozambique</option>">
<cfset html = html & "<option value=""Namibia"">Namibia</option>">

<cfset html = html & "<option value=""Niger"">Niger</option>">
<cfset html = html & "<option value=""Nigeria"">Nigeria</option>">
<cfset html = html & "<option value=""Rwanda"">Rwanda</option>">
<cfset html = html & "<option value=""Sao Tome and Principe"">Sao Tome and Principe</option>">
<cfset html = html & "<option value=""Senegal"">Senegal</option>">
<cfset html = html & "<option value=""Seychelles"">Seychelles</option>">
<cfset html = html & "<option value=""Sierra Leone"">Sierra Leone</option>">
<cfset html = html & "<option value=""Somalia"">Somalia</option>">
<cfset html = html & "<option value=""South Africa"">South Africa</option>">

<cfset html = html & "<option value=""Sudan"">Sudan</option>">
<cfset html = html & "<option value=""Swaziland"">Swaziland</option>">
<cfset html = html & "<option value=""United Republic of Tanzania"">Tanzania</option>">
<cfset html = html & "<option value=""Togo"">Togo</option>">
<cfset html = html & "<option value=""Tunisia"">Tunisia</option>">
<cfset html = html & "<option value=""Uganda"">Uganda</option>">
<cfset html = html & "<option value=""Zambia"">Zambia</option>">
<cfset html = html & "<option value=""Zimbabwe"">Zimbabwe</option>">

<cfif StructKeyExists( ARGUMENTS.fieldInfo, "defaultcountry" ) AND Len( ARGUMENTS.fieldInfo.defaultcountry )>
	<cfset html = replace( html, "<option value=""#ARGUMENTS.fieldInfo.defaultcountry#"">", "<option value=""#ARGUMENTS.fieldInfo.defaultcountry#"" selected>" )>
</cfif>

<cfset html = html & "</select><div class=""info"">Country#IIF( ARGUMENTS.fieldInfo.isrequired, DE("<span class=""req"">*</span>"), DE("") )#</div></div>">
<cfset html = html & "</div>">
