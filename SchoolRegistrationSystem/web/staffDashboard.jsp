<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
	<% String usertype = (String)request.getSession().getAttribute("LogedInType");
	   if(usertype != "staff"){
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
  	
  	<%-- Blinking text for users that are not approved yet--%>
    <script> 
	  	var ofs = 0;
		window.setInterval(function(){
		  $('#imp').css('background', 'rgba(255,0,0,'+Math.abs(Math.sin(ofs))+')');
		  ofs += 0.008;
		}, 10); 
	</script>
	
	<%-- Navigation content Change--%>
	<script>
	function myFunction() {
		var x = document.getElementById("myDIV");
		var z = document.getElementById("myDIV2");
		var a = document.getElementById("myDIV3");
		var b = document.getElementById("myDIV4");
	  if (x.style.display === "none") {
	    x.style.display = "block",z.style.display = "none",a.style.display = "none",b.style.display = "none";
	  } 
	}
	function myFunction2() {
		var x = document.getElementById("myDIV");
		var z = document.getElementById("myDIV2");
		var a = document.getElementById("myDIV3");
		var b = document.getElementById("myDIV4");
		  if (z.style.display === "none") {
		    z.style.display = "block",x.style.display = "none",a.style.display = "none",b.style.display = "none";
		  } 	  
		}
	function myFunction3() {
		var x = document.getElementById("myDIV");
		var z = document.getElementById("myDIV2");
		var a = document.getElementById("myDIV3");
		var b = document.getElementById("myDIV4");
		  if (a.style.display === "none") {
		    a.style.display = "block",x.style.display = "none",z.style.display = "none",b.style.display = "none";
		  }   
		}
	function myFunction4() {
		var x = document.getElementById("myDIV");
		var z = document.getElementById("myDIV2");
		var a = document.getElementById("myDIV3");
		var b = document.getElementById("myDIV4");
		  if (b.style.display === "none") {
		    b.style.display = "block",x.style.display = "none",z.style.display = "none",a.style.display = "none";
		  } 	  
		}
	function usersDetected() {
		
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
				<span class="badge rounded-pill bg-success">Staff</span>
				<span class="badge rounded-pill bg-warning text-dark">Dashboard</span> 	
			 </h1> 
		 </div>
   </div>
   
  <%-- get sqldb information from login Servlet.--%>

		   	<%
		  		String firstName = request.getParameter("firstName");
		  		String lastName = request.getParameter("lastName");
		  		String studentId = request.getParameter("studentId");
		 	%>
	
	
	
	<%-- Get from StaffServlet Users Awaiting Approval --%> 
	           	<jsp:useBean id="awaitingUsersID" class="com.SchoolRegistrationSystem.StaffServlet"/>  
	           	<%
	           	int storedApprovalCount = awaitingUsersID.awaitingPromo();
	            if (storedApprovalCount > 0) { 
	            	out.print("<div onclick=location.href='userApproval.jsp'; id='imp' style='width: 100%; cursor: pointer; text-align: center; padding: 15px 0px 15px 0px;'>There are users waiting to be approved.</div>");
	            }
	            else { 
	        	  out.print("");	        	  
	         	} 	            	
	             %>
	           
	         
	<div id='usersDetected'style='display:none;'>
		<div  onclick='location.href='userApproval.jsp';' id='imp' style=''width: 100%; cursor: pointer; text-align: center;  padding: 15px 0px 15px 0px;'>One or more users awaiting to be approved</div>
   	</div>
  <%-------------------- Menu------------------- --%>
   
	<div class="row">
	
		<div class="col-3">
			<nav class ="navbar bg-light">
				<ul class ="nav navbar-nav" >
					<li>Main Dashboard</li>
					<li class ="nav-item">
						<a class ="nav-link" onclick="myFunction()"> View Courses </a>
					</li>
					<li class ="nav-item">
						<a class ="nav-link" onclick="myFunction2()"> View Student Schedules </a>
					</li>
					<li class ="nav-item">
						<a class ="nav-link" onclick="myFunction3()"> View Student Grades </a>
					</li>
					<li class ="nav-item">
						<a class ="nav-link" onclick="myFunction4()"> View Student Info </a>
					</li>
				</ul>
			</nav>
		</div>	
		<%-- Content with text change via Javascript--%>
		<div class="col-9">
			<div class="container">
	           	<div id="content">
	           	
	   			<%-- Get from StaffServlet List of courses --%>  			
	           	<jsp:useBean id="users" class="com.SchoolRegistrationSystem.StaffServlet"/>  
	           	<%
	         
	               	
	           	
	           	ResultSet rset;
	           	rset = users.getclassList();
	           	out.print("<div id='myDIV'style='display:none;'><br><h2>List of Courses</h2><br><table>"+"<thead>" +
	                	"<tbody>"+
	                    "<tr>" +
	                    "<th> Course Number</th>"+          
	                    "<th> Course Name</th>"+
	                    "</tr>");
	           	if(rset != null){
	            while (rset.next ())
	            {
	            	out.print(
	            	"<tr>"+
	                "<td>"+ rset.getString("ClassId")+"</td>"+               
	                "<td>"+ rset.getString("ClassName")+"</td>"+
	                "</tr>");
	            }
	            out.print(
	                    "</table></div>");
	            }%>
	           	</div>    
	           	      	
                    
                    <%-- Get from StudentServlet Student Grade--%>
		   <jsp:useBean id="uniqueGradeID" scope="request" class="com.SchoolRegistrationSystem.StaffServlet"/>  
			   		<%
		      		ResultSet UniqueGradeData;
			   		UniqueGradeData = uniqueGradeID.uniqueGradeDat();
		           	
		        	out.print("<div id='myDIV3'style='display:none;'><br><h2>All Grades</h2><br><table>"+"<thead>" +
		                	"<tbody>"+
		                    "<tr>" +
		                    "<th> Student ID </th>"+
		                    "<th> Class Name </th>"+
		                    "<th> Grade </th>"+
		                    "<th> Event ID</th>"+
		                    "<th> is Homework?</th>"+
		                    "<th> is Test?</th>"+
		                    "</tr>");
		        	if(UniqueGradeData != null){
		           	while (UniqueGradeData.next())
		            {
		           		String studId = UniqueGradeData.getString("StudentId");
		           		String className = UniqueGradeData.getString("ClassName");
		                String grade = UniqueGradeData.getString("Grades");
		                String eventId = UniqueGradeData.getString("EventId");
		                String isHomework = UniqueGradeData.getString("Homework");
		                String isTest = UniqueGradeData.getString("Test");
		    
		           	out.print(
		           			"<tr>"+
		           			"<td>"+ studId + "</td>"+  
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
                    
 <%-- Get from Staff Servlet Student Personal Information and send back --%>
   			<jsp:useBean id="StudentInfoId" scope="request" class="com.SchoolRegistrationSystem.StaffServlet"/>  
	   		<%
      		ResultSet allStudentData;
	   	
           	allStudentData = StudentInfoId.uniqueStudentDat();
           	out.print("<div id='myDIV4'style='display:none;'><br><h2>All Students Personal Info</h2><br>");
           	if(allStudentData != null){
           	while (allStudentData.next())
            {
            String studId = allStudentData.getString("StudentId");
           	String nameFirst = allStudentData.getString("FirstName");
           	String nameLast= allStudentData.getString("LastName");
           	String bday= allStudentData.getString("Birthday");
           	String home= allStudentData.getString("Address");
           	String city= allStudentData.getString("City");
           	int zip= allStudentData.getInt("Zip");
           	String phoneNum= allStudentData.getString("PhoneNumber");
           	String Absence= allStudentData.getString("Absent");            
           	out.print("<form id='frm2' action=StaffServlet method='post'>"+
           		  "<div>"+
           		  "<div class='form-row'>"+
           				"<div class='form-group col-md-2'>"+
           				  "<label for='inputEmail4'>Student ID</label>"+
           				  "<input type='text' class='form-control' id='StudentID' name='StudentID' value='"+studId+"' readonly>"+
           				"</div>"+
           				"<div class='form-group col-md-2'>"+
           				  "<label for='inputPassword4'>First Name</label>"+
           				  "<input type='text' class='form-control' id='FirstName' name='FirstName' value='"+nameFirst+"' readonly>"+
           				"</div>"+
           				"<div class='form-group col-md-2'>"+
           					"<label for='inputAddress'>Last Name</label>"+
           					"<input type='text' class='form-control' id='LastName' name='LastName' value='"+nameLast+"' readonly>"+
           				"</div>"+
	           		    "<div class='form-group col-md-2'>"+
	           		   	    "<label for='inputBday'>Birth Date</label>"+
	           		        "<input type='date' class='form-control' id='bDate' name='bDate' value='"+bday+"' readonly>"+
	           		    "</div>"+
	           	  "</div>"+
	           		  "<div class='form-row'>"+
	           				"<div class='form-group col-md-3'>"+
		           		      "<label for='inputAddress2'>Address</label>"+
		           		  	  "<input type='text' class='form-control' id='address' name='address' value='"+home+"' required>"+
		           		    "</div>"+
	           			    "<div class='form-group col-md-2'>"+
	           			      "<label for='inputCity'>City</label>"+
	           			      "<input type='text' class='form-control' id='City' name='City' value='"+city+"' required>"+
	           			    "</div>"+
	           			    "<div class='form-group col-md-2'>"+
	           			      "<label for='inputZip'>Zip</label>"+
	           			      "<input type='number' class='form-control' id='Zip' name='Zip' value='"+zip+"' required>"+
	           			    "</div>"+
	           			    "<div class='form-group col-md-2'>"+
	           			      "<label for='inputPhone'>Phone</label>"+
	           			      "<input type='number' class='form-control' id='phone' name='phone' value='"+phoneNum+"'required>"+
	           			    "</div>"+
           			  "</div>"+
           		  "<button type='submit' class='btn btn-primary'>Update</button>"+
           		  "</div>"+
           		"</form><hr>");
            }
           	out.print("</div>");
           	}
           %> 
                 
                <%-- Get from StudentServlet Student Schedules--%>
		   <jsp:useBean id="scheduleID" scope="request" class="com.SchoolRegistrationSystem.StaffServlet"/>  
			   		<%
		      		ResultSet StudentSchedule;
			   		StudentSchedule = scheduleID.studentSchedules();
		           	
		        	out.print("<div id='myDIV2'style='display:none;'><br><h2>All Student Schedules</h2><br><table>"+"<thead>" +
		                	"<tbody>"+
		                    "<tr>" +
		                    "<th> Student ID </th>"+
		                    "<th> Class Name </th>"+
		                    "</tr>");
		        	if(StudentSchedule != null){
		           	while (StudentSchedule.next())
		            {
		           		String studId = StudentSchedule.getString("StudentId");
		           		String className = StudentSchedule.getString("ClassName");
		           	out.print(
		           			"<tr>"+
		           			"<td>"+ studId + "</td>"+  
		               		"<td>"+ className + "</td>"+
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
