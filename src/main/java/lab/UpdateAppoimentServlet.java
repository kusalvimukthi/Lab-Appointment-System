package lab;

import java.io.File;
import java.io.IOException;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import controller.AppoimentController;
import modal.Appointment;

@WebServlet("/appointment/UpdateAppoimentServlet")
@MultipartConfig
public class UpdateAppoimentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Map<String, String> fieldErrors = new HashMap<>();
        Appointment appointment = null;

        // Retrieve form data
        String appoiment_id = request.getParameter("appoiment_id");
        String status = request.getParameter("status");
        String result = request.getParameter("result");
        System.out.println(status+ "status");
        // Handle file upload
        Part filePart = request.getPart("reportFile");
        String uploadDir = getServletContext().getRealPath("/") + "uploads/";
        File directory = new File(uploadDir);
        if (!directory.exists()) {
            directory.mkdir();
        }
        System.out.println(filePart);
        String fileName = getFileName(filePart);
        String filePath = uploadDir + File.separator + fileName;
        try (InputStream input = filePart.getInputStream();
             OutputStream output = new FileOutputStream(filePath)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
            
        }
        String fileUrl = request.getContextPath() + "/uploads/" + fileName;
//        byte[] reportFileBytes = null;
//        if (filePart != null && filePart.getSize() > 0) {
//            reportFileBytes = new byte[(int) filePart.getSize()];
//            filePart.getInputStream().read(reportFileBytes);
//        }
//    	System.out.println(reportFileBytes);
        // Validate form fields
        // Note: You might need to add more validation logic here

        // If there are no validation errors
        if (fieldErrors.isEmpty()) {
            try {
                // Get user data (assuming the user is already logged in or identified)
                // You might need to retrieve user data from session or database
                String id = String.valueOf(session.getAttribute("user-id"));
                String email = (String) session.getAttribute("user-email");
                if (id != null && email != null) {
                    appointment = AppoimentController.updateAppoiments(appoiment_id, status, result,
                    		fileUrl, id);
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

        // Redirect to appropriate page
        response.sendRedirect("create.jsp");
    }
    
    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}

