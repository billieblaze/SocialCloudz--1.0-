<cfoutput>
	<div id="infobox">
		<p>
			You are now running 
			<strong>
				#getSetting( "codename", 1 )# 
				#getSetting( "version", 1 )# 
				(
				#getsetting( "suffix", 1 )#
				)
			</strong>
			.
			Welcome to the next generation of ColdFusion applications. You can now start building your application with ease, we already did the hard work
			for you.
		</p>
	</div>
	
	<h3>
		Registered Event Handlers
	</h3>
	<p>
		You can click on the following event handlers to execute their default action.
	</p>
	<ul>
		<cfloop list="#getSetting("RegisteredHandlers")#" index="handler">
			<li>
				<a href="#event.buildLink(handler)#">
					#handler#
				</a>
			</li>
		</cfloop>
	</ul>
	
	<h3>
		Registered Modules
	</h3>
	<p>
		You can click on the following modules to visit them (If they have an entry point defined)
	</p>
	<ul>
		<cfloop collection="#getSetting("Modules")#" item="thisModule">
			<li>
				<a href="#event.buildLink(getModuleSettings(thisModule).entryPoint)#">
					#thisModule#
				</a>
			</li>
		</cfloop>
	</ul>
	
	<h4>
		ColdBox URL Actions
	</h4>
	<p>
		ColdBox can use some very important URL actions to interact with your application. You can try them out below:
	</p>
	<ol>
		<li>
			<a href="index.cfm?fwreinit=true">
				Reinitialize the framework
			</a>
			(fwreinit=1)
		</li>
		<li>
			<a href="index.cfm?debugmode=false">
				Remove Debug Mode
			</a>
			(debugmode=false)
		</li>
		<li>
			<a href="index.cfm?debugmode=true">
				Enable Debug Mode
			</a>
			(debugmode=true)
		</li>
	</ol>
	<sub>
		* 
		<a href="http://wiki.coldbox.org/wiki/URLActions.cfm">
			URL Actions Guide
		</a>
	</sub>
	<h4>
		Customizing your Application
	</h4>
	<p>
		You can now start editing your application and building great ColdBox enabled apps. Important files & locations:
	</p>
	<ol>
		<li>
			<b>
				/config/coldbox.xml.cfm
			</b>
			: Your application configuration file
		</li>
		<li>
			<b>
				/config/environments.xml.cfm
			</b>
			: Your per-tier settings
		</li>
		<li>
			<b>
				/config/routes.cfm
			</b>
			: Your SES routing table
		</li>
		<li>
			<b>
				/handlers
			</b>
			: Your Application controllers
		</li>
		<li>
			<b>
				/includes
			</b>
			: Assets, Helpers, i18n, templates and more.
		</li>
		<li>
			<b>
				/includes/helpers
			</b>
			: Place all your application and specific helpers here
		</li>
		<li>
			<b>
				/layouts
			</b>
			: Where you place all your application layouts
		</li>
		<li>
			<b>
				/logs
			</b>
			: The ColdBox Logs directory
		</li>
		<li>
			<b>
				/model
			</b>
			: The meat of your app, your business logic objects
		</li>
		<li>
			<b>
				/plugins
			</b>
			: Where you place custom plugins built by you!
		</li>
		<li>
			<b>
				/test
			</b>
			: Your unit testing folder (Just DO IT!!)
		</li>
		<li>
			<b>
				/views
			</b>
			: Where you create all your views and viewlets
		</li>
	</ol>
	<h1>ORM Examples</h1>
	Using injected ORM objects 
	<cfscript>
		rc.author.setFirstName('b');
		rc.author.setLastName('blaze');
		rc.book.setID('1');
		rc.book.setTitle('title');
		rc.book.setAuthor(rc.author);
	</cfscript>
	Book Title - 
	#rc.book.getTitle()# - #rc.book.getID()#<br><br> 
	Author - 
	#rc.book.getAuthor().getFirstName()# #rc.book.getAuthor().getLastName()#<bR><br>
	Author via Custom Bean function - #rc.book.getAuthor().getName()#
	
	<!--- todo: checkout ORM entity service! --->
	
	<h1>Using i18n</h1>
	<cfset rc.localeUtils = getPlugin('i18n')>
	<strong>Locale:</strong> <br />#rc.localeUtils.getfwLocale()#<br />
<strong>Language:</strong> <br />#rc.localeUtils.showLanguage()#<br />
<strong>Country:</strong> <br />#rc.localeUtils.showCountry()#<br />
<strong>TimeZone:</strong> <br />#rc.localeUtils.getServerTZ()#<br />
<strong>i18nDateFormat:</strong> <br />#rc.localeUtils.i18nDateFormat(rc.localeUtils.toEpoch(now()),1)#<br />
<strong>i18nTimeFormat:</strong> <br />#rc.localeUtils.i18nTimeFormat(rc.localeUtils.toEpoch(now()),2)#<br />
<hr>
<strong>I18NUtilVersion:</strong> <br />#rc.localeUtils.getVersion().I18NUtilVersion#<br>
<strong>I18NUtilDate:</strong> <br />#rc.localeUtils.dateLocaleFormat(rc.localeUtils.getVersion().I18NUtilDate)#<br>
<strong>Java version:</strong> <br />#rc.localeUtils.getVersion().javaVersion#<br>
	<h3>Example of using an i18n message</h3>
	<cfset oRB = getPlugin("resourceBundle")>
<cfset orderDetails = ArrayNew(1)>
<cfset orderDetails[1] = "Luis Majano">
<cfset orderDetails[2] = "1-800-555-5555">

<cfoutput>#oRB.formatRBString(getResource('confirmMessage'),orderDetails)#</cfoutput>

<h1>Gravatar Module</h1>
	#getMyPlugin('Avatar').renderAvatar('bblaze@email.unc.edu',100)#
	

<h1>Solitary Security</h1>
<a href="index.cfm/Solitary">Check it out</a>

<h1>Freshbooks API Wrapper</h1>
<cfscript>
   var freshbooks = getMyPlugin("freshbooks",true).init();
   freshbooks.setAPIURL("https://socialcloudz.freshbooks.com/api/2.1/xml-in");
   freshbooks.setAPIToken("85fc00aa942fdf914c1cd5efff3a5125");
   queryResults = freshbooks.clientList(returnFormat='query',returnFields="first_name,last_name,organization,client_id");
</cfscript>
<cfdump var='#queryResults#'>

<h1> QR Code Plugin</h1>
<cfdump var='#getMyPlugin('QRCodeGenerator').getQRCodeImage('foobar')#'>




</cfoutput>

<h1>
	Foundation CSS Examples
</h1>
<style type="text/css">
	.row.display {
	    background: #f4f4f4;
	    margin-bottom: 10px;
	    border-radius: 3px;
	    -webkit-border-radius: 3px;
	    -moz-border-radius: 3px;
	}
	.row.display .column, .row.display .columns {
	    background: #e7e7e7;
	    font-size: 11px;
	    text-indent: 3px;
	    padding-top: 6px;
	    padding-bottom: 6px;
	    border-radius: 3px;
	    -webkit-border-radius: 3px;
	    -moz-border-radius: 3px;
	}
	.block-grid li {
	    background: none repeat scroll 0 0 #DDDDDD;
	    padding: 10px 0;
	}
	#orbitDemo .content h1 {
	    font-family: 'Helvetica', 'Arial', serif;
	    color: #2f260f;
	    font-weight: bold !important;
	    text-transform: uppercase;
	    text-shadow: 1px 1px 0 #f8f0d1, 2px 2px 0 #f8f0d1, 3px 3px 0 #1a5774;
	    text-align: center;
	    margin-top: 15%;
	}
	#orbitDemo .content h3 {
	    font-family: 'Helvetica', 'Arial', serif;
	    color: #7f6b37;
	    font-weight: bold !important;
	    text-align: center;
	}
	#orbitDemo {
	    background: url(images/spinner.gif) no-repeat center center #000;
	    height: 305px;
	    margin-bottom: 20px;
	}
	#orbitDemo.orbit {
	    height: auto;
	}
	#orbitDemo img, #orbitDemo div {
	    display: none;
	}
	#orbitDemo.orbit img, #orbitDemo.orbit div {
	    display: block;
	}
	@media handheld, only screen
	and (max-width: 767px) {
		#orbitDemo { height: 165px; }
		#orbitDemo.orbit { height: auto; }
		dl.nice.tabs.mobile { margin-bottom: 0px; }
		.nice.tabs.mobile dd a { padding: 12px 20px; }
		
		div.foundation-header h1 { font-size: 32px; font-size: 3.2rem; }
		
		div.slider-nav span { height: 50px; width: 39px; background-size: 100% auto; margin-top: -25px; }
	}
</style>
<div class="row">
	<div class="twelve columns">
		<h2>
			Welcome to Foundation
		</h2>
		<p>
			This is version 2.2 released on February 21, 2012
		</p>
		<hr/>
	</div>
</div>

<div class="row">
	<div class="eight columns">
		<h3>
			The Grid
		</h3>
		
		<!-- Grid Example -->
		<div class="row">
			<div class="twelve columns">
				<div class="panel">
					<p>
						This is a twelve column section in a row. Each of these includes a div.panel element so you can see where the columns are - it's not required at all for the grid.
					</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="six columns">
				<div class="panel">
					<p>
						Six columns
					</p>
				</div>
			</div>
			<div class="six columns">
				<div class="panel">
					<p>
						Six columns
					</p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="four columns">
				<div class="panel">
					<p>
						Four columns
					</p>
				</div>
			</div>
			<div class="four columns">
				<div class="panel">
					<p>
						Four columns
					</p>
				</div>
			</div>
			<div class="four columns">
				<div class="panel">
					<p>
						Four columns
					</p>
				</div>
			</div>
		</div>
		
		<h3>
			Tabs
		</h3>
		<dl class="tabs">
			<dd>
				<a href="#simple1" class="active">Simple Tab 1</a>
			</dd>
			<dd>
				<a href="#simple2">Simple Tab 2</a>
			</dd>
			<dd>
				<a href="#simple3">Simple Tab 3</a>
			</dd>
		</dl>
		
		<ul class="tabs-content">
			<li class="active" id="simple1Tab">
				This is simple tab 1's content. Pretty neat, huh?
			</li>
			<li id="simple2Tab">
				This is simple tab 2's content. Now you see it!
			</li>
			<li id="simple3Tab">
				This is simple tab 3's content. It's, you know...okay.
			</li>
		</ul>
		
		<h3>
			Buttons
		</h3>
		
		<div class="row">
			<div class="six columns">
				<p>
					<a href="#" class="small blue button">Small Blue Button</a>
				</p>
				<p>
					<a href="#" class="blue button">Medium Blue Button</a>
				</p>
				<p>
					<a href="#" class="large blue button">Large Blue Button</a>
				</p>
				
				<p>
					<a href="#" class="nice radius small blue button">Nice Blue Button</a>
				</p>
				<p>
					<a href="#" class="nice radius blue button">Nice Blue Button</a>
				</p>
				<p>
					<a href="#" class="nice radius large blue button">Nice Blue Button</a>
				</p>
			</div>
			<div class="six columns">
				<p>
					<a href="#" class="small red button">Small Red Button</a>
				</p>
				<p>
					<a href="#" class="green button">Medium Green Button</a>
				</p>
				<p>
					<a href="#" class="large white button">Large White Button</a>
				</p>
				
				<p>
					<a href="#" class="nice radius small red button">Nice Red Button</a>
				</p>
				<p>
					<a href="#" class="nice radius green button">Nice Green Button</a>
				</p>
				<p>
					<a href="#" class="nice radius large white button">Nice White Button</a>
				</p>
			</div>
		</div>
	</div>
	
	<div class="four columns">
		<h4>
			Getting Started
		</h4>
		<p>
			We're stoked you want to try Foundation! To get going, this file (index.html) includes some basic styles you can modify, play around with, or totally destroy to get going.
		</p>
		
		<h4>
			Other Resources
		</h4>
		<p>
			Once you've exhausted the fun in this document, you should check out:
		</p>
		<ul class="disc">
			<li>
				<a href="http://foundation.zurb.com/docs">
					Foundation Documentation
				</a>
				<br/>
				Everything you need to know about using the framework.
			</li>
			<li>
				<a href="http://github.com/zurb/foundation">
					Foundation on Github
				</a>
				<br/>
				Latest code, issue reports, feature requests and more.
			</li>
			<li>
				<a href="http://twitter.com/foundationzurb">
					@foundationzurb
				</a>
				<br/>
				Ping us on Twitter if you have questions. If you build something with this we'd love to see it (and send you a totally boss sticker).
			</li>
		</ul>
	</div>
