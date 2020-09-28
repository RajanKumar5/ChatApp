package db_data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import mail_service.JavaMailUtil;


public class DB_Details{
	public static String getURL(){
		/*return "jdbc:mysql://project1.cvqwklvcfmhx.us-east-1.rds.amazonaws.com:3306/project1";*/
		return "jdbc:mysql://localhost:3307/project1";
	}
	
	public static String getUsername(){
		return "root";
	}
	
	public static String getPassword(){
		return "root";
	}
	
	public static String UID(String email){
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String uid = null;
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
	  		String query = "select * from users where email = ?";		
	  		stmt = con.prepareStatement(query);
	  		stmt.setString(1, email);
	  		rs = stmt.executeQuery();
	  		if(rs.next()){
	  			uid = rs.getString("uid");
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
		return uid;
	}
	
	public static ArrayList<String> getFriendList(String email){
		ArrayList<String> friendList = new ArrayList<String>();
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			String sql = "select email from " + UID(email) + "_friendList";
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			while(rs.next()){
				String mail = rs.getString("email");
				friendList.add(mail);
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

		return friendList;
	}
	
	public static ArrayList<String> getRequestList(String email){
		ArrayList<String> requestList = new ArrayList<String>();
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			String sql = "select email from " + UID(email) + "_friendRequest";
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			while(rs.next()){
				String mail = rs.getString("email");
				requestList.add(mail);
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
		return requestList;
	}
	
	public static String getChatTableName(String uid1, String uid2){
		int a = Integer.parseInt(uid1);
		int b = Integer.parseInt(uid2);
		
		int min = Math.min(a, b);
		int max = Math.max(a, b);
		
		String tableName = min + "_" + max + "_chat";
		return tableName;
	}
	
	public static String getStatus(String email){		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String status = null;
		
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			String sql = "select status from  users where email = ?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, email);
			
			rs = stmt.executeQuery();
			
			if(rs.next()){
				status = rs.getString("status");
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
		return status;
	}
	
	public static void setStatus(String email, String status){
		Connection con = null;
		PreparedStatement stmt = null;
		
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			String sql = "update users set status = ? where email = ?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, status);
			stmt.setString(2, email);
			
			stmt.executeUpdate();
		}
		catch(Exception e){
			e.printStackTrace();
		}
		finally{
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
	
	public static String getFR(String email){
		String count = "";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			String tableName = UID(email) + "_friendRequest";
			
			String sql = "select count(*) as count from " + tableName;
			stmt = con.prepareStatement(sql);
			
			
			rs = stmt.executeQuery();
			if(rs.next()){
				count = rs.getString("count");
				return count;
			}
			return "0";
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
		return count;
	}
	
	public static String getFriendCount(String email){
		String count = "";
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			String tableName = UID(email) + "_friendList";
			
			String sql = "select count(*) as count from " + tableName;
			stmt = con.prepareStatement(sql);
			
			
			rs = stmt.executeQuery();
			if(rs.next()){
				count = rs.getString("count");
				return count;
			}
			return "0";
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
		return count;
	}
	
	public static ArrayList<String> getSendList(String email){
		ArrayList<String> sendList = new ArrayList<String>();
		
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			String sql = "select email from " + UID(email) + "_sendRequest";
			stmt = con.prepareStatement(sql);
			
			rs = stmt.executeQuery();
			while(rs.next()){
				String mail = rs.getString("email");
				sendList.add(mail);
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
		return sendList;
	}
	
	public static boolean isImage(String email){
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		Boolean image = true;
		try{
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			
			String sql = "select uid from users where image is null and email = ?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, email);
			
			rs = stmt.executeQuery();
			
			if(rs.next()){
				image = false;
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
		return image;
	}
	
	public static void sendMail(String reciepient, String sub, String msg) throws Exception{
		System.out.println("Preparing to send email..");
		Properties properties = new Properties();
		
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");
		
		String myAccountEmail = "service.chatapp.mail@gmail.com";
		String password = "Sunny123456*";
		
		Session session = Session.getInstance(properties, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication(){
				return new PasswordAuthentication(myAccountEmail, password);
			}
		});
	
		Message message = prepareMessage(session, myAccountEmail, reciepient, sub, msg);
		
		Transport.send(message);
		System.out.println("Message send successfully.");
	}
	
	public static Message prepareMessage(Session session, String myAccountEmail, String reciepient, String sub, String msg) {
		try{
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(myAccountEmail));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(reciepient));
			message.setSubject(sub);
			message.setText(msg);
			return message;
		}
		catch(Exception e){
			Logger.getLogger(JavaMailUtil.class.getName()).log(Level.SEVERE, null, e);
		}
		return null;
	}
}
