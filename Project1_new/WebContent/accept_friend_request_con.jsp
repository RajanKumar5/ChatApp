<%@page import="javax.swing.text.TabExpander"%>
<%@page import="java.sql.*" %>
<%@page import="db_data.DB_Details" %>

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
		PreparedStatement friend_stmt = null;
		PreparedStatement stmt = null;
		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		PreparedStatement stmt4 = null;
		
		String friend_uid = DB_Details.UID(friend_email);
		String uid = DB_Details.UID(my_email);
		
		String chatTable = DB_Details.getChatTableName(friend_uid, uid);
		
		try{
			String friend_tableName = friend_uid + "_friendList";
			String tableName = uid + "_friendList";
			String VT1 = uid + "_visibility";
			String VT2 = friend_uid + "_visibility";
			
			String friend_sql = "insert into " + friend_tableName + " values(?, ?)";	
			String sql = "insert into " + tableName + " values(?, ?)"; 
			String remove_from_friendRequest = "delete from " + uid +"_friendRequest where email = ?";
			String chatSQL = "create table " + chatTable + " (email varchar(100) not null, message varchar(2000) not null, time varchar(100) not null, "+ VT1 +" varchar(6) not null, "+ VT2 +" varchar(6) not null)";
			String remove_from_sendRequest = "delete from " + friend_uid +"_sendRequest where email = ?";
			
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			con = DriverManager.getConnection(url,uname,pass);
			
			stmt = con.prepareStatement(sql);
			friend_stmt = con.prepareStatement(friend_sql);
			stmt2 = con.prepareStatement(remove_from_friendRequest);
			stmt3 = con.prepareStatement(chatSQL);
			stmt4 = con.prepareStatement(remove_from_sendRequest);
			
			stmt.setString(1, friend_email);
			stmt.setString(2, friend_name);
			friend_stmt.setString(1, my_email);
			friend_stmt.setString(2, my_name);
			stmt2.setString(1, friend_email);
			stmt4.setString(1, my_email);
			
			stmt.executeUpdate();
			friend_stmt.executeUpdate();
			stmt2.executeUpdate();
			stmt3.executeUpdate();
			stmt4.executeUpdate();
			
			%>
				<script>
					alert("User added to your friend list.");
				</script>
			<%
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
			if(stmt != null){
				stmt.close();
			}	
			if(friend_stmt != null){
				friend_stmt.close();
			}
			if(stmt2 != null){
				stmt2.close();
			}
			if(stmt3 != null){
				stmt3.close();
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
