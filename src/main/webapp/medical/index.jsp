<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <%@ page import="java.util.Map"%>
    <%@ page import="controller.MedicalController"%>
    <%@ page import="modal.MedicalTest"%>
    <%@ page import="java.util.List"%>
    
    <%
    String userEmail = (String) session.getAttribute("user-email");
    String userFirstName = (String) session.getAttribute("user-first-name");
    String userLastName = (String) session.getAttribute("user-last-name");
    String userRole = (String) session.getAttribute("user-role");
    if (userFirstName == null || userEmail == null) {
        response.sendRedirect("../login.jsp");
    } else {
        if (!"supervisor".equals(userRole)) {
            response.sendRedirect("../dashbord.jsp");
        }
    }
    List<MedicalTest> medicalTestList = MedicalController.getAllMedicalTest();
    %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>Dashboard - Analytics | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>
    <meta name="description" content="" />

    <link rel="icon" type="image/x-icon" href="../back-end//assets/img/favicon/favicon.ico" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="../back-end/assets/vendor/fonts/boxicons.css" />
    <link rel="stylesheet" href="../back-end/assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../back-end/assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../back-end/assets/css/demo.css" />
    <link rel="stylesheet" href="../back-end/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />
    <link rel="stylesheet" href="../back-end/assets/vendor/libs/apex-charts/apex-charts.css" />
    <script src="../back-end/assets/vendor/js/helpers.js"></script>
    <script src="../back-end/assets/js/config.js"></script>
  </head>

  <body>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
        <!-- Menu -->

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="app-brand demo">
            <a href="index.html" class="app-brand-link">
              <span class="app-brand-text demo menu-text fw-bolder ms-2">Sneat</span>
            </a>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">
            <li class="menu-header small text-uppercase">
              <span class="menu-header-text">Pages</span>
            </li>
            <li class="menu-item">
              <a href="../dashbord.jsp" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Analytics">Dashboard</div>
              </a>
            </li>
            <%
            if (userRole != null) {
            %>
            <li class="menu-item">
              <a href="../appointment/index.jsp" class="menu-link">
                <i class="menu-icon tf-icons bx bx-collection"></i>
                <div data-i18n="Basic">Appointment</div>
              </a>
            </li>
            <%
            }
            if ("technologist".equals(userRole) || "supervisor".equals(userRole)) {
            %>
            <li class="menu-item active">
              <a href="index.jsp" class="menu-link">
                <i class="menu-icon tf-icons bx bx-crown"></i>
                <div data-i18n="Boxicons">Test Records</div>
              </a>
            </li>
            <li class="menu-item">
              <a href="../user/index.jsp" class="menu-link">
                <i class="menu-icon tf-icons bx bx-crown"></i>
                <div data-i18n="Boxicons">Users</div>
              </a>
            </li>
            <li class="menu-item">
              <a href="../technologist/index.jsp" class="menu-link">
                <i class="menu-icon tf-icons bx bx-crown"></i>
                <div data-i18n="Boxicons">Technologist</div>
              </a>
            </li>
            <%
            }
            %>
          </ul>
        </aside>
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
          <!-- Navbar -->

          <nav
            class="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
            id="layout-navbar"
          >
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
              <a class="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
              </a>
            </div>

            <div class="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
              <ul class="navbar-nav flex-row align-items-center ms-auto">
                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                      <img src="../back-end//assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                    </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="#">
                        <div class="d-flex">
                          <div class="flex-shrink-0 me-3">
                            <div class="avatar avatar-online">
                              <img src="../back-end//assets/img/avatars/1.png" alt class="w-px-40 h-auto rounded-circle" />
                            </div>
                          </div>
                          <div class="flex-grow-1">
                            <span class="fw-semibold d-block">Hi, <%=userFirstName%> <%=userLastName%></span>
                            <small class="text-muted"><%=userRole%></small>
                          </div>
                        </div>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="../logout">
                        <i class="bx bx-power-off me-2"></i>
                        <span class="align-middle">Log Out</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
          </nav>

          <!-- / Navbar -->

          <!-- Content wrapper -->
          <div class="content-wrapper">
            <!-- Content -->

            <div class="container-xxl flex-grow-1 container-p-y">
              <div class="row">
 				<div class="card">
                <div class="d-flex justify-content-between">
                  <h5 class="card-header">Technologist Table</h5>
                  <a href="create.jsp" class="btn btn-primary m-3">
                      <span class="tf-icons bx bx-pie-chart-alt"></span>&nbsp; Add medical
                  </a>
                </div>

                <div class="table-responsive text-nowrap">
                  <table class="table">
                    <thead>
                      <tr class="text-nowrap">
                        <th>ID</th>
                        <th>Name</th>
                        <th>Amount</th>
                        <th>Processing Time(hours)</th>
                        <th>Action</th>
                      </tr>
                    </thead>
                    <tbody>
                        <%
                        for (MedicalTest medicalTest : medicalTestList) {
                        %>
                        <tr>
                            <td><%=medicalTest.getId()%></td>
                            <td><%=medicalTest.getName()%></td>
                            <td><%=String.valueOf(medicalTest.getAmount())%></td>
                            <td><%=String.valueOf(medicalTest.getProcessingTime())%></td>
                            <td><a
                                href="create.jsp?medical-test=<%=String.valueOf(medicalTest.getId())%>">EDIT</a></td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                  </table>
                </div>
              </div>
              </div>
            </div>
            <!-- / Content -->

            <!-- Footer -->
            <footer class="content-footer footer bg-footer-theme">
              <div class="container-xxl d-flex flex-wrap justify-content-between py-2 flex-md-row flex-column">
                <div class="mb-2 mb-md-0">
                  ©
                  <script>
                    document.write(new Date().getFullYear());
                  </script>
                  , made with ❤️ by
                  <a href="https://themeselection.com" target="_blank" class="footer-link fw-bolder">ThemeSelection</a>
                </div>
              </div>
            </footer>
            <!-- / Footer -->

            <div class="content-backdrop fade"></div>
          </div>
          <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
      </div>

      <!-- Overlay -->
      <div class="layout-overlay layout-menu-toggle"></div>
    </div>
    <!-- / Layout wrapper -->

    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="../back-end/assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../back-end/assets/vendor/libs/popper/popper.js"></script>
    <script src="../back-end/assets/vendor/js/bootstrap.js"></script>
    <script src="../back-end/assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>
    <script src="../back-end/assets/vendor/js/menu.js"></script>
    <script src="../back-end/assets/vendor/libs/apex-charts/apexcharts.js"></script>
    <script src="../back-end/assets/js/main.js"></script>
    <script src="../back-end/assets/js/dashboards-analytics.js"></script>
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>