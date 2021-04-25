package com.SchoolRegistrationSystem;

import java.io.IOException;
import java.math.BigInteger;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ResetPasswordServlet
 */
@WebServlet("/ResetPassword")
public class ResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String ErrorMessages;
	
	  //db connection information
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
    public ResetPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    
    private boolean doesInformationMatch(String email, String firstName, String lastName, String phone) {
    	Integer phoneNumber = 0;
    	Integer resultCount = 0;
    	try {
    		phoneNumber = Integer.parseInt(phone);
    		}
    		catch (NumberFormatException e)
    		{
    		   phoneNumber = 0;
    		}
    
	
    	try {
		//Connection to db
		Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
		//Make a statement
		Statement st = con.createStatement();
		String query = "select count(*) from users where email='"+email+"' and FirstName='"+firstName+"' and LastName='"+lastName+"' and PhoneNumber='"+phone+"'";	
		
		//ResultSet
		ResultSet rs = st.executeQuery(query);
		rs.next();
		resultCount = rs.getInt("count(*)");
		
		rs.close();
		st.close();
		con.close();
  		}
		
			catch (SQLException e) {
				ErrorMessages = e.toString();
				System.out.println(e.toString());
			} catch (Exception e) {
				ErrorMessages = e.toString();
				System.out.println(e.toString());
			} 
    	
  
		if(resultCount > 0) {
			return true;
		} 
    	return false;

	}
    
    
    private boolean updatePassword(String email, String newPassword) {
		
		try {
  			//Connection to db
  			Connection con = DriverManager.getConnection(url, dbUsername, dbPassword);
  				    		    
  			//Make a statement
  			Statement st = con.createStatement();
  			
  			String query = 
  					"UPDATE users SET password='" + newPassword + "' WHERE email='" + email + "'";
  			//ResultSet
  	
  			int rs = st.executeUpdate(query);
  		
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
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		res.getWriter().append("Served at: ").append(req.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String email = req.getParameter("email");
		String firstName = req.getParameter("firstName");
		String lastName = req.getParameter("lastName");
		String phone = req.getParameter("phone");
		String newPassword = req.getParameter("newPassword");
		String newHashedPassword = null;
		try {
			newHashedPassword = hashNormalPassword(newPassword);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidKeySpecException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(doesInformationMatch(email, firstName, lastName, phone)){
			if(updatePassword(email, newHashedPassword)){
				req.setAttribute("message","Password has been reset. Please try to log in.");
				req.getRequestDispatcher("RestPassword.jsp").forward(req, res);
			} else {
				req.setAttribute("message","Reset not successful please verify that you are entering the correct information and try again.");
				req.getRequestDispatcher("RestPassword.jsp").forward(req, res);
			}
		} else {
			req.setAttribute("message","Reset not successful please verify that you are entering the correct information and try again.");
			req.getRequestDispatcher("RestPassword.jsp").forward(req, res);
		}
		
	}
	
	private String hashNormalPassword(String password) throws NoSuchAlgorithmException, InvalidKeySpecException {
		 int iterations = 1000;
	     char[] chars = password.toCharArray();
	     byte[] salt = getSalt();
	         
	     PBEKeySpec spec = new PBEKeySpec(chars, salt, iterations, 64 * 8);
	     SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
	     byte[] hash = skf.generateSecret(spec).getEncoded();
	     return iterations + ":" + toHex(salt) + ":" + toHex(hash);
	}

	private byte[] getSalt() throws NoSuchAlgorithmException {
		 SecureRandom sr = SecureRandom.getInstance("SHA1PRNG");
	     byte[] salt = new byte[16];
	     sr.nextBytes(salt);
	     return salt;
	}
	
	private String toHex(byte[] array) {

       BigInteger bi = new BigInteger(1, array);
       String hex = bi.toString(16);
       int paddingLength = (array.length * 2) - hex.length();
       if(paddingLength > 0)
       {
           return String.format("%0"  +paddingLength + "d", 0) + hex;
       }else{
           return hex;
       }
	}

}