</div>
<p>
	Below you can see how the rows and columns come together. All columns are inside a row and for this we've colored the rows and columns for visibility. You can also see how nesting 
	works - this example is inside an eight column container, but below we have all 12 columns to use. You can nest them down quite a ways before the percentage widths become absurdly 
	small.
</p>

<div class="row display">
	<div class="four columns">
		.four.columns
	</div>
	<div class="four columns">
		.four.columns
	</div>
	<div class="four columns">
		.four.columns
	</div>
</div>
<div class="row display">
	<div class="three columns">
		.three.columns
	</div>
	<div class="six columns">
		.six.columns
	</div>
	<div class="three columns">
		.three.columns
	</div>
</div>
<div class="row display">
	<div class="two columns">
		.two.columns
	</div>
	<div class="eight columns">
		.eight.columns
	</div>
	<div class="two columns">
		.two.columns
	</div>
</div>
<div class="row display">
	<div class="one columns">
		.one
	</div>
	<div class="eleven columns">
		.eleven.columns
	</div>
</div>
<div class="row display">
	<div class="two columns">
		.two.columns
	</div>
	<div class="ten columns">
		.ten.columns
	</div>
</div>
<div class="row display">
	<div class="three columns">
		.three.columns
	</div>
	<div class="nine columns">
		.nine.columns
	</div>
</div>
<div class="row display">
	<div class="four columns">
		.four.columns
	</div>
	<div class="eight columns">
		.eight.columns
	</div>
</div>
<div class="row display">
	<div class="five columns">
		.five
	</div>
	<div class="seven columns">
		.seven.columns
	</div>
</div>
<div class="row display">
	<div class="six columns">
		.six.columns
	</div>
	<div class="six columns">
		.six.columns
	</div>
</div>
<div class="row display">
	<div class="seven columns">
		.seven.columns
	</div>
	<div class="five columns">
		.five.columns
	</div>
</div>
<div class="row display">
	<div class="eight columns">
		.eight.columns
	</div>
	<div class="four columns">
		.four.columns
	</div>
</div>
<div class="row display">
	<div class="nine columns">
		.nine.columns
	</div>
	<div class="three columns">
		.three.columns
	</div>
</div>
<div class="row display">
	<div class="ten columns">
		.ten.columns
	</div>
	<div class="two columns">
		.two.columns
	</div>
</div>
<div class="row display">
	<div class="eleven columns">
		.eleven.columns
	</div>
	<div class="one columns">
		.one
	</div>
</div>
<div class="row display">
	<div class="twelve columns">
		.twelve.columns
	</div>
</div>

<hr/>
<h4>
	Offsets
</h4>
<p>
	Offsets allow you to create additional space between columns in a row. The offsets run from offset-by-one all the way up to offset-by-eleven. Like the rest of the grid they're 
	nestable.
</p>

<div class="row display">
	<div class="one columns">
		.one
	</div>
	<div class="eleven columns">
		.eleven.columns
	</div>
</div>
<div class="row display">
	<div class="one columns">
		.one
	</div>
	<div class="ten columns offset-by-one">
		.ten.columns.offset-by-one
	</div>
</div>
<div class="row display">
	<div class="one columns">
		.one
	</div>
	<div class="nine columns offset-by-two">
		.nine.columns.offset-by-two
	</div>
</div>
<div class="row display">
	<div class="one columns">
		.one
	</div>
	<div class="eight columns offset-by-three">
		.eight.columns.offset-by-three
	</div>
</div>
<div class="row display">
	<div class="seven columns offset-by-five">
		.seven.columns.offset-by-five
	</div>
</div>
<div class="row display">
	<div class="six columns offset-by-six">
		.six.columns.offset-by-six
	</div>
</div>
<div class="row display">
	<div class="five columns offset-by-seven">
		.five.columns.offset-by-six
	</div>
</div>
<div class="row display">
	<div class="four columns offset-by-eight">
		.four.columns.offset-by-eight
	</div>
</div>

<hr/>
<h4>
	Centered Columns
</h4>
<p>
	Centered columns are placed in the middle of the row. This does not center their content, but centers the grid element itself. This is a convenient way to make sure a block is 
	centered, even if you change the number of columns it contains. Note: for this to work, there cannot be any other column blocks in the row.
</p>

<div class="row display">
	<div class="one columns centered">
		.one.columns.centered
	</div>
</div>
<div class="row display">
	<div class="two columns centered">
		.two.columns.centered
	</div>
</div>
<div class="row display">
	<div class="three columns centered">
		.three.columns.centered
	</div>
</div>
<div class="row display">
	<div class="four columns centered">
		.four.columns.centered
	</div>
</div>
<div class="row display">
	<div class="five columns centered">
		.five.columns.centered
	</div>
</div>
<div class="row display">
	<div class="six columns centered">
		.six.columns.centered
	</div>
</div>
<div class="row display">
	<div class="seven columns centered">
		.seven.columns.centered
	</div>
</div>
<div class="row display">
	<div class="eight columns centered">
		.eight.columns.centered
	</div>
</div>
<div class="row display">
	<div class="nine columns centered">
		.nine.columns.centered
	</div>
</div>
<div class="row display">
	<div class="ten columns centered">
		.ten.columns.centered
	</div>
</div>
<div class="row display">
	<div class="eleven columns centered">
		.eleven.columns.centered
	</div>
</div>
<div class="row display">
	<div class="twelve columns centered">
		.twelve.columns.centered
	</div>
</div>

<hr/>

<h4>
	Source Ordering
</h4>
<p>
	Sometimes within the grid you want the order of your markup to not necessarily be the same as the order items are flowed into the grid. Using these source ordering classes you can 
	shift columns around on desktops and tablets. On phones the grid will still be linearized into the order of the markup.
</p>

<div class="row display">
	<div class="two columns push-ten">
		.two.columns
	</div>
	<div class="ten columns pull-two">
		.ten.columns (last)
	</div>
</div>
<div class="row display">
	<div class="three columns push-nine">
		.three.columns
	</div>
	<div class="nine columns pull-three">
		.nine.columns (last)
	</div>
</div>
<div class="row display">
	<div class="four columns push-eight">
		.four.columns
	</div>
	<div class="eight columns pull-four">
		.eight.columns (last)
	</div>
</div>
<div class="row display">
	<div class="five columns push-seven">
		.five
	</div>
	<div class="seven columns pull-five">
		.seven.columns (last)
	</div>
</div>
<div class="row display">
	<div class="six columns push-six">
		.six.columns
	</div>
	<div class="six columns pull-six">
		.six.columns (last)
	</div>
</div>
<div class="row display">
	<div class="seven columns push-five">
		.seven.columns
	</div>
	<div class="five columns pull-seven">
		.five.columns (last)
	</div>
</div>
<div class="row display">
	<div class="eight columns push-four">
		.eight.columns
	</div>
	<div class="four columns pull-eight">
		.four.columns (last)
	</div>
</div>
<div class="row display">
	<div class="nine columns push-three">
		.nine.columns
	</div>
	<div class="three columns pull-nine">
		.three.columns (last)
	</div>
</div>
<div class="row display">
	<div class="ten columns push-two">
		.ten.columns
	</div>
	<div class="two columns pull-ten">
		.two (last)
	</div>
</div>

<hr/>

<h4>
	Mobile Grid
</h4>
<p>
	The grid has two modes of adapting for small displays like phones. The first requires no work at all &mdash; the grid will linearize on a small device so your columns stack 
	vertically. This is useful to quickly adapt a desktop layout to a simple scrolling mobile layout. The other option is to use some simple classes to implement a four-column phone 
	grid.
</p>

<h5>
	Four Column Mobile Grid
</h5>
<p>
	When you're creating your layout you can optionally attach classes that take your existing grid elements and attach them to a four column phone grid.
</p>

<div class="row display">
	<div class="three phone-one columns">
		.three.phone-one.columns
	</div>
	<div class="nine phone-three columns">
		.nine.phone-three.columns
	</div>
</div>
<div class="row display">
	<div class="six phone-two columns">
		.six.phone-two.columns
	</div>
	<div class="six phone-two columns">
		.six.phone-two.columns
	</div>
</div>
<div class="row display">
	<div class="nine phone-three columns">
		.nine.phone-three.columns
	</div>
	<div class="three phone-one columns">
		.three.phone-one.columns
	</div>
</div>

<h4>
	Forms
</h4>
<form>
	<p>
		Inputs support a number of different base classes. Any text input has a class of 'input-text' and supports several sizes:
	</p>
	<label for="standardInput">
		Standard Input
	</label>
	<input type="text" class="input-text" id="standardInput"/>
	
	<label for="smallInput">
		Small Input
	</label>
	<input type="text" class="small input-text" id="smallInput"/>
	
	<label for="mediumInput">
		Medium Input
	</label>
	<input type="text" class="medium input-text" id="mediumInput"/>
	
	<label for="largeInput">
		Large Input
	</label>
	<input type="text" class="large input-text" id="largeInput"/>
	
	<label for="expandedInput">
		Expanded (Full Width) Input
	</label>
	<input type="text" class="expand input-text" id="expandedInput"/>
	
	<label for="oversizeInput">
		Oversize Input
	</label>
	<input type="text" class="oversize input-text" id="oversizeInput"/>
	
	<h5>
		Inline Labels
	</h5>
	<p>
		Inline labels are accomplished using the HTML5 Placeholder attribute, with a built-in JS fallback.
	</p>
	<input type="text" class="input-text" placeholder="Inline label"/>
	
	<h5>
		Error States
	</h5>
	<p>
		Error states can be applied in two ways:
	</p>
	<ul class="disc">
		<li>
			Using a wrapper for div.form-field.error, which will apply styles to text inputs, labels, and a small.error message (optional). This is ideal for programmatically generated 
			forms.
		</li>
		<li>
			You can also apply the .red class to labels, inputs, and also append a small.error.
		</li>
	</ul>
	
	<div class='form-field error'>
		<label for="mediumInputWrapper">
			Medium Input (with wrapper)
		</label>
		<input type="text" class="medium input-text" id="mediumInputWrapper"/>
		<small>
			Whoa, cowboy. Try that again.
		</small>
	</div>
	
	<label class="red" for="errorInput">
		Medium Input
	</label>
	<input type="text" class="medium input-text red" id="errorInput"/>
	<small class="error">
		Whoa, cowboy. Try that again.
	</small>
	
	<label for="standardTextarea">
		Textarea
	</label>
	<textarea id="standardTexted">
		This is a textarea
	</textarea>
	
	<label for="inlineTextarea">
		Inline Label Textarea
	</label>
	<textarea placeholder="This is a text area" id="inlineTextarea">
	</textarea>
	
	<label for="checkbox1">
		<input type="checkbox" id="checkbox1">
		Label for Checkbox
	</label>
	
	<label for="radio1">
		<input type="radio" id="radio1">
		Label for Radio
	</label>
	
	<label for="standardDropdown">
		Dropdown Label
	</label>
	<select id="standardDropdown">
		<option>
			This is a dropdown
		</option>
		<option>
			This is another option
		</option>
		<option>
			Look, a third option
		</option>
	</select>
	
	<div class="row">
		<div class="seven columns">
			<fieldset>
				<h5>
					Fieldset Header H2
				</h5>
				<p>
					This is a paragraph within a fieldset.
				</p>
				
				<label for="fieldsetInput">
					Standard Input
				</label>
				<input type="text" class="input-text" id="fieldsetInput"/>
			</fieldset>
		</div>
	</div>
</form>

<hr/>

<h4>
	Nice Forms
