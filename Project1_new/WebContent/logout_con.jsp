<%@page import="java.util.Date"%>
<%@page import="db_data.DB_Details"%>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	String email = session.getAttribute("email") + "";
	
	String dateTime = new Date() + "";
	
	dateTime = "Last seen : " + dateTime;
	
	DB_Details.setStatus(email, dateTime);
	
	session.invalidate();
	response.sendRedirect("home");
%>