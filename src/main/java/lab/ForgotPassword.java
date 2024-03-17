package lab;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
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
 * Servlet implementation class ForgotPasswordServlet
 */
@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ForgotPassword() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect("forgot-password.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Map<String, String> fieldErrors = new HashMap<>();
		boolean status = false;
    	
		String emailAddress = request.getParameter("email");

		String emailError = Validation.isFieldRequired("email", emailAddress);
		if (emailError != null) {
			fieldErrors.put("email", emailError);
		} else {
			String emailError1 = Validation.isValidEmail("email", emailAddress);
			if (emailError1 != null) {
				fieldErrors.put("email", emailError1);
			}
		}

		if (fieldErrors.isEmpty()) {
			try {
				boolean sendStatus = UserController.createPasswordResetTokens(emailAddress);
				if (sendStatus) {
					session.setAttribute("forgot-password-email", emailAddress); 
					status = true;
				} else {
					fieldErrors.put("email", "These credentials do not match our records.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (status) {
			response.sendRedirect("setPassword.jsp");
		} else {
			session.setAttribute("fieldErrors", fieldErrors);
			response.sendRedirect("forgot-password.jsp");
		}
	}
}
