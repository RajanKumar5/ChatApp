<%@page import="java.sql.*"%>
<%@page import="db_data.*" %>

<% 
	String email = session.getAttribute("email") + "";
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	String otp = request.getParameter("otp");
	String password = request.getParameter("password");
	
	Connection con = null;
	PreparedStatement stmt = null;
	PreparedStatement stmt1 = null;
	ResultSet rs = null;
	
	try{
		String sql = "select * from users where email = ?";
		String query = "update users set password = ?, otp_flag = ? where email = ?";

		Class.forName("com.mysql.cj.jdbc.Driver");
 		String url = DB_Details.getURL();
 		String uname = DB_Details.getUsername();
 		String pass = DB_Details.getPassword();
		con = DriverManager.getConnection(url,uname,pass);
		stmt = con.prepareStatement(sql);
		stmt.setString(1, email);
		rs = stmt.executeQuery();
		stmt1 = con.prepareStatement(query);
		if(rs.next()){
			String db_otp = rs.getString("otp");
			String db_otp_flag = rs.getString("otp_flag");
			if(otp.equals(db_otp) && db_otp_flag.equals("valid")){
				stmt1.setString(1, password);
				stmt1.setString(2, "invalid");
				stmt1.setString(3, email);
				stmt1.executeUpdate();
				%>
					<script>
						alert("Password changed successfully.");
					</script>
				<%
				session.invalidate();
				RequestDispatcher rd = request.getRequestDispatcher("temp.jsp");
				rd.include(request, response);
			}
			else{
				%>
					<script>
						alert("Incorrect OTP. Enter correct OTP.");
					</script>
				<%
			}
			RequestDispatcher rd = request.getRequestDispatcher("forgot-password");
			rd.include(request, response);
		}
	}
	catch(Exception e){
		e.printStackTrace();
		if(e instanceof javax.servlet.ServletException){
			RequestDispatcher rd = request.getRequestDispatcher("login");
			rd.include(request, response);
		}
		else{
			%>
				<script>
					alert("Something went wrong! Please try again.");
				</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("login");
			rd.include(request, response);
		}
	}
	finally{
		if(rs != null){
			rs.close();
		}
		if(stmt1 != null){
			stmt1.close();
		}
		if(stmt != null){
			stmt.close();
		}
		if(con != null){
			con.close();
		}
	}
%>