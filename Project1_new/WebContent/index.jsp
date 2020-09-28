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
<!--     <link rel="stylesheet" type="text/css" href="style.css">
 -->    <title>ChatApp</title> 
      <style>
        html{
          scroll-behavior: smooth;
        }
        #header {
            background: url("header.jpeg");
            /* background: url("imgs/header.jpeg") center center / cover no-repeat; */
        }
        body{
        background-color:#e2e2e2;
        }
        nav{
      background-color:#00695c;
      }

          .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            max-width: 300px;
            margin: auto;
            text-align: center;
            font-family: arial;
          }

          .title {
            color: grey;
            font-size: 18px;
          }
          .a1 {
            text-decoration: none;
            font-size: 22px;
            color: black;
          }
          /*footer */

          .foot{
        background:#303036;
        color:#d3d3d3;
      }
      .link{
        color:grey;
      }
      .link:hover{
        margin-left: 10px;
        color:white;
        transition: all .2s;
      }
      .a1{
        color: grey;
        font-size: 20px;
        padding-right:10px;
      }
      .a1:hover{
        color:white;
        transition: all .2s;
      }
    </style>

  </head>
  <body>
    <nav id="nav1" class="navbar navbar-expand-sm navbar-dark fixed-top">
    <div class="container">
  <a class="navbar-brand" href="home">
    <img src="https://i.pinimg.com/originals/4e/28/1b/4e281b75739f710729bd75accdb56fa8.jpg" width="30" height="30" class="d-inline-block align-top" alt="" loading="lazy">
    ChatApp
  </a>
  <!-- </a> -->
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="#home"><i class="fas fa-home pr-1"></i>Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#feature">Features</a>
      </li>
      <!-- <li class="nav-item">
        <a class="nav-link" href="#work"><i class="far fa-question-circle pr-1"></i>How It work's</a>
      </li> -->
    </ul>
  </div>
</div>
</nav>
<div id="home">
<section id="header" class="jumbotron text-center">
        <h1 class="display-3 pt-3">Connect With Friends</h1>
        <p class="lead"><b>Find Your Friends With Their Name Or Their Email</b></p>
        <a href="signup" class="btn btn-primary"><i class="fas fa-user-plus pr-1"></i>Sign-Up</a>
        <a href="login" class="btn btn-success"><i class="fas fa-sign-in-alt pr-1"></i>Login</a>
    </section>
  </div>
<div id="feature" class="pt-2">
  <h2 class="text-center pb-2">Features</h2>
  <section id="gallery">
       <div class="container">
            <div class="row">
              <div class="col-lg-4 mb-4">
                    <div class="card">
                        <i class="fas fa-user-friends fa-9x card-img-top pt-3"></i>
                        <div class="card-body">
                            <h5 class="card-title"><b>User Friendly</b></h5>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="card">
                        <i class="fas fa-shield-alt fa-9x card-img-top pt-3"></i>
                        <div class="card-body">
                            <h5 class="card-title"><b>Secure</b></h5>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 mb-4">
                    <div class="card">
                        <i class="fas fa-comments-dollar fa-9x card-img-top pt-3"></i>
                        <div class="card-body">
                            <h5 class="card-title"><b>Free</b></h5>
                        </div>
                    </div>
                </div>
            </div>
       </div>
    </section>
</div>
<!-- </div> -->

<!-- <div id="work">
<div class="container pt-3 mb-3">
  <h3 class="text-center pt-2">How It Work's</h3>
  <div class="row">
    <div class="col-sm-2"></div>
    <div class="col-sm-8">
  <div class="embed-responsive embed-responsive-4by3">
  <iframe class="embed-responsive-item" src="https://www.youtube.com/embed/zpOULjyy-n8?rel=0" allowfullscreen></iframe>
  </div>
  </div>
  <div class="col-sm-2"></div>
  </div>
</div>
</div> -->

<!-- footer -->

<footer class="page-footer font-small mdb-color pt-4 foot">

  <!-- Footer Links -->
  <div class="container text-center text-md-left">

    <!-- Footer links -->
    <div class="row text-center text-md-left mt-3 pb-3">

      <!-- Grid column col-lg-3 col-xl-3 mx-auto-->
      <div class="col-md-4 mx-auto mt-3">
        <h2 class="mb-4 font-weight-bold">ChatApp</h2>
        <p><i>Easily Accessible</i></p>
      </div>
      <!-- Grid column -->

      <hr class="w-100 clearfix d-md-none">

      <!-- Grid column -->
      <!-- col-lg-2 col-xl-2 mx-auto -->
      <div class="col-md-4 mx-auto mt-3">
        <h3 class="mb-4 font-weight-bold">Quick links</h3>
        <p>
          <a href="#home" class="link">Home</a>
        </p>
        <p>
          <a href="#feature" class="link">Features</a>
        </p>
        <p>
          <a href="signup" class="link">Sign-Up</a>
        </p>
        <p>
          <a href="login" class="link">Login</a>
        </p>
      </div>
      <!-- Grid column -->

      <hr class="w-100 clearfix d-md-none">


      <!-- Grid column -->
      <div class="col-md-4  mx-auto mt-3">
        <h3 class="mb-4 font-weight-bold">Contact Us</h3>
        <p>
          <i class="fas fa-envelope mr-3"></i>service.chatapp.mail@gmail.com</p>
        <!-- <p>
          <i class="fas fa-phone mr-3"></i> 8878858067</p> -->
        <a href="#" class="a1" target="_blank"><i class="fab fa-linkedin"></i></a>  
        <a href="#" class="a1" target="_blank"><i class="fab fa-facebook"></i></a>
        <a href="#" class="a1" target="_blank"><i class="fab fa-instagram-square"></i></a>
          
          
      </div>
      <!-- Grid column -->

    </div>
    <!-- Footer links -->

    <hr>

    <!-- Grid row -->
    <div class="row d-flex align-items-center">

      <!-- Grid column -->
      <div class="col-md-7 col-lg-8">

        <!--Copyright-->
        <p class=" float-center">© 2020 Copyright:
         <strong> Designed and Developed By Ayush Soni and Rajan Kumar</strong>
         </p>

      </div>

      </div>

    </div>
   

<!--   </div> -->
  <!-- Footer Links -->

</footer>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>
  </body>
</html>