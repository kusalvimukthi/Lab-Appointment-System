<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.Map"%>
    <%@ page import="core.SessionManage"%>
    <%@ page import="controller.MedicalController"%>
    <%@ page import="modal.MedicalTest"%>
    <%@ page import="java.util.List"%>

    	<%
		String userEmail = (String) session.getAttribute("user-email");
		String userFirstName = (String) session.getAttribute("user-first-name");
		String userRole = (String) session.getAttribute("user-role");
		%>
		<%
		if(session.getAttribute("user-email") == null){
			response.sendRedirect("login.jsp");
		}

	
	Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
	String bookingDateError = SessionManage.getFiledValue(fieldErrors, "booking_date");
	String bookingTimeError = SessionManage.getFiledValue(fieldErrors, "booking_time");
	String medicalTestError = SessionManage.getFiledValue(fieldErrors, "medical_test");
	String recommendedDoctorError = SessionManage.getFiledValue(fieldErrors, "recommended_doctor");
	session.removeAttribute("fieldErrors");
	
	String status = (String) session.getAttribute("user-create-status");
	session.removeAttribute("user-create-status");
	if (status != null) {
		session.removeAttribute("createUserFileds");
	}
	
	String booking_date, booking_time, recommended_doctor;
	booking_date = booking_time = recommended_doctor = "";
	Map<String, String> inputs = (Map<String, String>) session.getAttribute("createUserFileds");
	booking_date = SessionManage.getFiledValue(inputs, "booking_date");
	booking_time = SessionManage.getFiledValue(inputs, "booking_time");
	recommended_doctor = SessionManage.getFiledValue(inputs, "recommended_doctor");
	session.removeAttribute("createUserFileds");
	
	List<MedicalTest> medicalTestList = MedicalController.getAllActiveMedicalTest();
	%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="description" content="Orbitor,business,company,agency,modern,bootstrap4,tech,software">
  <meta name="author" content="themefisher.com">
  <title>ABC Laboratories</title>
  <link rel="shortcut icon" type="image/x-icon" href="./front-end/images/favicon.png" />
  <link rel="stylesheet" href="./front-end/plugins/bootstrap/css/bootstrap.min.css">
  <!-- <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css'> -->
  <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css'>
  <link rel="stylesheet" href="./front-end/plugins/icofont/icofont.min.css">
  <link rel="stylesheet" href="./front-end/plugins/slick-carousel/slick/slick.css">
  <link rel="stylesheet" href="./front-end/plugins/slick-carousel/slick/slick-theme.css"> 
  <link rel="stylesheet" href="./front-end/css/style.css">
  <link rel="stylesheet" href="./front-end/css/payment.css"> 
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
						<%
						if (userFirstName == null || userEmail == null) {
						%>
						<a href="registration.jsp" class="btn btn-outline-light btn-solid-white">Register</a>
						<a href="login.jsp" class="btn btn-outline-light btn-solid-white">Log In</a>
						<%
						} else {
						%>
						<a class=""  id="dropdown03" data-toggle="dropdown">
                             Hi, <%= userFirstName %> <i class="icofont-thin-down"></i>
                        </a>
                        <ul class="dropdown-menu mt-3" aria-labelledby="dropdown03">
                            <li><a class="dropdown-item" href="dashbord.jsp">Manage Appointment</a></li>
                            <li><a class="dropdown-item" href="logout">Log Out</a></li>
                        </ul>
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
          <span class="text-white">Make Appoinment</span>
          <h1 class="text-capitalize mb-5 text-lg">Appoinment</h1>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- contact form start -->

<section class="contact-form-wrap section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="section-title text-center">
                    <h2 class="text-md mb-2">Appoinment</h2>
                    <div class="divider mx-auto my-4"></div>
                    <p class="mb-5">Laboriosam exercitationem molestias beatae eos pariatur, similique, excepturi mollitia sit perferendis maiores ratione aliquam?</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="border col-lg-8 col-md-12 col-sm-12 mx-auto p-lg-5 rounded">
				<form id="#" class="appoinment-form" method="post" action="AppoimentServlet">
					<div class="row">
						<div class="col-lg-6">
							<div class="form-group">
								<label for="medical_test">Select Test</label>
								<select class="form-control" id="medical_test" name="medical_test" onchange="updateDetails()">
									<%
									for (MedicalTest medicalTest : medicalTestList) {
									%>
									<option value="<%=medicalTest.getId()%>"><%=medicalTest.getName()%></option>
									<%
									}
									%>
								</select>
								<%=(medicalTestError != null) ? "<span class=\"text-danger\">" + medicalTestError + "</span>" : ""%>
							  </div>
						</div>
						<div class="col-lg-6">
							<div class="form-group">
								<label for="booking_time">booking time</label>
								<select class="form-control" id="booking_time" name="booking_time">
									<option value="">Select Booking Time</option>
									<option value="09:00">09:00</option>
									<option value="09:30">09:30</option>
									<option value="10:00">10:00</option>
									<option value="10:30">10:30</option>
									<option value="11:00">11:00</option>
									<option value="11:30">11:30</option>
									<option value="12:00">12:00</option>
								</select>
								<%=(bookingTimeError != null) ? "<span class=\"text-danger\">" + bookingTimeError + "</span>" : ""%>
							  </div>
						</div>
						<div class="col-lg-6">
							<div class="form-group">
								<label for="booking_date">Booking Date</label>
								<input type="date" class="form-control" id="booking_date" name="booking_date" placeholder="booking date" value="<%=booking_date%>">
								<%=(bookingDateError != null) ? "<span class=\"text-danger\">" + bookingDateError + "</span>" : ""%>
							</div>
						</div>
				
						<div class="col-lg-6">
							<div class="form-group">
								<label for="recommended_doctor">Recommended Doctor</label>
								<input type="text" class="form-control" id="recommended_doctor" name="recommended_doctor" placeholder="name@example.com" value="<%=recommended_doctor%>">
								<%=(recommendedDoctorError != null) ? "<span class=\"text-danger\">" + recommendedDoctorError + "</span>" : ""%>
							</div>
						</div>
					</div>
					<div class="text-center makeappoinment">
						<button class="btn btn-main btn-round-full" type="submit"><i class="icofont-simple-right ml-2  "></i>Make Appoinment</button>
                    </div>
					<div class="form-check form-switch mb-2">
                        <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault" />
                        <label class="form-check-label" for="flexSwitchCheckDefault"
                          >Card Payment</label
                        >
                    </div>
					<div class="hide hidden-element">
						  <div class="card-data flex-fill flex-vertical">
							<!-- Card Number -->
							<div class="flex-between flex-vertical-center">
							  <div class="card-property-title">
								<strong>Card Number</strong>
								<span>Enter 16-digit card number on the card</span>
							  </div>
							</div>
			  
							<!-- Card Field -->
							<div class="flex-between">
							  <div class="card-number flex-vertical-center flex-fill">
								<div class="card-number-field flex-vertical-center flex-fill">
								  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="24px" height="24px">
									<path fill="#ff9800" d="M32 10A14 14 0 1 0 32 38A14 14 0 1 0 32 10Z" />
									<path fill="#d50000" d="M16 10A14 14 0 1 0 16 38A14 14 0 1 0 16 10Z" />
									<path fill="#ff3d00" d="M18,24c0,4.755,2.376,8.95,6,11.48c3.624-2.53,6-6.725,6-11.48s-2.376-8.95-6-11.48 C20.376,15.05,18,19.245,18,24z" />
								  </svg>
								  <input type="text" placeholder="Card Number" class="form-control" id="cardNumber" onkeypress="return onlyNumberKey(event)" maxlength="19" name="cardNumber" data-bound="carddigits_mock" data-def="0000 0000 0000 0000" required />
								</div>
								<i class="ai-circle-check-fill size-lg f-main-color"></i>
							  </div>
							</div>
			  
							<!-- Expiry Date -->
							<div class="flex-between">
							  <div class="card-property-title">
								<strong>Expiry Date</strong>
								<span>Enter the expiration date of the card</span>
							  </div>
							  <div class="card-property-value flex-vertical-center">
								<div class="input-container half-width">
								  <input class="numbers month-own" data-def="00" type="text" data-bound="mm_mock" placeholder="MM" />
								</div>
								<span class="m-md">/</span>
								<div class="input-container half-width">
								  <input class="numbers year-own" data-def="01" type="text" data-bound="yy_mock" placeholder="YYYY" />
								</div>
							  </div>
							</div>
			  
							<!-- CCV Number -->
							<div class="flex-between">
							  <div class="card-property-title">
								<strong>CVC Number</strong>
								<span>Enter card verification code from the back of the
								  card</span>
							  </div>
							  <div class="card-property-value">
								<div class="input-container">
								  <input id="cvc" placeholder="Card CVV" maxlength="3" onkeypress="return onlyNumberKey(event)" type="password" />
								  <i id="cvc_toggler" data-target="cvc" class="ai-eye-open pointer"></i>
								</div>
							  </div>
							</div>
			  
							<!-- Name -->
							<div class="flex-between">
							  <div class="card-property-title">
								<strong>Cardholder Name</strong>
								<span>Enter cardholder's name</span>
							  </div>
							  <div class="card-property-value">
								<div class="input-container">
								  <input id="name" data-bound="name_mock" data-def="Mr. Cardholder" type="text" class="uppercase" placeholder="CARDHOLDER NAME" />
								  <i class="ai-person"></i>
								</div>
							  </div>
							</div>
						  </div>
						  <div class="action flex-center">
							<button type="" class="b-main-color pointer">
							  Pay Now
							</button>
						</div>
					</div>

				</form>
            </div>
			<div class="col-lg-4 col-md-12 py-5 pay hidden-element">
				<div></div>
				<div class="purchase-section flex-fill flex-vertical">
				  <div class="card-mockup flex-vertical">
					<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
					  <path fill="#ff9800" d="M32 10A14 14 0 1 0 32 38A14 14 0 1 0 32 10Z" />
					  <path fill="#d50000" d="M16 10A14 14 0 1 0 16 38A14 14 0 1 0 16 10Z" />
					  <path fill="#ff3d00" d="M18,24c0,4.755,2.376,8.95,6,11.48c3.624-2.53,6-6.725,6-11.48s-2.376-8.95-6-11.48 C20.376,15.05,18,19.245,18,24z" />
					</svg>
					<div>
					  <strong>
						<div id="name_mock" class="size-md pb-sm uppercase ellipsis">
						  mr. Cardholder
						</div>
					  </strong>
					  <div class="size-md pb-md">
						<strong>
						  <span id="carddigits_mock">0000 0000 0000 0000</span>
						</strong>
					  </div>
					  <div class="flex-between flex-vertical-center">
						<strong class="size-md">
						  <span>Expiry Date : </span><span id="mm_mock">00</span> / <span id="yy_mock">00</span>
						</strong>
	  
						<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" width="40px" height="40px">
						  <path fill="#1565C0" d="M45,35c0,2.209-1.791,4-4,4H7c-2.209,0-4-1.791-4-4V13c0-2.209,1.791-4,4-4h34c2.209,0,4,1.791,4,4V35z" />
						  <path fill="#FFF" d="M15.186 19l-2.626 7.832c0 0-.667-3.313-.733-3.729-1.495-3.411-3.701-3.221-3.701-3.221L10.726 30v-.002h3.161L18.258 19H15.186zM17.689 30L20.56 30 22.296 19 19.389 19zM38.008 19h-3.021l-4.71 11h2.852l.588-1.571h3.596L37.619 30h2.613L38.008 19zM34.513 26.328l1.563-4.157.818 4.157H34.513zM26.369 22.206c0-.606.498-1.057 1.926-1.057.928 0 1.991.674 1.991.674l.466-2.309c0 0-1.358-.515-2.691-.515-3.019 0-4.576 1.444-4.576 3.272 0 3.306 3.979 2.853 3.979 4.551 0 .291-.231.964-1.888.964-1.662 0-2.759-.609-2.759-.609l-.495 2.216c0 0 1.063.606 3.117.606 2.059 0 4.915-1.54 4.915-3.752C30.354 23.586 26.369 23.394 26.369 22.206z" />
						  <path fill="#FFC107" d="M12.212,24.945l-0.966-4.748c0,0-0.437-1.029-1.573-1.029c-1.136,0-4.44,0-4.44,0S10.894,20.84,12.212,24.945z" />
						</svg>
					  </div>
					</div>
				  </div>
	  
				  <ul class="purchase-props">
					<li class="flex-between">
					  <span>Company</span>
					  <strong>ABC Laboratories</strong>
					</li>
					<li class="flex-between">
					  <span>Test </span>
					  <strong id="testname">N/A</strong>
					</li>
				  </ul>
				</div>
				<div class="separation-line"></div>
				<div class="total-section flex-between flex-vertical-center">
				  <div class="flex-fill flex-vertical">
					<div class="total-label f-secondary-color">You have to Pay</div>
					<div>
					  <strong id="valuess">00</strong>
					  <small>.00 <span class="f-secondary-color">LKR</span></small>
					</div>
				  </div>
				  <i class="ai-coin size-lg"></i>
				</div>
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
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js'></script>
	<!-- <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js'></script> -->
	<script src='https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js'></script>  
    <script src="./front-end/js/script.js"></script>
    	<script src="./front-end/js/payment.js"></script>

  </body>
</html>