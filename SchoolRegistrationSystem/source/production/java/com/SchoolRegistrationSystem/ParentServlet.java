//Christopher Evers
package com.SchoolRegistrationSystem;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class parentServlet
 */
@WebServlet("/ParentServlet")
public class ParentServlet extends HttpServlet {
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
    public ParentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */

		
	public ResultSet getStudent(String firstName, String lastName) throws SQLException {
		ResultSet rs = null;
		
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "Select studentdata.FirstName, studentdata.LastName, studentdata.StudentId, studentdata.Present, studentdata.Absent, registrationuser.Grade from studentdata left join registrationuser on studentdata.StudentId = registrationuser.studentId where registrationuser.FirstName = '"+firstName+"';";
  		//ResultSet
  			 rs = st.executeQuery(query);  			
    	}	
  	  		catch (SQLException e) {
  	  			System.out.println(e.toString());
  	  		} catch (Exception e) {
  	  			System.out.println(e.toString());
  	  		}
	
	   return rs;
	}
	
	public ResultSet getGrades(String studentId) throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "select gradeevent.Grades, classregistration.ClassName, gradeevent.EventName from gradeevent inner join gradejoinstudent on gradeevent.EventId = gradejoinstudent.EventId inner join classregistration on gradejoinstudent.ClassId = classregistration.ClassId where gradejoinstudent.StudentId = '"+studentId+"';";
  		//ResultSet
//  			inner join classregistration on gradejoinstudent.ClassId = classregistration.ClassId;
  			 rs = st.executeQuery(query);
  			
    	}	
  	  		catch (SQLException e) {
  	  			System.out.println(e.toString());
  	  		} catch (Exception e) {
  	  			System.out.println(e.toString());
  	  		}
	
	   return rs;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
			
		doGet(request, response);
	}

}
