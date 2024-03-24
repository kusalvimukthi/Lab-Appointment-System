package controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import modal.Appointment;
import modal.MedicalTest;
import core.DbConnection;

public class AppoimentController {
	private static final String EMAIL = "vimukthik197@gmail.com";
	private static final String PASSWORD = "stiblmujstsnhdyn";

	private static Appointment findAppointmentById(int id) {
		Connection con = null;
		Appointment appointment = null;
		ResultSet rs = null;
		try {
			con = DbConnection.getConnection();
			String query = "SELECT * FROM appointments WHERE id=?";
			PreparedStatement pst = con.prepareStatement(query);
			pst.setInt(1, id);
			rs = pst.executeQuery();
			if (rs.next()) {
				appointment = new Appointment();
				appointment.setId(rs.getInt("id"));
				appointment.setUserId(rs.getInt("user_id"));
				appointment.setAppointmentStatus(rs.getString("appointment_status"));
				appointment.setAmount(rs.getDouble("amount"));
				appointment.setRecommendedDoctor(rs.getString("recommended_doctor"));
				appointment.setSelectDate(rs.getString("select_date"));
				appointment.setSelectTime(rs.getString("select_time"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnection.closeConnection(con);
		}
		return appointment;
	}

	public static Appointment createAppointment(String userId, String userEmail, String recommended_doctor, String booking_date,
			String booking_time, String[] medical_test) {
		Connection con = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;
		double totalAmount = 0;
		try {
			con = DbConnection.getConnection();
			con.setAutoCommit(false);
			System.out.println("aaaa 1");
			String countQuery = "SELECT COUNT(*) FROM appointments WHERE select_date = ? AND select_time = ?";
			preparedStatement = con.prepareStatement(countQuery);
			preparedStatement.setString(1, booking_date);
			preparedStatement.setString(2, booking_time);
			rs = preparedStatement.executeQuery();
			if (rs.next()) {
				int appointmentCount = rs.getInt(1);
				if (appointmentCount >= 5) {
					return null;
				}
			}

			String query = "INSERT INTO appointments (user_id, appointment_status, recommended_doctor, select_date, select_time) VALUES (?, ?, ?, ?, ?)";
			preparedStatement = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, userId);
			preparedStatement.setString(2, "booked");
			preparedStatement.setString(3, recommended_doctor);
			preparedStatement.setString(4, booking_date);
			preparedStatement.setString(5, booking_time);
			int rowsAffected = preparedStatement.executeUpdate();
			if (rowsAffected > 0) {
				rs = preparedStatement.getGeneratedKeys();
				if (rs.next()) {
					int appointmentId = rs.getInt(1);
					for (String medicalTestId : medical_test) {
						String query1 = "SELECT * FROM medical_records WHERE id = ?";
						preparedStatement = con.prepareStatement(query1);
						preparedStatement.setInt(1, Integer.parseInt(medicalTestId));
						ResultSet rsMedicalTest = preparedStatement.executeQuery();
						if (rsMedicalTest.next()) {
							String query3 = "INSERT INTO medical_test_records "
									+ "(appointment_id, medical_test_id, status_id) " + "VALUES (?, ?, ?)";
							preparedStatement = con.prepareStatement(query3);
							preparedStatement.setInt(1, appointmentId);
							preparedStatement.setInt(2, rsMedicalTest.getInt("id"));
							preparedStatement.setInt(3, 1);
							int rowsAffected1 = preparedStatement.executeUpdate();
							if (rowsAffected1 > 0) {
								totalAmount += rsMedicalTest.getDouble("amount");
							}
						}
					}

					String query1 = "UPDATE appointments SET amount=? WHERE id=?";
					preparedStatement = con.prepareStatement(query1);
					preparedStatement.setDouble(1, totalAmount);
					preparedStatement.setInt(2, appointmentId);
					int rowsAffected2 = preparedStatement.executeUpdate();
					if (rowsAffected2 > 0) {
						con.commit();
						
						Properties props = new Properties();
						props.put("mail.smtp.host", "smtp.gmail.com");
						props.put("mail.smtp.socketFactory.port", "465");
						props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
						props.put("mail.smtp.auth", "true");
						props.put("mail.smtp.port", "465");
						Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
							protected PasswordAuthentication getPasswordAuthentication() {
								return new PasswordAuthentication(EMAIL, PASSWORD);
							}
						});
						MimeMessage message = new MimeMessage(session);
						try {
							message.setFrom(new InternetAddress(EMAIL));
							message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
							message.setSubject("ABC laboratory appointment. ID: "+appointmentId);
							String htmlContent = "<html><body>" +
			                        "<div style='padding: 20px; border: 1px solid #ccc; border-radius: 5px;'>" +
			                            "<h3>Hello,</h3>" +
			                            "<p>Thank you for choosing ABC laboratory for your medical tests. " +
			                            "We are thrilled to have you on board and look forward to providing you with exceptional service</p>" +
			                            "<hr style='border: 0; border-top: 1px solid #ccc;'>" +
			                            "<p>Your appointment details are as follows:</p>" +
			                            "<p>Appointment Number: <strong>" + appointmentId + "</strong></p>" +
			                            "<p>Booking date: <strong>" + booking_date + "</strong></p>" +
			                            "<p>Booking time: <strong>" + booking_time + "</strong></p>" +
			                            "<p>Total Amount: <strong>" + totalAmount + "</strong></p>" +
			                            "<hr style='border: 0; border-top: 1px solid #ccc;'>" +
			                            "<p>Thank you,</p>" +
			                            "<p>The ABC Laboratories Team</p>" +
			                        "</div>" +
			                    "</body></html>";
							message.setContent(htmlContent, "text/html");
							Transport.send(message);
							System.out.println("message sent successfully");
						} catch (AddressException e) {
							e.printStackTrace();
						} catch (MessagingException e) {
							e.printStackTrace();
						}
						return findAppointmentById(appointmentId);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				if (con != null) {
					con.rollback();
				}
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (con != null) {
					con.setAutoCommit(true);
					DbConnection.closeConnection(con);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public static List<Appointment> getAllAppointments(Integer user_id) {
		Connection con = null;
		List<Appointment> appointmentList = new ArrayList<>();
		ResultSet rs = null;
		System.out.println(user_id + "user id");
		PreparedStatement pst = null;
		try {
			con = DbConnection.getConnection();
			String query = null;
			if (user_id != null) {
				 query = "SELECT appointments.id, users.f_name, users.l_name, appointments.appointment_status, " +
	                    "appointments.amount, appointments.recommended_doctor, appointments.select_date, " +
	                    "appointments.select_time, medical_test_records.status_id, medical_test_records.report, " +
	                    "medical_test_records.result " +
	                    "FROM appointments " +
	                    "INNER JOIN users ON appointments.user_id = users.id " +
	                    "LEFT JOIN medical_test_records ON appointments.id = medical_test_records.appointment_id " +
	                    "WHERE appointments.user_id = ?";
				 pst = con.prepareStatement(query);
				 pst.setInt(1, user_id);
			}else {
				 query = "SELECT appointments.id, users.f_name, users.l_name, appointments.appointment_status, " +
	                    "appointments.amount, appointments.recommended_doctor, appointments.select_date, " +
	                    "appointments.select_time, medical_test_records.status_id, medical_test_records.report, " +
	                    "medical_test_records.result " +
	                    "FROM appointments " +
	                    "INNER JOIN users ON appointments.user_id = users.id " +
	                    "LEFT JOIN medical_test_records ON appointments.id = medical_test_records.appointment_id ";
				 pst = con.prepareStatement(query);
			}
			
			
			rs = pst.executeQuery();
			while (rs.next()) {
				Appointment appointment = new Appointment();
	            appointment.setId(rs.getInt("id"));
	            appointment.setUserName(rs.getString("f_name") + " " + rs.getString("l_name")); // Combine first name and last name
	            appointment.setAppointmentStatus(rs.getString("appointment_status"));
	            appointment.setAmount(rs.getDouble("amount"));
	            appointment.setRecommendedDoctor(rs.getString("recommended_doctor"));
	            appointment.setSelectDate(rs.getString("select_date"));
	            appointment.setSelectTime(rs.getString("select_time"));
	            appointment.setStatusId(rs.getInt("status_id"));
	            appointment.setReport(rs.getString("report"));
	            appointment.setResult(rs.getString("result"));
				appointmentList.add(appointment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DbConnection.closeConnection(con);
		}
		return appointmentList;
	}
	
	 public static Appointment updateAppoiments(String appoiment_id, String status, String result,
			 String fileUrl, String id) {
	        Connection con = null;
	        PreparedStatement preparedStatement = null;
	        try {
	            con = DbConnection.getConnection();
	            String sql = "UPDATE medical_test_records SET status_id=?, report=?, result=?, technician_id=? WHERE appointment_id=?";
	            preparedStatement = con.prepareStatement(sql);
	            preparedStatement.setString(1, status);
	            preparedStatement.setString(2, fileUrl);
	            preparedStatement.setString(3, result);
	            preparedStatement.setString(4, id);
	            preparedStatement.setString(5, appoiment_id);
	            int rowsAffected = preparedStatement.executeUpdate();
	            if (rowsAffected > 0) {
	                // If update is successful, you might want to return the updated appointment
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            DbConnection.closeConnection(con);
	        }
	        return null;
	    }



}

