package egovframework.example.sample.service.wssimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.wssservice.AsosService;
import egovframework.example.sample.wssservice.CmmnVO;
import egovframework.example.sample.wssservice.CrawlingService;
import egovframework.example.sample.wssservice.CrawlingVO;

@Service("asosService")
public class AsosServiceImpl implements AsosService {
	
	@Resource(name="asosMapper")
	private AsosMapper asosMapper;
	
	@Override
	public List<Map<String, Object>> tntAsosList(CmmnVO cmmnVO) {
		// TODO Auto-generated method stub
		return asosMapper.tntAsosList(cmmnVO);
	}
	
}
