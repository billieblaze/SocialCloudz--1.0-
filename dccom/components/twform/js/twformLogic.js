twFormLogic = {
	init:function(){
		if( window.twformList == null ) return;
		for( var formNo=0;formNo<window.twformList.length;formNo++){
			var formId = window.twformList[ formNo ];
			var formChecks = eval("twFormChecks"+formId);
			
			//attach a handler to all referenced fields
			for( var checkFieldNo=0; checkFieldNo < formChecks.length; checkFieldNo++ ){
				for( var checkNo=0; checkNo < formChecks[ checkFieldNo ].checks.length; checkNo++ ){
					var check = formChecks[ checkFieldNo ].checks[checkNo];
					if( document.getElementById("twForm"+formId+"f"+check.field) ){
						Element.extend( document.getElementById("twForm"+formId+"f"+check.field) );
						Event.observe( document.getElementById("twForm"+formId+"f"+check.field), 'change', twFormLogic.updateView.bindAsEventListener( {formId:formId} ) );
					}
				}
			}
			twFormLogic.updateFormView( formId );
		}
	}
	,updateFormView:function(formId){
		var formChecks = eval("twFormChecks"+formId);
		
		//attach a handler to all referenced fields
		for( var checkFieldNo=0; checkFieldNo < formChecks.length; checkFieldNo++ ){
			var formCheck = formChecks[ checkFieldNo ];
			var result = ( formCheck.bool == "OR" )?false:true;
			for( var checkNo=0; checkNo < formCheck.checks.length; checkNo++ ){
				var check = formCheck.checks[checkNo];
				var field = document.getElementById("twForm"+formId+"f"+check.field);
				var fieldVal;
				var isMatch;
				if( field && field.selectedIndex != null ){
					fieldVal = field.options[ field.selectedIndex ].value;
					isMatch = (check.condition=="==")?( fieldVal == check.option ):( fieldVal != check.option );
				}
				if( formCheck.bool == "OR" ) { result = ( result | isMatch ); if( result ) checkNo = formCheck.checks.length+1; }
				else result = ( result & isMatch );
			}
			//we should have a result
			if( result ){
				document.getElementById("TWFormLI"+formCheck.target).style.display = ((formCheck.action=="Show")?"block":"none");
			}else{
				document.getElementById("TWFormLI"+formCheck.target).style.display = ((formCheck.action=="Show")?"none":"block");
			}
		}
	}
	,updateView:function(e){
		twFormLogic.updateFormView( this.formId );
	}
}


//onload - all browsers
if(typeof window.addEventListener != 'undefined') window.addEventListener('load', twFormLogic.init, false);
else if(typeof document.addEventListener != 'undefined') document.addEventListener('load', twFormLogic.init, false);
else if(typeof window.attachEvent != 'undefined') window.attachEvent('onload', twFormLogic.init);
else{if(typeof window.onload == 'function'){
var existing = onload;window.onload = function(){existing();twFormLogic.init();};}else{window.onload = twFormLogic.init;}}