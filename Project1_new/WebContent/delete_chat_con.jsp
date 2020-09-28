<%@page import="java.sql.PreparedStatement"%>
<%@page import="db_data.*" %>
<%@page import="java.sql.*" %>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
		String tableName = session.getAttribute("tableName") + ""; 
		
		Connection con = null;
		PreparedStatement stmt = null;
		try{
			String VT = DB_Details.UID(session.getAttribute("email") + "") + "_visibility";  
			
			String sql = "update " + tableName + " set " + VT + " = ?";
			String email = session.getAttribute("email") + "";
			
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);	
		
			stmt = con.prepareStatement(sql);
			stmt.setString(1, "false");
			stmt.executeUpdate();
			
			RequestDispatcher rd = request.getRequestDispatcher("chat-box");
			rd.include(request, response);
			//response.sendRedirect("chat-box");
		}
		catch(Exception e){
			e.printStackTrace();
			%>
				<script>
					alert("Something went wrong! Please try again later.");
				</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("user-homepage");
			rd.include(request, response);
		}
		finally{
			if(stmt != null){
				stmt.close();
			}
			if(con != null){
				con.close();
			}
		}
		
	}
%>