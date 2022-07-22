package egovframework.example.cmmn;

import static org.junit.Assert.fail;
import java.sql.Connection;

import javax.annotation.Resource;
import javax.sql.DataSource;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.ibatis.common.logging.Log;


@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/resources/egovframework/spring/context-datasource.xml",
						"file:src/main/resources/egovframework/spring/context-mapper.xml"})
public class DataSourceTests {
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
//    @Test
//    public void testMyBatis() {
//
//        try (SqlSession session = sqlSessionFactory.openSession();
//             Connection con = session.getConnection();
//        ){	System.out.println(session);
//            System.out.println(con);
//        } catch (Exception e) {
//            fail(e.getMessage());
//        }
//    }
    

  @Test
  public void testConnection() {

    try (Connection con = dataSource.getConnection()){

    	System.out.println(con);
    }catch(Exception e) {
      fail(e.getMessage());
    }
  }
}
