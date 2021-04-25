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

public class attendanceupdate extends HttpServlet {
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
    public attendanceupdate() {
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
	String StudentId=request.getParameter("studentid");
	String Present=request.getParameter("present");
	String Absent=request.getParameter("absent");

	try{
		Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
		Statement st=con.createStatement();
	st.executeUpdate("update studentdata set Present = '"+Present+"', Absent = '"+Absent+"'where StudentId = " +StudentId+ ";");
	response.setContentType("text/html");
	PrintWriter pw=response.getWriter();
	pw.println("<script type=\"text/javascript\">");
	pw.println("alert('Attendance has been updated for StudentID: "+StudentId+"');");
	pw.println("</script>");
	RequestDispatcher rd=request.getRequestDispatcher("teacherdashboard.jsp");
	rd.include(request, response);
	}
	catch(Exception e)
	{
	System.out.print(e);
	e.printStackTrace();
	}
}
}
