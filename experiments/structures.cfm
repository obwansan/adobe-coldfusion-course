<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Untitled Document</title>
</head>

<body>
	<!---Step 1 - Create a structure using the structNew() function--->
	<cfset stUser = structNew() />
	<cfset stUser.firstName = 'Bobs' />
	<cfset stUser.lastName = 'Obwan' />
	<cfset stUser.age = 41 />
	<p>Dumping the explicit Structure</p>
	<cfdump var = "#stUser#" label = "Explicit Structure">
	
	<!---Step 2 - Create the same structure using implicit notation--->
	<cfset stUserImplicit = {firstName = 'Bobs', lastName = 'Obwan', age = 41} />
	
	<p>Dumping the implicit structure</p>
	<cfdump var = "#stUserImplicit#" label = "Implicit Structure">
	
	<!---Step 3 - use structDelete() --->
	<!--- Use ctrl + space to bring up list of structs --->
	<cfset structDelete(stUserImplicit, 'age') />
	
	<p>Dumping stUser after the deletion of the 'age' key'</p>
	<cfdump var="#stUserImplicit#" label = "Explicit structure after deletion" >
	
	<!---Step 4 - use structClear() --->
	<cfset structClear(stUserImplicit) />
	
	<p>Dumping stUser after using structClear()</p>
	<cfdump var="#stUserImplicit#" label = "Explicit Structure after structClear" >
	
	<!---Step 5 - use structCount()--->
	<!---	
	<cfset stCount = structCount(stUser) />
	<p>stUserImplicit holds <cfdump  var="#stCount#"/> elements</p>
	--->
	<p>stUserImplicit holds <cfoutput>#structCount(stUser)#</cfoutput> elements</p>
	
	
</body>
</html>
