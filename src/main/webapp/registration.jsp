<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.Map"%>
    <%@ page import="core.SessionManage"%>
    <%@ page import="controller.UserController"%>
    <%@ page import="modal.User"%>
    <%@ page import="java.util.List"%>
    
    <%
    if (session.getAttribute("user-email") != null) {
      response.sendRedirect("dashbord.jsp");
    }
    
    Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
    String firstNameError = SessionManage.getFiledValue(fieldErrors, "f_name");
    String lastNameError = SessionManage.getFiledValue(fieldErrors, "l_name");
    String emailError = SessionManage.getFiledValue(fieldErrors, "email");
    String passwordError = SessionManage.getFiledValue(fieldErrors, "password");
    String confirmPasswordError = SessionManage.getFiledValue(fieldErrors, "confPassword");
    String telephoneNumberError = SessionManage.getFiledValue(fieldErrors, "telephone");
    String nicError = SessionManage.getFiledValue(fieldErrors, "nic");
    String dobError = SessionManage.getFiledValue(fieldErrors, "db");
    session.removeAttribute("fieldErrors");
    %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />
    <title>ABC Laboratories</title>
    <meta name="description" content="" />
    <link rel="icon" type="image/x-icon" href="./back-end/assets/img/favicon/favicon.ico" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="./back-end/assets/vendor/fonts/boxicons.css" />
    <link rel="stylesheet" href="./back-end/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="./back-end/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="./back-end/assets/css/demo.css" />
    <link rel="stylesheet" href="./back-end/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="./back-end/assets/vendor/css/pages/page-auth.css" />
    <script src="./back-end/assets/vendor/js/helpers.js"></script>
    <script src="./back-end/assets/js/config.js"></script>
  </head>

  <body>
    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y">
        <div class="">
          <div class="card">
            <div class="card-body">
              <div class="app-brand justify-content-center">
                <a href="index.jsp" class="app-brand-link gap-2">
                  <span class="app-brand-text demo text-body fw-bolder">ABC Laboratories</span>
                </a>
              </div>
              <h4 class="mb-2 mt-4">Adventure starts here</h4>
              <p class="mb-4">Make your app appointment management easy and fun!</p>

              <form method="post" action="register" class="mb-3" id="register-form">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="mb-3">
                            <label for="f_name" class="form-label">First Name</label>
                            <div class="form-group">
                              <input type="text" class="form-control" id="f_name" name="f_name" placeholder="First Name" autofocus />
                              <%
                              if (firstNameError != null) {
                              %>
                              <span style="color: red;"><%=firstNameError%></span>
                              <%
                              }
                              %>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="mb-3">
                        <label for="l_name" class="form-label">Last Name</label>
                        <div class="form-group">
                          <input type="text" class="form-control" id="l_name" name="l_name" placeholder="Last Name" />
                          <%
                          if (lastNameError != null) {
                          %>
                          <span style="color: red;"><%=lastNameError%></span>
                          <%
                          }
                          %>
                        </div>
                      </div>
                    </div>
                </div>
                <div class="row">
                  <div class="col-lg-6">
                    <div class="mb-3">
                      <label for="nic" class="form-label">NIC</label>
                      <div class="form-group">
                        <input type="text" class="form-control" id="nic" name="nic" placeholder="NIC" />
                        <%
                        if (nicError != null) {
                        %>
                        <span style="color: red;"><%=nicError%></span>
                        <%
                        }
                        %>
                      </div>
                    </div>
                  </div>
                  <div class="col-lg-6">
                    <div class="mb-3">
                      <label for="telephone" class="form-label">Telephone Number</label>
                      <div class="form-group">
                        <input type="text" class="form-control" id="telephone" name="telephone" placeholder="Telephone Number" autofocus />
                        <%
                        if (telephoneNumberError != null) {
                        %>
                        <span style="color: red;"><%=telephoneNumberError%></span>
                        <%
                        }
                        %>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="row">
                <div class="col-lg-6">
                  <div class="mb-3">
                    <label for="dob" class="form-label">Date of Birth</label>
                    <div class="form-group">
                      <input type="date" class="form-control" id="dob" name="dob" placeholder="date of birth" autofocus />
                      <%
                      if (dobError != null) {
                      %>
                      <span style="color: red;"><%=dobError%></span>
                      <%
                      }
                      %>
                    </div>
                  </div>
                </div>
                <div class="col-lg-6">
                  <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <div class="form-group">
                      <input type="text" class="form-control" id="email" name="email" placeholder="Enter your email" />
                      <%
                      if (emailError != null) {
                      %>
                      <span style="color: red;"><%=emailError%></span>
                      <%
                      }
                      %>
                    </div>
                  </div>
                </div>
              </div>
                <div class="row">
                  <div class="col-lg-6">
                    <div class="mb-3 form-password-toggle">
                      <label class="form-label" for="pass">Password</label>
                      <div class="form-group">
                        <div class="input-group input-group-merge">
                            <input type="password" id="pass" class="form-control" name="password" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password" />
                            <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                        </div>
                        <%
                        if (passwordError != null) {
                        %>
                        <span style="color: red;"><%=passwordError%></span>
                        <%
                        }
                        %>
                      </div>
                  </div>
                  </div>
                  <div class="col-lg-6">
                    <div class="mb-3 form-password-toggle">
                      <label class="form-label" for="confPassword">Confirm Password</label>
                      <div class="form-group">
                        <div class="input-group input-group-merge">
                          <input type="password" id="confPassword" class="form-control" name="confPassword" placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;" aria-describedby="password" />
                          <span class="input-group-text cursor-pointer"><i class="bx bx-hide"></i></span>
                        </div>
                        <%
                        if (confirmPasswordError != null) {
                        %>
                        <span style="color: red;"><%=confirmPasswordError%></span>
                        <%
                        }
                        %>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="mb-3">
                  <div class="form-group">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="agree-term" name="agree-term" />
                        <label class="form-check-label" for="agree-term">
                            I agree to
                            <a href="javascript:void(0);">privacy policy & terms</a>
                        </label>
                    </div>
                  </div>
                </div>
                <button class="btn btn-primary d-grid w-100 form-submit" type="submit" name="signup" id="signup" value="Register">Sign up</button>
            </form>            
          </div>
              <p class="text-center">
                <span>Already have an account?</span>
                <a href="login.jsp">
                  <span>Sign in instead</span>
                </a>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="./back-end/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="./back-end/assets/vendor/libs/popper/popper.js"></script>
    <script src="./back-end/assets/vendor/js/bootstrap.js"></script>
    <script src="./back-end/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="./back-end/assets/js/jquery.validate.min.js"></script>
    <script src="./back-end/assets/js/jquery.validate-init.js"></script>
    <script src="./back-end/assets/vendor/js/menu.js"></script>
    <script src="./back-end/assets/js/main.js"></script>
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>