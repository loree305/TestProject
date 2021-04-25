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

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class StudentServlet
 */
@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {
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
 	
 	
 	
 	  public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
     	 
    	  String username = req.getParameter("username");
    	  
    	  PrintWriter out = res.getWriter();
    	  out.println("Hello " + username);
    	 }

      
   /**
    * @see HttpServlet#HttpServlet()
    */
   public StudentServlet() {
       super();
       // TODO Auto-generated constructor stub
   }
   

     


	
	//New!!!!!!!!!!!!!!!!!!!!!!!!!
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
	
	//Class list gets queried and sent to studentDashboard.jsp
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
	
	
	//Class list gets queried and sent to studentDashboard.jsp
	public ResultSet getUserApprovalList() throws SQLException {
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
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	//Student data gets queried and sent to studentDashboard.jsp
	public ResultSet getStudentData() throws SQLException {
		ResultSet rs = null;
	try {
 			//Connection to db
 			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
 			//Make a statement
 			Statement st = con.createStatement();
 			String query = "Select * from studentdata";
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
	
	//Query to get and display student personal info only
	public ResultSet uniqueStudentDat(String studentId) throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "SELECT studentdata.StudentId, studentdata.FirstName, studentdata.LastName, studentdata.Birthday, studentdata.Address, studentdata.City, studentdata.Zip, studentdata.phoneNumber, studentdata.Absent from studentdata where studentdata.StudentId='"+studentId+"';";
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
	
	//Query to get and display student personal grade only
	public ResultSet uniqueGradeDat(String studentId) throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "select distinct studentdata.StudentId,classregistration.ClassName,gradeevent.Grades,gradeevent.EventId,gradeevent.Homework,gradeevent.Test from studentdata, classregistration, gradeevent where studentdata.studentId ="+studentId+" order by FirstName, ClassName;";
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
	
	//Query to get and display student personal schedule only
	public ResultSet uniqueScheduleDat(String studentId) throws SQLException {
		ResultSet rs = null;
	try {
    		
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			String query = "select distinct classregistration.ClassName from studentdata, classregistration, gradeevent where studentdata.studentId ="+studentId+" order by FirstName, ClassName;";
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
			int Zip, int Phone) {			
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
	  				modifiablePhone = Phone;
	  				
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
	//retrieve changes from student personal data
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException,  IOException {
		String studentid = req.getParameter("StudentID");
		String firstname = req.getParameter("FirstName");
		String lastname = req.getParameter("LastName");
		String bdate = req.getParameter("bDate");
		String address1 = req.getParameter("address");
		String city1 = req.getParameter("City");
		int zip1 =  Integer.parseInt(req.getParameter("Zip"));
		int phone1 = Integer.parseInt(req.getParameter("phone"));
		
		
		System.out.println("New stuff:"+firstname+" "+lastname +" "+address1 +" "+bdate+" "+" "+city1+" "+" "+zip1+" "+" "+phone1+" ");
		String query = "SELECT * FROM studentdata WHERE StudentId='"+studentid+"';";
		
		if(updateUniqueStudent(studentid, firstname, lastname, bdate, address1, city1,  zip1, phone1)) 
		{
			res.setHeader("Refresh", "0; URL=" + req.getContextPath() + "/studentDashboard.jsp?firstName="+firstname+"&lastName="+lastname+"&studentId="+studentid+""); 

		} else {
			req.setAttribute("message",ErrorMessages);
			req.getRequestDispatcher("studentDashboard.jsp").forward(req, res);
		}

	}

}
