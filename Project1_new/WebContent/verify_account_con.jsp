<%@page import="java.sql.*"%>
<%@page import="db_data.*" %>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");


	Connection con = null;	
	PreparedStatement stmt = null;
	PreparedStatement stmt1 = null;
	ResultSet rs = null;
	try{
		
		String OTP = request.getParameter("otp");
		String email = session.getAttribute("email") + "";
		
		String url = DB_Details.getURL();
		String uname = DB_Details.getUsername();
		String pass = DB_Details.getPassword(); 
		String sql = "select otp, otp_flag from users where email = ?";
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(url,uname,pass);
		stmt = con.prepareStatement(sql);
		stmt.setString(1, email);
		rs = stmt.executeQuery();
		if(rs.next()){
			String db_otp = rs.getString("otp");
			String db_otp_flag = rs.getString("otp_flag");
			if(db_otp.equals(OTP) && db_otp_flag.equals("valid")){
				String sql1 = "update users set otp_flag = ?, verification = ? where email = ?";
				stmt1 = con.prepareStatement(sql1);
				stmt1.setString(1, "invalid");
				stmt1.setString(2, "done");
				stmt1.setString(3, email);
				stmt1.executeUpdate();
				%>
					<script>
						alert("Account verified successfully. Please login.");
					</script>
				<%
				RequestDispatcher rd = request.getRequestDispatcher("login");
				rd.include(request, response);
				session.invalidate();
			}
			else{
				%>
					<script>
						alert("Invalid OTP! Enter valid OTP.");
					</script>
				<%
				RequestDispatcher rd = request.getRequestDispatcher("verify");
				rd.include(request, response);
			}
		}
	}
	catch(Exception e){
		e.printStackTrace();
		if(e instanceof com.sun.mail.util.MailConnectException){
			%>
			<script>
				alert("Can't send OTP. Please connect to internet.");
			</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("verify");
			rd.include(request, response);
		}
		else{
			%>
				<script>
					alert("Something went wrong! Please try again later.");
				</script> 
			<%
	 		RequestDispatcher rd = request.getRequestDispatcher("verify");
			rd.include(request, response);
		}
	}
	finally{
		if(rs != null){
			rs.close();
		}
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
%>