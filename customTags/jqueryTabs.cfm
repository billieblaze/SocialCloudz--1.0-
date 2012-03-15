<!--- I take a configuration array of structs like so: 
		
		attributes.config[1].color 
		attributes.config[1].url 
		attributes.config[1].title
		
		
		and  build a jquery tabset.    
		possible colors are green, purple, blue and yellow
		
		You can add the class ajaxTabLink 
		to <A> tags to load them within the tabset.
	--->
	
<cfif thistag.executionmode EQ "start">

	
	<cfparam name="attributes.name" default="tabs">
	<cfparam name="attributes.config" default="arrayNew(2)">
	
<!--- 	<cfset attributes.name = attributes.name & '_#randRange(0,9999)#'> --->
<!--- 	
Include skin.css from common, your app should have it anyway, it's AWESOME
ALSO, load scripts.js from common as well
<style type="text/css">
	
	.loading{
			position:absolute;
			top:45%;
			left:45%;
			width:auto;
			z-index:101;
			padding:80px 40px 10px 40px;
			margin:5px;
			text-align:center;
			font-weight:bold;
			display:block;
			border:2px solid gray !important; 
			background-color: white;
			background-image: url(/common/images/updating3.gif) !important; 
			background-repeat: no-repeat !important; 
			background-position: 40px 10px !important; 
			color: black !important; }
			
	</style> --->

	<cfoutput>
		<script type="text/javascript">

	$(document).ready(function() { 
			
//	todo:	showLoading();
				
				$("###attributes.name#").tabs({
					<cfif isdefined('url.section')>
						
						<cfloop from="1" to="#arrayLen(attributes.config)#" index='i'>
							<cfif lcase(trim(url.section)) eq lcase(trim(attributes.config[i].title))>
								<cfset sectionIndex = i - 1>
							</cfif>
						</cfloop>
	
						selected: #sectionIndex#,
					</cfif>
			
					load: function(e, ui) {
						/* setup the ajaxTabLink class to intercept inner tab refreshes */
		            	$('a.ajaxTabLink', ui.panel).livequery('click', function() {
                 			//showLoading();
	                 		$(ui.panel).load(this.href+'/r/'+Math.random(),'',function(){
	                 		//	hideLoading();
	                 		});
						   
	                 		return false;
	             		});

					},
					select: function(e,ui){
					//todo:	showLoading();
					},
					
					ajaxOptions: {success: function(){
						//todo:					hideLoading();
														}
								 }
				});
	
	

		  });
		</script>
	
	
		<div id="#attributes.name#">
			<ul>
				<cfloop from="1" to="#arrayLen(attributes.config)#" index='i'>
					<li <!--- class="#attributes.config[i].color#" --->>
						<a href="#attributes.config[i].url#/r/#createUUID()#">
						#attributes.config[i].title#
						</a>
					</li>
				</cfloop>
			</ul>			
		</div>
		
	</cfoutput>

</cfif>
