<%@page import="db_data.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>

<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	

	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
		String email = session.getAttribute("email") + "";
		String friend_name = request.getParameter("name");
		String friend_email = request.getParameter("email");
		
		String status = DB_Details.getStatus(friend_email);
		if(email != null && friend_email != null){
			String tableName = DB_Details.getChatTableName(DB_Details.UID(email), DB_Details.UID(friend_email));
			session.setAttribute("tableName", tableName);
			session.setAttribute("friendName", friend_name);
			session.setAttribute("friendEmail", friend_email);
		}
		friend_email = session.getAttribute("friendEmail") + "";
%>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    

    <title>ChatBox|ChatApp</title>
    <style type="text/css">
      body{
        background-color: #00796b;
        color: white;
      }
      nav{
        background-color:#00695c ;
      }
      .bb{
      background-color:#00695c ;
      }
      .enc{
      color:#9e9d24;
      }
      .scrollable{
       height:290px;
       overflow: scroll;
      }
       .scrollable::-webkit-scrollbar{
        color: #383838;
      }  
      #imgr{
        width:50px;
        height:50px;
      }
      #h{
        background: #00695c;
        color:white;
        border: none;
        resize:none;
      }
      .bg{
        color:white;
        width: 70%;
      }
      .bg1{
        color: #ffab00 ;
        margin-left: 30%;
      }
      .d-block{
        margin-top: 70%;
      }
      .footer {
         position: fixed;  
        bottom: 0;
         color: white;
         width: 100%;
         text-align: center;
      }
      table{
      background-color:#00695c ;
      }
  </style>
          <script type="text/javascript" src="check1.js"></script>
          <script>
		     setInterval(reloaddata, 1000);
		  </script>
		  <script type="text/javascript">
		  var submit = document.getElementById('brr');

		  submit.addEventListener('click', function(){
		  var textContent = document.querySelector('textarea').value;
		    
		  document.getElementById('result').innerHTML = textContent.replace(/\n/g, '<br/>');
		    

		  });
		  </script>
		  

  </head>
  <body>
  <nav id="nav1" class="navbar navbar-expand-sm navbar-dark fixed-top">
    <div class="container">
  <a class="navbar-brand" href="user-homepage">ChatApp</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
<ul class="navbar-nav ml-auto">
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Settings
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="user-account">Account</a>
          <a class="dropdown-item" href="manage-friends">Manage Friends<span class="badge badge-pill badge-danger"><%= DB_Details.getFriendCount(email) %></span></a>
          <a class="dropdown-item" href="friend-request">Friend Request<span class="badge badge-pill badge-danger"><%= DB_Details.getFR(email) %></span></a>
          <a class="dropdown-item" href="logout">Logout</a>
        </div>
      </li>
      
     </ul>
      
   
</div>
</nav>

<div class="container mt-3 pt-5">
  <div class="row">
    <div class="col-sm-4">
      <div class="media">
      		<%
              	Boolean image = DB_Details.isImage(friend_email);
              	if(image.equals(true)){
              		%>
              			<img src="view.jsp?email=<%= friend_email%>" class="img-fluid rounded-circle mt-3 mb-2 mr-2" id="imgr" alt="Can't load image.">
              		<%	
              	}
              	else{
              		%>
              			<img src="avtar.jpg" class="img-fluid rounded-circle mt-3 mb-2 mr-2" id="imgr" alt="Can't load image.">
              		<%
              	}
              %>
        <div class="media-body">
          <h5 class="mt-2"><label><%= session.getAttribute("friendName")%></label></h5>
          <small class="mb-5"><label><%= DB_Details.getStatus(session.getAttribute("friendEmail") + "")%></label></small>
        </div>
      </div>
    </div>
    <div class="col-sm-4">
      <form action="delete-chat">
      	<button class="btn btn-danger btn-sm">Clear Chat<i class="fas fa-trash-alt ml-2"></i></button>
      </form>
      <!-- <form action="">
      	<button class="btn btn-success btn-sm">Save Chat<i class="fas fa-download ml-2"></i></button>
      </form> -->	
    </div>
    <div class="col-sm-4"></div> 
  </div>
</div>
<!-- d-block d-sm-none -->
<div class="container bb">
  <div class="row">
    <div class="col-sm-1"></div>
    <div class="col-sm-10">
     <div class="scrollable" id="abcd">
     <p class="text-center enc">Start Conversation!!!!!</p> 
     	<div id="list">
     	<div id="content"></div>
      	
      <p id="result" class="bg text-left"></p>
      <p id="result" class="bg1 text-right"></p>
     	</div>
     	
     </div>
<!--         <div class="d-block d-sm-none text-center ">Your Chat will be deleted After 12hrs</div>
 -->   </div>
    <div class="col-sm-1"></div>
  </div>
</div>


<div class="container footer">
  <div class="row text-center">
    <div class="col-sm-3"></div>
    <div class="col-sm-6">
         <table class="table table-borderless text-center">
          <tr>            
          
          <td> 
            <div class="md-form amber-textarea active-amber-textarea">
              <textarea id="h" name="message" class="sm-textarea form-control" cols="50" placeholder="Message"></textarea>
              <input type="hidden" name="name" value="<%= friend_name%>">
              <input type="hidden" name="email" value="<%= friend_email %>">
            </div>
          </td>
        
          <td><button id="brr" class="btn btn-primary btn-sm mt-3" onclick="addText()"><i class="fas fa-paper-plane"></i></button>
          </td>
        </tr>
        
       </table>
     </div>
  <div class="col-sm-3"></div>
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