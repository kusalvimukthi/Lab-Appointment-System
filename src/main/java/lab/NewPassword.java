package lab;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.UserController;
import core.Validation;

/**
 * Servlet implementation class NewPassword
 */
@WebServlet("/newPassword")
public class NewPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Map<String, String> fieldErrors = new HashMap<>();
		boolean status = false;
		
		String emailAddress = (String) session.getAttribute("forgot-password-email");
		String otp = request.getParameter("otp");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confPassword");

		
		String otpError = Validation.isFieldRequired("otp", otp);
		if (otpError != null) {
			fieldErrors.put("otp", otpError);
		} else {
			String otpError1 = Validation.isLengthIsValid("otp", otp, 6);
			if (otpError1 != null) {
				fieldErrors.put("otp", otpError1);
			}
		}

		String passwordError = Validation.isFieldRequired("password", password);
		if (passwordError != null) {
			fieldErrors.put("password", passwordError);
		} else {
			String passwordError1 = Validation.isLengthIsValid("password", password, 8);
			if (passwordError1 != null) {
				fieldErrors.put("password", passwordError1);
			}else {
				if (!password.equals(confirmPassword)) {
					fieldErrors.put("password", "The password and confirm password does not match");
				}
			}
		}

		String confirmPasswordError = Validation.isFieldRequired("confPassword", confirmPassword);
		if (confirmPasswordError != null) {
			fieldErrors.put("confPassword", confirmPasswordError);
		} else {
			String confirmPasswordError1 = Validation.isLengthIsValid("confPassword", confirmPassword, 8);
			if (confirmPasswordError1 != null) {
				fieldErrors.put("confPassword", confirmPasswordError1);
			}
		}

		if (fieldErrors.isEmpty()) {
			try {
				boolean resetStatus = UserController.resetPassword(emailAddress, otp, password, confirmPassword);
				if (resetStatus) {
					session.setAttribute("forgot-password-email", null); 
		            session.setAttribute("forgot-password-success", "Password reset successfully. Please log in.");
					status = true;
				} else {
					fieldErrors.put("otp", "Invalid otp.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (status) {
			response.sendRedirect("login.jsp");
		} else {
			session.setAttribute("fieldErrors", fieldErrors);
			response.sendRedirect("setPassword.jsp");
		}
	}

}


