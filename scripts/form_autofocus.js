// form_autofocus.js
//
// To use, place this file within your Web site, and include the following in
// the <head> section of your document, with $PATH changed to the URL path
// (Web address, not internal path name) where you have installed this file:
//
//    <script type="text/javascript" src="/$PATH/form_autofocus.js"></script>
//
// This script will automatically move the input focus (the user's cursor) to
// what looks like the most reasonable place for it.  The script's order of
// preference for where it will move focus is:
//
//    1) Empty text, textarea, and password inputs
//    2) Text, textarea, and password inputs with text in them
//    3) File inputs
//    4) Select inputs (single or multiple)
//    5) Radio button and checkbox inputs
//
// Input focus is moved using the onload event, and so will occur when page
// load is complete.  If it appears that the user has interacted with the
// page -- if any form inputs are not in their default state, including
// hidden inputs -- focus will not be changed.  This is to avoid the annoying
// case where you've already started typing into a form input, but a script
// interferes with what you're doing.
//
// The script will select the first input it encounters (in the order they
// are reported by the browser, which is generally the order they were
// defined in) out of the most preferred type of input it finds.  Non-visible
// form elements are excluded from consideration entirely, since focus cannot
// be successfully moved to them.
//
// You can alter the script's behavior in four ways.
//
//   1) You can set the variable document.focusOverride to a form input
//      object; this will make the script focus on that input instead of one
//      it selects.
//   2) You can include the class 'nofocus' on inputs; this will make the
//      script skip them for purposes of selecting what to focus on.
//   3) You can include the class 'wantfocus' on inputs; the script will
//      preferentially select inputs with this class.  (If two inputs both
//      have 'wantfocus', the preference list above applies to them.)
//   4) You can include the class 'focusignore' on inputs.  This makes the
//      script ignore the input for purposes of determining whether the user
//      has interacted with the page.
//
// This script is known to work under IE 6, IE 7, Firefox 2, and Safari 3.
// This includes handling the case where a window is opened in a new tab that
// does not immediately receive window focus, which requires special treatment
// for some browsers.
//
// Official home: http://lostsouls.org/grimoire_form_autofocus.  Any updates
// will be found there.
//
// v1.0   2007-09-24, Chaos of Lost Souls MUD, http://lostsouls.org/
// v1.1   2007-10-05, Chaos: refactoring, cleanup, unload on completion
// v1.1.1 2007-12-25, Chaos: don't break if a form element has no classname
// v1.2   2008-06-03, Chaos: detecting and handling non-visible form elements
// v1.2.1 2008-07-02, Chaos: fixed logic error on multiple select boxes
//
// This code is released into the public domain.

// This information is provided AS IS and any express or implied warranties,
// including, but not limited to, the implied warranties of merchantability
// and fitness for a particular purpose are disclaimed. In no event shall the
// author or publisher be liable for any damages of any kind, however caused
// and on any theory of liability, arising in any way out of the use of this
// information, even if advised of the possibility of such damage.

if(window) {
    var formAutoFocus = function() {
        var focusTarget;
        var focusFlag;
        var focusDone = function() {
            focusFlag = true;
        }
        var attachFocus = function() {
            if(focusTarget.attachEvent) {
                focusTarget.attachEvent('onfocus', focusDone);
            } else {
                focusTarget.prevOnFocus = focusTarget.onfocus;
                if(focusTarget.prevOnFocus) {
                    var dualFocus = function() {
                        focusTarget.prevOnFocus();
                        focusDone();
                    }
                    focusTarget.onfocus = dualFocus;
                } else {
                    focusTarget.onfocus = focusDone;
                }
            }
        }
        var detachFocus = function() {
            if(focusTarget.attachEvent) {
                focusTarget.detachEvent('onfocus', focusDone);
            } else {
                focusTarget.onfocus = focusTarget.prevOnFocus;
                focusTarget.prevOnFocus = null;
            }
        }
        var checkFocus = function() {
            detachFocus();
            if(focusFlag)
                window.formAutoFocus = null;
            else
                window.setTimeout(formAutoFocus, 50);
        }
        var tryFocus = function(obj) {
            focusTarget = obj;
            focusFlag = false;
            attachFocus();
            try {
                focusTarget.focus();
            } catch(error) {
                return;
            }
            if(focusFlag) {
                detachFocus();
                formAutoFocus = null;
                return;
            }
            window.setTimeout(checkFocus, 10);
        }
        var skip = function(obj) {
            return elem.classname && elem.classname.match(/\bfocusignore\b/);
        }
        if(document.focusOverride) {
            tryFocus(document.focusOverride);
            return;
        }
        var tiers = new Array;
        for(var i = 0; i < document.forms.length; i++) {
            var form = document.forms[i];
            for(var j = 0; j < form.elements.length; j++) {
                var elem = form.elements[j];
                if(!elem.focus)
                    continue;
                if(!elem.offsetWidth)
                    continue;
                var tier;
                switch(elem.type) {
                case 'text'           :
//                case 'textarea'       :
                case 'password'       :
                    if(elem.value != elem.defaultValue && !skip(elem))
                        return;
                    tier = elem.value ? 1 : 0;
                    break;
                case 'file'           :
                    if(elem.value != elem.defaultValue && !skip(elem))
                        return;
                    tier = 2;
                    break;
                case 'select-one'     :
                    if(!skip(elem)) {
                        var anyDefault = false;
                        for(var k = 0; k < elem.options.length; k++) {
                            if(elem.options[k].defaultSelected) {
                                anyDefault = true;
                                break;
                            }
                        }
                        if(anyDefault) {
                            for(var k = 0; k < elem.options.length; k++) {
                                var opt = elem.options[k];
                                if(opt.selected != opt.defaultSelected)
                                    return;
                            }
                        } else {
                            if(elem.selectedIndex != 0)
                                return;
                        }
                    }
                    tier = 3;
                    break;
                case 'select-multiple':
                    if(!skip(elem)) {
                        for(var k = 0; k < elem.options.length; k++) {
                            var opt = elem.options[k];
                            if(opt.selected != opt.defaultSelected)
                                return;
                        }
                    }
                    tier = 3;
                    break;
                case 'radio'          :
                case 'checkbox'       :
                    if(elem.selected != elem.defaultSelected && !skip(elem))
                        return;
                    tier = 4;
                    break;
                case 'hidden'         :
                    if(elem.value != elem.defaultValue && !skip(elem))
                        return;
                    continue;
                default               :
                    continue;
                }
                if(!tiers[0] && !elem.className.match(/\bnofocus\b/)) {
                    var wantfocus = elem.className.match(/\bwantfocus\b/);
                    if(!wantfocus)
                        tier += 5;
                    if(!tiers[tier])
                        tiers[tier] = elem;
                }
            }
        }
        for(var ix = 0; ix < tiers.length; ix++) {
            if(tiers[ix]) {
                tryFocus(tiers[ix]);
                break;
            }
        }
    }
    if(window.attachEvent) {
        window.attachEvent('onload', formAutoFocus);
    } else {
        if(window.onload) {
            var curronload = window.onload;
            var newonload = function() {
                curronload();
                formAutoFocus();
            };
            window.onload = newonload;
        } else {
            window.onload = formAutoFocus;
        }
    }
}
