package com.SchoolRegistrationSystem;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class gradeupdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
  	String url = "jdbc:mysql://localhost:3306/schoolregistrationsystem";
  	String dbUsername = "root";
  	String dbPassword = "admin";
  	boolean successRegistration = false;
  	
	public void init() {
  		//load driver
  		try {
  			Class.forName("com.mysql.jdbc.Driver");
  		} catch (ClassNotFoundException e) {
  			e.printStackTrace();
  		}
  	}
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public gradeupdate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// TODO Auto-generated method stub
	
	String Update = request.getParameter("update");
	String Delete = request.getParameter("delete");
	String Add = request.getParameter("add");
	String EventId=request.getParameter("eventid");
	String EventName=request.getParameter("eventname");
	String StudentId=request.getParameter("studentid");
	String Class=request.getParameter("class");
	String Homework=request.getParameter("homework");
	String Test=request.getParameter("test");
	String Grades=request.getParameter("grades");
	String ClassId = null;
	
	System.out.println(Grades);
	
	Test = Test.substring(0, 1).toUpperCase() + Test.substring(1);
	Homework = Homework.substring(0, 1).toUpperCase() + Homework.substring(1);

	
	System.out.println(!Test.equals("Yes") || !Test.equals("No") || !Homework.equals("Yes") || !Homework.equals("No"));
	try{
		Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
		Statement st=con.createStatement();

		ResultSet rs = st.executeQuery("select ClassId from classregistration where ClassName = '"+Class+"';");
		while (rs.next()) {
			  ClassId = rs.getString("ClassId");
			  }
		
	if (Test.contentEquals(Homework)) {
		response.setContentType("text/html");
		PrintWriter pw=response.getWriter();
		pw.println("<script type=\"text/javascript\">");
		pw.println("alert('Homework and Test can not be the same value.');");
		pw.println("</script>");
		RequestDispatcher rd=request.getRequestDispatcher("teacherdashboard.jsp");
		rd.include(request, response);
	} else if (ClassId == null) {
		response.setContentType("text/html");
		PrintWriter pw=response.getWriter();
		pw.println("<script type=\"text/javascript\">");
		pw.println("alert('Class misspelled or does not exist. Contact Admin if you believe this is an error.');");
		pw.println("</script>");
		RequestDispatcher rd=request.getRequestDispatcher("teacherdashboard.jsp");
		rd.include(request, response);
	} else if ((Test.equalsIgnoreCase("Yes") || Test.equalsIgnoreCase("No")) && (Homework.equalsIgnoreCase("Yes") || Homework.equalsIgnoreCase("No"))) {
			
		if (EventId != "" && Update != null) {
			int i=st.executeUpdate("update gradeevent set Homework = '"+Homework+"', Test = '"+Test+"', Grades = '"+Grades+"', EventName = '"+EventName+"' where EventId = " +EventId+ ";");
			int j=st.executeUpdate("update gradejoinstudent set StudentId = '"+StudentId+"', ClassId = '"+ClassId+"', EventId = '"+EventId+"' where EventId = " +EventId+ ";");
			response.setContentType("text/html");
			PrintWriter pw=response.getWriter();
			pw.println("<script type=\"text/javascript\">");
			pw.println("alert('"+EventName+" has been updated for StudentID: "+ StudentId +"');");
			pw.println("</script>");
			RequestDispatcher rd=request.getRequestDispatcher("teacherdashboard.jsp");
			rd.include(request, response);
			
			} else if (Add != null) {
				int i=st.executeUpdate("insert into gradeevent (Homework, Test, Grades, EventName) values ('"+Homework+"', '"+Test+"', '"+Grades+"', '"+EventName+"');");
				rs = st.executeQuery("select last_insert_id() as EventId");
				while (rs.next()) {
					  EventId = rs.getString("EventId");
				}
				int j=st.executeUpdate("insert into gradejoinstudent (StudentId, ClassId, EventId) values ('"+StudentId+"', '"+ClassId+"', '"+EventId+"');");
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('"+EventName+" has been added for StudentID: "+ StudentId +"');");
				pw.println("</script>");
				RequestDispatcher rd=request.getRequestDispatcher("teacherdashboard.jsp");
				rd.include(request, response);
				
			} else {
				int i=st.executeUpdate("delete from gradeevent where EventId = "+EventId+";");
				int j=st.executeUpdate("delete from gradejoinstudent where EventId = "+EventId+";");
				response.setContentType("text/html");
				PrintWriter pw=response.getWriter();
				pw.println("<script type=\"text/javascript\">");
				pw.println("alert('"+EventName+" has been deleted for StudentID: "+ StudentId +"');");
				pw.println("</script>");
				RequestDispatcher rd=request.getRequestDispatcher("teacherdashboard.jsp");
				rd.include(request, response);
			}
		}
	 else {
		response.setContentType("text/html");
		PrintWriter pw=response.getWriter();
		pw.println("<script type=\"text/javascript\">");
		pw.println("alert('Test and Homework must equal \"Yes\" or \"No\".');");
		pw.println("</script>");
		RequestDispatcher rd=request.getRequestDispatcher("teacherdashboard.jsp");
		rd.include(request, response);
	}
	}
	catch(Exception e)
	{
	System.out.print(e);
	e.printStackTrace();
	}
}
}
