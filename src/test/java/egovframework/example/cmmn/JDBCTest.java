package egovframework.example.cmmn;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.junit.Test;

public class JDBCTest {

	
	@Test
	public void a() {
		        try {
					Class.forName("org.postgresql.Driver");
				} catch (ClassNotFoundException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}  
		        
		        String     connurl  = "jdbc:postgresql://192.168.123.132:5432/watersupplysafety";
		        String     user     = "geopeople";
		        String     password = "geopeople";
		 
		        try (Connection connection = DriverManager.getConnection(connurl, user, password);) {
		              Statement stmt = connection.createStatement();
		              ResultSet rs = stmt.executeQuery("SELECT VERSION() AS version");
		 
		              while (rs.next()) {
		                  String version = rs.getString("version");
		                  
		                  System.out.println(version);                  
		              }           
		            rs.close();
		            stmt.close();
		            connection.close();
		        }
		        catch (SQLException e) {
		            e.printStackTrace();
		        }
	}
}
