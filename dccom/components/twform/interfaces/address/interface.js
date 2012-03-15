interfaces["address"] = {
	name : 'Address',
	defaults : {
		title: 'Address'
		},
	options : {
		showDefault: 0,
		showFieldSize: 0
		},
	preview : function(o){
		var html = "";
		
		html += "<div><div class=\"fakeInput big\">&nbsp;</div><div class=\"info\">Street Address</div></div>";
		html += "<div><div class=\"fakeInput big\">&nbsp;</div><div class=\"info\">Address Line 2</div></div>";
		html += "<div class=\"half left\"><div class=\"fakeInput large\">&nbsp;</div><div class=\"info\">City</div></div>";
		html += "<div class=\"half right\"><div class=\"fakeInput large\">&nbsp;</div><div class=\"info\">State / Province / Region</div></div>";
		html += "<div class=\"clear half left\"><div class=\"fakeInput large\">&nbsp;</div><div class=\"info\">Zip / Post Code</div></div>";
		html += "<div class=\"half right\"><select class=\"large\"></select><div class=\"info\">Country</div></div>";
		return html;
	},
	extraOptions : function(o){
		var html = '<li class="clear extra" id="listAddressDefault">';
		html += '<label class="desc" for="fieldAddressDefault">Default Country<a href="#" class="help" title="About Default Country" rel="By setting this value, the country field will be prepopulated with the selection you make when a user visits your form.">(?)</a></label>';
		html += '<select class="select medium" id="fieldCountries" onchange="updateProps($F(this), \'defaultcountry\')">';
		html += '<option value=""></option>';
		html += '<optgroup label="North America">';
		html += '<option value="Antigua and Barbuda">Antigua and Barbuda</option>';
		html += '<option value="Bahamas">Bahamas</option>';
		html += '<option value="Barbados">Barbados</option>';
		html += '<option value="Belize">Belize</option>';
		html += '<option value="Canada">Canada</option>';
		html += '<option value="Costa Rica">Costa Rica</option>';
		html += '<option value="Cuba">Cuba</option>';
		
		html += '<option value="Dominica">Dominica</option>';
		html += '<option value="Dominican Republic">Dominican Republic</option>';
		html += '<option value="El Salvador">El Salvador</option>';
		html += '<option value="Grenada">Grenada</option>';
		html += '<option value="Guatemala">Guatemala</option>';
		html += '<option value="Haiti">Haiti</option>';
		html += '<option value="Honduras">Honduras</option>';
		html += '<option value="Jamaica">Jamaica</option>';
		html += '<option value="Mexico">Mexico</option>';
		
		html += '<option value="Nicaragua">Nicaragua</option>';
		html += '<option value="Panama">Panama</option>';
		html += '<option value="Saint Kitts and Nevis">Saint Kitts and Nevis</option>';
		html += '<option value="Saint Lucia">Saint Lucia</option>';
		html += '<option value="Saint Vincent and the Grenadines">Saint Vincent and the Grenadines</option>';
		html += '<option value="Trinidad and Tobago">Trinidad and Tobago</option>';
		html += '<option value="United States">United States</option>';
		html += '</optgroup>';
		
		html += '<optgroup label="South America">';
		
		html += '<option value="Argentina">Argentina</option>';
		html += '<option value="Bolivia">Bolivia</option>';
		html += '<option value="Brazil">Brazil</option>';
		html += '<option value="Chile">Chile</option>';
		html += '<option value="Columbia">Columbia</option>';
		html += '<option value="Ecuador">Ecuador</option>';
		html += '<option value="Guyana">Guyana</option>';
		html += '<option value="Paraguay">Paraguay</option>';
		html += '<option value="Peru">Peru</option>';
		
		html += '<option value="Suriname">Suriname</option>';
		html += '<option value="Uruguay">Uruguay</option>';
		html += '<option value="Venezuela">Venezuela</option>';
		html += '</optgroup>';
		
		html += '<optgroup label="Europe">';
		html += '<option value="Albania">Albania</option>';
		html += '<option value="Andorra">Andorra</option>';
		html += '<option value="Armenia">Armenia</option>';
		html += '<option value="Austria">Austria</option>';
		
		html += '<option value="Azerbaijan">Azerbaijan</option>';
		html += '<option value="Belarus">Belarus</option>';
		html += '<option value="Belgium">Belgium</option>';
		html += '<option value="Bosnia and Herzegovina">Bosnia and Herzegovina</option>';
		html += '<option value="Bulgaria">Bulgaria</option>';
		html += '<option value="Croatia">Croatia</option>';
		html += '<option value="Cyprus">Cyprus</option>';
		html += '<option value="Czech Republic">Czech Republic</option>';
		html += '<option value="Denmark">Denmark</option>';
		
		html += '<option value="Estonia">Estonia</option>';
		html += '<option value="Finland">Finland</option>';
		html += '<option value="France">France</option>';
		html += '<option value="Georgia">Georgia</option>';
		html += '<option value="Germany">Germany</option>';
		html += '<option value="Greece">Greece</option>';
		html += '<option value="Hungary">Hungary</option>';
		html += '<option value="Iceland">Iceland</option>';
		html += '<option value="Ireland">Ireland</option>';
		
		html += '<option value="Italy">Italy</option>';
		html += '<option value="Latvia">Latvia</option>';
		html += '<option value="Liechtenstein">Liechtenstein</option>';
		html += '<option value="Lithuania">Lithuania</option>';
		html += '<option value="Luxembourg">Luxembourg</option>';
		html += '<option value="Macedonia">Macedonia</option>';
		html += '<option value="Malta">Malta</option>';
		html += '<option value="Moldova">Moldova</option>';
		html += '<option value="Monaco">Monaco</option>';
		
		html += '<option value="Montenegro">Montenegro</option>';
		html += '<option value="Netherlands">Netherlands</option>';
		html += '<option value="Norway">Norway</option>';
		html += '<option value="Poland">Poland</option>';
		html += '<option value="Portugal">Portugal</option>';
		html += '<option value="Romania">Romania</option>';
		html += '<option value="San Marino">San Marino</option>';
		html += '<option value="Serbia">Serbia</option>';
		html += '<option value="Slovakia">Slovakia</option>';
		
		html += '<option value="Slovenia">Slovenia</option>';
		html += '<option value="Spain">Spain</option>';
		html += '<option value="Sweden">Sweden</option>';
		html += '<option value="Switzerland">Switzerland</option>';
		html += '<option value="Ukraine">Ukraine</option>';
		html += '<option value="United Kingdom">United Kingdom</option>';
		html += '<option value="Vatican City">Vatican City</option>';
		html += '</optgroup>';
		
		html += '<optgroup label="Asia">';
		
		html += '<option value="Afghanistan">Afghanistan</option>';
		html += '<option value="Bahrain">Bahrain</option>';
		html += '<option value="Bangladesh">Bangladesh</option>';
		html += '<option value="Bhutan">Bhutan</option>';
		html += '<option value="Brunei Darussalam">Brunei Darussalam</option>';
		html += '<option value="Myanmar">Myanmar</option>';
		html += '<option value="Cambodia">Cambodia</option>';
		html += '<option value="China">China</option>';
		html += '<option value="East Timor">East Timor</option>';
		
		html += '<option value="India">India</option>';
		html += '<option value="Indonesia">Indonesia</option>';
		html += '<option value="Iran">Iran</option>';
		html += '<option value="Iraq">Iraq</option>';
		html += '<option value="Israel">Israel</option>';
		html += '<option value="Japan">Japan</option>';
		html += '<option value="Jordan">Jordan</option>';
		html += '<option value="Kazakhstan">Kazakhstan</option>';
		html += '<option value="North Korea">North Korea</option>';
		
		html += '<option value="South Korea">South Korea</option>';
		html += '<option value="Kuwait">Kuwait</option>';
		html += '<option value="Kyrgyzstan">Kyrgyzstan</option>';
		html += '<option value="Laos">Laos</option>';
		html += '<option value="Lebanon">Lebanon</option>';
		html += '<option value="Malaysia">Malaysia</option>';
		html += '<option value="Maldives">Maldives</option>';
		html += '<option value="Mongolia">Mongolia</option>';
		html += '<option value="Nepal">Nepal</option>';
		
		html += '<option value="Oman">Oman</option>';
		html += '<option value="Pakistan">Pakistan</option>';
		html += '<option value="Philippines">Philippines</option>';
		html += '<option value="Qatar">Qatar</option>';
		html += '<option value="Russia">Russia</option>';
		html += '<option value="Saudi Arabia">Saudi Arabia</option>';
		html += '<option value="Singapore">Singapore</option>';
		html += '<option value="Sri Lanka">Sri Lanka</option>';
		html += '<option value="Syria">Syria</option>';
		
		html += '<option value="Taiwan">Taiwan</option>';
		html += '<option value="Tajikistan">Tajikistan</option>';
		html += '<option value="Thailand">Thailand</option>';
		html += '<option value="Turkey">Turkey</option>';
		html += '<option value="Turkmenistan">Turkmenistan</option>';
		html += '<option value="United Arab Emirates">United Arab Emirates</option>';
		html += '<option value="Uzbekistan">Uzbekistan</option>';
		html += '<option value="Vietnam">Vietnam</option>';
		html += '<option value="Yemen">Yemen</option>';
		
		html += '</optgroup>';
		
		html += '<optgroup label="Oceania">';
		html += '<option value="Australia">Australia</option>';
		html += '<option value="Fiji">Fiji</option>';
		html += '<option value="Kiribati">Kiribati</option>';
		html += '<option value="Marshall Islands">Marshall Islands</option>';
		html += '<option value="Micronesia">Micronesia</option>';
		html += '<option value="Nauru">Nauru</option>';
		html += '<option value="New Zealand">New Zealand</option>';
		
		html += '<option value="Palau">Palau</option>';
		html += '<option value="Papua New Guinea">Papua New Guinea</option>';
		html += '<option value="Samoa">Samoa</option>';
		html += '<option value="Solomon Islands">Solomon Islands</option>';
		html += '<option value="Tonga">Tonga</option>';
		html += '<option value="Tuvalu">Tuvalu</option>'; 
		html += '<option value="Vanuatu">Vanuatu</option>';
		html += '</optgroup>';
		
		html += '<optgroup label="Africa">';
		
		html += '<option value="Algeria">Algeria</option>';
		html += '<option value="Angola">Angola</option>';
		html += '<option value="Benin">Benin</option>';
		html += '<option value="Botswana">Botswana</option>';
		html += '<option value="Burkina Faso">Burkina Faso</option>';
		html += '<option value="Burundi">Burundi</option>';
		html += '<option value="Cameroon">Cameroon</option>';
		html += '<option value="Cape Verde">Cape Verde</option>';
		html += '<option value="Central African Republic">Central African Republic</option>';
		
		html += '<option value="Chad">Chad</option>'; 
		html += '<option value="Comoros">Comoros</option>'; 
		html += '<option value="Congo">Congo</option>';
		html += '<option value="Djibouti">Djibouti</option>';
		html += '<option value="Egypt">Egypt</option>';
		html += '<option value="Equatorial Guinea">Equatorial Guinea</option>';
		html += '<option value="Eritrea">Eritrea</option>';
		html += '<option value="Ethiopia">Ethiopia</option>';
		html += '<option value="Gabon">Gabon</option>';
		
		html += '<option value="Gambia">Gambia</option>';
		html += '<option value="Ghana">Ghana</option>';
		html += '<option value="Guinea">Guinea</option>';
		html += '<option value="Guinea-Bissau">Guinea-Bissau</option>';
		html += '<option value="C&ocirc;te d\'Ivoire">C&ocirc;te d\'Ivoire</option>';
		html += '<option value="Kenya">Kenya</option>';
		html += '<option value="Lesotho">Lesotho</option>';
		html += '<option value="Liberia">Liberia</option>';
		
		html += '<option value="Libya">Libya</option>';
		html += '<option value="Madagascar">Madagascar</option>';
		html += '<option value="Malawi">Malawi</option>';
		html += '<option value="Mali">Mali</option>';
		html += '<option value="Mauritania">Mauritania</option>';
		html += '<option value="Mauritius">Mauritius</option>';
		html += '<option value="Morocco">Morocco</option>';
		html += '<option value="Mozambique">Mozambique</option>';
		html += '<option value="Namibia">Namibia</option>';
		
		html += '<option value="Niger">Niger</option>';
		html += '<option value="Nigeria">Nigeria</option>';
		html += '<option value="Rwanda">Rwanda</option>';
		html += '<option value="Sao Tome and Principe">Sao Tome and Principe</option>';
		html += '<option value="Senegal">Senegal</option>';
		html += '<option value="Seychelles">Seychelles</option>';
		html += '<option value="Sierra Leone">Sierra Leone</option>';
		html += '<option value="Somalia">Somalia</option>';
		html += '<option value="South Africa">South Africa</option>';
		
		html += '<option value="Sudan">Sudan</option>';
		html += '<option value="Swaziland">Swaziland</option>';
		html += '<option value="United Republic of Tanzania">Tanzania</option>';
		html += '<option value="Togo">Togo</option>';
		html += '<option value="Tunisia">Tunisia</option>';
		html += '<option value="Uganda">Uganda</option>';
		html += '<option value="Zambia">Zambia</option>';
		html += '<option value="Zimbabwe">Zimbabwe</option>';
		html += '</optgroup>';
		
		html += '</select>';
		html += '</li>';

		new Insertion.After( $("listType"), html );
		
		$("fieldCountries").value = o.defaultcountry;
	}
}
