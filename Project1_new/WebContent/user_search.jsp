<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="db_data.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>

<% 
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
%>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">

    <title>UserList|ChatApp</title>
    <style type="text/css">
      #imgr{
        width:65px;
        height:65px;
      }
      body{
        background-color:#e2e2e2;
        }
      nav{
      background-color:#00695c;
      }
      table,.inp{
        background-color:#00796b ;
        }
      .inp{
        margin-top: 10px;
        text-align: center;
        border: none;
        color:white;
      }
      .btn{
        background: #383838;
        border: none;
        margin-top: 10px;
      }
    </style>
  </head>
  <body>
       <nav id="nav1" class="navbar navbar-expand-sm navbar-dark fixed-top">
    <div class="container">
  <a class="navbar-brand" href="user-homepage">ChatApp</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <!--  -->
      <ul class="navbar-nav ml-auto">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Settings
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="user-account">Account</a>
          <a class="dropdown-item" href="manage-friends">Manage Friends</a>
          <a class="dropdown-item" href="friend-request">Friend Request<span class="badge badge-pill badge-danger"><%= DB_Details.getFR(session.getAttribute("email") + "")%></span></a>
          <a class="dropdown-item" href="logout">Logout</a>
        </div>
      </li>
      
     </ul>
  </div>
   
</div>

</nav>


<div class="container mt-5 pt-5">
  <div class="row">
    <div class="col-sm-1"></div>
    <div class="col-sm-10">
      <table class="table">
        <thead>
          <tr class="text-center">
            <th colspan="3">Search Result</th>
          </tr>
        </thead>
          <tbody>
  <% 
  	Connection con = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String search_name = request.getParameter("name");
	try{
		String sql = "select name, email from users where name like '%"+ search_name +"%' or email = ? order by name";
		String url = DB_Details.getURL();
		String uname = DB_Details.getUsername();
		String pass = DB_Details.getPassword(); 
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(url,uname,pass);	
		stmt = con.prepareStatement(sql);
		stmt.setString(1, search_name);
		rs = stmt.executeQuery();
		int f = 0;
		ArrayList<String> sendList = DB_Details.getSendList(session.getAttribute("email") + "");
		while(rs.next()){
			String friend_name = rs.getString("name");
			String friend_email = rs.getString("email");	
			if(! session.getAttribute("email").equals(friend_email)){
				int index = sendList.indexOf(friend_email);
				if(index == -1){
					%>
						<tr>
							<form action="send-friend-request" method="post">
							<%
								Boolean image = DB_Details.isImage(friend_email);
								if(image.equals(true)){
									%>
										<td><img src="view.jsp?email=<%=friend_email %>" id="imgr" alt="Can't load image." class="img-fluid rounded-circle mb-1"></td>	
									<%
								}
								else{
									%>
										<td><img src="avtar.jpg" id="imgr" alt="Can't load image." class="img-fluid rounded-circle mb-1"></td>
									<%
								}
							%>
						     
						     <td><input type="text" name="name" readonly="" class="inp" value="<%= friend_name%>">
						         <input type="hidden" name="email" id="custId" value="<%= friend_email%>">
						     </td>
						     <td><button type="submit" class="btn btn-success btn-sm text-center">Add Friend</button></td>
						   	</form>
						</tr>
					<%		
				}
				else{
					%>
						<tr>
							<form action="cancel-friend-request" method="post">
							<%
								Boolean image = DB_Details.isImage(friend_email);
								if(image.equals(true)){
									%>
										<td><img src="view.jsp?email=<%=friend_email %>" id="imgr" alt="Can't load image." class="img-fluid rounded-circle mb-1"></td>	
									<%
								}
								else{
									%>
										<td><img src="avtar.jpg" id="imgr" alt="Can't load image." class="img-fluid rounded-circle mb-1"></td>
									<%
								}
							%>
						     <td><input type="text" name="name" readonly="" class="inp" value="<%= friend_name%>">
						         <input type="hidden" name="email" id="custId" value="<%= friend_email%>">
						     </td>
						     <td><button type="submit" class="btn btn-danger btn-sm text-center">Cancel Friend Request</button></td>
						   	</form>
						</tr>
					<%
				}
			
				f++;
			}
		}
		if(f == 0){
			%>
			<tr class="text-center">
		      <th colspan="3">No users found.</th>
		    </tr>
			<%	
		}
	}
	catch(Exception e){
		e.printStackTrace();
		%>
			<script>
				alert("Something went wrong! Please try again later.");
			</script>
		<%
		RequestDispatcher rd = request.getRequestDispatcher("user-homepage");
		rd.include(request, response);
	}
	finally{
		if(rs != null){
			rs.close();
		}
		if(stmt != null){
			stmt.close();
		}
		if(con != null){
			con.close();
		}
	}
  %>
    
    
            </tbody>
         </table>
    </div>
    <div class="col-sm-1"></div>

  </div>
</div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>
<% 
	}
%>