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
  <style>li {cursor: pointer;}a:hover { background-color: #90ee90; transition: 0.1s;}</style>
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
	a:hover {
  text-decoration: none;
}
   </style>
 </head>
 <body>
 
 <%-- Header --%>
 	<div class="container">
		<div class="d-flex justify-content-center">
			<h1>
				<span class="badge rounded-pill bg-success">Staff</span>
				<span class="badge rounded-pill bg-warning text-dark">Dashboard</span> 	
			 </h1> 
		 </div>
   </div>
  <%-- Menu --%>
	<div class="row">
		<div class="col-3">
			<nav class ="navbar bg-light">
				<ul class ="nav navbar-nav" >
					<li class ="nav-link"> <a href="staffDashboard.jsp">Main Dashboard</a></li>					
				</ul>
			</nav>
		</div>
		<%-- Content with text change via Javascript--%>
		<div class="col-9">
			<div class="container">
           	<p id="content"></p>
           	<jsp:useBean id="users" scope="request" class="com.SchoolRegistrationSystem.userApprovalServlet"/>  
           	<%
           	ResultSet rset;
           	rset = users.getWaitingUsers();
        	
           	out.print("<br><h2>Users Awaiting Approval</h2>");
           	out.print( 
           			
           		"<table>"+"<thead>" +"<tbody>"+
                	"<tr>"+
               	   		 "<th>Full Name</th>"+               
                		 "<th>User Type</th>"+
                		 "<th>Approval</th>"+
                	"</tr>"+
           		"</table>");
           	if(rset != null){
            while (rset.next ())
            { 
            	int regID =rset.getInt("RegistrationId");
            	out.print(
            	"<form id='frm2' action=userApprovalServlet method='post'>"+
           			
            			
                "<table>"+"<thead>" +
                "<tbody>"+
                "<tr>" + 
                "<th style='display: none;'><label for='EMAIL'></label></th>"+
                "<th style='display: none;'><label for='pWord'></label></th>"+
                "<th style='display: none;'><label for='firstN'></label></th>"+
                "<th style='display: none;'><label for='lastN'></label></th>"+
                "<th style='display: none;'><label for='phoneN'></label></th>"+
                "<th style='display: none;'><label for='studID'></label></th>"+
                "<th style='display: none;'><label for='regId'></label></th>"+
                "<th style='display: none;'><label for='fname'>Full Name</label></th>"+               
                "<th style='display: none;'><label for='type'>User Type</label></th>"+
                "<th style='display: none;'>Approval</th>"+
                "</tr>"+
            	"<tr>"+
            	"<td style='display: none;'><input type='hidden' id='regId' name='regId' value='"+regID+"' readonly></td>"+
                "<td><input type='text' id='fname' name='fname' value='"+rset.getString("User")+"' readonly></td>"+
                "<td><input type='text' id='type' name='type' value='"+rset.getString("UserType")+"' readonly></td>"+
                "<td style='display: none;'><input type='hidden' id='EMAIL' name='EMAIL' value='"+rset.getString("Email")+"' readonly></td>"+
                "<td style='display: none;'><input type='hidden' id='pWord' name='pWord' value='"+rset.getString("Password")+"' readonly></td>"+
                "<td style='display: none;'><input type='hidden' id='firstN' name='firstN' value='"+rset.getString("FirstName")+"' readonly></td>"+
                "<td style='dsisplay: none;'><input type='hidden' id='lastN' name='lastN' value='"+rset.getString("LastName")+"' readonly></td>"+
                "<td style='display: none;'><input type='hidden' id='phoneN' name='phoneN' value='"+rset.getString("Phone")+"' readonly></td>"+
         	    "<td style='display: none;'><input type='hidden' id='studID' name='studID' value='"+rset.getInt("StudentId")+"' readonly></td>"+                
               
                "<td><button type='submit' name='add' class='btn btn-primary'>Approve</button>"+
              	    "<button type='Submit' name='deny' class='btn btn-danger'>Deny</button></td>"+
                "</tr></table></form>");
            }
           	}
           	%>
			</div>
		</div>
	</div>			
</body>
</html>
