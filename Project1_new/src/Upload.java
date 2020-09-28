
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import java.io.*;
import javax.servlet.http.Part;

import db_data.DB_Details;

@WebServlet("/Upload")
@MultipartConfig(maxFileSize = 16177215)

public class Upload extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        InputStream inputStream = null; 
         
        Part filePart = request.getPart("image");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
         
        Connection con = null; 
        PreparedStatement stmt = null; 
        HttpSession session = request.getSession(); 
        String email = session.getAttribute("email") + "";
        
        try {
        	String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			con = DriverManager.getConnection(url,uname,pass);
 
            // constructs SQL statement
            String sql = "update users set image = ? where email = ?";
            stmt = con.prepareStatement(sql);
             
//            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                stmt.setBlob(1, inputStream);
                stmt.setString(2, email);
            //}
 
            // sends the statement to the database server
            int row = stmt.executeUpdate();
            if (row > 0) {
                System.out.println("File uploaded and saved into database");
            }
            response.sendRedirect("user-account");
        } 
        catch (SQLException ex) {
            ex.printStackTrace();
        } 
        finally {
            if(stmt != null) {
                try {
					stmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
            if(con != null){
            	try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
        }
	}
}