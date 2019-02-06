<!--- Form processing script starts here --->

<!--- If the form has been submitted --->
<cfif structKeyExists(form, 'fld_newUserSubmit')>
	<!--- Server-side data validation --->
	<cfset aErrorMessages = Arraynew(1) />
	<!--- Validate first name --->
	<cfif form.fld_userFirstName EQ ''>
		<cfset arrayAppend(aErrorMessages, 'Please provide a valid first name')>
	</cfif>
	<!--- Validate last name --->
	<cfif form.fld_userLastName EQ ''>
		<cfset arrayAppend(aErrorMessages, 'Please provide a valid last name')>
	</cfif>
	<!--- Validate eMail --->
	<cfif form.fld_userEmail EQ '' OR NOT isValid('eMail', form.fld_userEmail)>
		<cfset arrayAppend(aErrorMessages, 'Please provide a valid eMail address')>
	</cfif>
	<!--- If no error detected --->
	<cfif ArrayisEmpty(aErrorMessages)>
		<!---Generate the missing data --->
		<cfset form.fld_userPassword = generateSecretKey("AES") />
		<cfset form.fld_userRole = 1 />
		<cfset form.fld_userApproved = 0 />
		<cfset form.fld_userIsActive = 0 />
		<!--- Insert data in database --->
		<cfquery datasource="hdstreet" >
			INSERT INTO TBL_USERS
			(FLD_USERFIRSTNAME, FLD_USERLASTNAME, FLD_USEREMAIL, FLD_USERPASSWORD, FLD_USERCOMMENT, FLD_USERAPPROVED, FLD_USERISACTIVE, FLD_USERROLE, FLD_USERINSTRUMENT)
			VALUES
			('#form.fld_userFirstName#', '#form.fld_userLastName#', '#form.fld_userEmail#', '#form.fld_userPassword#', '#form.fld_userComment#', #form.fld_userApproved#, #form.fld_userIsActive#, #form.fld_userRole#, #form.fld_userInstrument#)
		</cfquery>
		<cfset userIsInserted = true>
	</cfif>
</cfif>

<!---Get page content for fld_pageID = 4--->
<cfquery datasource="hdStreet-final" name="rsPage">
	SELECT FLD_PAGETITLE, FLD_PAGECONTENT
	FROM TBL_PAGES
	WHERE FLD_PAGEID = 4 AND FLD_PAGEISACTIVE = 1
</cfquery>

<!--- Get the instruments list to fill the drop down menu of the form --->
<cfquery datasource="hdstreet" name="rsInstruments">
	SELECT FLD_INSTRUMENTID, FLD_INSTRUMENTNAME
	FROM TBL_INSTRUMENTS
	ORDER BY FLD_INSTRUMENTNAME ASC
</cfquery>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>HD Street Concert Band - Come play with us</title>
<link href="/cfTraining/styles/hdStreet.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="/cfTraining/script/jquery.js"></script>
<script type="text/javascript" src="/cfTraining/script/menu.js"></script>
</head>

<body>
<div id="wrapper">
  <div id="header"> <a href="#"><img src="/cfTraining/images/logo.png" alt="logo" name="logo" width="188" height="181" id="logo" /></a>
    <p id="mainTitle"><img src="/cfTraining/images/mainTitle.png" width="398" height="158" alt="HD Street Concert Band" /><span>HD Street Concert Band</span></p>
<ul>
       	<li><a href="siteMap.html">Site Map</a></li>
        <li><a href="contactUs.html">Contact us</a></li>
    </ul>
  </div>
  <div id="menu">
    <ul>
      <li><a href="index.html">Home</a></li>
      <li><a href="agenda.html">Agenda</a></li>
      <li><a href="#">The Band</a>
        <ul>
          <li><a href="director.html">The director</a></li>
          <li><a href="history.html">The band History</a></li>
        </ul>
      </li>
      <li><a href="wePlayForYou.html">We play for You</a></li>
      <li><a href="comePlayWithUs.html">Come play with us</a></li>
      <li><a href="news.html">News</a></li>
    </ul>
  </div>
  <div id="pageBody">
  	<div id="calendarContent">
	<cfoutput>
		<h1>#rsPage.FLD_PAGETITLE#</h1>
		#rsPage.FLD_PAGECONTENT#
	</cfoutput>
	</div>
	<div id="calendarSideBar">
		<cfif isDefined('userIsInserted')>
			<h2>Thank you!</h2>
			<p>Your demand has been correctly submitted. You should hear from us very soon.</p>
			<p>Enjoy the music.</p>
			<p>The HD Street staff</p>
		<cfelse>
			<h2>Complete the form below to join our band</h2>
		<cfif isdefined('aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
			<cfoutput >
				<!--- index="message" seems to denote each array element by the term 'message', which can then be used to access / display each
				      array element (i.e. error message). --->
				<cfloop array="#aErrorMessages#" index="message">
					<p class="errorMessage">#message#</p>
				</cfloop>
			</cfoutput>
		</cfif>
		<!--- cfform uses post method by default and posts back to same file/page (so doesn't need a method or action attribute).
			  When rendered in the browser, <cfform> is turned into the html <form> and the method and post declared. --->
		<cfform id="frm_newUser">
				<fieldset>
					<legend>Join our band</legend>
					<dl>
						<dt><label>First Name</label></dt>
						<dd><cfinput type="text" name="fld_userFirstName" id="fld_userFirstName" required="true" message="Please enter a first name" /></dd>
						<dt><label>Last Name</label></dt>
						<dd><cfinput type="text" name="fld_userLastName" id="fld_userLastName" required="true" message="Please enter a last name" /></dd>
						<dt><label>E-mail Address</label></dt>
						<dd><cfinput  type="text" name="fld_userEmail" id="fld_userEmail" required="true" validate="eMail" message="Please enter a valid eMail address" /></dd>
						<dt><label>Instrument</label></dt>
						<dd>
							<!--- Assigning the query="rsInstruments" attribute to <cfselect> makes it iterate over the SQL query record set and assign the name and ID to each record. --->
							<cfselect name="fld_userInstrument" id="fld_userInstrument" query="rsInstruments" value="FLD_INSTRUMENTID" display="FLD_INSTRUMENTNAME" queryposition="below">
								<option value="0">Please choose your instrument</option>
							</cfselect>
						</dd>
						<dt><label>Comment</label></dt>
						<dd><textarea name="fld_userComment" id="fld_userComment"></textarea></dd>
					</dl>
					<input type="submit" name="fld_newUserSubmit" id="fld_newUserSubmit" value="Join the band" />
				</fieldset>
			</cfform>
		</cfif>
	</div>
	</div>
 </div>
  <div id="footer">
    <p>&copy; Copyright 2011 - HD Street Concert Band</p>
  </div>
</div>
</body>
</html>
