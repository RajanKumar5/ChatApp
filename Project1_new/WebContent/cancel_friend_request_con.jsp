<%@page import="db_data.*" %>
<%@page import="java.sql.*" %>

<% 
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{		
		String my_email = session.getAttribute("email") + "";
		String my_name = session.getAttribute("name") + "";
		
		String friend_email = request.getParameter("email");
		String friend_name = request.getParameter("name");

			Connection con = null;
			PreparedStatement stmt = null;
			PreparedStatement stmt1 = null;
			
			try{		
				String friend_uid = DB_Details.UID(friend_email); 
				String uid = DB_Details.UID(my_email);
				String tableName = friend_uid + "_friendRequest";
				String send_table = uid + "_sendRequest";
				
				String sql = "delete from " + tableName + " where email = ?";
				String sql1 = "delete from " + send_table + " where email = ?";
				
				Class.forName("com.mysql.cj.jdbc.Driver");
		 		String url = DB_Details.getURL();
		 		String uname = DB_Details.getUsername();
		 		String pass = DB_Details.getPassword();
				con = DriverManager.getConnection(url,uname,pass);
				
				stmt = con.prepareStatement(sql);
				stmt.setString(1, my_email);
				stmt.executeUpdate();
				 
				stmt1 = con.prepareStatement(sql1);
				stmt1.setString(1, friend_email);
				stmt1.executeUpdate();
				
				RequestDispatcher rd = request.getRequestDispatcher("search");
				rd.include(request, response);
			}
			catch(Exception e){
				e.printStackTrace();
					%>
					<script>
						alert("Something went wrong! Please try again later.");
					</script>
					<%
					RequestDispatcher rd = request.getRequestDispatcher("search");
					rd.include(request, response);	
			}
			finally{
				if(stmt != null){
					stmt.close();
				}
				if(stmt1 != null){
					stmt1.close();
				}
				if(con != null){
					con.close();
				}
			}	
		}
%>