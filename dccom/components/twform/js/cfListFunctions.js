function listFind(c,n,d)
{
	if(arguments.length<3)d=",";
	var e = c.split(d);
	for(var i=0;i<c.length;i++) if( e[i]==n ) return i+1;
	return 0;
}
function listPrepend(c,n,d)
{
	if(arguments.length<3)d=",";
	return n+(c!=""?(d+c):"");
}
function listAppend(c,n,d)
{
	if(arguments.length<3)d=",";
	return (c!=""?(c+d):"")+n;
}
function listDeleteAt(c,p,d)
{
	if(arguments.length<3)d=",";
	var e = c.split(d);
	if(p<=e.length)
	{
		var n="";
		for(var i=0;i<p-1;i++) n=n+e[i]+d;
		for(var i=p;i<e.length;i++) n=n+e[i]+d;
		return (n.length<1 || n.charAt(n.length-1)!=d)?n:n.substring(0,n.length-1);
	}
	return c;
}
function listGetAt(c,p,d)
{
	if(arguments.length<3)d=",";
	var e = c.split(d);
	if( p >= 1 && p <= e.length )
	{
		return e[p-1];
	}
	alert("Out of range");
	return "";
}
function listSetAt(c,p,v,d)
{
	if(arguments.length<4) d=",";
	var e = c.split(d);
	if( p >= 1 && p <= e.length )
	{
		e[p-1] = v;//set the value
		//rebuild the string
		for( var i=0,c=""; i < e.length; i++ )
			c = (c!=""?(c+d):"")+e[i];
	}
	else alert("listSetAt: Index " + p + " is Out of range");
	return c;
}
function listInsertAt(c,p,v,d)
{
	if(arguments.length<4) d=",";
	var e = c.split(d);
	if( p >= 1 && p <= e.length+1 )
	{
		e.splice( p-1, 0, v );//insert the value
		//rebuild the string
		for( var i=0,c=""; i < e.length; i++ )
			c = (c!=""?(c+d):"")+e[i];
	}
	else alert("listSetAt: Index " + p + " is Out of range");
	return c;
}
function listLen(c,d)
{
	if( c == "" ) return 0;
	if(arguments.length<2)d=",";
	return c.split(d).length;
}