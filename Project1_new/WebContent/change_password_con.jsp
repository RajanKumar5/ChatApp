<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="db_data.*" %>


<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
		String email = session.getAttribute("email") + "";
		
		String old_password = request.getParameter("old_password");
		String new_password = request.getParameter("new_password");
		String confirm_password = request.getParameter("confirm_password");
		String db_password = null;
		
		if(new_password.equals(confirm_password)){
			Connection con = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			PreparedStatement stmt1 = null;
			
			
			try{
				String sql = "select password from users where email = ?";
				String query = "update users set password = ? where email = ?";
				String url = DB_Details.getURL();
		 		String uname = DB_Details.getUsername();
		 		String pass = DB_Details.getPassword(); 
				Class.forName("com.mysql.cj.jdbc.Driver");
				con = DriverManager.getConnection(url,uname,pass);
				stmt1 = con.prepareStatement(sql);
				stmt1.setString(1, email);
				rs = stmt1.executeQuery();
				if(rs.next()){
					db_password = rs.getString("password");
				}
				if(db_password.equals(old_password)){
					stmt = con.prepareStatement(query);
					stmt.setString(1, new_password);
					stmt.setString(2, email);
					stmt.executeUpdate();
					%>
						<script>
							alert("Password changed successfully.");
						</script>
					<%
					RequestDispatcher rd = request.getRequestDispatcher("user-account");
					rd.include(request, response);	
				}
				else{
					%>
						<script>
							alert("Incorrect Old Password. Try again.");
						</script>
					<%
					RequestDispatcher rd = request.getRequestDispatcher("user-account");
					rd.include(request, response);
				}
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
				if(rs != null){
					rs.close();
				}
				if(stmt != null){
					stmt.close();
				}
				if(con != null){
					con.close();
				}
			}	
		}
		else{
			%>
				<script>
					alert("New Password and Confirm Password must be same! Try again.");
				</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("user-account");
			rd.include(request, response);
		}	
	}
%>

