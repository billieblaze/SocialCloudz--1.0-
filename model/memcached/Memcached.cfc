<cfcomponent  extends="_base"  output="false">

	<!-----------
		This memcached client uses the java memcached client written by Dustin Sallings found at:
			http://bleu.west.spy.net/~dustin/projects/memcached/
		it also borrows from the javaloader project put together by mark mandel
			http://www.transfer-orm.com/?action=javaloader.index
		This project was also inspired by the previous memcached client put together by shayne sweeney
			http://memcached.riaforge.org/
		
		you can find this project at 
			http://cfmemcached.riaforge.org/
		And if you feel like visiting my personal blog (Jon Hirschi), it can be found at:
			http://www.flexablecoder.com
		Wow, that's a mouthful...  
		
	------------->

	<cfset variables.memcached = "">
	<cfset variables.timeUnit = "">
	<cfset variables.FutureTask = "">
	<cfset variables.transcoder = "">
	<cfset variables.addrUtil = "">
	
	<cffunction name="init" displayname="init" hint="init function" access="public" output="false" returntype="any">
		
		<cfargument name="servers" type="string" required="true" />
		<cfscript>
		
			// these lines to use if you don't want to use the java loader
			variables.addrUtil = createObject("java","net.spy.memcached.AddrUtil").init();
			variables.memcached = createObject("java","net.spy.memcached.MemcachedClient").init(addrUtil.getAddresses(arguments.servers));
			variables.timeUnit = createObject("java","java.util.concurrent.TimeUnit");
			
				
			variables.transcoder = variables.memcached.getTranscoder();
	
			/****************************
				some methods return a future object (especially asyncronous sets and gets)
				these let you check back in on the result.  they don't require that you wait around for 
				a response
				
				future object methods:
					Cancel() - returns a boolean - allows you to cancel the operation
					get( int, variables.timeunit ) - returns object - when an interger is sent in, you can 
							get the result in that amount of time.
					get() - returns an object - get the result when it is available.
					isCancelled() -  returns boolean - lets you know if the operation was cancelled
					isDone() - returns boolean - returns true when the operation has finished.
			
				Just a little caveat here.  keys are case sensitive, so make sure that you have the right case...
			*/
			super.init();
		</cfscript>
		<cfreturn this>
	</cffunction>

	<cffunction name="add" displayname="add" access="public" output="false" returntype="any"
			hint="Add an object to the cache iff it does not exist already. 
				Add an object to the cache iff it does not exist already. 
				The exp value is passed along to memcached exactly as given, and will be processed per 
				the memcached protocol specification: 

				The actual value sent may either be Unix time 
				(number of seconds since January 1, 1970, as a 32-bit value), 
				or a number of seconds starting from current time. 
				In the latter case, this number of seconds may not 
				exceed 60*60*24*30 (number of seconds in 30 days); 
				if the number sent by a client is larger than that, the server will consider it to be 
				real Unix time value rather than an offset from current time. 
				
				RETURNS: a future representing the processing of this operation

			" >
		<cfargument name="key" type="string" hint="a single key to add" required="true" />
		<cfargument name="value" type="any" hint="the value to set" required="true" />
		<cfargument name="expiry" type="numeric" hint="number of seconds until expire" default="0" required="true" />
		<cfscript>
			var futureTask = "";
			var ret = "";
			try {
				ret = variables.memcached.add(arguments.key, arguments.expiry, serialize(arguments.value) );
			} catch (Any e)	{
				// failing gracefully
			}
			futureTask = createObject("component","futuretask").init(ret);
		</cfscript>
		<cfreturn futureTask/>
	</cffunction>

	<cffunction name="asyncGet" access="public" output="false" returntype="Any"
		hint="Get the given key asynchronously. returns the future value of those keys
			what you get back wht you use this function is an object that has the future value
			of the key you asked to retrieve.  You can check at anytime to see if the value has been
			retrieved by using the  ret.isDone() method. once you get a true from that value, you 
			need to then call the ret.get() function.  
			">
		<cfargument name="key" type="string" hint="given a key, get the key asnycronously" required="true" />
		<cfscript>
			var ret = "";
			var futureTask ="";
			// gotta go through all this to catch the nulls.
			try	{
				ret = variables.memcached.asyncGet(arguments.key);
				// additional processing might be required.
			} catch(Any e)	{
				// failing gracefully
			}
			futureTask = createObject("component","futuretask").init(ret);
		</cfscript>
		<cfreturn futureTask/>
	</cffunction>

	<cffunction name="asyncGetBulk" access="public" output="false" returntype="any"
			hint="Asynchronously get a bunch of objects from the cache. returns the future value of those keys.  
				" >
		<cfargument name="keys" type="array" hint="given a struct of keys, get the keys asnycronously" required="true" />
		<cfscript>
			var ret = "";
			var futureTask = "";
			// gotta go through all this to catch the nulls.
			try	{
				ret = variables.memcached.asyncGetBulk(arguments.keys);
				// additional processing might be required.
			} catch(Any e)	{
				// catch is here to fail gracefully
			}
			futureTask = createObject("component","futuretask").init(ret);
		</cfscript>
		<cfreturn futureTask/>
	</cffunction>

	<cffunction name="decr" displayname="decr" access="public" output="false" returntype="Numeric"
			hint="Decrement the given key by the given value. returns the new value, or -1 if we were unable to decrement or add" >
		<cfargument name="key" type="string" hint="a single key to add" required="true" />
		<cfargument name="by" type="numeric" hint="amount to decrement by" default="0" required="false" />
		<cfargument name="value" type="numeric" hint="the value to set" required="false" default="0"/>
		<cfscript>
			var ret = -1;
			try {
				if ( structkeyExists(arguments,"value") )	{
					ret = variables.memcached.decr(arguments.key,arguments.by,arguments.value);
				} else {
					ret = variables.memcached.decr(arguments.key,arguments.by);
				}
			}  catch (Any e)	{
				// catch is here to fail gracefully
				ret = -1;
			}
		</cfscript>
		<cfreturn ret/>
	</cffunction>

	<cffunction name="delete" access="public" output="true" returntype="any"
		hint="Shortcut to delete that will immediately delete the item from the cache. 
			or in the delay specified. returns a future object that allows you to 
			check back on the processing further if you choose." >
		<cfargument name="deletekey" type="string" required="true" hint="the key to delete"/>
		<cfargument name="delay" type="numeric" required="false" default="0" hint="when to delete the key - time in seconds" />
		<cfscript>
			var ret = false;
			var futureTask = "";
			try 	{
				if (arguments.delay gt 0)	{
					ret = variables.memcached.delete(arguments.deletekey,arguments.delay);
				} else {
					ret = variables.memcached.delete(arguments.deletekey);
				}
			}  catch (Any e)	{
				// failing gracefully
				ret = "";
			}
			if (isdefined("ret"))	{
				futureTask = createobject("component","futuretask").init(ret);
			}  else {
				futureTask = createobject("component","futuretask").init();
			}
		</cfscript>
		<cfreturn futureTask/>
	</cffunction>

	<cffunction name="get" access="public" output="false" returntype="Any"
		hint=" Get with a single key.  waits for a return value" >
		<cfargument name="key" type="string" required="true" hint="given a key, get the key asnycronously" />
		<cfargument name="timeout" type="numeric" required="false" default="#variables.defaultRequestTimeout#" 
				hint="the number of milliseconds to wait until for the response.  
				a timeout setting of 0 will wait forever for a response from the server"/>
		<cfargument name="timeoutUnit" type="numeric" required="false" default="#variables.defaultTimeoutUnit#"
				hint="The timeout unit to use for the timeout"/>
		<cfscript>
			var ret = "";
			var futureTask = "";
			// gotta go through all this to catch the nulls.
			try 	{
				ret = variables.memcached.asyncGet(arguments.key);	
				if (not isdefined("ret") )	{
					ret = "";
				} else {
					futureTask = createObject("component","futuretask").init(ret);
					ret = futureTask.get(arguments.timeout,arguments.timeoutUnit);
				}
			} catch	(Any e) 	{
				// failing gracefully
			}
		</cfscript>
		<cfreturn ret/>
	</cffunction>

	<cffunction name="getBulk" access="public" output="false" returntype="any"
		hint="Get the values for multiple keys from the cache. waits for a return value" >
		<cfargument name="keys" type="array" hint="given a key, get the key asnycronously" required="true" />
		<cfargument name="timeout" type="numeric" required="false" default="#variables.defaultRequestTimeout#" 
				hint="the number of milliseconds to wait until for the response.  
				a timeout setting of 0 will wait forever for a response from the server"/>
		<cfargument name="timeoutUnit" type="numeric" required="false" default="#variables.defaultTimeoutUnit#"
				hint="The timeout unit to use for the timeout"/>
		<cfscript>
			var ret = "";
			var futureTask = "";
			// gotta go through all this to catch the nulls.
			try {
				ret = variables.memcached.asyncGetBulk(arguments.keys);
				if (not isdefined("ret") )	{
					ret = "";
				} else {
					futureTask = createObject("component","futuretask").init(ret);
					ret = futureTask.get(arguments.timeout,arguments.timeoutUnit);
				}
			}  catch (Any e)	{
				// failing gracefully
				ret = "";
			}
		</cfscript>
		<cfreturn ret/>
	</cffunction>

	<cffunction name="incr" access="public" output="false" returntype="Numeric"
		hint="Increment the given key by the given amount. returns -1 if string cannot be incremented">
		<cfargument name="key" type="string" hint="a single key to add" required="true" />
		<cfargument name="by" type="numeric" hint="amount to increment by" default="0" required="false" />
		<cfargument name="value" type="numeric" hint="the default value used if null" required="false"/>
		<cfscript>
			var ret = -1;
			
			try 	{
				if ( structkeyExists(arguments,"value") )	{
					ret = variables.memcached.incr(arguments.key,arguments.by,arguments.value);
				} else {
					ret = variables.memcached.incr(arguments.key,arguments.by);
				}
			} catch (Any e)	{
				// failing gracefully here
				ret = -1;
			}
		</cfscript>
		<cfreturn ret/>
	</cffunction>

	<cffunction name="doReplace" access="public" output="false" returntype="any"
		hint="Replace an object with the given value iff there is already a value for the given key.
			
			The exp value is passed along to memcached exactly as given, 
			and will be processed per the memcached protocol specification: 

			The actual value sent may either be Unix time (number of seconds since January 1, 1970, 
			as a 32-bit value), or a number of seconds starting from current time. 
			In the latter case, this number of seconds may not exceed 60*60*24*30 
			(number of seconds in 30 days); if the number sent by a client is larger than that, 
			the server will consider it to be real Unix time value rather than an offset from current time.
		
			RETURNS: a future representing the processing of the operation		
		" >
		<cfargument name="key" type="string" hint="a single key to add" required="true" />
		<cfargument name="value" type="any" hint="the value to set" required="true" />
		<cfargument name="expiry" type="numeric" hint="number of seconds until expire" default="0" required="true"/>
		<cfscript>
			var futureTask = "";
			var ret = "";
			try	{
				ret = variables.memcached.replace(arguments.key,arguments.expiry,serialize(arguments.value));
			} catch (Any e)	{
				// failing gracefully
				ret = "";
			}
			futureTask = createObject("component","futuretask").init(ret);
		</cfscript>
		<cfreturn futureTask/>
	</cffunction>

	<cffunction name="set" access="public" output="false" returntype="any"
		hint="Set an object in the cache regardless of any existing value.
			Set an object in the cache regardless of any existing value. 
			The exp value is passed along to memcached exactly as given, 
			and will be processed per the memcached protocol specification: 

			The actual value sent may either be Unix time (number of seconds since January 1, 1970, 
			as a 32-bit value), or a number of seconds starting from current time. 
			In the latter case, this number of seconds may not exceed 60*60*24*30 
			(number of seconds in 30 days); if the number sent by a client is larger than that, 
			the server will consider it to be real Unix time value rather than an offset from current time.
		
			RETURNS: a future Task representing the processing of the operation
		" >
		<cfargument name="key" type="string" hint="a single key to add" required="true" />
		<cfargument name="value" type="any" hint="the value to set" required="true" />
		<cfargument name="expiry" type="numeric" hint="number of seconds until expire" default="0" required="true"/>
		<cfscript>
			var futureTask = "";
			var ret = "";
			try 	{
				ret = variables.memcached.set(arguments.key,arguments.expiry,serialize(arguments.value));
			}  catch (Any e)	{
				// failing gracefully
				ret = "";
			}
			futureTask = createObject("component","futureTask").init(ret);
		</cfscript>
		<cfreturn futureTask/>
	</cffunction>

	<!------------------ public util functions ------------------>
	
	<cffunction name="concatArrayQueries" access="public" returntype="any" output="false"
		hint="this will return either full query or an empty string if no queries are found.
			in the case of sending in an array full of null values, it will return an empty string" >
		<cfargument name="arrQueries" required="true" type="array">
		<cfscript>
			var mainQuery = "";
			var arrColumns = "";
			var ColumnLength = "";
			var i = 1;
			var j = 1;
			var currentRow = 1;
			
			for (i=1;i lte arrayLen(arrQueries);i=i+1)	{
				if (isQuery(arrQueries[i]) and isQuery(mainQuery))	{
					currentRow = queryAddRow(mainQuery,1);
					for (j=1; j lte columnLength;j=j+1)	{
						mainQuery[arrColumns[j]][currentRow] = arrQueries[i][arrColumns[j]][1];
					}
				} else if ( isQuery(arrQueries[i]) )	{
					mainQuery = duplicate(arrQueries[i]);
					arrColumns = listToArray(mainQuery.columnList);
					ColumnLength = arrayLen(arrColumns);
				}
			}
		</cfscript>
		<cfreturn mainQuery>
	</cffunction>
	
	<cffunction name="concatStructQueries" access="public" returntype="any" output="false" 
		hint="this will return either full query or an empty string if no queries are found.
			in the case of sending in an array full of null values, it will return an empty string" >
		<cfargument name="structQueries" required="true" type="struct">
		<cfscript>
			var arrKeys = listtoarray(structKeyList(structQueries));
			var mainQuery = "";
			var arrColumns = "";
			var ColumnLength = "";
			var i = 1;
			var j = 1;
			var currentRow = 1;
			
			for (i=1;i lte arrayLen(arrKeys);i=i+1)	{
				if (isQuery(structQueries[arrKeys[i]]) and isQuery(mainQuery))	{
					currentRow = queryAddRow(mainQuery,1);
					for (j=1; j lte columnLength;j=j+1)	{
						mainQuery[arrColumns[j]][currentRow] = structQueries[arrKeys[i]][arrColumns[j]][1];
					}
				} else if ( isQuery(structQueries[arrKeys[i]]) )	{
					mainQuery = duplicate(structQueries[arrKeys[i]]);
					arrColumns = listToArray(mainQuery.columnList);
					ColumnLength = arrayLen(arrColumns);
				}
			}
		</cfscript>
		<cfreturn mainQuery>
	</cffunction>
	
	
	<cffunction name="concatQueries" access="public" output="false" returntype="query"
			hint="queries need to be exactly the same">
		<cfargument name="query1" type="query" required="true">
		<cfargument name="query2" type="query" required="true">
		<cfargument name="arrColumns" type="array" required="false" default="#listToArray(Query1.columnList)#">
		<cfscript>
			var i = 0;
			var j = 0;
			var columnLength = arrayLen(arrColumns);
			var currentRow = queryAddRow(query1,1);
			for (i=1; i lte query2.recordcount;i=i+1)	{
				for (j=1; j lte columnLength;j=j+1)	{
					query1[arrColumns[j]][currentRow] = query2[arrColumns[j]][i];
				}
			}
		</cfscript>
		<cfreturn query1>
	</cffunction>
	
	<cffunction name="createMemcachedKey" returnType="string" output="no" access="public" 
		hint="create a key from a struct of input arguments">
		<cfargument name="keyStruct" type="struct" required="true">
		<cfargument name="prefix" type="string" required="false" default="">	
		<cfset var cacheKey = "">
		<cfset var arrKeys = structkeyArray(arguments.keyStruct)>
		<cfset var i = 0>
		<cfset arraySort(arrKeys,"textnocase")>
		<cfloop from="1" to="#arrayLen(arrKeys)#" index="i">
			<cfset cacheKey = cacheKey.concat("#arrKeys[i]#=#arguments.keyStruct[arrKeys[i]]#")>
		</cfloop>
		<cfreturn arguments.prefix.concat(hash(cacheKey))>
	</cffunction>


	<!-------------------- admin functions ----------------------->

	<cffunction name="getTranscoder" access="public" output="false" returntype="Any"
			hint="Get the current transcoder that's in use." >
		<cfreturn variables.memcached.getTranscoder()/>
	</cffunction>

	<cffunction name="setTranscoder" access="public" output="false" returntype="void"
		hint="Set the transcoder for managing the cache representations of objects going in and out of the cache." >
		<cfargument name="transcoder" required="true" type="any" hint="Must be a transcoder object">
		<cfset variables.memcached.setTranscoder(arguments.transcoder)>
	</cffunction>

	<cffunction name="flush" access="public" output="false" returntype="any"
		hint="Flush all caches from all servers immediately or with a delay which is provided." >
		<cfargument name="delay" type="numeric" required="false" default="0" hint="Integer value - time in seconds to delay flushing cache">
		<cfscript>
			var ret = true;
			if (arguments.delay gt 0)	{
				ret = variables.memcached.flush(arguments.delay);
			} else {
				ret = variables.memcached.flush();
			}
		</cfscript>
		<cfreturn ret/>
	</cffunction>

	<cffunction name="run" access="public" output="true" returntype="void"
		hint="Infinitely loop processing IO. what can we use this for?" >
		<cfreturn variables.memcached.run()/>
	</cffunction>

	<cffunction name="shutdown" access="public" output="false" returntype="boolean"
		hint="Shut down this client.">
		<cfargument name="timeout" required="false" type="numeric" default="0" hint="Integer number of units which to wait for the queue to die down">
		<cfargument name="timeUnit" required="false" type="any" hint="a time unit object - java.util.concurrent.TimeUnit">
		<cfscript>
			var ret = true;
			if (arguments.timeout gt 0)	{
				ret = variables.memcached.shutdown(arguments.timeout,arguments.timeUnit);
			} else {
				ret = variables.memcached.shutdown();
			}
		</cfscript>
		<cfreturn ret/>
	</cffunction>

	<cffunction name="waitForQueues" access="public" output="false" returntype="boolean"
		hint="Wait for the queues to die down." >
		<cfargument name="timeout" required="true" type="numeric" default="0" hint="Integer number of units which to wait for the queue to die down">
		<cfargument name="timeUnit" required="true" type="any" default="#variables.timeUnit#" hint="a time unit object ">
		<cfscript>
			var ret = true;
			ret = variables.memcached.waitForQueues(arguments.timeout,arguments.timeUnit);
		</cfscript>
		<cfreturn ret/>
	</cffunction>

	<cffunction name="getVersions" access="public" output="false" returntype="struct"
		hint="Get the versions of all of the connected memcacheds. struct comes back as ">
		<!----------- there is a problem in here that if memcached is not running, this will hang 
			this is a known problem with the underlying java client - which should be addressed soon.
		------>
		<cfset var myVersions = variables.memcached.getVersions()>
		<cfset var ret = StructNew()>
		<cfif isdefined("myVersions")>
			<!------- checking isdefined here, just incase we get a java null back ---->
			<cfset ret = toStruct(myVersions)>
		</cfif>
		<cfreturn ret/>
	</cffunction>
	
	<cffunction name="getStats" access="public" output="false" returntype="any"
			hint="get all of the stats from all of the connections">
		<!----------- there is a problem in here that if memcached is not running, this will hang 
			this is a known problem with the underlying java client which should be addressed soon.
		------>
		<cfset var myStats = variables.memcached.getStats()>
		<cfset var ret = StructNew()>
		<cfif isdefined("myStats")>
			<!------- checking isdefined here, just incase we get a java null back ---->
			<cfset ret = toStruct(myStats)>
		</cfif>
		<cfreturn ret/>
	</cffunction>
	
	<cffunction name="stats" access="public" output="false" returntype="any"
			hint="get all of the stats from all of the connections">
		<!----------- there is a problem in here that if memcached is not running, this will hang 
			this is a known problem with the underlying java client which should be addressed soon.
		
			this function here for compatability with other memcached client.
		------>
		<cfreturn getStats()/>
	</cffunction>
	<!------------------ private util functions ------------------>
	
	<cffunction name="dateAddSeconds" access="private" output="false" returntype="date"
		hint="Converts a given number (seconds) to a future date-time.">
		<cfargument name="seconds" required="true" />
		<cfreturn DateAdd("s", arguments.seconds, Now()) />
	</cffunction>
			
	<cffunction name="toStruct" returntype="struct" access="private" output="false" hint="converts a java hashmap into a usable struct">
		<cfargument name="hashMap" type="Any" required="true"> 
		<!------- thanks to Ken Kolodziej for this snippet of code.  it works great! -------->
		<cfscript>
			var theStruct = structNew();
			var key = "";
			var newStructKey = ""; 
			var keys = arguments.hashMap.keySet();
			var iter = keys.Iterator();
			
			while(iter.HasNext()) {
				key = iter.Next();
				newStructKey = key.toString();
				theStruct[newStructKey] = arguments.hashMap.get(key);
			}
		</cfscript>
		<cfreturn theStruct>
	</cffunction>
</cfcomponent>