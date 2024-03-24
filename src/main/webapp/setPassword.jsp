<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.Map"%>
    <%
    if (session.getAttribute("user-email") != null) {
      response.sendRedirect("dashbord.jsp");
    }
    if (session.getAttribute("forgot-password-email") == null) {
      response.sendRedirect("forgot-password.jsp");
    }
    
    Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
    String otpError = (fieldErrors != null && fieldErrors.containsKey("otp")) ? fieldErrors.get("otp") : null;
    String passwordError = (fieldErrors != null && fieldErrors.containsKey("password")) ? fieldErrors.get("password")
        : null;
    String confirmPasswordError = (fieldErrors != null && fieldErrors.containsKey("confPassword"))
        ? fieldErrors.get("confPassword")
        : null;
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
        <div class="authentication-inner">
          <div class="card">
            <div class="card-body">
              <div class="app-brand justify-content-center">
                <a href="index.jsp" class="app-brand-link gap-2">
                  <span class="app-brand-text demo text-body fw-bolder">ABC Laboratories</span>
                </a>
              </div>
              <h4 class="mb-2">Set New Password</h4>

              <form id="formAuthentication" class="mb-3" action="newPassword" method="POST">
                <div class="mb-3">
                  <label for="otp" class="form-label">One-Time Password</label>
                  <input
                    type="text"
                    class="form-control"
                    id="otp"
                    name="otp"
                    placeholder="Enter your OTP"
                    autofocus
                  />
                  <%
									if (otpError != null) {
									%>
									<span style="color: red;"><%=otpError%></span>
									<%
									}
									%>
                </div>
                <div class="mb-3 form-password-toggle">
                  <div class="d-flex justify-content-between">
                    <label class="form-label" for="password">New Password</label>
                  </div>
                  <div class="input-group input-group-merge">
                    <input
                      type="password"
                      id="password"
                      class="form-control"
                      name="password"
                      placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                      aria-describedby="password"
                    />
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
                <div class="mb-3 form-password-toggle">
                  <div class="d-flex justify-content-between">
                    <label class="form-label" for="confPassword">Confirm Password</label>
                  </div>
                  <div class="input-group input-group-merge">
                    <input
                      type="password"
                      id="confPassword"
                      class="form-control"
                      name="confPassword"
                      placeholder="&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;&#xb7;"
                      aria-describedby="confirm_password"
                    />
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
                <div class="mb-3">
                  <button class="btn btn-primary d-grid w-100" type="submit">Set Password</button>
                </div>
              </form>

              <p class="text-center">
                <span>New on our platform?</span>
                <a href="registration.jsp">
                  <span>Create an account</span>
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
    <script src="./back-end/assets/vendor/js/menu.js"></script>
    <script src="./back-end/assets/js/main.js"></script>
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>