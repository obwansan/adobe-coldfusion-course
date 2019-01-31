<!---Get news years--->
<cfquery datasource="hdStreet-final" name="rsNewsYears">
	SELECT YEAR(FLD_NEWSCREATIONDATE) AS fld_newsYear
	FROM TBL_NEWS
	ORDER BY FLD_NEWSCREATIONDATE DESC
</cfquery>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>HD Street Concert Band - News</title>
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
    		<!--- If the url contains a newsID parameter --->
    		<cfif isDefined('url.newsID')>
    			<!--- Output a single news --->
    			<cfquery datasource="hdStreet" name="rsSingleNews">
    				SELECT TBL_NEWS.FLD_NEWSCONTENT, TBL_NEWS.FLD_NEWSTITLE, TBL_NEWS.FLD_NEWSCREATIONDATE, TBL_USERS.FLD_USERFIRSTNAME, TBL_USERS.FLD_USERLASTNAME
    				FROM TBL_NEWS INNER JOIN TBL_USERS ON TBL_NEWS.FLD_NEWSAUTHOR = TBL_USERS.FLD_USERID
    				WHERE FLD_NEWSID = #url.newsID#
    			</cfquery>
    			<cfoutput>
    				<h1>#rsSingleNews.FLD_NEWSTITLE#</h1>
    				<p class="metadata">Published on #dateFormat(rsSingleNews.FLD_NEWSCREATIONDATE, 'mmm dd yyyy')# by #rsSingleNews.FLD_USERFIRSTNAME# #rsSingleNews.FLD_USERLASTNAME#</p>
    				#rsSingleNews.FLD_NEWSCONTENT#
    			</cfoutput>
    		<cfelseif isDefined('url.year')>
    			<cfquery datasource="hdStreet" name="rsNewsOfYear">
    				SELECT FLD_NEWSTITLE, FLD_NEWSCREATIONDATE, FLD_NEWSID
    				FROM TBL_NEWS
    				WHERE year(FLD_NEWSCREATIONDATE) = #url.year#
    				ORDER BY FLD_NEWSCREATIONDATE DESC
    			</cfquery>
    			<h1> All the news of year <cfoutput>#url.year#</cfoutput></h1>
		      <table>
				<!---Output  news in a table--->
				<!--- Just adding query="rsAllNews" to <cfoutput> makes it loop over the record set returned by the query 
				and stored in rsAllNews --->
				<cfoutput query="rsNewsOfYear">
					<tr>
						<td>#dateFormat(FLD_NEWSCREATIONDATE, 'mmm dd yyyy')#</td>
						<td>#FLD_NEWSTITLE#</td>
						<td><a href="news.cfm?newsID=#FLD_NEWSID#">Read More</a></td>
					</tr>
				</cfoutput>
				
		      </table>
    		<cfelse>
	<!---Output all news if no url scope newsID not present in URL--->
	

	<!---Get all news--->
	<cfquery datasource="hdStreet-final" name="rsAllNews">
		SELECT FLD_NEWSTITLE, FLD_NEWSCREATIONDATE, FLD_NEWSID
		FROM TBL_NEWS
		ORDER BY FLD_NEWSCREATIONDATE DESC
	</cfquery>
	  <h1> News</h1>
      <table>
		<!---Output  news in a table--->
		<!--- Just adding query="rsAllNews" to <cfoutput> makes it loop over the record set returned by the query 
		and stored in rsAllNews --->
		<cfoutput query="rsAllNews">
			<tr>
				<td>#dateFormat(FLD_NEWSCREATIONDATE, 'mmm dd yyyy')#</td>
				<td>#FLD_NEWSTITLE#</td>
				<td><a href="news.cfm?newsID=#FLD_NEWSID#">Read More</a></td>
			</tr>
		</cfoutput>
		
      </table>
      </cfif>
</div>
	<!--- The cfoutput query attribute makes it loopover the SQL query result set. --->
	<!--- The cfoutput group attribute works like GROUP BY in SQL (e.g. groups what's output by year) --->
    <div id="calendarSideBar">
	<h1>News archive</h1>
	      <ul>
			<cfoutput query="rsNewsYears" group="fld_newsYear">
				<li><a href="news.cfm?year=#fld_newsYear#">#fld_newsYear#</a></li>
			</cfoutput>
	      </ul>
	      <p class="alignRight">&nbsp;</p>
	</div>
  </div>
  <div id="footer">
    <p>&copy; Copyright 2011 - HD Street Concert Band</p>
  </div>
</div>
</body>
</html>
