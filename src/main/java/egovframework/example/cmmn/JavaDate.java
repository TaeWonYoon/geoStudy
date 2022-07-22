package egovframework.example.cmmn;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class JavaDate {


        public static String getDate() {
        	SimpleDateFormat dateFormat;
    		dateFormat = new SimpleDateFormat("yyyy-MM-dd");//dd/MM/yyyy
            Calendar calendar = Calendar.getInstance();
            String dateTotal = dateFormat.format(calendar.getTime());
            return dateTotal;
        }
        
        public static String getRandom() {
            int num = (int)((Math.random()*10000)%999)+100;
            String random = Integer.toString(num);
            return random;
        }
        
        public static String getFileDate() {
        	SimpleDateFormat dateFormat;
    		dateFormat = new SimpleDateFormat("yyyyMMdd");//dd/MM/yyyy
            Calendar calendar = Calendar.getInstance();
            String dateTotal = dateFormat.format(calendar.getTime());
            return dateTotal;
        }
        
        public static void main(String args[]) {
        	//System.out.println(getDate());
        }
}
