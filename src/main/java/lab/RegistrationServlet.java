package lab;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.UserController;
import modal.User;
import core.Validation;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<String, String> fieldErrors = new HashMap<>();
        User user = null;

        Enumeration<String> parameterNames = request.getParameterNames();
        Map<String, String> createUserFields = new HashMap<>();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String paramValue = request.getParameter(paramName);
            createUserFields.put(paramName, paramValue);
        }
        session.setAttribute("createUserFields", createUserFields);

        String firstName = request.getParameter("f_name");
        String lastName = request.getParameter("l_name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confPassword");
        String telephone = request.getParameter("telephone");
        String nic = request.getParameter("nic");
        String dob = request.getParameter("dob");

        String firstNameError = Validation.isFieldRequired("f_name", firstName);
        if (firstNameError != null) {
            fieldErrors.put("f_name", firstNameError);
        }

        String lastNameError = Validation.isFieldRequired("l_name", lastName);
        if (lastNameError != null) {
            fieldErrors.put("l_name", lastNameError);
        }

        String emailError = Validation.isFieldRequired("email", email);
        if (emailError != null) {
            fieldErrors.put("email", emailError);
        } else {
            String emailError1 = Validation.isValidEmail("email", email);
            if (emailError1 != null) {
                fieldErrors.put("email", emailError1);
            }
        }

        String passwordError = Validation.isFieldRequired("password", password);
        if (passwordError != null) {
            fieldErrors.put("password", passwordError);
        } else {
            String passwordError1 = Validation.isLengthIsValid("password", password, 8);
            if (passwordError1 != null) {
                fieldErrors.put("password", passwordError1);
            }
        }

        String confirmPasswordError = Validation.isFieldRequired("confPassword", confirmPassword);
        if (confirmPasswordError != null) {
            fieldErrors.put("confPassword", confirmPasswordError);
        } else if (!confirmPassword.equals(password)) {
            fieldErrors.put("confPassword", "Passwords do not match");
        }

        String telephoneError = Validation.isFieldRequired("telephone", telephone);
        if (telephoneError != null) {
            fieldErrors.put("telephone", telephoneError);
        }

        String nicError = Validation.isFieldRequired("nic", nic);
        if (nicError != null) {
            fieldErrors.put("nic", nicError);
        }

        String dobError = Validation.isFieldRequired("dob", dob);
        if (dobError != null) {
            fieldErrors.put("dob", dobError);
        }

        if (fieldErrors.isEmpty()) {
            try {
                User userData = UserController.findUserByEmail(email);
                if (userData == null) {
                    user = UserController.createUser(firstName, lastName, email, password, telephone, nic, dob);
                } else {
                    fieldErrors.put("email", "This email is already used.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (user == null) {
            fieldErrors.put("common", "Something went wrong. please try again later.");
            session.setAttribute("fieldErrors", fieldErrors);
        } else {
            session.setAttribute("user-create-status", "User created successfully.");
        }

        if (fieldErrors.isEmpty()) {
            response.sendRedirect("appoiment.jsp"); // Redirect to dashboard if registration successful
        } else {
            session.setAttribute("fieldErrors", fieldErrors);
            response.sendRedirect("registration.jsp"); // Redirect back to registration page if errors occurred
        }
    }
}
