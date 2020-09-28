<%@page import="javax.swing.text.TabExpander"%>
<%@page import="java.sql.*" %>
<%@page import="db_data.*" %>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
		String friend_name = request.getParameter("name");
		String friend_email = request.getParameter("email");
		
		String my_name = session.getAttribute("name") + "";
		String my_email = session.getAttribute("email") + "";
		
		Connection con = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt4 = null;
		
		String friend_uid = DB_Details.UID(friend_email);
		String uid = DB_Details.UID(my_email);
			
		try{
			String remove_from_friendRequest = "delete from " + uid +"_friendRequest where email = ?";
			String remove_from_sendRequest = "delete from " + friend_uid +"_sendRequest where email = ?";
			
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			con = DriverManager.getConnection(url,uname,pass);
			
			stmt2 = con.prepareStatement(remove_from_friendRequest);
			stmt4 = con.prepareStatement(remove_from_sendRequest);
			
			stmt2.setString(1, friend_email);
			stmt4.setString(1, my_email);
			
			stmt2.executeUpdate();
			stmt4.executeUpdate();
			
			RequestDispatcher rd = request.getRequestDispatcher("friend-request");
			rd.include(request, response);
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
			if(stmt2 != null){
				stmt2.close();
			}
			if(stmt4 != null){
				stmt4.close();
			}
			if(con != null){
				con.close();
			}
		}
	}
%>
