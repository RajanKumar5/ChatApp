<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import="db_data.*" %>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

if(session.getAttribute("email") == null || session.getAttribute("name") == null){
	response.sendRedirect("home");
}
else{
	Blob image = null;
	Connection con = null;
	byte[ ] imgData = null ;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String email = request.getParameter("email");
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String url = DB_Details.getURL();
		String uname = DB_Details.getUsername();
		String pass = DB_Details.getPassword(); 
		con = DriverManager.getConnection(url,uname,pass);
		String sql = "select image from users where email = ?";
		stmt = con.prepareStatement(sql);
		stmt.setString(1, email);
		rs = stmt.executeQuery();
		if (rs.next()) {
			image = rs.getBlob(1);
			imgData = image.getBytes(1,(int)image.length());
		}
		else {
			out.println("Display Blob Example");
			out.println("image not found for given id>");
			return;
		}
		// display the image
		response.setContentType("image/jpg");
		OutputStream o = response.getOutputStream();
		o.write(imgData);
		o.flush();
		o.close();
		out.clear(); // where out is a JspWriter
		out = pageContext.pushBody();
	} 
	catch (Exception e) {
		e.printStackTrace();
	} 
	finally {
		try{
			if(rs != null){
				rs.close();
			}
			if(stmt != null){
				stmt.close();
			}
			if(con != null){
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
%>