<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="description" content="Orbitor,business,company,agency,modern,bootstrap4,tech,software">
  <meta name="author" content="themefisher.com">
  <title>ABC Laboratories</title>
  <link rel="shortcut icon" type="image/x-icon" href="./front-end/images/favicon.png" />
  <link rel="stylesheet" href="./front-end/plugins/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="./front-end/plugins/icofont/icofont.min.css">
  <link rel="stylesheet" href="./front-end/plugins/slick-carousel/slick/slick.css">
  <link rel="stylesheet" href="./front-end/plugins/slick-carousel/slick/slick-theme.css">
  <link rel="stylesheet" href="./front-end/css/style.css">
</head>

<body id="top">

<header>
	<div class="header-top-bar">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-lg-6">
					<ul class="top-bar-info list-inline-item pl-0 mb-0">
						<li class="list-inline-item"><a href="mailto:support@gmail.com"><i class="icofont-support-faq mr-2"></i>support@novena.com</a></li>
						<li class="list-inline-item"><i class="icofont-location-pin mr-2"></i>Address Ta-134/A, New York, USA </li>
					</ul>
				</div>
				<div class="col-lg-6">
                    <div class="text-right top-right-bar mt-2 mt-lg-0">
                        <%-- Check if user is logged in --%>
                        <% if (session.getAttribute("name") != null) { %>
                            <a class=""  id="dropdown03" data-toggle="dropdown">
                                <%= session.getAttribute("name") %> <i class="icofont-thin-down"></i>
                            </a>
                            <ul class="dropdown-menu mt-3" aria-labelledby="dropdown03">
                                <li><a class="dropdown-item" href="dashbord.jsp">Manage Appointment</a></li>
                                <li><a class="dropdown-item" href="logout">Log Out</a></li>
                            </ul>
                        <% } else { %>
							<a href="registration.jsp" class="btn btn-outline-light btn-solid-white">Register</a>
                            <a href="login.jsp" class="btn btn-outline-light btn-solid-white">Log In</a>
                        <% } %>
                    </div>
                </div>
			</div>
		</div>
	</div>
	<nav class="navbar navbar-expand-lg navigation" id="navbar">
		<div class="container">
		 	 <a class="navbar-brand" href="index.jsp">
			  	<img src="./front-end/images/logo.png" alt="" class="img-fluid">
			  </a>

		  	<button class="navbar-toggler collapsed" type="button" data-toggle="collapse" data-target="#navbarmain" aria-controls="navbarmain" aria-expanded="false" aria-label="Toggle navigation">
			<span class="icofont-navigation-menu"></span>
		  </button>
	  
		  <div class="collapse navbar-collapse" id="navbarmain">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
				<li class="nav-item"><a class="nav-link" href="service.jsp">Services</a></li>
				<li class="nav-item active"><a class="nav-link" href="contact.jsp">Contact</a></li>
				<li class="nav-item"><a class="nav-link" href="appoiment.jsp">Make appoinment </a></li>
			</ul>
		  </div>
		</div>
	</nav>
</header>
	


<section class="page-title bg-1">
  <div class="overlay"></div>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="block text-center">
          <span class="text-white">Contact Us</span>
          <h1 class="text-capitalize mb-5 text-lg">Get in Touch</h1>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- contact form start -->

<section class="section contact-info pb-0">
    <div class="container">
         <div class="row">
            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="contact-block mb-4 mb-lg-0">
                    <i class="icofont-live-support"></i>
                    <h5>Call Us</h5>
                    +45-0456-6588
                </div>
            </div>
            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="contact-block mb-4 mb-lg-0">
                    <i class="icofont-support-faq"></i>
                    <h5>Email Us</h5>
                    abclaboratories@email.com
                </div>
            </div>
            <div class="col-lg-4 col-sm-6 col-md-6">
                <div class="contact-block mb-4 mb-lg-0">
                    <i class="icofont-location-pin"></i>
                    <h5>Location</h5>
                     Kururnegala, Sri Lanka
                </div>
            </div>
        </div>
    </div>
</section>

