package core;

public class Validation {
	
	public static String convertUnderscoreToSpace(String input) {
		return input.replace('_', ' ');
	}

	// Validate email
	public static String isValidEmail(String fieldName, String fieldValue) {
		String emailRegex = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
		if (fieldValue == null || !fieldValue.matches(emailRegex)) {
			return "The "+convertUnderscoreToSpace(fieldName)+" is invalid email address.";
		}
		return null;
	}

	// Validate password
	public static String isLengthIsValid(String fieldName, String fieldValue, int minLength) {
		if (fieldValue == null || fieldValue.length() < minLength) {
			return "The "+convertUnderscoreToSpace(fieldName)+" must be at least " + minLength + " characters.";
		}
		return null;
	}

	// Validate required
	public static String isFieldRequired(String fieldName, String fieldValue) {
		if (fieldValue == null || fieldValue.trim().isEmpty()) {
			return "The "+convertUnderscoreToSpace(fieldName)+" is required.";
		}
		return null;
	}
	


}

