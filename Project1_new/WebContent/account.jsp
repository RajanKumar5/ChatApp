<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="db_data.*" %>


<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	if(session.getAttribute("email") == null || session.getAttribute("name") == null){
		response.sendRedirect("home");
	}
	else{
	
		String email = session.getAttribute("email") + "";
		
/* 		byte[ ] imgData = null;
		Blob image = null; */
		Connection con = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String name = null;
		String dob = null;
		String date_joined = null;
		
		
		try{
			String query = "select * from users where email = ?";
			String url = DB_Details.getURL();
	 		String uname = DB_Details.getUsername();
	 		String pass = DB_Details.getPassword(); 
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url,uname,pass);
			stmt = con.prepareStatement(query);
			stmt.setString(1, email);
			rs = stmt.executeQuery();
			if(rs.next()){
				name = rs.getString("name");
				dob = rs.getString("dob");
				date_joined = rs.getString("date_joined");
				date_joined = date_joined.substring(4, 11) + date_joined.substring(24);
				/* image = rs.getBlob("image");
				imgData = image.getBytes(1,(int)image.length()); */
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

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <link class="jsbin" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.0/jquery-ui.min.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
     <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">

    <title>Account|ChatApp</title>
    <script type="text/javascript">
      function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#upload')
                    .attr('src', e.target.result)
                    .width(140)
                    .height(200);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
    </script>
      <style type="text/css">
      /**{
        margin: 0;
        padding: 0;
      }*/
      body{
		background-color:#e2e2e2;
        font-family: 'Raleway',sans-serif;
        font-size: 14px;
        font-weight: 400;
        color: #777;
      }
      nav{
      background-color:#00695c;
      }
      h4{
        font-size: 22px;
        color: #333;
        font-weight: 600;
      }
      .dob{
        font-size: 20px;
        font-weight: 500;
      }

      #team img{
        margin: -50px;
        width:140px;
      	height: 140px;
      }
      #team i{
        font-size: 26px;
        color:#555;

      }
      #team .card{
        border-radius: 0;
        box-shadow: 5px 5px 15px #e74c3c;
        transition: all 0.3s ease-in;
        -webkit-transition:all 0.3s ease-in;
      }

      #team .card:hover{
        background: #00796b;
        color:#fff;
        border-radius: 5px;
        border: none;
        box-shadow: 5px 5px 10px #9E9E9E;

      }

      #team .card:hover h4,#team .card:hover i{
        color: black;
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
          <a class="dropdown-item" href="manage-friends">Manage Friends<span class="badge badge-pill badge-danger"><%= DB_Details.getFriendCount(email) %></span></a>
          <a class="dropdown-item" href="friend-request">Friend Request<span class="badge badge-pill badge-danger"><%= DB_Details.getFR(email) %></span></a>
          <a class="dropdown-item" href="logout">Logout</a>
        </div>
      </li>  
     </ul>
  </div>
   
</div>

</nav>
<div class="container">
 <div class="row">
   <div class="col-sm-4"></div>
   <div class="col-sm-4 pb-5"></div>
   <div class="col-sm-4"></div>
 </div>
</div>


<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog text-center">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Change Password</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
      <div class="modal-body">
        <form action="change-password" method="post">
              <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock fa-2x"></i>
                  </span>
                </div>
                <input type="password" name="old_password" class="form-control py-4" placeholder=" Old Password" required="">
              </div>

              <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock fa-2x"></i>
                  </span>
                </div>
                <input type="password" name="new_password" class="form-control py-4" placeholder=" New Password" required="">
              </div>

              <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock fa-2x"></i>
                  </span>
                </div>
            <input type="password" name="confirm_password" class="form-control py-4" placeholder="Confirm Password" required="">
              </div>
              <div class="modal-footer justify-content-center">
<!--         <button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Close</button>
 -->        <button type="submit" class="btn btn-primary btn-sm">Change Password</button>
      </div>
            </form>
      </div>
      
    </div>
  </div>
</div>

<div class="modal fade" id="profileChange" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog text-center">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Change Photo</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
      <div class="modal-body">
              <!-- <form action="Upload" enctype="multipart/form-data">
              <label for="img">Select image:</label>
              <input type='file' name="filename" onchange="readURL(this);" />
              <div class="modal-footer justify-content-center">
		      		<button type="submit" class="btn btn-primary btn-sm">Update Photo</button>
      		  </div>
            </form> -->
            <form method="post" action="Upload" enctype="multipart/form-data">
                    Portrait Photo:
                    <input type="file" name="image" size="50"/ required="">
                    <input type="submit" value="Upload">
        </form>
      </div>
      
    </div>
  </div>
</div>

<section id="team">
  
      <div class="container my-3 py-5 text-center">
        <div class="row">
          <div class="col-sm-3"></div>
          <div class="col-sm-6">
            <div class="card">
              <div class="card-body">
              <%
              	Boolean image = DB_Details.isImage(email);
              	if(image.equals(true)){
              		%>
              			<img src="view.jsp?email=<%= email%>" id="upload" alt="Can't load image." class="img-fluid rounded-circle w-53 mb-2">
              		<%	
              	}
              	else{
              		%>
              			<img src="avtar.jpg" id="upload" alt="Can't load image." class="img-fluid rounded-circle w-53 mb-2">
              		<%
              	}
              %>
                <h4><%= name%></h4>
                <h4><%= email%></h4>
                <h4 class="dob">DOB : <%= dob%></h4>
               <h4 class="dob">Joining date : <%= date_joined %></h4>
                <div class="d-flex flex-row justify-content-center">
                  <div style="margin: 24px 0;">
        <!-- <a href="#" class="a1" target="_blank"><i class="fab fa-linkedin"></i></a>  
        <a href="#" class="a1" target="_blank"><i class="fab fa-facebook"></i></a>
        <a href="#" class="a1" target="_blank"><i class="fab fa-instagram-square"></i></a>  -->
        <button type="button" class="btn btn-success btn-sm text-center mb-2" data-toggle="modal" data-target="#exampleModal">Change Password</button><br>
        <button type="button" class="btn btn-success btn-sm text-center" data-toggle="modal" data-target="#profileChange">Change Profile Photo</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-3"></div>
        </div>
              
      </div>
</section>


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