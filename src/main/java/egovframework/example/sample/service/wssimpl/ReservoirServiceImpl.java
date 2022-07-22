package egovframework.example.sample.service.wssimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.wssservice.AsosService;
import egovframework.example.sample.wssservice.AwsService;
import egovframework.example.sample.wssservice.CmmnVO;
import egovframework.example.sample.wssservice.CrawlingService;
import egovframework.example.sample.wssservice.CrawlingVO;
import egovframework.example.sample.wssservice.ReservoirService;

@Service("reservoirService")
public class ReservoirServiceImpl implements ReservoirService {
	
	@Resource(name="reservoirMapper")
	private ReservoirMapper reservoirMapper;
	
	
	@Override
	public List<Map<String, Object>> tntReservoirList(CmmnVO vo) {
		// TODO Auto-generated method stub
		return reservoirMapper.tntReservoirList(vo);
	}
	
	
}
