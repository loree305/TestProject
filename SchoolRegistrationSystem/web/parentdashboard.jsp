<!--Christopher Evers  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>  
	<% String usertype = (String)request.getSession().getAttribute("LogedInType");
	   if(usertype != "parent"){
		   session.invalidate();
		   response.sendRedirect("AccessDenied.jsp");
	   }
	%>
<!DOCTYPE html>
 <head>
  <title>School Registration System Application</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
  <script src ="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src ="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
 </head>
 <body>
 <div class="row">
 	<div class="container-fluid">
		<div class="d-flex justify-content-center col">
			<h1>
				<span class="badge rounded-pill bg-primary">Parent</span>
				<span class="badge rounded-pill bg-danger">Dashboard</span> 
			 </h1>
		 </div>
		 <div class="text-right col">
		 <label class="btn btn-outline-danger m-1 text-danger" for="btncheck1"><a href="login.jsp">Log Out</a></label>
		 </div>
   </div>
   </div>
   <div class="container-fluid">
   
   
   <div class="container col-8 card">
  		<div class="card-body text-center">
   	     <%
  			String firstName = request.getParameter("firstName");
  			String lastName = request.getParameter("lastName");
  			String studentId = request.getParameter("studentId");
  			out.println("<h1>Welcome back " + firstName + " " + lastName + "</h1>");
 		%>
  		</div>
	</div>
	</div>
	<div class="row justify-content-center">
  	 <div class="col-10 mt-5 mb-5">
  	<div class="card">
 		 <div class="card-header bg-primary bg-lighten-md">
   		<jsp:useBean id="students" class="com.SchoolRegistrationSystem.ParentServlet"/>  
           	<%
           	String Grade = "";
           	String StudentId = "";
           	String Present = "";
           	String Absent = "";
           	
           	try {
           	ResultSet rs;
           	rs = students.getStudent(firstName, lastName);
            while (rs.next())
            {
            	out.print("<h3>Student: " + rs.getString("FirstName"));
            	out.print(" " + rs.getString("LastName") + "</h3>");
            	StudentId = rs.getString("StudentId");
            	Grade = rs.getString("Grade");
            	Present = rs.getString("Present");
            	Absent = rs.getString("Absent");
            	
            };
  	  		} catch (Exception e) {
  	  			System.out.println(e.toString());
  	  		}
           	%> 
 		 </div>
  			<div class="card-body">
    		<h5 class="card-title"> <%
            	out.print(Grade);
           	%>th Grade</h5> 
  			</div>
  			
  			<div class="card">
  				<div class="card-body">
  				<h5 class="card-title">Current Grades</h5>
    		<div class="container">
 			 <div class="row">
   				 <div class="col row">
   				 <jsp:useBean id="grades" class="com.SchoolRegistrationSystem.ParentServlet"> 
   				 <% 
   				 try {
   				ResultSet rs = students.getGrades(studentId);
   	            while (rs.next())
   	            {
   	            	out.print("<div class=\"col-4\"> " + rs.getString("ClassName"));
   	            	out.print(": " + rs.getString("EventName"));
   	            	out.print(" - " + rs.getString("Grades") + "%</div>");
   	            	
   	            };
   	  	  		} catch (Exception e) {
   	  	  			System.out.println(e.toString());
   	  	  		}
   				%>
   				</jsp:useBean>
   				 </div>
  			</div>
			</div>
  			</div>
			</div>
			
  			<div class="card">
  				<div class="card-body">
  				<h5 class="card-title">Attendance</h5>
    		<div class="container">
 			 <div class="row">
   				 <div class="col">
   				   Days out: <%out.print(Present);%>
   				 </div>
   			 <div class="col">
   			   	   Days in: <%out.print(Absent);%>
   			 </div>
   			 <div class="col">
   		
   			 </div>
   			 </div>
  			</div>
  			</div>
			</div>
			
		</div>
		</div>
	</div>
</body>
</html>