</h4>
<form class="nice">
	<p>
		Changing the form style to a slightly fancier version is dead simple - just add a class of 'nice' to the form itself.
	</p>
	
	<label for="standardNiceInput">
		Standard Input
	</label>
	<input type="text" class="input-text" id="standardNiceInput"/>
	
	<input type="text" placeholder="Inline label" class="input-text"/>
	
	<label for="smallNiceInput">
		Small Input
	</label>
	<input type="text" class="small input-text" id="smallNiceInput"/>
	
	<div class='form-field error'>
		<label for="mediumNiceInput">
			Medium Input (with wrapper)
		</label>
		<input type="text" class="medium input-text" id="mediumNiceInput"/>
		<small>
			Whoa, cowboy. Try that again.
		</small>
	</div>
	
	<label class="red" for="errorNiceInput">
		Medium Input
	</label>
	<input type="text" class="medium red input-text" id="errorNiceInput"/>
	<small class="error">
		Whoa, cowboy. Try that again.
	</small>
	
	<label for="largeNiceInput">
		Large Input
	</label>
	<input type="text" class="large input-text" id="largeNiceInput"/>
	
	<label for="expandedNiceInput">
		Expanded (Full Width) Input
	</label>
	<input type="text" class="expand input-text" id="expandedNiceInput"/>
	
	<label for="oversizeNiceInput">
		Oversize Input
	</label>
	<input type="text" class="oversize input-text" id="oversizeNiceInput"/>
	
	<label for="niceTextarea">
		Textarea
	</label>
	<textarea id="niceTextarea">
		This is a textarea
	</textarea>
	
	<label for="inlineNiceTextarea">
		Inline Label Textarea
	</label>
	<textarea placeholder="This is a text area" id="inlineNiceTextarea">
	</textarea>
	
	<label for="checkbox1">
		<input type="checkbox" id="checkbox1">
		Label for Checkbox
	</label>
	
	<label for="radio1">
		<input type="radio" id="radio1">
		Label for Radio
	</label>
	
	<label for="niceDropdown">
		Dropdown Label
	</label>
	<select id="niceDropdown">
		<option>
			This is a dropdown
		</option>
		<option>
			This is another option
		</option>
		<option>
			Look, a third option
		</option>
	</select>
	
	<div class="row">
		<div class="seven columns">
			<fieldset>
				<h5>
					Fieldset Header H2
				</h5>
				<p>
					This is a paragraph within a fieldset.
				</p>
				
				<label for="niceFieldsetInput">
					Standard Input
				</label>
				<input type="text" class="input-text" id="niceFieldssetInput"/>
			</fieldset>
		</div>
	</div>
</form>

<hr/>

<h3>
	Custom Forms
</h3>

<form class="custom">
	<p>
		Creating easy to style custom form elements is so crazy easy, it's practically a crime. Just add a class of 'custom' to a form and, if you want, forms.jquery.js will do 
		everything for you.
	</p>
	<p>
		The Foundation forms js will look for any checkbox, radio button, or select element and replace it with custom markup that is already styled with forms.css.
	</p>
	<p>
		If you want to avoid a potential flash (waiting for js to load and replace your default elements) you can supply the custom markup as part of the page, and the js will instead 
		simply map the custom elements to the inputs.
	</p>
	<p>
		Foundation custom forms will even correctly respect and apply default states for radio, checkbox and select elements. You can use the 'checked' or 'selected' properties just like 
		normal, and the js will apply that as soon as the page loads.
	</p>
	<p>
		<script type="text/javascript" src="http://snipt.net/embed/d1ce9f919728c0d52fc0ed0ef4600224">

		</script>
	</p>
	
	<h5>
		Radio Buttons
	</h5>
	<p>
		<script type="text/javascript" src="http://snipt.net/embed/8fcb1d67179ebc3e79b873419be04bf2">

		</script>
	</p>
	
	<h5>
		Checkboxes
	</h5>
	<p>
		<script type="text/javascript" src="http://snipt.net/embed/01d86277dee91bab34dd1baed52d2c18">

		</script>
	</p>
	
	<div class="row">
		<div class="four columns">
			<label for="radio1">
				<input name="radio1" type="radio" id="radio1" style="display:none;">
				<span class="custom radio">
				</span>
				Radio Button 1
			</label>
			<label for="radio2">
				<input name="radio1" type="radio" id="radio2" style="display:none;">
				<span class="custom radio checked">
				</span>
				Radio Button 2
			</label>
			<label for="radio3">
				<input name="radio1" type="radio" id="radio3" style="display:none;">
				<span class="custom radio">
				</span>
				Radio Button 3
			</label>
		</div>
		<div class="four columns">
			<label for="radio4">
				<input name="radio2" type="radio" id="radio4">
				Radio Button 1
			</label>
			<label for="radio5">
				<input name="radio2" checked type="radio" id="radio5">
				Radio Button 2
			</label>
			<label for="radio6">
				<input name="radio2" type="radio" id="radio6">
				Radio Button 3
			</label>
		</div>
		<div class="four columns">
			<label for="checkbox1">
				<input type="checkbox" id="checkbox1" style="display: none;">
				<span class="custom checkbox">
				</span>
				Label for Checkbox
			</label>
			<label for="checkbox2">
				<input type="checkbox" id="checkbox2" checked style="display: none;">
				<span class="custom checkbox checked">
				</span>
				Label for Checkbox
			</label>
			<label for="checkbox3">
				<input type="checkbox" checked id="checkbox3">
				Label for Checkbox
			</label>
		</div>
	</div>
	
	<h5>
		Dropdown / Select Elements
	</h5>
	<p>
		<script type="text/javascript" src="http://snipt.net/embed/bb153a86cba41617b41d91268828bb42">

		</script>
	</p>
	
	<label for="customDropdown">
		Dropdown Label
	</label>
	<select style="display:none;" id="customDropdown">
		<option selected>
			This is a dropdown
		</option>
		<option>
			This is another option
		</option>
		<option>
			Look, a third option
		</option>
	</select>
	<div class="custom dropdown">
		<a href="#" class="current">
							This is a dropdown
						</a>
		<a href="#" class="selector"></a>
		<ul>
			<li>
				This is a dropdown
			</li>
			<li>
				This is another option
			</li>
			<li>
				Look, a third option
			</li>
		</ul>
	</div>
	
	<label for="customDropdown2">
		Dropdown Label
	</label>
	<select id="customDropdown2">
		<option>
			This is a dropdown
		</option>
		<option selected>
			This is another option
		</option>
		<option>
			Look, a third option
		</option>
	</select>
</form>

<h4>
	Block Grids
</h4>
<p>
	Block grids are ULs with 2-up, 3-up, 4-up and 5-up styles. These are ideal for blocked-in content generated by an application, as they do not require rows or even numbers of 
	elements to display correctly.
</p>
<p>
	By default these blocks will stay in their N-up configuration on mobile devices, but you can add a class of 'mobile' to have them reshuffle on smartphones into one element per 
	line, just like the Grid.
</p>

<h5>
	Two-up
</h5>
<ul class="block-grid two-up">
	<li>
		Two-up element
	</li>
	<li>
		Two-up element
	</li>
	<li>
		Two-up element
	</li>
	<li>
		Two-up element
	</li>
	<li>
		Two-up element
	</li>
</ul>

<h5>
	Three-up
</h5>
<ul class="block-grid three-up">
	<li>
		Three-up element
	</li>
	<li>
		Three-up element
	</li>
	<li>
		Three-up element
	</li>
	<li>
		Three-up element
	</li>
	<li>
		Three-up element
	</li>
</ul>

<h5>
	Four-up (Mobile)
</h5>
<ul class="block-grid mobile four-up">
	<li>
		Four-up element
	</li>
	<li>
		Four-up element
	</li>
	<li>
		Four-up element
	</li>
	<li>
		Four-up element
	</li>
	<li>
		Four-up element
	</li>
	<li>
		Four-up element
	</li>
</ul>

<h5>
	Five-up
</h5>
<ul class="block-grid five-up">
	<li>
		Five-up element
	</li>
	<li>
		Five-up element
	</li>
	<li>
		Five-up element
	</li>
	<li>
		Five-up element
	</li>
	<li>
		Five-up element
	</li>
	<li>
		Five-up element
	</li>
	<li>
		Five-up element
	</li>
</ul>

<h4>
	Alerts
</h4>
<p>
	Alerts are a handy element you can drop into a form or inline on a page to communicate success, warnings, failure or just information. The syntax is extremely simple and like 
	anything else in Foundation, easy to customize.
</p>

<div class="alert-box">
	This is a standard alert (div.alert-box).
	<a href="" class="close">
		&times;
	</a>
</div>

<div class="alert-box success">
	This is a success alert (div.alert-box.success).
	<a href="" class="close">
		&times;
	</a>
</div>

<div class="alert-box warning">
	This is a warning alert (div.alert-box.warning).
	<a href="" class="close">
		&times;
	</a>
</div>

<div class="alert-box error">
	This is an error alert (div.alert-box.error).
	<a href="" class="close">
		&times;
	</a>
</div>

<p>
	<script type="text/javascript" src="http://snipt.net/embed/e291c9b926573dfd81fe24168d554c92">

	</script>
</p>

<hr/>

<h4>
	Labels
</h4>
<p>
	Labels are useful inline styles that can be dropped into body copy to call out certain sections or to attach metadata. Examples might be noting when something was updated or that 
	something is new. The syntax is simple, just a 
	<code>
		span
	</code>
	element with a class of .label. The border styling mirrors that of the Foundation buttons.
</p>

<div class="row">
	<div class="three columns phone-two">
		<p>
			<span class="label">
				Regular Label
			</span>
			<br/>
			<br/>
			<span class="radius label">
				Radius Label
			</span>
			<br/>
			<br/>
			<span class="round label">
				Round Label
			</span>
		</p>
	</div>
	<div class="three columns phone-two">
		<p>
			<span class="blue radius label">
				Blue Label
			</span>
			<br/>
			<br/>
			<span class="red radius label">
				Red Label
			</span>
			<br/>
			<br/>
			<span class="black radius label">
				Black Label
			</span>
			<br/>
			<br/>
			<span class="green radius label">
				Green Label
			</span>
			<br/>
			<br/>
			<span class="white radius label">
				White Label
			</span>
		</p>
	</div>
</div>

<p>
	<span class="label">
		Added 01/19
	</span>
	This paragraph has an inline label to let you know that it was added on January 19, 2012 courtesy of Thomas Klemm. Thanks man!
</p>

<p>
	<script type="text/javascript" src="http://snipt.net/embed/eabd94fbda853d866057cbda5e8ab64a">

	</script>
</p>

<hr/>

<h4>
	Tooltips
</h4>
<p>
	Tooltips are a quick way to provide extended information on a term or action on a page. They work cross browser and cross platfrom and are easily added to a page by including the 
	jquery.tooltip.js plugin. You can apply the 
	<strong>
		has-tip
	</strong>
	class to any element, as long as you assign it a unique ID.
</p>

<p>
	By default the tooltip takes the width of the element that it is applied to, but you can override this behavior by applying a 
	<strong>
		data-width
	</strong>
	attribute to the target element. The tooltip takes on the content of the targets 
	<strong>
		title
	</strong>
	attribute.
</p>

<p>
	The tooltips can be positioned on the 
	<span class="has-tip" data-width="210" title="I'm on bottom and the default position.">
		"tip-bottom"
	</span>
	, which is the default position, 
	<span class="has-tip tip-top noradius" data-width="210" title="I'm on the top and I'm not rounded!">
		"tip-top" (hehe)
	</span>
	, 
	<span class="has-tip tip-left" data-width="90" title="I'm on the left!">
		"tip-left"
	</span>
	, or 
	<span class="has-tip tip-right" data-width="90" title="I'm on the right!">
		"tip-right"
	</span>
	of the target element.In a mobile environment the tooltips are full width and bottom aligned.
</p>

<hr/>

<h4>
	Panels
</h4>
<p>
	A panel is a simple, helpful css class that enables you to outline sections of your page easily. This allows you to view your page sections as you add content to them, or add 
	emphasis to a section (for example the download box on the right).
</p>

<div class="panel">
	<h5>
		My panel is bigger than yours.
	</h5>
	<p>
		Seriously, just look at this sweet panel.
	</p>
</div>

<p>
	<script type="text/javascript" src="http://snipt.net/embed/66b5c85cee4ee8648ad51dfcf2c2ffd6">

	</script>
