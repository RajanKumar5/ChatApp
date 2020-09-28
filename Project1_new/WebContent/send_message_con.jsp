<%@page import="db_data.*" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date" %>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
		String email = session.getAttribute("email") + "";
		
		String message = request.getParameter("message");
		
		Connection con = null;
		PreparedStatement stmt = null;
		
		String tableName = session.getAttribute("tableName") + "";
		
		try{
			String time = new Date() + "";
			
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			con = DriverManager.getConnection(url,uname,pass);
			
			String sql = "insert into " + tableName + " values (?, ?, ?, ?, ?)";
			
			stmt = con.prepareStatement(sql);
			stmt.setString(1, email);
			stmt.setString(2, message);
			stmt.setString(3, time);
			stmt.setString(4, "true");
			stmt.setString(5, "true");
			stmt.executeUpdate();
			RequestDispatcher rd = request.getRequestDispatcher("chat-box");
			rd.include(request, response);
		}
		catch(Exception e){
			e.printStackTrace();
			%>
				<script>
					alert("Something went wrong! Please try again later.");
				</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("chat-box");
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