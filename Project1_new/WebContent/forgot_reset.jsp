<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<% 
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if(session.getAttribute("email") == null){
		response.sendRedirect("home");
	}
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

    <title>Forgot Password|ChatApp</title>
    <style type="text/css">
    body{
        background-color:#2e7d32 ;
          opacity: 0.9;
      }
      nav{
        background-color:#1b5e20 ;
      }   
    </style>
  </head>
  <body>
    <nav id="nav1" class="navbar navbar-expand-sm navbar-dark bg-dark fixed-top">
    <div class="container">
  <a class="navbar-brand" href="home">ChatApp</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <!--  -->
  </div>
</div>
</nav>
    
    <div class="row mt-4">
      <div class="col-lg-5 m-auto">
        <div class="card mt-5 bg-dark">
          <div class="card-title text-center text-white">
            <h3 class="pt-2">OTP has been send to your Email Address. Please enter the OTP.</h3>
            <hr>
            <div class="card-body">
            <form action="reset-password" method="post">
              <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fas fa-envelope-square fa-2x"></i>
                  </span>
                </div>
                <input type="text" name="otp" pattern="[0-9]{4}" class="form-control py-4" placeholder="Enter OTP" required="">
              </div>
              <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock fa-2x"></i>
                  </span>
                </div>
          <input type="password" name="password"  class="form-control py-4" placeholder="New Password" required="">
              </div>

              <div class="justify-content-center">
        <button type="submit" class="btn btn-primary btn-sm float-left">Change Password</button>
      	<p class="text-white mt-2 float-right"><a href="resend-otp-1">Resend OTP</a></p>
      </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>