</p>

<hr/>

<h4>
	Tabs
</h4>
<div class="row">
	<div class="six columns">
		<p>
			Tabs are very versatile both as organization and navigational constructs. To keep things easy for everyone we've created two main tab styles (simple and nice) as well as two 
			variants of each - open and contained. With the base Foundation package, tabs of a particular format are actually already hooked up - no extra work required.
		</p>
	</div>
	<div class="six columns">
		<p>
			Tabs are made of 
			<strong>
				two objects:
			</strong>
			a DL object containing the tabs themselves, and a UL object containing the tab content. If you simply want visual tabs (as seen in this documentation) without the on-page 
			hookup, you only need the DL. If you want functional tabs, just be sure that each tab is linked to an ID, and that the corresponding tab has an ID of tabnameTab. Check out these 
			examples.
		</p>
	</div>
</div>
<p>
	<em>
		Note: The third tab is using the 
		<a href="layout.php">
			mobile visibility classes
		</a>
		to hide on small devices.
	</em>
</p>
<h5>
	Simple Tabs
</h5>
<dl class="tabs">
	<dd>
		<a href="#simple1" class="active">Simple Tab 1</a>
	</dd>
	<dd>
		<a href="#simple2">Simple Tab 2</a>
	</dd>
	<dd class="hide-on-phones">
		<a href="#simple3">Simple Tab 3</a>
	</dd>
</dl>
<ul class="tabs-content">
	<li class="active" id="simple1Tab">
		This is simple tab 1's content. Pretty neat, huh?
	</li>
	<li id="simple2Tab">
		This is simple tab 2's content. Now you see it!
	</li>
	<li id="simple3Tab">
		This is simple tab 3's content. It's only okay.
	</li>
</ul>

<script src="http://snipt.net/embed/beabf0c3da0338ec44d9d383d9c405f4">

</script>

<hr/>

<h5>
	Contained Tabs
</h5>
<p>
	Contained tabs have a simple added class of 'contained' on the tabs-content element. What that means is the tab content has a border around it tying it to the tabs, and the 
	padding on that container (by default) is one column on each side. That means you can still use standard column sizes inside a tab element.
</p>

<dl class="tabs contained">
	<dd>
		<a href="#simpleContained1" class="active">Simple Tab 1</a>
	</dd>
	<dd>
		<a href="#simpleContained2">Simple Tab 2</a>
	</dd>
	<dd class="hide-on-phones">
		<a href="#simpleContained3">Simple Tab 3</a>
	</dd>
</dl>
<ul class="tabs-content contained">
	<li class="active" id="simpleContained1Tab">
		This is simple tab 1's content. Pretty neat, huh?
	</li>
	<li id="simpleContained2Tab">
		This is simple tab 2's content. Now you see it!
	</li>
	<li id="simpleContained3Tab">
		This is simple tab 3's content. It's only okay.
	</li>
</ul>

<script src="http://snipt.net/embed/79e2cd3515daf12475946930a3d0f011">

</script>

<hr/>

<h5>
	Nice Tabs
</h5>
<p>
	Need something a little fancier? Nice tabs have some sweet default styling and can add a little polish to a prototype (or documentation). They can be both standard and contained, 
	just like the simple tabs.
</p>

<dl class="nice contained tabs">
	<dd>
		<a href="#nice1" class="active">Nice Tab 1</a>
	</dd>
	<dd>
		<a href="#nice2">Nice Tab 2</a>
	</dd>
	<dd class="hide-on-phones">
		<a href="#nice3">Nice Tab 3</a>
	</dd>
</dl>
<ul class="nice tabs-content contained">
	<li class="active" id="nice1Tab">
		This is nice tab 1's content. Pretty neat, huh?
	</li>
	<li id="nice2Tab">
		This is nice tab 2's content. Now you see it!
	</li>
	<li id="nice3Tab">
		This is simple tab 3's content. It's only okay.
	</li>
</ul>

<script src="http://snipt.net/embed/63e549cb8b9606acbaed87b1b37b51e1">

</script>

<hr/>

<h5>
	Vertical Tabs
</h5>
<p>
	You can also use tabs in a vertical configuration by adding a class of 'vertical' to the DL element. These are great for more scalable nav, and you can see how they work on this 
	page on a tablet or desktop.
</p>

<dl class="nice vertical tabs">
	<dd>
		<a href="#vertical1" class="active">Vertical Tab 1</a>
	</dd>
	<dd>
		<a href="#vertical2">Vertical Tab 2</a>
	</dd>
	<dd>
		<a href="#vertical3">Vertical Tab 3</a>
	</dd>
</dl>

<script type="text/javascript" src="http://snipt.net/embed/4086cc6652ec6713851eba85db00c3e5">

</script>

<hr/>

<h5>
	Mobile Tabs
</h5>
<p>
	To demonstrate how mobile navigation can work, adding a class of 'mobile' to a tab group will switch them (at small resolutions) to full width nav bars.
</p>

<hr/>

<h4>
	Nav Bar
</h4>
<p>
	If you need a more traditional nav bar with dropdowns, you can use this sucka. The dropdowns are optional - omitting the flyout element and .has-flyout class means it will act as 
	a standard link. The flyouts can hold arbitrary content, including grid objects, and have three sizes (.small, standard, and .large).
</p>

<p>
	<em>
		Note: In IE7 the dropdowns are obscured by the code snippet below. This is due to IE7s iframe z-index bug, and is not an issue with the dropdowns themselves. Try not to have 
		dropdown elements over an iframe.
	</em>
</p>

<ul class="nav-bar">
	<li>
		<a href="#" class="main">Nav Item 1</a>
	</li>
	<li class="has-flyout">
		<a href="#" class="main">Nav Item 2</a>
		<a href="#" class="flyout-toggle"><span> </span></a>
		<div class="flyout small">
			<h5>
				Small Example (200px)
			</h5>
			<p>
				This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. 
			</p>
		</div>
	</li>
	<li class="has-flyout">
		<a href="#" class="main">Nav Item 3</a>
		<a href="#" class="flyout-toggle"><span> </span></a>
		<div class="flyout">
			<div class="row">
				<div class="twelve columns">
					<h5>
						Medium Example (400px)
					</h5>
					<div class="row">
						<div class="six columns">
							<p>
								This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example 
								text.
							</p>
						</div>
						<div class="six columns">
							<p>
								This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example 
								text.
							</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li class="has-flyout hide-on-tablets">
		<a href="#" class="main">Nav Item 4</a>
		<a href="#" class="flyout-toggle"><span> </span></a>
		<div class="flyout large right">
			<div class="row">
				<div class="twelve columns">
					<h5>
						Large Example (600px)
					</h5>
					<div class="row">
						<div class="four columns">
							<p>
								This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example 
								text.
							</p>
							<p>
								This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example 
								text.
							</p>
						</div>
						<div class="four columns">
							<p>
								This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example 
								text.
							</p>
							<p>
								This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example text. This is example 
								text.
							</p>
						</div>
						<div class="four columns">
							<img src="http://placehold.it/200x250"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</li>
</ul>

<script type="text/javascript" src="http://snipt.net/embed/7dd4b241f040a3437468b7e7176429a6">

</script>

<p>
	You can also drop inputs into the nav in place of an anchor. Here you can see a search input.
</p>

<ul class="nav-bar">
	<li>
		<input type="search"/>
	</li>
	<li class="has-flyout">
		<a href="" class="main">
			Nav Element
		</a>
		<a href="http://www.zurb.com" class="flyout-toggle">
			<span>
			</span>
		</a>
		<div class="flyout">
			<ul>
				<li>
					<a href="">
						This is a link in a UL.
					</a>
				</li>
				<li>
					<a href="">
						This is a link in a UL.
					</a>
				</li>
				<li>
					<a href="">
						This is a link in a UL.
					</a>
				</li>
			</ul>
		</div>
	</li>
</ul>

<hr/>

<h4>
	Sub Nav
</h4>

<p>
	If you need to provide simple and effective on-page navigation, to either jump to content on the page or flip to another view then use this awesome little sub-nav.
</p>

<dl class="sub-nav">
	<dt>
		Filter:
	</dt>
	<dd class="active">
		<a href="#">All</a></dd>
					<dd><a href="#">
			Active
		</a>
	</dd>
	<dd>
		<a href="#">Pending</a></dd>
					<dd><a href="#">
			Suspended
		</a>
	</dd>
</dl>

<script type="text/javascript" src="http://snipt.net/embed/f05cca3ec55b4de8d2f5090e8e790fa9">

</script>

<hr/>

<h4>
	Pagination
</h4>
<p>
	Breaking stuff up into pages? Yeah you are. Here's some pagination to get you started.
</p>

<ul class="pagination">
	<li class="unavailable">
		<a href="">
			&laquo;
		</a>
	</li>
	<li class="current">
		<a href="">
			1
		</a>
	</li>
	<li>
		<a href="">
			2
		</a>
	</li>
	<li>
		<a href="">
			3
		</a>
	</li>
	<li>
		<a href="">
			4
		</a>
	</li>
	<li class="unavailable">
		<a href="">
			&hellip;
		</a>
	</li>
	<li>
		<a href="">
			12
		</a>
	</li>
	<li>
		<a href="">
			13
		</a>
	</li>
	<li>
		<a href="">
			&raquo;
		</a>
	</li>
</ul>

<script src="http://snipt.net/embed/724214a9eba6436e1565fc748693e61b">

</script>

<hr/>

<h4>
	Breadcrumbs
</h4>
<p>
	Walking through a linear flow, or want to show where someone is in the hierarchy? Breadcrumbs are totally boss.
</p>
<p>
	Breadcrumbs are built with a UL just like pagination, and they can support span or anchor elements with 'current' and 'unavailable' classes.
</p>

<ul class="breadcrumbs">
	<li>
		<a href="#">Home</a></li>
					<li><a href="#">
			Features
		</a>
	</li>
	<li class="unavailable">
		<a href="#">Gene Splicing</a>
	</li>
	<li class="current">
		<a href="#">Home</a>
	</li>
</ul>

<ul class="breadcrumbs">
	<li>
		<span>
			Home
		</span>
	</li>
	<li>
		<span>
			Features
		</span>
	</li>
	<li>
		<span>
			Gene Splicing
		</span>
	</li>
	<li class="current">
		<span>
			Home
		</span>
	</li>
</ul>

<script type="text/javascript" src="http://snipt.net/embed/19f73f5dd789f687f48e3928a0ddc157">

</script>

<hr/>

<h4>
	Tables
</h4>
<p>
	Okay, they're not the sexiest things ever, but tables get the job done (for tabular data).
</p>

<table>
	<thead>
		<tr>
			<th>
				Table Header
			</th>
			<th>
				Table Header
			</th>
			<th>
				Table Header
			</th>
			<th>
				Table Header
			</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				Content
			</td>
			<td>
				This is longer content
			</td>
			<td>
				Content
			</td>
			<td>
				Content
			</td>
		</tr>
		<tr>
			<td>
				Content
			</td>
			<td>
				This is longer content
			</td>
			<td>
				Content
			</td>
			<td>
				Content
			</td>
		</tr>
		<tr>
			<td>
				Content
			</td>
			<td>
				This is longer content
			</td>
			<td>
				Content
			</td>
			<td>
				Content
			</td>
		</tr>
		<tr>
			<td>
				Content
			</td>
			<td>
				This is longer content
			</td>
			<td>
				Content
			</td>
			<td>
				Content
			</td>
		</tr>
	</tbody>
</table>

<hr/>

<h4>
	Video
</h4>
<p>
	If you're embedding video from YouTube, Vimeo, or another site that uses iframe, embed or object elements you can wrap your video in 
	<code>
		div.flex-video
	</code>
	to create an intrinsic ratio that will properly scale your video on any device.
</p>

<dl class="tabs contained">
	<dd>
		<a href="#video1" class="active">4:3</a>
	</dd>
	<dd>
		<a href="#video2">Widescreen</a>
	</dd>
	<dd>
		<a href="#video3">Vimeo</a>
	</dd>
