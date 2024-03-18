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
import controller.AppoimentController;
import modal.User;
import modal.Appointment;
import core.Validation;

/**
 * Servlet implementation class AppoimentServlet
 */
@WebServlet("/AppoimentServlet")
public class AppoimentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AppoimentServlet() {
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
        Appointment appointment = null;

        // Retrieve form data
        String booking_date = request.getParameter("booking_date");
        String booking_time = request.getParameter("booking_time");
        String recommended_doctor = request.getParameter("recommended_doctor");
        String[] medical_test = request.getParameterValues("medical_test");

        // Validate form fields
        // Note: You might need to add more validation logic here

        // If there are no validation errors
        if (fieldErrors.isEmpty()) {
            try {
                // Get user data (assuming the user is already logged in or identified)
                // You might need to retrieve user data from session or database
            	System.err.println("hello1");
                String id = String.valueOf(session.getAttribute("user-id"));
                String email = (String)session.getAttribute("user-email");
                if (id != null && email != null) {
                	System.err.println("hello2");
                    appointment = AppoimentController.createAppointment(id, email, recommended_doctor, booking_date,
                            booking_time, medical_test);
                } else {
                    fieldErrors.put("common", "User not logged in or identified.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                fieldErrors.put("common", "Something went wrong. please try again later.");
            }
        }

        // Handle success or failure
        if (appointment == null) {
            // Appointment creation failed, set error messages
            session.setAttribute("fieldErrors", fieldErrors);
        } else {
            // Appointment creation successful, set success message
            session.setAttribute("user-create-status",
                    "Your appointment has been booked successfully. Your appointment details will be sent to your email shortly.");
        }
        System.err.println(fieldErrors);
        // Redirect to appropriate page
        response.sendRedirect("appoiment.jsp");
    }
}
