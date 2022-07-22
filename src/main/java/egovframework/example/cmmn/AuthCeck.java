package egovframework.example.cmmn;


public class AuthCeck {

	public static Boolean strCeck(String txt, int length) { //문자열 길이 체크
		
		Boolean returnData = false;
		
		if(length >= txt.length()) {
			returnData = true;
		} else {
			returnData = false;
		}
		
		return returnData;
	}
	
}
