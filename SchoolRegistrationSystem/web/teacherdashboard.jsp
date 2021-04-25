<%--Christopher Evers  --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
	<% String usertype = (String)request.getSession().getAttribute("LogedInType");
	   if(usertype != "teacher"){
		   session.invalidate();
		   response.sendRedirect("AccessDenied.jsp");
	   }
	%>
<!DOCTYPE html>
 <head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <link href="css/teacherdashboard.css" rel="stylesheet">
  <script src="js/teacherdashboard.js"></script>
  <style>li {cursor: pointer;}a:hover { background-color: #90ee90; transition: 0.1s;}</style>
  <script src ="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src ="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <title>
  		Teacher Dashboard
  	</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
  <script src ="js/teacherdashboard.js"></script>
  </head>
 <body>
 <div class="container">
		<div class="d-flex justify-content-center">
			<h1>
				<span class="badge rounded-pill bg-success">Teacher</span>
				<span class="badge rounded-pill bg-warning text-dark">Dashboard</span> 	
			 </h1> 
		 </div>
   </div>
 <div class="row align-top">
<div class="row col-2">
				<ul class ="nav bg-light navbar-nav" style="padding-right:0;">
					<a class ="nav-item" onclick="openPage('Student', this)"><li class ="nav-item">
					Student
					</li></a>
					<a onclick="openPage('Grades', this)"><li class ="nav-item">
					Grades
					</li></a>
					<a onclick="openPage('Classes', this)"><li class ="nav-item">
					Classes
					</li></a>
					<a href="./"><li class ="nav-item">
					Log Out
					</li></a>
				</ul>
	</div>

	<div id="Grades" class="tabcontent col-10">
	<div class="row">
				<p class="col-1">Student Id</p>
				<p class="col-2">Student Name</p>
				<p class="col-1 mx-1">Class</p>
				<p class="col-1 mx-1">Homework</p>
				<p class="col-1 mx-1">Test</p>
				<p class="col-2 mx-1">Event Name</p>
				<p class="col-1 mx-1">Grades</p>
				</div>
<jsp:useBean id="grades" class="com.SchoolRegistrationSystem.teacherServlet"/>  
		<%
           	try {
           	ResultSet rs;
           	rs = grades.getGrades();
            while (rs.next())
            {
            	out.println("<div class=\"row\">");
            	out.println("<form method=\"post\" action=\"gradeupdate\" class=\"inline\">");
            	out.println("<input type=\"text\" readonly name=\"eventid\" value="+rs.getString("EventId")+" style=\"display: none;\">");
            	out.println("<input type=\"text\" readonly name=\"classid\" value="+rs.getString("ClassId")+" style=\"display: none;\">");
            	out.println("<input type=\"text\"  name=\"studentid\" value="+rs.getString("StudentId")+" class=\"col-1 mx-1\">");
            	out.println("<p class=\"col-2\">"+rs.getString("FirstName") + " " + rs.getString("LastName")+ "</p>");
            	out.println("<input type=\"text\"  name=\"class\" value="+rs.getString("ClassName")+" class=\"col-1 mx-1\">");
            	out.println("<input type=\"text\"  name=\"homework\" value="+rs.getString("Homework")+" class=\"col-1 mx-1\">");
            	out.println("<input type=\"text\"  name=\"test\" value="+rs.getString("Test")+" class=\"col-1 mx-1\">");
            	out.println("<input type=\"text\"  name=\"eventname\" value="+rs.getString("EventName")+" class=\"col-2 mx-1\">");
            	out.println("<input type=\"text\"  name=\"grades\" value="+rs.getString("Grades")+" class=\"col-1 mx-1\">");
            	out.println("<input name=\"delete\" type=\"submit\" value=\"Delete\" class=\"col-1 mx-1\">");
            	out.println("<input name=\"update\"type=\"submit\" value=\"Update\" class=\"col-1 mx-1\">");
            	out.println("</form>");
            	out.println("</div>");
            };
  	  		} catch (Exception e) {
  	  			System.out.println(e.toString());
  	  		}
           	%> 
	<br>
	<jsp:useBean id="student" class="com.SchoolRegistrationSystem.teacherServlet" scope="request">  
           	</jsp:useBean>
           		<div class="row">
				<p class="col-1">Student Id</p>
				<p class="col-1 mx-1">Class</p>
				<p class="col-1 mx-1">Homework</p>
				<p class="col-1 mx-1">Test</p>
				<p class="col-2 mx-1">Event Name</p>
				<p class="col-1 mx-1">Grades</p>
				</div>
				<div class="row">
		<form method="post" action="gradeupdate" class="inline">
			<input type="text" readonly name="eventid" style="display: none;">
			<input type="text" name="studentid" value="1" class="col-1 mx-1"> 
			<input type="text" name="class" value="Math" class="col-1 mx-1">   
			<input type="text" name="homework" value="No" class="col-1 mx-1"> 
			<input type="text" name="test" value="No" class="col-1 mx-1">         
			<input type="text" name="eventname" value="Event" class="col-2 mx-1"> 
			<input type="text" name="grades" value="0" class="col-1 mx-1">
			<input name="add" type="submit" value="Add" class="col-1 mx-1">
		</form>
		</div>
</div>

<div id="Classes" class="tabcontent col-10">

<jsp:useBean id="classes" class="com.SchoolRegistrationSystem.teacherServlet" scope="request">  
           	<%
           	try {
           	ResultSet rs;
           	rs = classes.getClasses();
            while (rs.next())
            {
            	out.println("<h2>"+rs.getString("ClassName") + "</h2></br>");
            	
            };
  	  		} catch (Exception e) {
  	  			System.out.println(e.toString());
  	  		}
           	%> 
           	</jsp:useBean>
</div>

<div id="Student" class="tabcontent col-10">
<div class="row">
<p class="col-1">Student ID</p>
<p class="col-2">Name</p>
<p class="col-2">Present</p>
<p class="col-2">Absent</p>
</div>
<jsp:useBean id="students" class="com.SchoolRegistrationSystem.teacherServlet" scope="request">
<%
	try {
   	ResultSet rs;
   	rs = students.getStudents();
    while (rs.next())
    {
    	out.println("<div class=\"row\">");
		out.println("<form method=\"post\" action=\"attendanceupdate\"  class=\"inline\">"+
		"<input type=\"number\" readonly name=\"studentid\" value="+rs.getString("StudentId")+" id=\"studentid\" class=\"col-1 mx-1\">"+
		"<span  class=\"col-2 mx-1\">"+rs.getString("FirstName")+ " "+rs.getString("LastName")+"</span>"+
		"<input type=\"number\" name=\"present\" min=\"0\" value="+rs.getString("Present")+"  class=\"col-2 mx-1\">"+
		"<input type=\"number\" name=\"absent\" min=\"0\" value="+rs.getString("Absent")+"  class=\"col-2 mx-1\">"+
		"<input type=\"submit\" value=\"Update\">"+
		"</form>");
		out.println("</div>");
    }
} catch (Exception e) {
			System.out.println(e.toString());
		}	
		 %>
		 </jsp:useBean>
		</div>
</div>
</body>
</html>
