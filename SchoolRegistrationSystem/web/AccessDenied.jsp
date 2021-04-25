<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%session.invalidate();%>
<!DOCTYPE html>
<html>
 <head>
    <title>Thanks</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
  </head>
<body class="bg-danger">
     <div class="d-flex flex-row bd-highlight justify-content-end p-5">
     <a href="login.jsp">
       <buttom type="button" class="btn btn-primary" for="btncheck1">Home Page</button>
       </a>
 	 </div>
 <div class="container">
 <div class="card">
  <div class="card-body">
	<h5>Current user type does not have access to that dashboard.</h5><br>
	<h5>If this is an issue, please go back to the Home Page and try
	    log in again. You will be automatically redirect to the page
	    that you user type has access to.</h5>
  </div>
</div></div>
</body>
</html>