</dl>
<ul class="tabs-content contained">
	<li class="active" id="video1Tab">
		<div class="flex-video">
			<iframe width="420" height="315" src="http://www.youtube.com/embed/9otNWTHOJi8" frameborder="0" allowfullscreen>
			</iframe>
		</div>
		4:3 is the default size for the .flex-video element, and the assumption for .flex-video for chrome (controls) height is based on YouTube.
	</li>
	<li id="video2Tab">
		<div class="flex-video widescreen">
			<iframe width="560" height="315" src="http://www.youtube.com/embed/N966cATFWjI" frameborder="0" allowfullscreen>
			</iframe>
		</div>
		By adding a class of .widescreen we change the ratio to 16:9, ideal for more recent video and most popular YouTube or Vimeo embeds.
	</li>
	<li id="video3Tab">
		<div class="flex-video widescreen vimeo">
			<iframe src="http://player.vimeo.com/video/21762736?title=0&amp;byline=0&amp;portrait=0" width="400" height="225" frameborder="0" webkitallowfullscreen mozallowfullscreen
			        allowfullscreen>
			</iframe>
		</div>
		Because Vimeo places their chrome on the player itself, adding a class of .vimeo creates a container that is sized for the video only - no extra padding for the controls.
	</li>
</ul>

<script type="text/javascript" src="http://snipt.net/embed/723bad35ef085d939ed09fff20fca68e">

</script>

<hr/>

<h4>
	Microformats
</h4>
<p>
	Microformats are formats for data objects represented on the page using standard HTML. By applying specific classes to objects parsers like the operator plugin can detect relevant 
	data and display it. This can be especially handy for contact info, events, locations and news articles. We've supplied some base styling for microformats, as well as the relevant 
	markup.
</p>

<h5>
	hCard
</h5>
<p>
	hCards are a microformat for contact information. We've represented the correct syntax here to ensure they are machine readable, as well as applied some minimal styling.
</p>

<ul class="vcard">
	<li class="fn">
		John T. Yeti
	</li>
	<li class="nickname">
		Yeti
	</li>
	<li class="org">
		Foundation, Inc.
	</li>
	<li class="tel">
		<a href="tel:408-867-5309">
			408-867-5309
		</a>
	</li>
	<li>
		<a class="url" href="http://foundation.zurb.com/">
			http://foundation.zurb.com/
		</a>
	</li>
</ul>

<p>
	<script type="text/javascript" src="http://snipt.net/embed/eb809555f900b7fa2651d6f31b35d941">

	</script>
</p>

<h5>
	hCalendar
</h5>
<p>
	An hCalendar event is an iCalendar formatted entry for an event at a specific time and location. This can be interpreted by parsing tools to recognize events and add them to a 
	calendar.
</p>

<p class="vevent">
	The 
	<span class="summary">
		Foundation Launch Party
	</span>
	was on October 13 2011 from
	<abbr class="dtstart" title="2011-10-13T14:00:00+06:00">
		2
	</abbr>
	&ndash;
	<abbr class="dtend" title="2011-10-13T16:00:00+06:00">
		4
	</abbr>
	pm at 
	<span class="location">
		ZURB HQ
	</span>
	(
	<a class="url" href="http://foundation.zurb.com">
		More Info
	</a>
	)
</p>

<p>
	<script type="text/javascript" src="http://snipt.net/embed/ef85ba34e235c9bc712baa62cc8bdf4c">

	</script>
</p>

<h3>
	Orbit
</h3>
<h4 class="subheader">
	Orbit is all the rage in jQuery hotness right now. It's a killer, lightweight slider for images &amp; content.
</h4>
<hr/>

<div id="orbitDemo">
	<img src="images/orbit-demo/overflow.jpg" alt="Overflow: Hidden No More"/>
	<img 
	src="images/orbit-demo/captions.jpg" alt="HTML Captions" data-caption="#htmlCaption" />
	<img src="images/orbit-demo/features.jpg" alt="and more features"/>
	<div class="content" style="">
		<h1>
			Orbit does content.
		</h1>
		<h3>
			This is just text over a background image.
		</h3>
	</div>
</div>
<!-- Captions for Orbit -->
<span class="orbit-caption" id="htmlCaption">
	<strong>
		I'm A Badass Caption:
	</strong>
	I can haz 
	<a href="#">links</a>
	, 
	<em>
		style
	</em>
	or anything that is valid markup :)
</span>

<h3>
	Reveal Modal
</h3>

<a id="buttonForModal">
	Launch Modal Window
</a>
<div id="myModal" class="reveal-modal">
	<h2>
		Awesome. I have it.
	</h2>
	<p class="lead">
		Your couch. I it's mine.
	</p>
	<p>
		Im a cool paragraph that lives inside of an even cooler modal. Wins
	</p>
	<a class="close-reveal-modal">
		&#215;
	</a>
</div>

<h1>
	jQuery UI Examples 
	<div id="switcher">
	</div>
</h1>

