<%@page import="javax.servlet.annotation.WebServlet"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">

    <title>Login|ChatApp</title>
    <style type="text/css">
      body{
        background-color:#00796b ; 
          opacity: 0.9;
      }
      nav{
        background-color:#00695c ;
      }
      img{
        border-radius: 50%;
      }
    </style>
  </head>
  <body>
    <nav id="nav1" class="navbar navbar-expand-sm navbar-dark fixed-top">
    <div class="container">
  <a class="navbar-brand" href="home">ChatApp</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
  </div>
</div>
</nav>
    <div class="row mt-4">
      <div class="col-lg-5 m-auto">
        <div class="card mt-5 bg-dark">
          <div class="card-title text-center mt-5">
            <img src="avtar.jpg" width="150px" height="150px">
            
          </div>
          <div class="card-body">
            <form action="user-login" method="post">
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fas fa-envelope-square fa-2x"></i>
                  </span>
                </div>
              <input type="email" name="email" class="form-control py-4" placeholder="Email Address" required="">

                
              </div>
              <div class="input-group mb-3">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fa fa-lock fa-2x"></i>
                  </span>
                </div>
                <input type="password" name="password" class="form-control py-4" placeholder="Password" required="">

                
              </div>
              <button type="submit" class="btn btn-success "><i class="fas fa-sign-in-alt pr-2"></i>Login</button>
              <!-- <a href="welcome.jsp" class="btn btn-success"><i class="fas fa-sign-in-alt pr-1"></i>Login</a> -->

                <!-- <p class="float-right text-white mt-2"><a href="#">Forgot Password</a></p> -->
              <button type="button" class="btn btn-danger btn-md float-right text-center" data-toggle="modal" data-target="#exampleModal">Forgot Password</button>
            </form>
		</div>
<!-- Modal -->
   <div class="modal fade " id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog ">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title"	 id="exampleModalLabel">Forgot Password</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
      <div class="modal-body">
        <form action="send-otp" method="post">
              <!-- <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fas fa-mobile-alt fa-2x pr-2"></i>
                  </span>
                </div>
                <input type="text" name="otp" pattern="[0-9]{4}" class="form-control py-4" placeholder="Enter Otp" required=""></div> -->
                <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                      <i class="fas fa-envelope-square fa-2x"></i>
                  </span>
                </div>
                <input type="email" name="email" class="form-control py-4" placeholder="Email Address" required="">
               </div>
              <div class="modal-footer justify-content-center">
<!--         <button type="submit" class="btn btn-primary btn-sm">GET OTP</button>
 -->     
                <button type="submit" class="btn btn-danger btn-md float-center text-center">GET OTP</button>
                <!-- <p class="text-white mt-2"><a href="resend_otp_con1.jsp">Resend OTP</a></p> -->
             </div>
            </form>
      </div>
      
    </div>
  </div>
</div>


           
           <!-- <div class="modal fade " id="resetPass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog ">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Reset Password</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
      <div class="modal-body">
        <form action="reset_password_con.jsp">
              <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fas fa-mobile-alt fa-2x pr-2"></i>
                  </span>
                </div>
          <input type="password" name=""  class="form-control py-4" placeholder="New Password" required="">
              </div>

              <div class="input-group mb-2">
                <div class="input-group-prepend">
                  <span class="input-group-text">
                    <i class="fas fa-mobile-alt fa-2x pr-2"></i>
                  </span>
                </div>
          <input type="password" name=""  class="form-control py-4" placeholder="Confirm Password" required="">
              </div>
              <div class="modal-footer justify-content-center">
        <button type="submit" class="btn btn-success btn-sm">Reset Password</button><br>
      </div>
            </form>
      </div>
      
    </div>
  </div>
</div> -->
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