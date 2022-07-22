package egovframework.example.sample.service.wssimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.wssservice.CmmnVO;
import egovframework.example.sample.wssservice.CrawlingService;
import egovframework.example.sample.wssservice.CrawlingVO;

@Service("crawlingService")
public class CrawlingServiceImpl implements CrawlingService {
	
	@Resource(name="crawlingMapper")
	private CrawlingMapper crawlingMapper;
	
	@Override
	public List<Map<String, Object>> crawlingList(CrawlingVO vo) {
		// TODO Auto-generated method stub
		return crawlingMapper.crawlingList(vo);
	}
	
	@Override
	public List<Map<String, Object>> crawling(CrawlingVO vo) {
		// TODO Auto-generated method stub
		return crawlingMapper.crawling(vo);
	}
	
	
	@Override
	public List<Map<String, Object>> tntCrawlingList(CmmnVO vo) {
		// TODO Auto-generated method stub
		return crawlingMapper.tntCrawlingList(vo);
	}
	
}
