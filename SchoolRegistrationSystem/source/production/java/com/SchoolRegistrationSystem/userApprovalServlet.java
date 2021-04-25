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


/**
 * Servlet implementation class userApprovalServlet
 */
@WebServlet("/userApprovalServlet")
public class userApprovalServlet extends HttpServlet {
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
    public userApprovalServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	
	//List gets queried and sent to UserApproval.jsp
		public ResultSet getWaitingUsers() throws SQLException {
			ResultSet rs = null;
		try {
	    		
	  			//Connection to db
	  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
	  				    		    
	  			//Make a statement
	  			Statement st = con.createStatement();
	  			String query = "select *, concat(FirstName,' ',LastName) AS User from registrationuser where Promoted is Null";
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
		
		private boolean updateApproval(String Add, String Deny, int id,String passW,String nameF,
				String nameL, String eMail, String uType,int numP, int idStudent) {			
					try {
						
						
		  			//Connection to db
		  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
		  			//Make a statement
		  			Statement st = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
		  			      ResultSet.CONCUR_UPDATABLE);
		  			String query = "SELECT * FROM registrationuser WHERE RegistrationId='"+id+"';";
		  			//ResultSet
		  			System.out.println(numP);
		  			
		  			ResultSet rs = st.executeQuery(query);
		  			rs.beforeFirst();
		  			//String modifiablePromo = rs.getString("Promoted");
		  			while(rs.next()) {
	  				if (Add != null) {	  				
		  				rs.updateString("Promoted", "approved");
		  				rs.updateRow();;
	  					System.out.println("allow button Pressed ");
	  					String record="INSERT INTO users (UserId, Currentt, Rolee, FirstName,LastName,PhoneNumber,email,password,studentId) "
	  				          + "VALUES (NULL,'Yes','"+uType+"','"+nameF+"','"+nameL+"',"+numP+",'"+eMail+"','"+passW+"',"+idStudent+")";
	  				      st.executeUpdate(record);
	  					//st.executeUpdate("Insert into users");	  					  					
	  				}
	  				else if (Deny != null) {  				
		  				rs.updateString("Promoted", "denied");
		  				rs.updateRow();;
	  					System.out.println("deny button Pressed ");
	  					//st.executeUpdate("update registrationusr set Promoted = 'denied' where RegistrationId= " +id+ ";");
		  				}			
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
		
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException,  IOException {
		int id = Integer.parseInt(req.getParameter("regId"));
		
		String Add = req.getParameter("add");
		String Deny = req.getParameter("deny");		
		String passW = req.getParameter("pWord");
		String nameF = req.getParameter("firstN");
		String nameL = req.getParameter("lastN");
		String eMAIL = req.getParameter("EMAIL");
		String uType = req.getParameter("type");
		int numP = Integer.parseInt(req.getParameter("phoneN"));
		int idStudent = Integer.parseInt(req.getParameter("studID"));

		if(updateApproval(Add, Deny, id, passW, nameF, nameL,eMAIL,uType,numP,idStudent)) 
		{
			res.setHeader("Refresh", "0; URL=" + req.getContextPath() + "/userApproval.jsp"); 

		} else {
			req.setAttribute("message",ErrorMessages);
			res.setHeader("Refresh", "0; URL=" + req.getContextPath() + "/userApproval.jsp"); 
		}

	}


}