<div id="components" class="clearfix">
	<style type="text/css">
		#compGroupA {
		    width: 600px;
		    padding: 0px 50px;
		    float: left;
		}
		#compGroupB {
		    width: 300px;
		    float: left;
		}
		#icons li {
		    width: 15px;
		    padding: 3px;
		    margin: 5px 5px;
		    float: left;
		}
	</style>
	
	<div id="compGroupA" class="clearfix">
	
		<!-- Accordion -->
		<h2 class="demoHeaders">
			Accordion
		</h2>
		<div id="accordion">
			<h3>
				<a href="#">Section 1</a></h3>
				<div>
					<p>Mauris mauris ante, blandit et, ultrices a, suscipit eget, quam. Integer ut neque. Vivamus nisi metus, molestie vel, gravida in, condimentum sit amet, nunc. Nam a nibh. Donec suscipit eros. Nam mi. Proin viverra leo ut odio. Curabitur malesuada. Vestibulum a velit eu ante scelerisque vulputate.</p>
				</div>
				<h3><a href="#">
					Section 2
				</a>
			</h3>
			<div>
				<p>
					Sed non urna. Donec et ante. Phasellus eu ligula. Vestibulum sit amet purus. Vivamus hendrerit, dolor at aliquet laoreet, mauris turpis porttitor velit, faucibus interdum 
					tellus libero ac justo. Vivamus non quam. In suscipit faucibus urna. 
				</p>
			</div>
			<h3>
				<a href="#">Section 3</a>
			</h3>
			<div>
				<p>
					Nam enim risus, molestie et, porta ac, aliquam ac, risus. Quisque lobortis. Phasellus pellentesque purus in massa. Aenean in pede. Phasellus ac libero ac tellus pellentesque 
					semper. Sed ac felis. Sed commodo, magna quis lacinia ornare, quam ante aliquam nisi, eu iaculis leo purus venenatis dui. 
				</p>
				<ul>
					<li>
						List item one
					</li>
					<li>
						List item two
					</li>
					<li>
						List item three
					</li>
				</ul>
			</div>
		</div>
		
		<!-- Tabs -->
		<h2 class="demoHeaders">
			Tabs
		</h2>
		<div id="tabs">
			<ul>
				<li>
					<a href="#tabs-1">First</a>
				</li>
				<li>
					<a href="#tabs-2">Second</a>
				</li>
				<li>
					<a href="#tabs-3">Third</a>
				</li>
			</ul>
			<div id="tabs-1">
				Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
				ullamco laboris nisi ut aliquip ex ea commodo consequat.
			</div>
			<div id="tabs-2">
				Phasellus mattis tincidunt nibh. Cras orci urna, blandit id, pretium vel, aliquet ornare, felis. Maecenas scelerisque sem non nisl. Fusce sed lorem in enim dictum bibendum.
			</div>
			<div id="tabs-3">
				Nam dui erat, auctor a, dignissim quis, sollicitudin eu, felis. Pellentesque nisi urna, interdum eget, sagittis et, consequat vestibulum, lacus. Mauris porttitor ullamcorper 
				augue.
			</div>
		</div>
		
		<!-- Dialog -->
		<h2 class="demoHeaders">
			Dialog
		</h2>
		<p>
			<a href="#" id="dialog_link" class="ui-state-default ui-corner-all"><span class="ui-icon ui-icon-newwin"></span>Open Dialog</a>
		</p>
		
		<h2 class="demoHeaders">
			Overlay and Shadow Classes
		</h2>
		<div style="position: relative; width: 96%; height: 200px; padding:1% 4%; overflow:hidden;" class="fakewindowcontain">
			<p>
				Lorem ipsum dolor sit amet, Nulla nec tortor. Donec id elit quis purus consectetur consequat. 
			</p>
			<p>
				Nam congue semper tellus. Sed erat dolor, dapibus sit amet, venenatis ornare, ultrices ut, nisi. Aliquam ante. Suspendisse scelerisque dui nec velit. Duis augue augue, gravida 
				euismod, vulputate ac, facilisis id, sem. Morbi in orci. 
			</p>
			<p>
				Nulla purus lacus, pulvinar vel, malesuada ac, mattis nec, quam. Nam molestie scelerisque quam. Nullam feugiat cursus lacus.orem ipsum dolor sit amet, consectetur adipiscing 
				elit. Donec libero risus, commodo vitae, pharetra mollis, posuere eu, pede. Nulla nec tortor. Donec id elit quis purus consectetur consequat. 
			</p>
			<p>
				Nam congue semper tellus. Sed erat dolor, dapibus sit amet, venenatis ornare, ultrices ut, nisi. Aliquam ante. Suspendisse scelerisque dui nec velit. Duis augue augue, gravida 
				euismod, vulputate ac, facilisis id, sem. Morbi in orci. Nulla purus lacus, pulvinar vel, malesuada ac, mattis nec, quam. Nam molestie scelerisque quam. 
			</p>
			<p>
				Nullam feugiat cursus lacus.orem ipsum dolor sit amet, consectetur adipiscing elit. Donec libero risus, commodo vitae, pharetra mollis, posuere eu, pede. Nulla nec tortor. 
				Donec id elit quis purus consectetur consequat. Nam congue semper tellus. Sed erat dolor, dapibus sit amet, venenatis ornare, ultrices ut, nisi. Aliquam ante. 
			</p>
			<p>
				Suspendisse scelerisque dui nec velit. Duis augue augue, gravida euismod, vulputate ac, facilisis id, sem. Morbi in orci. Nulla purus lacus, pulvinar vel, malesuada ac, mattis 
				nec, quam. Nam molestie scelerisque quam. Nullam feugiat cursus lacus.orem ipsum dolor sit amet, consectetur adipiscing elit. Donec libero risus, commodo vitae, pharetra 
				mollis, posuere eu, pede. Nulla nec tortor. Donec id elit quis purus consectetur consequat.
			</p>
			
			<!-- ui-dialog -->
			<div class="ui-overlay">
				<div class="ui-widget-overlay">
				</div>
				<div class="ui-widget-shadow ui-corner-all" style="width: 302px; height: 152px; position: absolute; left: 50px; top: 30px;">
				</div>
			</div>
			<div style="position: absolute; width: 280px; height: 130px;left: 50px; top: 30px; padding: 10px;" class="ui-widget ui-widget-content ui-corner-all">
			
				<p>
					Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
					ullamco laboris nisi ut aliquip ex ea commodo consequat.
				</p>
			</div>
		</div>
		
		<!-- ui-dialog -->
		<div id="dialog" title="Dialog Title">
			<p>
				Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation 
				ullamco laboris nisi ut aliquip ex ea commodo consequat.
			</p>
		</div>
		
		<h2 class="demoHeaders">
			Framework Icons (content color preview)
		</h2>
		
		<ul id="icons" class="ui-widget ui-helper-clearfix">
		
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-1-n">
				<span class="ui-icon ui-icon-carat-1-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-1-ne">
				<span class="ui-icon ui-icon-carat-1-ne">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-1-e">
				<span class="ui-icon ui-icon-carat-1-e">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-1-se">
				<span class="ui-icon ui-icon-carat-1-se">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-1-s">
				<span class="ui-icon ui-icon-carat-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-1-sw">
				<span class="ui-icon ui-icon-carat-1-sw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-1-w">
				<span class="ui-icon ui-icon-carat-1-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-1-nw">
				<span class="ui-icon ui-icon-carat-1-nw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-2-n-s">
				<span class="ui-icon ui-icon-carat-2-n-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-carat-2-e-w">
				<span class="ui-icon ui-icon-carat-2-e-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-1-n">
				<span class="ui-icon ui-icon-triangle-1-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-1-ne">
				<span class="ui-icon ui-icon-triangle-1-ne">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-1-e">
				<span class="ui-icon ui-icon-triangle-1-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-1-se">
				<span class="ui-icon ui-icon-triangle-1-se">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-1-s">
				<span class="ui-icon ui-icon-triangle-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-1-sw">
				<span class="ui-icon ui-icon-triangle-1-sw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-1-w">
				<span class="ui-icon ui-icon-triangle-1-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-1-nw">
				<span class="ui-icon ui-icon-triangle-1-nw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-2-n-s">
				<span class="ui-icon ui-icon-triangle-2-n-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-triangle-2-e-w">
				<span class="ui-icon ui-icon-triangle-2-e-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-1-n">
				<span class="ui-icon ui-icon-arrow-1-n">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-1-ne">
				<span class="ui-icon ui-icon-arrow-1-ne">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-1-e">
				<span class="ui-icon ui-icon-arrow-1-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-1-se">
				<span class="ui-icon ui-icon-arrow-1-se">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-1-s">
				<span class="ui-icon ui-icon-arrow-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-1-sw">
				<span class="ui-icon ui-icon-arrow-1-sw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-1-w">
				<span class="ui-icon ui-icon-arrow-1-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-1-nw">
				<span class="ui-icon ui-icon-arrow-1-nw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-2-n-s">
				<span class="ui-icon ui-icon-arrow-2-n-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-2-ne-sw">
				<span class="ui-icon ui-icon-arrow-2-ne-sw">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-2-e-w">
				<span class="ui-icon ui-icon-arrow-2-e-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-2-se-nw">
				<span class="ui-icon ui-icon-arrow-2-se-nw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowstop-1-n">
				<span class="ui-icon ui-icon-arrowstop-1-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowstop-1-e">
				<span class="ui-icon ui-icon-arrowstop-1-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowstop-1-s">
				<span class="ui-icon ui-icon-arrowstop-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowstop-1-w">
				<span class="ui-icon ui-icon-arrowstop-1-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-1-n">
				<span class="ui-icon ui-icon-arrowthick-1-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-1-ne">
				<span class="ui-icon ui-icon-arrowthick-1-ne">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-1-e">
				<span class="ui-icon ui-icon-arrowthick-1-e">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-1-se">
				<span class="ui-icon ui-icon-arrowthick-1-se">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-1-s">
				<span class="ui-icon ui-icon-arrowthick-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-1-sw">
				<span class="ui-icon ui-icon-arrowthick-1-sw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-1-w">
				<span class="ui-icon ui-icon-arrowthick-1-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-1-nw">
				<span class="ui-icon ui-icon-arrowthick-1-nw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-2-n-s">
				<span class="ui-icon ui-icon-arrowthick-2-n-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-2-ne-sw">
				<span class="ui-icon ui-icon-arrowthick-2-ne-sw">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-2-e-w">
				<span class="ui-icon ui-icon-arrowthick-2-e-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthick-2-se-nw">
				<span class="ui-icon ui-icon-arrowthick-2-se-nw">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthickstop-1-n">
				<span class="ui-icon ui-icon-arrowthickstop-1-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthickstop-1-e">
				<span class="ui-icon ui-icon-arrowthickstop-1-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthickstop-1-s">
				<span class="ui-icon ui-icon-arrowthickstop-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowthickstop-1-w">
				<span class="ui-icon ui-icon-arrowthickstop-1-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowreturnthick-1-w">
				<span class="ui-icon ui-icon-arrowreturnthick-1-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowreturnthick-1-n">
				<span class="ui-icon ui-icon-arrowreturnthick-1-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowreturnthick-1-e">
				<span class="ui-icon ui-icon-arrowreturnthick-1-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowreturnthick-1-s">
				<span class="ui-icon ui-icon-arrowreturnthick-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowreturn-1-w">
				<span class="ui-icon ui-icon-arrowreturn-1-w">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowreturn-1-n">
				<span class="ui-icon ui-icon-arrowreturn-1-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowreturn-1-e">
				<span class="ui-icon ui-icon-arrowreturn-1-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowreturn-1-s">
				<span class="ui-icon ui-icon-arrowreturn-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowrefresh-1-w">
				<span class="ui-icon ui-icon-arrowrefresh-1-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowrefresh-1-n">
				<span class="ui-icon ui-icon-arrowrefresh-1-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowrefresh-1-e">
				<span class="ui-icon ui-icon-arrowrefresh-1-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrowrefresh-1-s">
				<span class="ui-icon ui-icon-arrowrefresh-1-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-4">
				<span class="ui-icon ui-icon-arrow-4">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-arrow-4-diag">
				<span class="ui-icon ui-icon-arrow-4-diag">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-extlink">
				<span class="ui-icon ui-icon-extlink">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-newwin">
				<span class="ui-icon ui-icon-newwin">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-refresh">
				<span class="ui-icon ui-icon-refresh">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-shuffle">
				<span class="ui-icon ui-icon-shuffle">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-transfer-e-w">
				<span class="ui-icon ui-icon-transfer-e-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-transferthick-e-w">
				<span class="ui-icon ui-icon-transferthick-e-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-folder-collapsed">
				<span class="ui-icon ui-icon-folder-collapsed">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-folder-open">
				<span class="ui-icon ui-icon-folder-open">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-document">
				<span class="ui-icon ui-icon-document">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-document-b">
				<span class="ui-icon ui-icon-document-b">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-note">
				<span class="ui-icon ui-icon-note">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-mail-closed">
				<span class="ui-icon ui-icon-mail-closed">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-mail-open">
				<span class="ui-icon ui-icon-mail-open">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-suitcase">
				<span class="ui-icon ui-icon-suitcase">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-comment">
				<span class="ui-icon ui-icon-comment">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-person">
				<span class="ui-icon ui-icon-person">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-print">
				<span class="ui-icon ui-icon-print">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-trash">
				<span class="ui-icon ui-icon-trash">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-locked">
				<span class="ui-icon ui-icon-locked">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-unlocked">
				<span class="ui-icon ui-icon-unlocked">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-bookmark">
				<span class="ui-icon ui-icon-bookmark">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-tag">
				<span class="ui-icon ui-icon-tag">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-home">
				<span class="ui-icon ui-icon-home">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-flag">
				<span class="ui-icon ui-icon-flag">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-calculator">
				<span class="ui-icon ui-icon-calculator">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-cart">
				<span class="ui-icon ui-icon-cart">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-pencil">
				<span class="ui-icon ui-icon-pencil">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-clock">
				<span class="ui-icon ui-icon-clock">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-disk">
				<span class="ui-icon ui-icon-disk">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-calendar">
				<span class="ui-icon ui-icon-calendar">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-zoomin">
				<span class="ui-icon ui-icon-zoomin">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-zoomout">
				<span class="ui-icon ui-icon-zoomout">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-search">
				<span class="ui-icon ui-icon-search">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-wrench">
				<span class="ui-icon ui-icon-wrench">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-gear">
				<span class="ui-icon ui-icon-gear">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-heart">
				<span class="ui-icon ui-icon-heart">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-star">
				<span class="ui-icon ui-icon-star">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-link">
				<span class="ui-icon ui-icon-link">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-cancel">
				<span class="ui-icon ui-icon-cancel">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-plus">
				<span class="ui-icon ui-icon-plus">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-plusthick">
				<span class="ui-icon ui-icon-plusthick">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-minus">
				<span class="ui-icon ui-icon-minus">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-minusthick">
				<span class="ui-icon ui-icon-minusthick">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-close">
				<span class="ui-icon ui-icon-close">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-closethick">
				<span class="ui-icon ui-icon-closethick">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-key">
				<span class="ui-icon ui-icon-key">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-lightbulb">
				<span class="ui-icon ui-icon-lightbulb">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-scissors">
				<span class="ui-icon ui-icon-scissors">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-clipboard">
				<span class="ui-icon ui-icon-clipboard">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-copy">
				<span class="ui-icon ui-icon-copy">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-contact">
				<span class="ui-icon ui-icon-contact">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-image">
				<span class="ui-icon ui-icon-image">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-video">
				<span class="ui-icon ui-icon-video">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-script">
				<span class="ui-icon ui-icon-script">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-alert">
				<span class="ui-icon ui-icon-alert">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-info">
				<span class="ui-icon ui-icon-info">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-notice">
				<span class="ui-icon ui-icon-notice">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-help">
				<span class="ui-icon ui-icon-help">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-check">
				<span class="ui-icon ui-icon-check">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-bullet">
				<span class="ui-icon ui-icon-bullet">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-radio-off">
				<span class="ui-icon ui-icon-radio-off">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-radio-on">
				<span class="ui-icon ui-icon-radio-on">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-pin-w">
				<span class="ui-icon ui-icon-pin-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-pin-s">
				<span class="ui-icon ui-icon-pin-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-play">
				<span class="ui-icon ui-icon-play">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-pause">
				<span class="ui-icon ui-icon-pause">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-seek-next">
				<span class="ui-icon ui-icon-seek-next">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-seek-prev">
				<span class="ui-icon ui-icon-seek-prev">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-seek-end">
				<span class="ui-icon ui-icon-seek-end">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-seek-first">
				<span class="ui-icon ui-icon-seek-first">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-stop">
				<span class="ui-icon ui-icon-stop">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-eject">
				<span class="ui-icon ui-icon-eject">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-volume-off">
				<span class="ui-icon ui-icon-volume-off">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-volume-on">
				<span class="ui-icon ui-icon-volume-on">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-power">
				<span class="ui-icon ui-icon-power">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-signal-diag">
				<span class="ui-icon ui-icon-signal-diag">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-signal">
				<span class="ui-icon ui-icon-signal">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-battery-0">
				<span class="ui-icon ui-icon-battery-0">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-battery-1">
				<span class="ui-icon ui-icon-battery-1">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-battery-2">
				<span class="ui-icon ui-icon-battery-2">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-battery-3">
				<span class="ui-icon ui-icon-battery-3">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-plus">
				<span class="ui-icon ui-icon-circle-plus">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-minus">
				<span class="ui-icon ui-icon-circle-minus">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-close">
				<span class="ui-icon ui-icon-circle-close">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-triangle-e">
				<span class="ui-icon ui-icon-circle-triangle-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-triangle-s">
				<span class="ui-icon ui-icon-circle-triangle-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-triangle-w">
				<span class="ui-icon ui-icon-circle-triangle-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-triangle-n">
				<span class="ui-icon ui-icon-circle-triangle-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-arrow-e">
				<span class="ui-icon ui-icon-circle-arrow-e">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-arrow-s">
				<span class="ui-icon ui-icon-circle-arrow-s">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-arrow-w">
				<span class="ui-icon ui-icon-circle-arrow-w">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-arrow-n">
				<span class="ui-icon ui-icon-circle-arrow-n">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-zoomin">
				<span class="ui-icon ui-icon-circle-zoomin">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-zoomout">
				<span class="ui-icon ui-icon-circle-zoomout">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circle-check">
				<span class="ui-icon ui-icon-circle-check">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circlesmall-plus">
				<span class="ui-icon ui-icon-circlesmall-plus">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circlesmall-minus">
				<span class="ui-icon ui-icon-circlesmall-minus">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-circlesmall-close">
				<span class="ui-icon ui-icon-circlesmall-close">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-squaresmall-plus">
				<span class="ui-icon ui-icon-squaresmall-plus">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-squaresmall-minus">
				<span class="ui-icon ui-icon-squaresmall-minus">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-squaresmall-close">
				<span class="ui-icon ui-icon-squaresmall-close">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-grip-dotted-vertical">
				<span class="ui-icon ui-icon-grip-dotted-vertical">
				</span>
			</li>
			
			<li class="ui-state-default ui-corner-all" title=".ui-icon-grip-dotted-horizontal">
				<span class="ui-icon ui-icon-grip-dotted-horizontal">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-grip-solid-vertical">
				<span class="ui-icon ui-icon-grip-solid-vertical">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-grip-solid-horizontal">
				<span class="ui-icon ui-icon-grip-solid-horizontal">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-gripsmall-diagonal-se">
				<span class="ui-icon ui-icon-gripsmall-diagonal-se">
				</span>
			</li>
			<li class="ui-state-default ui-corner-all" title=".ui-icon-grip-diagonal-se">
				<span class="ui-icon ui-icon-grip-diagonal-se">
				</span>
			</li>
		</ul>
	</div>
	<!-- /#compGroupA -->
	<div id="compGroupB" class="clearfix">
	
		<!-- Button -->
		<h2 class="demoHeaders">
			Button
		</h2>
		<button id="button">
			A button element
		</button>
		<form style="margin-top: 1em;">
			<div id="radioset">
				<input type="radio" id="radio1" name="radio"/>
				<label for="radio1">
					Choice 1
				</label>
				<input type="radio" id="radio2" name="radio" checked="checked"/>
				<label for="radio2">
					Choice 2
				</label>
				<input type="radio" id="radio3" name="radio"/>
				<label for="radio3">
					Choice 3
				</label>
			</div>
		</form>
		
		<!-- Autocomplete -->
		<h2 class="demoHeaders">
			Autocomplete
		</h2>
		<div>
			<input id="autocomplete" style="z-index: 100; position: relative" title="type &quot;a&quot;"/>
		</div>
		
		<!-- Slider -->
		<h2 class="demoHeaders">
			Slider
		</h2>
		<div id="slider">
		</div>
		
		<!-- Datepicker -->
		<h2 class="demoHeaders">
			Datepicker
		</h2>
		<div id="datepicker">
		</div>
		
		<!-- Progressbar -->
		<h2 class="demoHeaders">
			Progressbar
		</h2>
		<div id="progressbar">
		</div>
		
		<!-- Highlight / Error -->
		<h2 class="demoHeaders">
			Highlight / Error
		</h2>
		<div class="ui-widget">
			<div class="ui-state-highlight ui-corner-all" style="margin-top: 20px; padding: 0 .7em;">
				<p>
					<span class="ui-icon ui-icon-info" style="float: left; margin-right: .3em;">
					</span>
					<strong>
						Hey!
					</strong>
					Sample ui-state-highlight style.
				</p>
			</div>
		</div>
		<br/>
		<div class="ui-widget">
			<div class="ui-state-error ui-corner-all" style="padding: 0 .7em;">
				<p>
					<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;">
					</span>
					<strong>
						Alert:
					</strong>
					Sample ui-state-error style.
				</p>
			</div>
		</div>
	</div>
	<!-- /#compGroupB -->
