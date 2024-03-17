package lab;

import java.io.IOException;
import java.util.Enumeration;
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
 * Servlet implementation class TechniciansServlet
 */
@WebServlet("/technologist/TechniciansServlet")
public class TechniciansServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TechniciansServlet() {
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
		response.sendRedirect("backend-technicians/index.jsp");
		// String path = request.getServletPath();
		// String action = request.getPathInfo();
		// System.out.println(action);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Map<String, String> fieldErrors = new HashMap<>();
		User user = null;

		Enumeration<String> parameterNames = request.getParameterNames();
		Map<String, String> createTechniciansFileds = new HashMap<>();
		while (parameterNames.hasMoreElements()) {
			String paramName = parameterNames.nextElement();
			String paramValue = request.getParameter(paramName);
			createTechniciansFileds.put(paramName, paramValue);
		}
		session.setAttribute("createTechniciansFields", createTechniciansFileds);

		String formAction = request.getParameter("action");
		String f_name = request.getParameter("f_name");
		String l_name = request.getParameter("l_name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confPassword = request.getParameter("confPassword");
		String telephone = request.getParameter("telephone");
		String nic = request.getParameter("nic");
		String dob = request.getParameter("dob");

		String firstNameError = Validation.isFieldRequired("f_name", f_name);
		if (firstNameError != null) {
			fieldErrors.put("f_name", firstNameError);
		}

		String lastNameError = Validation.isFieldRequired("l_name", l_name);
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
		
		if (formAction.equals("create")) {
			String passwordError = Validation.isFieldRequired("password", password);
			if (passwordError != null) {
				fieldErrors.put("password", passwordError);
			} else {
				String passwordError1 = Validation.isLengthIsValid("password", password, 8);
				if (passwordError1 != null) {
					fieldErrors.put("password", passwordError1);
				}
			}

			String confirmPasswordError = Validation.isFieldRequired("confPassword", confPassword);
			if (confirmPasswordError != null) {
				fieldErrors.put("confPassword", confirmPasswordError);
			} else {
				String confirmPasswordError1 = Validation.isLengthIsValid("confPassword", confPassword, 8);
				if (confirmPasswordError1 != null) {
					fieldErrors.put("confPassword", confirmPasswordError1);
				}
			}
		}

		String telError = Validation.isFieldRequired("telephone", telephone);
		if (telError != null) {
			fieldErrors.put("telephone", telError);
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
				if (formAction.equals("create")) {
					if (userData == null) {
						user = UserController.createTechnicians(f_name, l_name, email, password,
								confPassword, telephone, nic, dob, "technologist");
					} else {
						fieldErrors.put("email", "This email is already used.");
					}
				} else {
					if (userData != null) {
						user = UserController.updateUserByEmail(f_name, l_name, email, telephone, nic,
								dob);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (user == null) {
			fieldErrors.put("common", "Something went wrong. please try again later.");
			session.setAttribute("fieldErrors", fieldErrors);
		} else {
			if (formAction.equals("create")) {
				session.setAttribute("technician-create-status", "Technician created successfully.");
			}else {
				session.setAttribute("technician-create-status", "Technician updated successfully.");
			}
		}
		if (formAction.equals("create")) {
			response.sendRedirect("create.jsp");
		}else {
			response.sendRedirect("create.jsp?email-address="+email);
		}
	}

	/**
	 * @see HttpServlet#doPut(HttpServletRequest, HttpServletResponse)
	 */
	protected void doPut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
