/*
Copyright (c) 2009, Yahoo! Inc. All rights reserved.
Code licensed under the BSD License:
http://developer.yahoo.net/yui/license.txt
version: 3.0.0b1
build: 1163
*/
YUI.add("io-base",function(D){var f="io:start",R="io:complete",B="io:success",H="io:failure",h="io:end",a=0,Q={"X-Requested-With":"XMLHttpRequest"},b={},M=D.config.win;function d(j,q){var i,k,q=q||{},n=Z((arguments.length===3)?arguments[2]:null,q),Y=(q.method)?q.method.toUpperCase():"GET",l=(q.data)?q.data:null;n.abort=function(){q.xdr?n.c.abort(n.id,q):P(n,"abort");};n.isInProgress=function(){var m=(q.xdr)?g(n):(n.c.readyState!==4&&n.c.readyState!==0);return m;};if(q.form){if(q.form.upload){i=D.io._upload(n,j,q);return i;}k=D.io._serialize(q.form);if(l){k+="&"+l;}if(Y==="POST"){l=k;X("Content-Type","application/x-www-form-urlencoded");}else{if(Y==="GET"){j=S(j,k);}}}else{if(l&&Y==="POST"){X("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");}}if(q.xdr){D.io._xdr(j,n,q);return n;}if(q.timeout){T(n,q.timeout);}n.c.onreadystatechange=function(){e(n,q);};try{E(n.c,Y,j);}catch(p){}C(n.c,(q.headers||{}));W(n,(l||""),q);return n;}function A(i,j){var Y=new D.EventTarget().publish("transaction:"+i);Y.subscribe(j.on[i],(j.context||this),j.arguments);return Y;}function U(l,k){var Y=D.io._fn||{},i=(Y&&Y[l])?Y[l]:null,j;k.on=k.on||{};if(i){k.on.start=i.start;}D.fire(f,l);if(k.on.start){j=A("start",k);j.fire(l);}}function I(j,k){var i,Y;k.on=k.on||{};i=(j.status)?G(j.status):j.c;D.fire(R,j.id,i);if(k.on.complete){Y=A("complete",k);Y.fire(j.id,i);}}function V(k,l){var Y=D.io._fn||{},i=(Y&&Y[k.id])?Y[k.id]:null,j;l.on=l.on||{};if(i){l.on.success=i.success;k.c.responseText=decodeURI(k.c.responseText);}D.fire(B,k.id,k.c);if(l.on.success){j=A("success",l);j.fire(k.id,k.c);}L(k,l);}function K(l,n){var Y=D.io._fn||{},i=(Y&&Y[l.id])?Y[l.id]:null,k,j;n.on=n.on||{};if(i){n.on.failure=i.failure;l.c.responseText=decodeURI(l.c.responseText);}k=(l.status)?G(l.status):l.c;D.fire(H,l.id,k);if(n.on.failure){j=A("failure",n);j.fire(l.id,k);}L(l,n);}function L(k,l){var Y=D.io._fn||{},i=(Y&&Y[k.id])?Y[k.id]:null,j;l.on=l.on||{};if(i){l.on.end=i.end;delete Y[k.id];}D.fire(h,k.id);if(l.on.end){j=A("end",l);j.fire(k.id);}J(k,(l.xdr)?true:false);}function P(i,Y){if(i&&i.c){i.status=Y;i.c.abort();}}function g(Y){return Y.c.isInProgress(Y.id);}function G(Y){return{status:0,statusText:Y};}function F(){var Y=a;a++;return Y;}function Z(Y,k){var j={};j.id=D.Lang.isNumber(Y)?Y:F();if(k.xdr){j.c=D.io._transport[k.xdr.use];}else{if(k.form&&k.form.upload){j.c={};}else{j.c=N();}}return j;}function N(){return(M.XMLHttpRequest)?new XMLHttpRequest():new ActiveXObject("Microsoft.XMLHTTP");}function S(Y,i){Y+=((Y.indexOf("?")==-1)?"?":"&")+i;return Y;}function X(Y,i){if(i){Q[Y]=i;}else{delete Q[Y];}}function C(j,Y){var i;for(i in Q){if(Q.hasOwnProperty(i)){if(Y[i]){break;}else{Y[i]=Q[i];}}}for(i in Y){if(Y.hasOwnProperty(i)){j.setRequestHeader(i,Y[i]);}}}function E(j,Y,i){j.open(Y,i,true);}function W(i,Y,j){i.c.send(Y);U(i.id,j);}function T(i,Y){b[i.id]=M.setTimeout(function(){P(i,"timeout");},Y);}function O(Y){M.clearTimeout(b[Y]);delete b[Y];}function e(Y,i){if(Y.c.readyState===4){if(i.timeout){O(Y.id);}M.setTimeout(function(){I(Y,i);c(Y,i);},0);}}function c(j,k){var Y;try{if(j.c.status&&j.c.status!==0){Y=j.c.status;}else{Y=0;}}catch(i){Y=0;}if(Y>=200&&Y<300||Y===1223){V(j,k);}else{K(j,k);}}function J(i,Y){if(M.XMLHttpRequest&&!Y){if(i.c){i.c.onreadystatechange=null;}}i.c=null;i=null;}d.start=U;d.complete=I;d.success=V;d.failure=K;d.isInProgress=g;d._id=F;d.header=X;D.io=d;D.io.http=d;},"3.0.0b1");YUI.add("io-form",function(A){A.mix(A.io,{_serialize:function(D){var I=encodeURIComponent,H=[],M=D.useDisabled||false,P=0,K,J,E,N,L,G,C,F,O,D,B=(typeof D.id==="string")?D.id:D.id.getAttribute("id");if(!B){B=A.guid("io:");D.id.setAttribute("id",B);}J=A.config.doc.getElementById(B);for(G=0,C=J.elements.length;G<C;++G){K=J.elements[G];L=K.disabled;E=K.name;if((M)?E:(E&&!L)){E=encodeURIComponent(E)+"=";N=encodeURIComponent(K.value);switch(K.type){case"select-one":if(K.selectedIndex>-1){D=K.options[K.selectedIndex];H[P++]=E+I((D.attributes.value&&D.attributes.value.specified)?D.value:D.text);}break;case"select-multiple":if(K.selectedIndex>-1){for(F=K.selectedIndex,O=K.options.length;F<O;++F){D=K.options[F];if(D.selected){H[P++]=E+I((D.attributes.value&&D.attributes.value.specified)?D.value:D.text);}}}break;case"radio":case"checkbox":if(K.checked){H[P++]=E+N;}break;case"file":case undefined:case"reset":case"button":break;case"submit":default:H[P++]=E+N;}}}return H.join("&");}},true);},"3.0.0b1",{requires:["io-base"]});YUI.add("io-xdr",function(C){var A="io:xdrReady";function B(E,F){var D='<object id="yuiIoSwf" type="application/x-shockwave-flash" data="'+E+'" width="0" height="0">'+'<param name="movie" value="'+E+'">'+'<param name="FlashVars" value="yid='+F+'">'+'<param name="allowScriptAccess" value="sameDomain">'+"</object>";C.get("body").appendChild(C.Node.create(D));}C.mix(C.io,{_transport:{},_fn:{},_xdr:function(D,E,F){if(F.on){this._fn[E.id]=F.on;}E.c.send(D,F,E.id);return E;},xdrReady:function(D){C.fire(A,D);},transport:function(D){switch(D.id){case"flash":B(D.src,D.yid);this._transport.flash=C.config.doc.getElementById("yuiIoSwf");break;}}});},"3.0.0b1",{requires:["io-base"]});YUI.add("io-upload-iframe",function(B){var H=B.config.win;function D(K,N){var M=[],L,J;for(L in N){if(N.hasOwnProperty(N,L)){M[J]=document.createElement("input");M[J].type="hidden";M[J].name=L;M[J].value=N[L].f.appendChild(M[J]);}}return M;}function E(L,M){var K,J;if(M&&M.length>0){for(K=0,J=M.length;K<J;K++){L.removeChild(M[K]);}}}function I(L,M){var K=B.Node.create('<iframe id="ioupload'+L.id+'" name="ioupload'+L.id+'" />'),J={position:"absolute",top:"-1000px",left:"-1000px"};K.setStyles(J);B.get("body").appendChild(K);B.on("load",function(){A(L,M);},"#ioupload"+L.id);}function A(L,M){var K,J=B.get("#ioupload"+L.id).get("contentWindow.document.body");if(M.timeout){G(L.id);}K=J.query("pre:first-child");L.c.responseText=(K)?K.get("innerHTML"):J.get("innerHTML");B.io.complete(L,M);setTimeout(function(){F(L.id);},0);}function C(J,K){B.io._timeout[J.id]=H.setTimeout(function(){B.io.abort(J,K);
},K.timeout);}function G(J){H.clearTimeout(B.io._timeout[J]);delete B.io._timeout[J];}function F(J){B.Event.purgeElement("#ioupload"+J,false);B.get("body").removeChild(B.get("#ioupload"+J));}B.mix(B.io,{_upload:function(K,L,R){var O=(typeof R.form.id==="string")?document.getElementById(R.form.id):R.form.id,Q,N,M,J,P;I(K,R);P={action:O.getAttribute("action"),target:O.getAttribute("target")};O.setAttribute("action",L);O.setAttribute("method","POST");O.setAttribute("target","ioupload"+K.id);O.setAttribute((B.UA.ie&&!document.documentMode)?"encoding":"enctype","multipart/form-data");if(R.data){N=D(O,R.data);}if(R.timeout){C(K,R);}O.submit();B.io.start(K.id,R);if(R.data){E(O,N);}for(J in P){if(P.hasOwnProperty(P,J)){if(P[J]){O.setAttribute(J,O[prop]);}else{O.removeAttribute(J);}}}}});},"3.0.0b1",{requires:["io-base"]});YUI.add("io-queue",function(B){var A=new B.Queue(),I,G,M=1;function J(N,P){var O={uri:N,id:B.io._id(),cfg:P};A.add(O);if(M===1){F();}return O;}function F(){var N=A.next();G=N.id;M=0;B.io(N.uri,N.cfg,N.id);}function D(N){A.promote(N);}function C(N){M=1;if(G===N&&A.size()>0){F();}}function L(N){A.remove(N);}function E(){M=1;if(A.size()>0){F();}}function H(){M=0;}function K(){return A.size();}I=B.on("io:complete",function(N){C(N);},B.io);J.size=K;J.start=E;J.stop=H;J.promote=D;J.remove=L;B.mix(B.io,{queue:J},true);},"3.0.0b1",{requires:["io-base"]});YUI.add("io",function(A){},"3.0.0b1",{use:["io-base","io-form","io-xdr","io-upload-iframe","io-queue"]});