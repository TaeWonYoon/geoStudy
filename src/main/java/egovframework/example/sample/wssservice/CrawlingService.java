package egovframework.example.sample.wssservice;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface CrawlingService {

	public List<Map<String, Object>> crawlingList(CrawlingVO vo);
	
	//크롤링 전체 리스트
	public List<Map<String, Object>> crawling(CrawlingVO vo);
	
	//집계페이지 전체 리스트
	List<Map<String, Object>> tntCrawlingList(CmmnVO vo);
}
