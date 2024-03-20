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
import modal.User;
import core.Validation;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
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
		response.sendRedirect("login.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("hello");
		System.out.println("hello");
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Map<String, String> fieldErrors = new HashMap<>();
		boolean status = false;
		
		String emailAddress = request.getParameter("email");
		String password = request.getParameter("password");

		String emailError = Validation.isFieldRequired("email", emailAddress);
		if (emailError != null) {
			fieldErrors.put("email", emailError);
		} else {
			String emailError1 = Validation.isValidEmail("email", emailAddress);
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

		if (fieldErrors.isEmpty()) {
			try {
				User user = UserController.authenticateUser(emailAddress, password);
				if (user != null) {
					session.setAttribute("user-id", user.getId());
					session.setAttribute("user-email", user.getEmail());
					session.setAttribute("user-first-name", user.getf_name());
					session.setAttribute("user-last-name", user.getl_name());
					session.setAttribute("user-role", user.getRoleName());
					status = true;
				} else {
					fieldErrors.put("email", "These credentials do not match our records.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if (status) {
			response.sendRedirect("index.jsp");
		} else {
			session.setAttribute("fieldErrors", fieldErrors);
			response.sendRedirect("login.jsp");
		}
	}
}


