package egovframework.example.sample.service.wssimpl;


import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.sample.wssservice.CmmnVO;
import egovframework.example.sample.wssservice.CrawlingVO;

@Mapper("crawlingMapper")
public interface CrawlingMapper {

	//크롤링 그룹별 리스트
	List<Map<String, Object>> crawlingList(CrawlingVO vo);
	
	//크롤링 전체 리스트
	List<Map<String, Object>> crawling(CrawlingVO vo);
	
	
	//집계페이지 전체 리스트
	List<Map<String, Object>> tntCrawlingList(CmmnVO vo);
}
