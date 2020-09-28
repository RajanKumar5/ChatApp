<%@page import="java.sql.*" %>
<%@page import="db_data.*" %>

<html>
	<head>
		<style type="text/css">
				.clr{
					color: silver;
				}
		</style>
	</head>
</html>

<% 
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			String tableName = session.getAttribute("tableName") + "";
			
	 		Class.forName("com.mysql.cj.jdbc.Driver");

			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			con = DriverManager.getConnection(url,uname,pass);
			
			String email = session.getAttribute("email") + "";
			
			String sql = "select * from " + tableName;
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			String VT = DB_Details.UID(email) + "_visibility";
			
			while(rs.next()){
				String username = rs.getString("email");
				String msg = rs.getString("message");
				String time = rs.getString("time");
				String visibility = rs.getString(VT);
				time = " " + time.substring(4, 16);
				if(visibility.equals("true")){
					msg = msg.replace(" ", "&nbsp;");
					/* msg = msg.replace("\n", "<br/>"); */
					if(username.equals(email)){
						%>
							<pre><p id="result" class="bg1 text-right"><g><%= msg%></g><span class="clr"><small><small><small><%= time%></small></small></small></span></p></pre>
						<%
					}
					else{
						%>
							<pre><p id="result" class="bg text-left"><g><%= msg %></g><span class="clr"><small><small><small><%= time%></small></small></small></span></p></pre>
						<%
					}	
				}
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(stmt != null){
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
%>