</div>
<!-- /#components -->

<h3> jQuery portlets</h3>
<style>
	.column { width: 170px; float: left; padding-bottom: 100px; }
	.portlet { margin: 0 1em 1em 0; }
	.portlet-header { margin: 0.3em; padding-bottom: 4px; padding-left: 0.2em; }
	.portlet-header .ui-icon { float: right; }
	.portlet-content { padding: 0.4em; }
	.ui-sortable-placeholder { border: 1px dotted black; visibility: visible !important; height: 50px !important; }
	.ui-sortable-placeholder * { visibility: hidden; }
	</style>


<div style="width:560px">

<div class="column">

	<div class="portlet">
		<div class="portlet-header">Feeds</div>
		<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
	</div>
	
	<div class="portlet">
		<div class="portlet-header">News</div>
		<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
	</div>

</div>

<div class="column">

	<div class="portlet">
		<div class="portlet-header">Shopping</div>
		<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
	</div>

</div>

<div class="column">

	<div class="portlet">
		<div class="portlet-header">Links</div>
		<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
	</div>
	
	<div class="portlet">
		<div class="portlet-header">Images</div>
		<div class="portlet-content">Lorem ipsum dolor sit amet, consectetuer adipiscing elit</div>
	</div>

</div>

</div><!-- End demo -->

 <br style="clear:both">
 
 <h3>Resizable</h3>
<style>
	#resizable { width: 150px; height: 150px; padding: 0.5em; }
	#resizable h3 { text-align: center; margin: 0; }
	</style>
<div id="resizable" class="ui-widget-content">
	<h3 class="ui-widget-header">Grid</h3>
</div>



<h3>Google Maps</h3>
 <style type="text/css">
      #map_canvas { height: 100% }
    </style>
<div id="map_canvas" style="width:100%; height:100%"></div>


			<h2>jPlayer as a video player</h2>

			<p>In this demo jPlayer is combined with HTML and CSS to create a video player.</p>
			<p>You can easily customise the way it looks and make it fit your pages colours and style.</p>
			<p>This demo will use the HTML solution if it can, otherwise the Flash fallback solution will be used. The supplied media formats are WebMv, OGV and M4V.</p>
			<p>Press play to start the media.</p>


		<div id="jp_container_1" class="jp-video jp-video-360p">
			<div class="jp-type-single">
				<div id="jquery_jplayer_1" class="jp-jplayer"></div>
				<div class="jp-gui">
					<div class="jp-video-play">
						<a href="javascript:;" class="jp-video-play-icon" tabindex="1">play</a>
					</div>
					<div class="jp-interface">
						<div class="jp-progress">
							<div class="jp-seek-bar">
								<div class="jp-play-bar"></div>
							</div>
						</div>
						<div class="jp-current-time"></div>
						<div class="jp-duration"></div>
						<div class="jp-title">
							<ul>
								<li>Big Buck Bunny Trailer</li>
							</ul>
						</div>
						<div class="jp-controls-holder">
							<ul class="jp-controls">
								<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
								<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
								<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
								<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
								<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
								<li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
							</ul>
							<div class="jp-volume-bar">
								<div class="jp-volume-bar-value"></div>
							</div>

							<ul class="jp-toggles">
								<li><a href="javascript:;" class="jp-full-screen" tabindex="1" title="full screen">full screen</a></li>
								<li><a href="javascript:;" class="jp-restore-screen" tabindex="1" title="restore screen">restore screen</a></li>
								<li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
								<li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat off</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>

			<div id="jplayer_inspector"></div>


		<div id="jquery_jplayer_2" class="jp-jplayer"></div>

		<div id="jp_container_1" class="jp-audio">
			<div class="jp-type-single">
				<div class="jp-gui jp-interface">
					<ul class="jp-controls">
						<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
						<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
						<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
						<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
						<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
						<li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
					</ul>
					<div class="jp-progress">
						<div class="jp-seek-bar">
							<div class="jp-play-bar"></div>

						</div>
					</div>
					<div class="jp-volume-bar">
						<div class="jp-volume-bar-value"></div>
					</div>
					<div class="jp-current-time"></div>
					<div class="jp-duration"></div>
					<ul class="jp-toggles">
						<li><a href="javascript:;" class="jp-repeat" tabindex="1" title="repeat">repeat</a></li>
						<li><a href="javascript:;" class="jp-repeat-off" tabindex="1" title="repeat off">repeat off</a></li>
					</ul>
				</div>
				<div class="jp-title">
					<ul>
						<li>Cro Magnon Man</li>
					</ul>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>

	<div id="jplayer_inspector2"></div>

	
	
	
