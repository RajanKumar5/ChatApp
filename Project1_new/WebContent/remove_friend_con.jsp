<%@page import="db_data.*" %>
<%@page import="java.sql.*" %>

<%

	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
		Connection con = null;
		PreparedStatement stmt1 = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt5 = null;
		
		String email = session.getAttribute("email") + "";
		String friend_email = request.getParameter("email");
		
		try{
			String uid = DB_Details.UID(email);
			String friend_uid = DB_Details.UID(friend_email);
			
			String table1 = uid + "_friendList";
			String table2 = friend_uid + "_friendList";
			String chatTable = DB_Details.getChatTableName(uid, friend_uid);
			
			String sql1 = "delete from " + table1 + " where email = ?";
			String sql2 = "delete from " + table2 + " where email = ?";
			String sql5 = "drop table " + chatTable;
			
			String url = DB_Details.getURL();
			String uname = DB_Details.getUsername();
			String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			stmt1 = con.prepareStatement(sql1);
			stmt2 = con.prepareStatement(sql2);
			stmt5 = con.prepareStatement(sql5);
			
			stmt1.setString(1, friend_email);
			stmt2.setString(1, email);
			
			stmt1.executeUpdate();
			stmt2.executeUpdate();
			stmt5.executeUpdate();
			
			
			%>
				<script>
					alert("User removed from your friend list.");
				</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("manage-friends");
			rd.include(request, response);
		}
		catch(Exception e){
			e.printStackTrace();
			%>
				<script>
					alert("Something went wrong. Please try again later.");
				</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("user-homepage");
			rd.include(request, response);
		}
		finally{
			if(stmt1 != null){
				stmt1.close();
			}
			if(stmt2 != null){
				stmt2.close();
			}
			if(stmt5 != null){
				stmt5.close();
			}
			if(con != null){
				con.close();
			}
		}	
	}
%>