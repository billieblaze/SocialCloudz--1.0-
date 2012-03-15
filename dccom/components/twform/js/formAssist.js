function ensureInt(othis){if((window.event.keyCode<=57)&&(window.event.keyCode>=48)){window.event.returnValue=true;}else{window.event.returnValue=false;}}
function ensureFloat(othis){if((window.event.keyCode==46)||((window.event.keyCode<=57)&&(window.event.keyCode>=48))){window.event.returnValue=true;}else{window.event.returnValue=false;}}
function ensureIntOrComma(othis){if(((window.event.keyCode<=57)&&(window.event.keyCode>=48))||window.event.keyCode==44||window.event.keyCode==46){window.event.returnValue=true;}else{window.event.returnValue=false;}}
