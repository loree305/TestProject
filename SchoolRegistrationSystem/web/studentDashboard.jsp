<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
	<% String usertype = (String)request.getSession().getAttribute("LogedInType");
	   if(usertype != "student"){
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

	
	<%-- Navigation content Change--%>
	<script>

	function myFunction2() {
		var z = document.getElementById("myDIV2");
		var a = document.getElementById("myDIV3");
		var b = document.getElementById("myDIV4");
		  if (z.style.display === "none") {
		    z.style.display = "block",a.style.display = "none",b.style.display = "none";
		  } 	  
		}
	function myFunction3() {
		var z = document.getElementById("myDIV2");
		var a = document.getElementById("myDIV3");
		var b = document.getElementById("myDIV4");
		  if (a.style.display === "none") {
		    a.style.display = "block",z.style.display = "none",b.style.display = "none";
		  }   
		}
	function myFunction4() {
		var z = document.getElementById("myDIV2");
		var a = document.getElementById("myDIV3");
		var b = document.getElementById("myDIV4");
		  if (b.style.display === "none") {
		    b.style.display = "block",z.style.display = "none",a.style.display = "none";
		  }
		}
	</script> 
	<script>
		function myFunction() {
		  document.getElementById("frm1").submit();
		}
	</script>
	<%-- -------------Menu Style -------------- --%>
	<style>li {cursor: pointer;}a:hover { background-color: #90ee90; transition: 0.1s;}</style>
	<%-- ------------Table Style -------------- --%>
	<style>
	table {
	  border-collapse: collapse;
	  width: 100%;
	}
	
	td, th {
	  border: 1px solid #dddddd;
	  text-align: left;
	  padding: 8px;
	}
	
	tr:nth-child(even) {
	  background-color: #dddddd;
	}
	input {
	  width: 100px;
	}
	</style>
 </head>
 <body>

  <%-- Log out --%>
    <div class="d-flex flex-row bd-highlight justify-content-end p-5">
    	<label class="btn btn-outline-danger m-1 text-danger" for="btncheck1"><a href="login.jsp">Log Out</a></label>
 	</div>
 <%-- Header --%>
 	<div class="container">
		<div class="d-flex justify-content-center">
			<h1>
				<span class="badge rounded-pill bg-success">Student</span>
				<span class="badge rounded-pill bg-warning text-dark">Dashboard</span> 	
			 </h1> 
		 </div>
   </div>
  			
	<%-- Welcome using Servlet--%>
	<div style='display:none;' class="card">
		<div class="card-body">
		   	<%
		  		String firstName = request.getParameter("firstName");
		  		String lastName = request.getParameter("lastName");
		  		String studentId = request.getParameter("studentId");
		 	%>
		</div>
	</div>
	
  <%-------------------- Menu------------------- --%>
   
	<div class="row">
	
		<div class="col-4">
			<nav class ="navbar bg-light">
				<ul class ="nav navbar-nav" >
					<li>Main Dashboard</li>
					<li class ="nav-item">
						<a class ="nav-link" onclick="myFunction2()"> My Schedule </a>
					</li>
					<li class ="nav-item">
						<a class ="nav-link" onclick="myFunction3()"> My Grades </a>
					</li>
					<li class ="nav-item">
						<a class ="nav-link" onclick="myFunction4()"> My Personal Info </a>
					</li>
				</ul>
			</nav>
		</div>	

		<%-- content with text change via JavaScript--%>
		<div class="col-8">
			<div class="container">
	           	<div id="content">	       
	                                       
		   <%-- Get from StudentServlet Student Personal Grade--%>
		
		   <jsp:useBean id="uniqueGradeID" scope="request" class="com.SchoolRegistrationSystem.StudentServlet"/>  
			   		<%
		      		ResultSet UniqueGradeData;
			   	
		           	UniqueGradeData = uniqueGradeID.uniqueGradeDat(studentId);
		           	
		        	out.print("<div id='myDIV3'style='display:none;'><h2>My Grades</h2><table>"+"<thead>" +
		                	"<tbody>"+
		                    "<tr>" +
		                    "<th> Class Name </th>"+
		                    "<th> Grade </th>"+
		                    "<th> Event ID</th>"+
		                    "<th> is Homework?</th>"+
		                    "<th> is Test?</th>"+
		                    "</tr>");
		        	if(UniqueGradeData != null){
		           	while (UniqueGradeData.next())
		            {
		           		String className = UniqueGradeData.getString("ClassName");
		                String grade = UniqueGradeData.getString("Grades");
		                String eventId = UniqueGradeData.getString("EventId");
		                String isHomework = UniqueGradeData.getString("Homework");
		                String isTest = UniqueGradeData.getString("Test");
		    
		           	out.print(
		           			"<tr>"+
		               		"<td>"+ className + "</td>"+        
		               		"<td>"+ grade + "</td>"+ 
		               		"<td>"+ eventId + "</td>"+ 
		               		"<td>"+ isHomework + "</td>"+ 
		               		"<td>"+ isTest + "</td>"+
		               		"</tr>");
		            }
		           out.print(
		               		"</table></div>");        
		        	}
		           %>     
                 
                   
             <%-- Get from StudentServlet Student Personal Information and send back --%>
   			<jsp:useBean id="uniqueID" scope="request" class="com.SchoolRegistrationSystem.StudentServlet"/>  
	   		<%
      		ResultSet UniqueStudentData;
	   	
           	UniqueStudentData = uniqueID.uniqueStudentDat(studentId);
           	if(UniqueStudentData != null){
           	while (UniqueStudentData.next())
            {
            String studId = UniqueStudentData.getString("StudentId");
           	String nameFirst = UniqueStudentData.getString("FirstName");
           	String nameLast= UniqueStudentData.getString("LastName");
           	String bday= UniqueStudentData.getString("Birthday");
           	String home= UniqueStudentData.getString("Address");
           	String city= UniqueStudentData.getString("City");
           	int zip= UniqueStudentData.getInt("Zip");
           	int phoneNum= UniqueStudentData.getInt("PhoneNumber");
           	String Absence= UniqueStudentData.getString("Absent");            
           	out.print("<form id='frm1' action=StudentServlet method='post'>"+
           		  "<div id='myDIV4' style='display:none;'><h2>My Personal Info</h2>"+
           		  "<div class='form-row'>"+
           				"<div class='form-group col-md-2'>"+
           				  "<label for='inputEmail4'>Student ID</label>"+
           				  "<input type='text' class='form-control' id='StudentID' name='StudentID' value='"+studId+"' readonly>"+
           				"</div>"+
           				"<div class='form-group col-md-4'>"+
           				  "<label for='inputPassword4'>First Name</label>"+
           				  "<input type='text' class='form-control' id='FirstName' name='FirstName' value='"+nameFirst+"' readonly>"+
           				"</div>"+
           				"<div class='form-group col-md-4'>"+
           					"<label for='inputAddress'>Last Name</label>"+
           					"<input type='text' class='form-control' id='LastName' name='LastName' value='"+nameLast+"' readonly>"+
           				"</div>"+
           		  "</div>"+
           		    "<div class='form-group'>"+
           		    "<label for='inputBday'>Birth Date</label>"+
           		    "<input type='date' class='form-control' id='bDate' name='bDate' value='"+bday+"' readonly>"+
           		  "</div>"+
           		  "<div class='form-group'>"+
           		    "<label for='inputAddress2'>Address</label>"+
           		    "<input type='text' class='form-control' id='address' name='address' value='"+home+"' required>"+
           		  "</div>"+
           		  "<div class='form-row'>"+
           			    "<div class='form-group col-md-4'>"+
           			      "<label for='inputCity'>City</label>"+
           			      "<input type='text' class='form-control' id='City' name='City' value='"+city+"' required>"+
           			    "</div>"+
           			    "<div class='form-group col-md-2'>"+
           			      "<label for='inputZip'>Zip</label>"+
           			      "<input type='number' class='form-control' id='Zip' name='Zip' value='"+zip+"' required>"+
           			    "</div>"+
           			    "<div class='form-group col-md-6'>"+
           			      "<label for='inputPhone'>Phone Number</label>"+
           			      "<input type='number' class='form-control' id='phone' name='phone' value='"+phoneNum+"'required>"+
           			    "</div>"+
           		  "</div>"+
           		  "<button type='submit' onclick='window.location='thanks.jsp'' class='btn btn-primary'>Update</button>"+
           		  "</div>"+
           		"</form>");
            }
           	}
           %>       
            
            <%-- Get from StudentServlet Student Personal Schedule--%>
		
		   <jsp:useBean id="uniqueScheduleID" scope="request" class="com.SchoolRegistrationSystem.StudentServlet"/>  
			   		<%
		      		ResultSet UniqueScheduleData;
			   	
			   		UniqueScheduleData = uniqueScheduleID.uniqueScheduleDat(studentId);
		           	
		        	out.print("<div id='myDIV2'style='display:none;'><h2>My Schedule</h2><table>"+"<thead>" +
		                	"<tbody>"+
		                    "<tr>" +
		                    "<th> Class Name </th>"+
		                    "<th> Class Period </th>"+
		                    "</tr>");
		            if(UniqueScheduleData != null){
		           	while (UniqueScheduleData.next())
		            {
		           		String className = UniqueScheduleData.getString("ClassName");
		           	out.print(
		           			"<tr>"+
		               		"<td>"+ className + "</td>"+
		               		"<td>To be determined...</td>"+
		               		"</tr>");
		            }
		           out.print(
		               		"</table></div>");	
		            }
		           %>                            
			</div>
		</div>

	</div>
		    	     

</body>
</html>
