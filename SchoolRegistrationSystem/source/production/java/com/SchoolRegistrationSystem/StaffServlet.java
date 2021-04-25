package com.SchoolRegistrationSystem;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.synth.Region;

/**
 * Servlet implementation class staffServlet
 */
@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 //db connection information
  	String url = "jdbc:mysql://localhost:3306/schoolregistrationsystem";
  	String dbUsername = "root";
  	String dbPassword = "admin";
  	String ErrorMessages;
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
    public StaffServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    

      

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

	}
	
	public ResultSet getRegCount() throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  		//ResultSet
  			 rs = st.executeQuery("select FirstName from registrationuser");
  			
    	}	
  	  		catch (SQLException e) {
  	  			System.out.println(e.toString());
  	  		} catch (Exception e) {
  	  			System.out.println(e.toString());
  	  		}
	
	   return rs;
	}
	
	//Class list gets queried and sent to staffDashboard.jsp
	public ResultSet getWaitingUsers() throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "select concat(FirstName,' ',LastName) AS User, UserType from registrationuser";
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
	
	

	//Class list gets queried and sent to staffDashboard.jsp
	public ResultSet getclassList() throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "Select * from classregistration";
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
	 
	//Determine if there are any registrationuser not promoted in staffDashboard.jsp
	public int awaitingPromo() throws SQLException 
	{
		 ResultSet rs = null;
		 int waitCount = 0;
	 
		 try {
			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "Select count(*) from registrationuser where Promoted IS NULL ";
  		
  		//ResultSet
  			 rs = st.executeQuery(query);
		 

		 rs.next();
		 waitCount = rs.getInt("count(*)");
		 rs.close();
		 st.close();
		 con.close();
		 return waitCount;
		
		 }
			
		 catch (SQLException e) {
 	  			System.out.println(e.toString());
 	  		} catch (Exception e) {
 	  			System.out.println(e.toString());
 	  		}
		 return waitCount;
	}
	
	//Query to get and display student grades
	public ResultSet uniqueGradeDat() throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "select distinct studentdata.StudentId,classregistration.ClassName,gradeevent.Grades,gradeevent.EventId,gradeevent.Homework,gradeevent.Test from studentdata, classregistration, gradeevent order by FirstName, ClassName;";
  		//ResultSet
  			 rs = st.executeQuery(query); 
  			 System.out.print(rs);
    	}	  
  	  		catch (SQLException e) {
  	  			System.out.println(e.toString());
  	  		} catch (Exception e) {
  	  			System.out.println(e.toString());
  	  		}
	   return rs;
	}
	
	//Query to get and display student schedules
	public ResultSet studentSchedules() throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "select distinct studentdata.StudentId,classregistration.ClassName,gradeevent.Grades,gradeevent.EventId,gradeevent.Homework,gradeevent.Test from studentdata, classregistration, gradeevent order by FirstName, ClassName;";
  		//ResultSet
  			 rs = st.executeQuery(query); 
  			 System.out.print(rs);
    	}	  
  	  		catch (SQLException e) {
  	  			System.out.println(e.toString());
  	  		} catch (Exception e) {
  	  			System.out.println(e.toString());
  	  		}
	   return rs;
	}
	
		
	
	//NEW Query to get and display all student data
	public ResultSet uniqueStudentDat() throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "SELECT studentdata.StudentId, studentdata.FirstName, studentdata.LastName, studentdata.Birthday, studentdata.Address, studentdata.City, studentdata.Zip, studentdata.phoneNumber, studentdata.Absent from studentdata;";
  		//ResultSet
  			 rs = st.executeQuery(query); 
  			 System.out.print(rs);
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
	
	//Update Unique student data
	private boolean updateUniqueStudent(String studentid, String FirstName, String LastName, String bDate, String address, String City,
			int Zip, int phone) {			
				try {
					
					
	  			//Connection to db
	  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
	  			//Make a statement
	  			Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
	  			      ResultSet.CONCUR_UPDATABLE);
	  			String query = "SELECT * FROM studentdata WHERE StudentId='"+studentid+"';";
	  			//ResultSet
	  			ResultSet rs = st.executeQuery(query);
	  			rs.beforeFirst();
	  			while(rs.next()) {
	  				String modifiableAddress = rs.getString("Address");
	  				String modifiableCity = rs.getString("City");
	  				int modifiableZip = rs.getInt("Zip");
	  				int modifiablePhone = rs.getInt("PhoneNumber");
	  				modifiableAddress = address;
	  				modifiableCity = City;
	  				modifiableZip = Zip;
	  				modifiablePhone = phone;
	  				
	  				rs.updateString("Address", modifiableAddress);
	  				rs.updateString("City", modifiableCity);
	  				rs.updateInt("Zip", modifiableZip);
	  				rs.updateInt("PhoneNumber", modifiablePhone);

	  				rs.updateRow();
	  			}
	  			st.close();
	  			con.close();
	  			return true;
	  		}
	  		catch (SQLException e) {
	  			ErrorMessages = e.toString();
	  			System.out.println(e.toString());
	  		} catch (Exception e) {
	  			ErrorMessages = e.toString();
	  			System.out.println(e.toString());
	  		}
			return false;

	  
	}
	//changes made by user retrieved
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException,  IOException {
		String studentid = req.getParameter("StudentID");
		String firstname = req.getParameter("FirstName");
		String lastname = req.getParameter("LastName");
		String bdate = req.getParameter("bDate");
		String address1 = req.getParameter("address");
		String city1 = req.getParameter("City");
		int zip1 =  Integer.parseInt(req.getParameter("Zip"));
		int phone1 = Integer.parseInt(req.getParameter("phone"));
		
		
		
		String query = "SELECT StudentId FROM studentdata WHERE StudentId='"+studentid+"';";
		System.out.println("waiting on this to print out"+studentid);
		if(updateUniqueStudent(studentid, firstname, lastname, bdate, address1, city1,  zip1, phone1)) 
		{
			res.setHeader("Refresh", "0; URL=" + req.getContextPath() + "/staffDashboard.jsp?"); 

		} else {
			req.setAttribute("message",ErrorMessages);
			res.setHeader("Refresh", "0; URL=" + req.getContextPath() + "/staffDashboard.jsp?"); 
		}

	}


}
