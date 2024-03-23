package modal;

public class Appointment {
    private int id;
    private int userId;
    private String appointmentStatus;
    private double amount;
    private String recommendedDoctor;
    private String selectDate;
    private String selectTime;
    private int statusId; 
    private String report; 
    private String result; 
    private String userName; 


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getAppointmentStatus() {
        return appointmentStatus;
    }

    public void setAppointmentStatus(String appointmentStatus) {
        this.appointmentStatus = appointmentStatus;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getRecommendedDoctor() {
        return recommendedDoctor;
    }

    public void setRecommendedDoctor(String recommendedDoctor) {
        this.recommendedDoctor = recommendedDoctor;
    }

    public String getSelectDate() {
        return selectDate;
    }

    public void setSelectDate(String selectDate) {
        this.selectDate = selectDate;
    }

    public String getSelectTime() {
        return selectTime;
    }

    public void setSelectTime(String selectTime) {
        this.selectTime = selectTime;
    }
    
    public String getStatusId() {
    	String statusText = "";
    	if (statusId == 1) {
    	    statusText = "<span class=\"badge bg-label-primary\">Pending</span>";
    	} else if (statusId == 2) {
    	    statusText = "<span class=\"badge bg-label-info\">Processing</span>";
    	} else if (statusId == 3) {
    	    statusText = "<span class=\"badge bg-label-success\">Completed</span>";
    	} else {
    	    statusText = "<span class=\"badge bg-label-dark\">Booked</span>"; 
    	}
        return statusText;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getReport() {
        if (report != null && !report.isEmpty()) {
            // If report URL is available, return an HTML anchor tag
            return "<a href='" + report + "' target='_blank'>Report</a>";
        } else {
            // If report URL is not available, return "N/A"
            return "N/A";
        }
    }

    public void setReport(String report) {
        this.report = report;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
