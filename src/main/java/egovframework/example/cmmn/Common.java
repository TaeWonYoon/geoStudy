package egovframework.example.cmmn;

import java.util.HashMap;
import java.util.Map;

public class Common {

	public static String keyVal(String data, String statusKey, String statusVal){
        String statusKeys[] = statusKey.split(","); // key
        String statusVals[] = statusVal.split(","); // value
        
        
        Map<String, Object> map = new HashMap<String, Object>();
        
        for(int i=0; i < statusKeys.length; i++) {
        	map.put(statusKeys[i], statusVals[i]);  // 원하는 key,val 배열에 담기
        }
        String dataVal = (String)map.get(data);  //val 출력
        return dataVal;
	}
	
	public static String cmpr(String txt, String data, String ceck){
		String type = "";
		if(ceck.equals("r")) type ="checked";
		else if(ceck.equals("s")) type ="selected";
		
		String returnData = txt.equals(data) ? type : "";
		
		
        return returnData;
	}
}
