<%@page import="java.sql.*"%>
<%@page import="java.util.Random"%>
<%@page import="mail_service.*" %>
<%@page import="db_data.*" %>

<% 
	String email = session.getAttribute("email") + "";
	
	Connection con = null;
	PreparedStatement stmt = null;
	
	try{
		Random rand = new Random();
		String a = rand.nextInt(9) + "";
		String b = rand.nextInt(9) + "";
		String c = rand.nextInt(9) + "";
		String d = rand.nextInt(9) + "";
		String OTP = a+b+c+d;
		
		String sub = "OTP for account verification";
		String msg = "Dear User,\nYour OTP for account verification is : " + OTP + "\nPlease don't share this OTP with anyone. ";
		//JavaMailUtil.sendMail(email, sub, msg);
		DB_Details.sendMail(email, sub, msg);
		
		String url = DB_Details.getURL();
 		String uname = DB_Details.getUsername();
 		String pass = DB_Details.getPassword(); 
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(url,uname,pass);
		String sql = "update users set otp = ?, otp_flag = ? where email = ?";
		stmt = con.prepareStatement(sql);
		stmt.setString(1, OTP);
		stmt.setString(2, "valid");
		stmt.setString(3, email);
		stmt.executeUpdate();
		RequestDispatcher rd = request.getRequestDispatcher("verify");
		rd.include(request, response);
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
				alert("Something went wrong! Please try again.");
			</script>
			<%
			RequestDispatcher rd = request.getRequestDispatcher("verify");
			rd.include(request, response);	
		}
	}
	finally{
		if(stmt != null){
			stmt.close();
		}	
		if(con != null){
			con.close();
		}
	}
%>