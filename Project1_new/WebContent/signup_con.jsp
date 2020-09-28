<%@page import="java.util.Random"%>
<%@page import="com.mysql.cj.x.protobuf.MysqlxSql.StmtExecute"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*" %>
<%@page import="db_data.*" %>
<%@page import="mail_service.*" %>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String dob = request.getParameter("dob");
	String password = request.getParameter("password");
	String date_joined = new Date() + "";
	
		Connection con = null;
 		PreparedStatement stmt = null;
 		PreparedStatement stmt1 = null;
 		PreparedStatement stmt2 = null;
		PreparedStatement stmt3 = null;
		PreparedStatement stmt4 = null;
		
		try{
	 		String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			String sql = "insert into users (name, email, dob, date_joined, password, otp, otp_flag, verification) values(?, ?, ?, ?, ?, ?, ?, ?)";
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			stmt = con.prepareStatement(sql);
			stmt.setString(1, name);
			stmt.setString(2, email);
			stmt.setString(3, dob);
			stmt.setString(4, date_joined);
			stmt.setString(5, password);
			stmt.setString(6, "0000");
			stmt.setString(7, "invalid");
			stmt.setString(8, "pending");
			stmt.executeUpdate();
			
			
			String uid = DB_Details.UID(email);
			String friend_table = uid + "_friendList";
			String req_table = uid + "_friendRequest";
			String send_table = uid + "_sendRequest";

			String friendList_sql = "create table " + friend_table + "(email varchar(100) primary key, name varchar(100) not null)";
			stmt2 = con.prepareStatement(friendList_sql);
			stmt2.executeUpdate();
	
			String friendRequest_sql = "create table " + req_table + "(email varchar(100) primary key, name varchar(100) not null)";
			stmt3 = con.prepareStatement(friendRequest_sql);
			stmt3.executeUpdate();
			
			String sendRequest_sql = "create table " + send_table + "(email varchar(100) primary key, name varchar(100) not null)";
			stmt4 = con.prepareStatement(sendRequest_sql);
			stmt4.executeUpdate();
			
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
			
			sql = "update users set otp = ?, otp_flag = ? where email = ?";
			stmt1 = con.prepareStatement(sql);
			stmt1.setString(1, OTP);
			stmt1.setString(2, "valid");
			stmt1.setString(3, email);
			stmt1.executeUpdate();
	 		session.setAttribute("email", email);
	 		session.setMaxInactiveInterval(1000);
			
	 		%>
	 		<script>
				alert("Your account has been created. Please verify your Email Address.");
			</script> 
			<%
			RequestDispatcher rd = request.getRequestDispatcher("verify");
			rd.include(request, response);
		}
		catch(Exception e){
			e.printStackTrace(); 
			if(e instanceof SQLIntegrityConstraintViolationException){
				%>
	 			<script>
					alert("Account already exists with this Email. Please login.");
				</script> 
				<%
		 		RequestDispatcher rd = request.getRequestDispatcher("login");
				rd.include(request, response);
			}
			else if(e instanceof com.sun.mail.util.MailConnectException){
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
		 		RequestDispatcher rd = request.getRequestDispatcher("signup");
				rd.include(request, response);	
			}
		}
	 	finally{
	 		if(stmt != null){
	 			stmt.close();
	 		}
	 		if(stmt1 != null){
	 			stmt1.close();
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
%>
