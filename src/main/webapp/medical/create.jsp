<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

    <%@ page import="java.util.Map"%>
    <%@ page import="core.SessionManage"%>
    <%@ page import="controller.MedicalController"%>
    <%@ page import="modal.MedicalTest"%>
    
    <%
    String userEmail = (String) session.getAttribute("user-email");
    String userFirstName = (String) session.getAttribute("user-first-name");
    String userLastName = (String) session.getAttribute("user-last-name");
    String userRole = (String) session.getAttribute("user-role");
    if (userFirstName == null || userEmail == null) {
        response.sendRedirect("../login.jsp");
    }
    Map<String, String> fieldErrors = (Map<String, String>) session.getAttribute("fieldErrors");
        String idError = SessionManage.getFiledValue(fieldErrors, "medical_test_id");
        String nameError = SessionManage.getFiledValue(fieldErrors, "medical_test_name");
        String descriptionError = SessionManage.getFiledValue(fieldErrors, "medical_test_description");
        String dataError = SessionManage.getFiledValue(fieldErrors, "medical_test_normal_record_data");
        String amountError = SessionManage.getFiledValue(fieldErrors, "medical_test_amount");
        String timeError = SessionManage.getFiledValue(fieldErrors, "medical_test_processing_time");
        String isActiveError = SessionManage.getFiledValue(fieldErrors, "medical_test_is_active");
        String common = SessionManage.getFiledValue(fieldErrors, "common");
        session.removeAttribute("fieldErrors");
        
        String status = (String) session.getAttribute("medical-test-create-status");
        session.removeAttribute("medical-test-create-status");
        
        String updateTestId = request.getParameter("medical-test");
        if (status != null || updateTestId != null) {
            session.removeAttribute("createMedicalTestFileds");
        }
        
        String testId, testName, testDescription, testNormalRecordData, testAmount, testProccesingTime;
        testId = testName = testDescription = testNormalRecordData = testAmount = testProccesingTime = "";
        boolean isInvalidTest = false;
        if (updateTestId != null) {
            MedicalTest medicalTestData = MedicalController.findMedicalTestById(updateTestId);
            if (medicalTestData != null) {
                testId = String.valueOf(medicalTestData.getId());
                testName = medicalTestData.getName();
                testDescription = medicalTestData.getDescription();
                testNormalRecordData = medicalTestData.getNormalRecordData();
                testAmount = String.valueOf(medicalTestData.getAmount());
                testProccesingTime = String.valueOf(medicalTestData.getProcessingTime());
            } else {
                updateTestId = null;
                isInvalidTest = true;
            }
        } else {
            Map<String, String> inputs = (Map<String, String>) session.getAttribute("createMedicalTestFileds");
            testId = SessionManage.getFiledValue(inputs, "medical_test_id");
            testName = SessionManage.getFiledValue(inputs, "medical_test_name");
            testDescription = SessionManage.getFiledValue(inputs, "medical_test_description");
            testNormalRecordData = SessionManage.getFiledValue(inputs, "medical_test_normal_record_data");
            testAmount = SessionManage.getFiledValue(inputs, "medical_test_amount");
            testProccesingTime = SessionManage.getFiledValue(inputs, "medical_test_processing_time");
            session.removeAttribute("createTechniciansFields");
        }
        %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0" />

    <title>ABC Laboratories</title>
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
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">

        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="app-brand demo">
            <a href="../index.jsp" class="app-brand-link">
              <span class="app-brand-text demo menu-text fw-bolder ms-2">ABC LAB</span>
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
            <%
            }
            if ("supervisor".equals(userRole)) {
            %>
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

        <div class="layout-page">

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
              </ul>
            </div>
          </nav>


          <div class="content-wrapper">
            <div class="container-xxl flex-grow-1 container-p-y">
                <div class="row">
                    <div class="card mb-4">
                        <h5 class="card-header"><%=(updateTestId == null) ? "Create a New Medical Tests" : "Update a Medical Tests"%></h5>
                        <hr class="my-0" />
                        <div class="card-body">
                          <form id="formAccountSettings" method="post" action="MedicalTestServlet">
                            <div class="row">
                              <div class="mb-3 col-md-6">
                                <input type="hidden" name="action"
                                value="<%=(updateTestId != null) ? "update" : "create"%>">
                                <input type="hidden" name="medical_test_id"
                                value="<%=updateTestId %>">
                                <label for="medical_test_name" class="form-label">Medical Test Name</label>
                                <input class="form-control" type="text" name="medical_test_name" id="medical_test_name" value="<%=testName%>" />
                                <%=(nameError != null) ? "<span style=\"color: red;\">" + nameError + "</span>" : ""%>
                              </div>

                              <div class="mb-3 col-md-6">
                                <label for="medical_test_processing_time" class="form-label">Medical Test Processing Time</label>
                                <input class="form-control" type="number" min="1" step="0.25" id="medical_test_processing_time" name="medical_test_processing_time"  value="<%=testProccesingTime%>"/>
                                <%=(timeError != null) ? "<span style=\"color: red;\">" + timeError + "</span>" : ""%>
                              </div>

                              <div class="mb-3 col-md-6">
                                <label for="medical_test_amount" class="form-label">Medical Test Amount</label>
                                <input class="form-control" type="number" min="1" step="0.01" id="medical_test_amount" name="medical_test_amount"  value="<%=testAmount%>"/>
                                <%=(amountError != null) ? "<span style=\"color: red;\">" + amountError + "</span>" : ""%>
                              </div>

                              <div class="mb-3 col-md-12">
                                <label for="medical_test_description" class="form-label">Medical Test Description</label>
                                <textarea type="text" class="form-control" id="medical_test_description" name="medical_test_description"   rows="2"/><%=testDescription%></textarea>
                                <%=(descriptionError != null) ? "<span style=\"color: red;\">" + descriptionError + "</span>" : ""%>
                              </div>

                              <div class="mb-3 col-md-12">
                                <label for="medical_test_normal_record_data" class="form-label">Medical Test Normal</label>
                                <textarea class="form-control" type="tel" id="medical_test_normal_record_data" name="medical_test_normal_record_data"   rows="2" /><%=testNormalRecordData%></textarea>
                                <%=(dataError != null) ? "<span style=\"color: red;\">" + dataError + "</span>" : ""%>
                              </div>
                              
                            </div>
                            <div class="form-group">
                                <%=(common != null) ? "<span style=\"color: red;\">" + common + "</span>" : ""%>
                            </div>
                            <div class="mt-2">
                              <button type="submit" class="btn btn-primary me-2">Save changes</button>
                              <a href="index.jsp" class="btn btn-outline-secondary">Back Test Records</a>
                            </div>
                          </form>
                        </div>
                      </div>
                </div>
            </div>

            <div class="content-backdrop fade"></div>
          </div>
        </div>
      </div>

      <div class="layout-overlay layout-menu-toggle"></div>
    </div>

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