<h1>jquery Raty</h1>
	<div id="default-demo" class="session-first">Default options:</div>

			<div id="default"></div>

			<div class="source">
				$('#star').raty();<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div>

			<div id="fixed-demo" class="session">Started with a score and read only value:</div>
			<div id="fixed"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;readOnly: true,<br/>
				&nbsp;&nbsp;start:&nbsp;&nbsp;&nbsp;&nbsp;2<br/>
				});<br/><br/>
				
				&lt;div id="star"&gt;&lt;/div&gt;
			</div>

			<div id="start-demo" class="session">Starting with a callback:</div>
			<div id="start" data-rating="3"></div>

			<div class="source">
			 	$('#start').raty({<br/>
				&nbsp;&nbsp;start: function() {<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;return $(this).attr('data-rating');<br/>
				&nbsp;&nbsp;}<br/>
				});<br/><br/>

				&lt;div id="star" data-rating="3"&gt;&lt;/div&gt;
			</div>

			<div id="anyone-demo" class="session">A hint for no rated elements when it's read-only:</div>
			<div id="anyone"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;readOnly:&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;noRatedMsg: 'anyone rated this product yet!'<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div>

			<div id="number-demo" class="session">Custom score name and a number of stars:</div>
			<div id="number"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;scoreName: 'entity.score',<br/>
				&nbsp;&nbsp;number:&nbsp;&nbsp;&nbsp;&nbsp;10<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div>

			<div id="click-demo" class="session">Using click function:</div>
			<div id="click"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;click: function(score, evt) {<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;alert('ID: ' + $(this).attr('id') + '\nscore: ' + score + '\nevent: ' + evt);<br/>
				&nbsp;&nbsp;}<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				 - The argument score is the selected value;<br/>
				 - The argument evt is the click event;<br/>
				 - You can mension the star element (DOM) itself using 'this'.<br/>
			</span>

			<div id="cancel-demo" class="session">Default cancel button:</div>
			<div id="cancel"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;cancel: true<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				 - The score value for the click on cancel button is null.<br/>
			</span>

			<div id="cancel-custom-demo" class="session">Custom cancel button:</div>
			<div id="cancel-custom"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;cancel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;cancelHint:&nbsp;&nbsp;'remove my rating!',<br/>
				&nbsp;&nbsp;cancelPlace: 'right',<br/>
				&nbsp;&nbsp;click: function(score, evt) {<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;alert('score: ' + score);<br/>
				&nbsp;&nbsp;}<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div>

			<div id="half-demo" class="session">Half star voting:</div>
			<div id="half"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;half:&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;start: 3.3<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				- You can disable the 'halfShow' option to just vote with half star but not show it.<br/>
				- If 'halfShow' is disabled, then score &gt;= x.6 will be rounded up visually.<br/>
				- The interval can be:<br/>
				-- Rounded down: [x.00 .. x.25]<br/>
				-- Half star:&nbsp;&nbsp;&nbsp; [x.26 .. x.75]<br/>
				-- Rounded up:&nbsp;&nbsp; [x.76 .. x.99]
			</span>

			<div id="round-demo" class="session">Custom round option:</div>
			<div id="round"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;start: 1.26,<br/>
				&nbsp;&nbsp;round: { down: .25, full: .6, up: .76 }<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				- This example use the default round values;<br/>
				- down: with halfShow enabled, score &lt;= x.25 will be rounded down; (inclusive)<br/>
				- up: with halfShow enabled, score &gt;= x.76 will be rounded up; (inclusive)<br/>
				- down-up: with halfShow enabled, score &gt; x.25 and score &lt; .76 will be half star; (inclusive)<br/>
				- full: with halfShow disabled, score &gt;= x.6 will be rounded up; (inclusive)<br/>
			</span>

			<div id="icon-demo" class="session">Custom hint and icons:</div>
			<div id="icon"></div>

			<div class="source">
			 	$('#star').raty({<br/>
				&nbsp;&nbsp;hintList: ['a', '', null, 'd', '5'],<br/>
				&nbsp;&nbsp;starOn:&nbsp;&nbsp;&nbsp;'medal-on.png',<br/>
				&nbsp;&nbsp;starOff:&nbsp;&nbsp;'medal-off.png'<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				- To display the number of the star, set null.
			</span>

			<div id="range-demo" class="session">Range of custom icons:</div>
			<div id="range"></div>

			<div class="source">
			 	$('#star').raty({<br/>
			 	&nbsp;&nbsp;iconRange: [<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;{ range: 2, on: 'face-a.png', off: 'face-a-off.png' },<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;{ range: 3, on: 'face-b.png', off: 'face-b-off.png' },<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;{ range: 4, on: 'face-c.png', off: 'face-c-off.png' },<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;{ range: 5, on: 'face-d.png', off: 'face-d-off.png' }<br/>
				&nbsp;&nbsp;]
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				- It's a array of objects where each one represents a custom icon;<br/>
				- The value range is until wich position the icon will be displayed;<br/>
				- The value on is the active icon;<br/>
				- The value off is the inactive icon;<br/>
				- The sequence of the range interval should be in a ascending order;<br/>
				- If the value on or off is omitted then the attribute starOn or starOff will be used.
			</span>

			<div id="big-demo" class="session">Bigger icon:</div>
			<div id="big"></div>

			<div class="source">
			 	$('#star').raty({<br/>
			 	&nbsp;&nbsp;cancel:&nbsp;&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;cancelOff: 'cancel-off-big.png',<br/>
				&nbsp;&nbsp;cancelOn:&nbsp;&nbsp;'cancel-on-big.png',<br/>
				&nbsp;&nbsp;half:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;24,<br/>
				&nbsp;&nbsp;starHalf:&nbsp;&nbsp;'star-half-big.png',<br/>
				&nbsp;&nbsp;starOff:&nbsp;&nbsp;&nbsp;'star-off-big.png',<br/>
				&nbsp;&nbsp;starOn:&nbsp;&nbsp;&nbsp;&nbsp;'star-on-big.png'<br/>
				});<br/><br/>
			   
				&lt;div id="star"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				- You can specify your own width as following: width: 120.
			</span>

			<div id="group-demo" class="session">Group of elements:</div>
			<div class="group"></div>
			<div class="group"></div>
			<div class="group"></div>

			<div class="source">
				$('.star').raty();<br/><br/>
	
				&lt;div class="star"&gt;&lt;/div&gt;<br/>
				&lt;div class="star"&gt;&lt;/div&gt;<br/>
				&lt;div class="star"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				- The ID is optional and must be unique;<br/>
				- If you don't pass a ID for the element, then it will be created.
			</span>

			<div id="target-demo" class="session">Displaying hint in a target element:</div>

			<div id="target"></div>
			<div id="hint"></div><br/>

			<div class="source">
				$('#star').raty({<br/>
				&nbsp;&nbsp;cancel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;cancelHint: 'none',<br/>
				&nbsp;&nbsp;target:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'#hint'<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;<br/>
				&lt;div id="target"&gt;&lt;/div&gt;
			</div>

			<div id="target-number-demo" class="session">Displaying and keeping the score in a target element:</div>

			<div id="target-number"></div>

			<select id="score">
				<option value="">--</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
			</select>

			<div class="source left">
				$('#star').raty({<br/>
				&nbsp;&nbsp;cancel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;target:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'#score',<br/>
				&nbsp;&nbsp;targetKeep:&nbsp;true,<br/>
				&nbsp;&nbsp;targetType: 'number'<br/>
				});<br/><br/>

				&lt;select id="target"&gt;<br/>
					&nbsp;&nbsp;&lt;option value=""&gt;0&lt;/option&gt;<br/>
					&nbsp;&nbsp;&lt;option value="1"&gt;1&lt;/option&gt;<br/>
					&nbsp;&nbsp;&lt;option value="2"&gt;2&lt;/option&gt;<br/>
					&nbsp;&nbsp;&lt;option value="3"&gt;3&lt;/option&gt;<br/>
					&nbsp;&nbsp;&lt;option value="4"&gt;4&lt;/option&gt;<br/>
					&nbsp;&nbsp;&lt;option value="5"&gt;5&lt;/option&gt;<br/>
				&lt;/select&gt;<br/>
			</div><br/>

			<span class="comment">
				- You can to choose the target types 'hint' or 'number'.
			</span>

			<div id="target-out-demo" class="session">Setting default value to the target on mouseout:</div>

			<div id="target-out"></div>
			<div id="hint-out"></div><br/>

			<div class="source">
				$('#star').raty({<br/>
				&nbsp;&nbsp;cancel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;cancelHint: 'none',<br/>
				&nbsp;&nbsp;target:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'#hint'<br/>
				});<br/><br/>
	
				&lt;div id="star"&gt;&lt;/div&gt;<br/>
				&lt;div id="target"&gt;&lt;/div&gt;
			</div>

			<div id="format-demo" class="session">Displaying hint with format template:</div>

			<div id="format"></div>
			<div id="hint-format"></div><br/>

			<div class="source">
				$('#star').raty({<br/>
				&nbsp;&nbsp;cancel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;cancelHint:&nbsp;&nbsp;&nbsp;'Sure?',<br/>
				&nbsp;&nbsp;target:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'#hint',<br/>
				&nbsp;&nbsp;targetFormat: 'your score: {score}',<br/>
				&nbsp;&nbsp;targetText:&nbsp;&nbsp;&nbsp;'none',<br/>
				&nbsp;&nbsp;targetKeep:&nbsp;&nbsp;&nbsp;&nbsp;true<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;<br/>
				&lt;div id="target"&gt;&lt;/div&gt;
			</div>

			<div id="precision-demo" class="session">Half star voting precision:</div>

			<div id="precision"></div>
			<div id="precision-target"></div><br/>

			<div class="source" style="margin-top: 15px;">
				$('#star').raty({<br/>
				&nbsp;&nbsp;half:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;precision:&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;24,<br/>
				&nbsp;&nbsp;starHalf:&nbsp;&nbsp;&nbsp;'star-half-big.png',<br/>
				&nbsp;&nbsp;starOff:&nbsp;&nbsp;&nbsp;&nbsp;'star-off-big.png',<br/>
				&nbsp;&nbsp;starOn:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'star-on-big.png'<br/>
				&nbsp;&nbsp;target:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'#precision-target'<br/>
				&nbsp;&nbsp;targetType: 'number'<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;<br/>
				&lt;div id="target"&gt;&lt;/div&gt;
			</div>

			<div id="space-demo" class="session">Without space between stars:</div>

			<div id="space"></div>

			<div class="source">
				$('#star').raty({<br/>
				&nbsp;&nbsp;space: false<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;<br/>
			</div>

			<div id="single-demo" class="session">Single icon:</div>

			<div id="single"></div>

			<div class="source">
				$('#star').raty({<br/>
				&nbsp;&nbsp;single: true<br/>
				});<br/><br/>

				&lt;div id="star"&gt;&lt;/div&gt;<br/>
			</div>

			<div id="action-demo" class="session">Directed actions with public functions:</div>

			love:
			<div class="action"></div>

			happy:
			<div class="action"></div><br/>

			your last rate:
			<div id="result"></div>

			<div class="source">
				$('.star').raty({<br/>
				&nbsp;&nbsp;half:&nbsp;&nbsp;true,<br/>
				&nbsp;&nbsp;click: function(score, evt) {<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;$(this).raty('cancel');<br/>
				&nbsp;&nbsp;&nbsp;&nbsp;$('#result').raty('start', score);<br/>
				&nbsp;&nbsp;}<br/>
				});<br/><br/>

				&lt;div class="star"&gt;&lt;/div&gt;<br/>
				&lt;div class="star"&gt;&lt;/div&gt;<br/><br/>
				&lt;div id="result"&gt;&lt;/div&gt;
			</div><br/>

			<span class="comment">
				- All public functions have a optional second parameter to specify which container will be executed;<br/>
				- You can pass a ID or a class to be the target of the action;<br/>
				- If the ID or class are not specified, then the last element Raty will be takes.
			</span>

			<div id="function-demo" class="session">Public functions:</div>

			<div id="function"></div>
			<div id="hint-function"></div><br/>

			<div style="color: #CCC; margin-top: 15px;">
				<a href="javascript:void(0);" title="1" class="start">Start 1</a> |
				<a href="javascript:void(0);" title="2" class="start">Start 2</a> |
				<a href="javascript:void(0);" title="3" class="start">Start 3</a> |
				<a href="javascript:void(0);" title="4" class="start">Start 4</a> |
				<a href="javascript:void(0);" title="5" class="start">Start 5</a>
			</div>

			<div style="color: #CCC; margin-top: 15px;">
				<a href="javascript:void(0);" title="1" class="click">Click 1</a> |
				<a href="javascript:void(0);" title="2" class="click">Click 2</a> |
				<a href="javascript:void(0);" title="3" class="click">Click 3</a> |
				<a href="javascript:void(0);" title="4" class="click">Click 4</a> |
				<a href="javascript:void(0);" title="5" class="click">Click 5</a>
			</div>

			<div style="color: #CCC; margin-top: 15px;">
				<a href="javascript:void(0);" title="true" class="readOnly">ReadOnly (true)</a> |
				<a href="javascript:void(0);" title="false" class="readOnly">ReadOnly (false)</a>
			</div>

			<div style="color: #CCC; margin-top: 15px;">
				<a href="javascript:void(0);" title="false" class="cancel">Cancel</a> |
				<a href="javascript:void(0);" title="true" class="cancel">Cancel (trigger)</a>
			</div>

			<div id="global-demo" class="session">Changing the settings globally:</div>

			<div class="source">
				$.fn.raty.defaults.starOn = 'star-on.gif';<br/>
				$.fn.raty.defaults.starOff = 'star-off.gif';
			</div>

			<span class="comment">
				- You can change any option mention the scope <b>$.fn.raty.defaults.</b> + <i>option_name</i>;<br/>
				- This setup must be called before you bind the Raty, of course.
			</span>

			<div class="session">Default options:</div>

			<div class="source">
			 	cancel:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;false<br/>
			 	<div class="comment">If will be showed a button to cancel the rating.</div>

			 	cancelHint:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'cancel this rating!'<br/>
			 	<div class="comment">The hint information.</div>

			 	cancelOff:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'cancel-off.png'<br/>
			 	<div class="comment">Name of the cancel image off.</div>

			 	cancelOn:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'cancel-on.png'<br/>
			 	<div class="comment">Name of the cancel image on.</div>

			 	cancelPlace:&nbsp;&nbsp;&nbsp;&nbsp;'left'<br/>
			 	<div class="comment">Position of the cancel button.</div>

				click:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;undefined<br/>
			 	<div class="comment">Function that returns the selected value.</div>

				half:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;false<br/>
			 	<div class="comment">Enables half star selection.</div>

				halfShow:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true<br/>
			 	<div class="comment">Enables half star display.</div>

			 	hintList:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;['bad', 'poor', 'regular', 'good', 'gorgeous']<br/>
			 	<div class="comment">List of names that will be used as a hint on each star.</div>

				iconRange:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;undefined<br/>
				<div class="comment">List of object that represent each icon with position and names.</div>

				noRatedMsg:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'not rated yet'<br/>
			 	<div class="comment">A hint for no rated elements when it's read-only.</div>

				number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5<br/>
			 	<div class="comment">Number of stars that will be presented.</div>

				path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'img/'<br/>
			 	<div class="comment">A range of custom icons that you can set.</div>

				readOnly:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;false<br/>
			 	<div class="comment">If the stars will be read-only.</div>

				scoreName:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'score'<br/>
			 	<div class="comment">Name of the hidden field that holds the score value.</div>

				size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;16<br/>
			 	<div class="comment">The icons size.</div>

				starHalf:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'star-half.png'<br/>
			 	<div class="comment">The name of the half star image.</div>

				space:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;true<br/>
			 	<div class="comment">Option to take off the spaces between the star.</div>

				starOff:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'star-off.png'<br/>
			 	<div class="comment">Name of the star image off.</div>

				starOn:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'star-on.png'<br/>
			 	<div class="comment">Name of the star image on.</div>

				start:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0<br/>
				<div class="comment">Number of stars to be selected.</div>

				target:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;undefined<br/>
				<div class="comment">Number of stars to be selected.</div>

				targetKeep:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;false<br/>
				<div class="comment">If the last choose value will be keeped on mouseout.</div>

				targetText:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;''<br/>
				<div class="comment">Default value when there is no score or targetKeep is off.</div>

				targetType:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'hint'<br/>
				<div class="comment">What display on target element: hint or number.</div>

				width:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;undefined<br/>
				<div class="comment">The container width of the stars.</div>
			</div>

			<div class="session">Public functions:</div>

			<div class="source">$('#star').raty('start', 3);</div>
			<div class="description">Starts the last Raty with 3 stars.</div>

			<div class="source">$('#star').raty('click', 2);</div>
			<div class="description">Click on the second star of the Raty with ID called 'raty'.</div>

			<div class="source">$('.star').raty('readOnly', true);</div>
			<div class="description">Adjusts all Raty with class called 'raty' for read-only.</div>

			<div class="source">$('#star').raty('cancel', true);</div>
			<div class="description">Cancel the rating. The second optional parameter enable thes click callback.</div>

			<div class="source">$('#star').raty('score');</div>
			<div class="description">Recovers the current score. For class returns an array. No rated returns null.</div>
		</div>

		
<h3>jQueyr file upload</h3>
<a href="js/jQuery-File-Upload">example</a>