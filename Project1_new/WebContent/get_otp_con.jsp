<%@page import="java.sql.*"%>
<%@page import="java.util.Random"%>
<%@page import="mail_service.*" %>
<%@page import="db_data.*" %>

<% 
	String email = request.getParameter("email");
	session.setAttribute("email", email);
	session.setMaxInactiveInterval(1000);

	
	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	PreparedStatement stmt1 = null;
	
	try{
		String query = "select * from users where email = ?";
		String url = DB_Details.getURL();
		String uname = DB_Details.getUsername();
		String pass = DB_Details.getPassword(); 
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(url,uname,pass);
		stmt1 = con.prepareStatement(query);
		stmt1.setString(1, email);
		rs = stmt1.executeQuery();		
		if(rs.next()){

			Random rand = new Random();
			String a = rand.nextInt(9) + "";
			String b = rand.nextInt(9) + "";
			String c = rand.nextInt(9) + "";
			String d = rand.nextInt(9) + "";
			String OTP = a+b+c+d;
			
			String sub = "OTP for password reset";
			String msg= "Dear User, \nYour OTP to reset your account password is : " + OTP + "\nPlease don't share this OTP with anyone.";
			//JavaMailUtil.sendMail(email, sub, msg);
			DB_Details.sendMail(email, sub, msg);
			
			String sql = "update users set otp = ?, otp_flag = ? where email = ?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, OTP);
			stmt.setString(2, "valid");
			stmt.setString(3, email);
			stmt.executeUpdate();
			response.sendRedirect("forgot-password");
		}
		else{
			session.invalidate();
			%>
				<script>
					alert("Enter valid Email Address!");
				</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("login");
			rd.include(request, response);
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
			RequestDispatcher rd = request.getRequestDispatcher("login");
			rd.include(request, response);
		}
		else{
			%>
			<script>
				alert("Something went wrong. Please try again later.");
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