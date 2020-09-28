<%@page import="java.util.Date"%>
<%@page import="java.sql.*" %>
<%@page import="db_data.DB_Details" %>
<% 		
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	try{
		String sql = "select * from users where email = ? and password = ?";
		Class.forName("com.mysql.cj.jdbc.Driver");
 		String url = DB_Details.getURL();
 		String uname = DB_Details.getUsername();
 		String pass = DB_Details.getPassword();
		con = DriverManager.getConnection(url,uname,pass);
		stmt = con.prepareStatement(sql);
		stmt.setString(1, email);
		stmt.setString(2, password);
		rs = stmt.executeQuery();
		if(rs.next()){
			String verification = rs.getString("verification");
			if(verification.equals("pending")){
				session.setAttribute("email", email);
				response.sendRedirect("verify");
			}
			else{
				DB_Details.setStatus(email, "online");
				String name = rs.getString("name");
				session.setAttribute("name", name);
				session.setAttribute("email", email);
				/* session.setMaxInactiveInterval(1000); */
				response.sendRedirect("user-homepage");	
			}
		}
		else{
			%>
			<script>
				alert("Login failed! Incorrect email address or password.");
			</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("login");
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
		RequestDispatcher rd = request.getRequestDispatcher("login");
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
%>
