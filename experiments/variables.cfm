<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Untitled Document</title>
</head>

<body>
	<!--- step 1 - Create 2 variables using cfset--->
	<cfset firstName = 'Kevin' />
	<cfset lastName = 'OBrien' />
	
	<!--- step 2 - Use cfoutput --->
	<cfoutput>
			<p>My first name is #firstName# and my lastName is #lastName#</p>
	</cfoutput>

	<!---Step 3 - experiment with typeless variables--->
	<cfset theNum = 10 />
	<cfset newNum = theNum + 5 />
	<cfoutput>
		<p>The new number is #newNum#</p>
	</cfoutput>
	
	<!---Step 4 - Copy /paste the above 3 lines below this comment--->
 	<!--- CF doesn't type juggle / coerce. So you can't add a string and a number'	
 
 	<cfset theNum = 'ten' />
	<cfset newNum = theNum + 5 />
	<cfoutput>
		<p>The new number is #newNum#</p>
	</cfoutput>--->

	<!---Step 5 - Experiment with the CGI scope--->
	<!---<cfdump var = "#cgi#" />--->
	
	<!---Step 6 - The server scope --->
	<cfdump var="#server#" />
	
</body>
</html>
