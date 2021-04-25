<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Password Reset</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
</head>
<body class="bg-dark">
  <div class="d-flex flex-row bd-highlight justify-content-end p-5">
     <a href="userregistration.jsp">
  	   <label class="btn btn-outline-info m-1" for="btncheck2">Register</label>
  	   </a>
  	     <a href="login.jsp">
  	   <label class="btn btn-outline-success m-1" for="btncheck2">Login</label>
  	   </a>
 	 </div>
<div class="container" style="width: 40%;">
<div class="card">
  <div class="card-body">
<form action=ResetPassword method="post">
  <div class="form-group">
    <label for="Email">Email address</label>
    <input type="email" class="form-control" id="email" name="email" aria-describedby="email" placeholder="Enter email" >
  </div>
  <div class="form-group">
    <label for="FirstName">First name</label>
    <input type="text" class="form-control" id="firstName" name="firstName" placeholder="John" >
  </div>
   <div class="form-group">
    <label for="LastName">Last name</label>
    <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Smith" >
  </div>
   <div class="form-group">
    <label for="Phone">Phone</label>
    <input type="text" class="form-control" id="phone" name="phone" placeholder="1234567890" >
  </div> 
   <div class="form-group">
    <label for="NewPassword">New Password</label>
    <input type="password" class="form-control" id="newPassword" name="newPassword" >
  </div> 
  <button type="submit" class="btn btn-info mt-2">Reset Password</button>
</form>
  <p>Password reset message: ${message}</p>
</div>
</div>
</div>





</body>
</html>