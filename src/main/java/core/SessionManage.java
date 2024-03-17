package core;

import java.util.Map;

public class SessionManage {

    public static String getFiledValue(Map<String, String> fieldErrors, String fieldName) {
    	System.out.println((fieldErrors != null && fieldErrors.containsKey(fieldName)) ? fieldErrors.get(fieldName) : "");
        return (fieldErrors != null && fieldErrors.containsKey(fieldName)) ? fieldErrors.get(fieldName) : "";
        
    }
}
