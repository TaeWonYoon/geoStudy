package egovframework.example.cmmn;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.impl.BoardMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/resources/egovframework/spring/context-datasource.xml",
						"file:src/main/resources/egovframework/spring/context-mapper.xml"})
public class DAOTest {

	// TODO mybatis 사용
	/*
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
	*/
	
	
	@Test
	public void a() throws Exception {
		//List<Map<String, Object>> data = boardService.list();
		//List<Map<String, Object>> data = boardMapper.boardList();
		//System.out.println(data);
		//System.out.println(data.get(0));
	}
}