<section class="contact-form-wrap section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="section-title text-center">
                    <h2 class="text-md mb-2">Contact us</h2>
                    <div class="divider mx-auto my-4"></div>
                    <p class="mb-5">Feel free to reach out to us for any inquiries or assistance.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-9 col-md-9 col-sm-12 mx-auto">
                <form id="contact-form" class="contact__form " method="post" action="">
                 <!-- form message -->
                    <div class="row">
                        <div class="col-12">
                            <div class="alert alert-success contact__msg" style="display: none" role="alert">
                                Your message was sent successfully.
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-lg-6">
                            <div class="form-group">
                                <input name="name" id="name" type="text" class="form-control" placeholder="Your Full Name" >
                            </div>
                        </div>

                        <div class="col-lg-6">
                            <div class="form-group">
                                <input name="email" id="email" type="email" class="form-control" placeholder="Your Email Address">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                                <input name="phone" id="phone" type="text" class="form-control" placeholder="Your Phone Number">
                            </div>
                        </div>
                         <div class="col-lg-6">
                            <div class="form-group">
                                <input name="subject" id="subject" type="text" class="form-control" placeholder="Your Query Topic">
                            </div>
                        </div>
                    </div>

                    <div class="form-group-2 mb-4">
                        <textarea name="message" id="message" class="form-control" rows="8" placeholder="Your Message"></textarea>
                    </div>

                    <div class="text-center">
                        <input class="btn btn-main btn-round-full" name="submit" type="submit" value="Send Messege"></input>
                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

<!-- footer Start -->
<footer class="footer section">
	<div class="container">
		<div class="row">
			<div class="col-lg-4 mr-auto col-sm-6">
				<div class="widget mb-5 mb-lg-0">
					<div class="logo mb-4">
						<img src="./front-end/images/logo1.png" alt="" class="img-fluid">
					</div>
					<p>Welcome to our online appointment booking system! Whether you're a returning patient or new to our services, scheduling your appointments is quick and easy.</p>

					<ul class="list-inline footer-socials mt-4">
						<li class="list-inline-item"><a href="#"><i class="icofont-facebook"></i></a></li>
						<li class="list-inline-item"><a href="#"><i class="icofont-twitter"></i></a></li>
						<li class="list-inline-item"><a href="#"><i class="icofont-linkedin"></i></a></li>
					</ul>
				</div>
			</div>

			<div class="col-lg-4 col-md-6 col-sm-6">
				<div class="widget mb-5 mb-lg-0">
					<h4 class="text-capitalize mb-3">Quick Links</h4>
					<div class="divider mb-4"></div>

					<ul class="list-unstyled footer-menu lh-35">
						<li><a href="index.jsp">Home </a></li>
						<li><a href="service.jsp">Services</a></li>
						<li><a href="contact.jsp">Contact</a></li>
						<li><a href="appoiment.jsp">Make Appoinment</a></li>
						<li><a href="login.jsp">Login</a></li>
						<li><a href="registration.jsp">Register</a></li>
						<li><a href="dashbord.jsp">Manage Appoinment</a></li>
					</ul>
				</div>
			</div>



			<div class="col-lg-4 col-md-6 col-sm-6">
				<div class="widget widget-contact mb-5 mb-lg-0">
					<h4 class="text-capitalize mb-3">Get in Touch</h4>
					<div class="divider mb-4"></div>

					<div class="footer-contact-block mb-4">
						<div class="icon d-flex align-items-center">
							<i class="icofont-email mr-3"></i>
							<span class="h6 mb-0">Support Available for 24/7</span>
						</div>
						<h4 class="mt-2"><a href="tel:+23-345-67890">abclaboratories@email.com</a></h4>
					</div>

					<div class="footer-contact-block">
						<div class="icon d-flex align-items-center">
							<i class="icofont-support mr-3"></i>
							<span class="h6 mb-0">Mon to Fri : 08:30 - 18:00</span>
						</div>
						<h4 class="mt-2"><a href="tel:+23-345-67890">+45-0456-6588</a></h4>
					</div>
				</div>
			</div>
		</div>
		
		<div class="footer-btm py-4 mt-5">
			<div class="row align-items-center justify-content-between">
				<div class="col-lg-6">
					<div class="copyright">
						&copy; Copyright Reserved to <span class="text-color">ABC Laboratories</span>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-4">
					<a class="backtop js-scroll-trigger" href="#top">
						<i class="icofont-long-arrow-up"></i>
					</a>
				</div>
			</div>
		</div>
	</div>
</footer>

    
    <script src="./front-end/plugins/jquery/jquery.js"></script>
    <script src="./front-end/plugins/bootstrap/js/popper.js"></script>
    <script src="./front-end/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="./front-end/plugins/counterup/jquery.easing.js"></script>
    <script src="./front-end/plugins/slick-carousel/slick/slick.min.js"></script>
    <script src="./front-end/plugins/counterup/jquery.waypoints.min.js"></script>
    <script src="./front-end/plugins/shuffle/shuffle.min.js"></script>
    <script src="./front-end/plugins/counterup/jquery.counterup.min.js"></script>
    <script src="./front-end/plugins/google-map/map.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAkeLMlsiwzp6b3Gnaxd86lvakimwGA6UA&callback=initMap"></script>    
    <script src="./front-end/js/script.js"></script>
    <script src="j./front-end/s/contact.js"></script>

  </body>
</html>