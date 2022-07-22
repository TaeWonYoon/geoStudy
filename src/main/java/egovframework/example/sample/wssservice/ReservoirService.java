package egovframework.example.sample.wssservice;

import java.util.List;
import java.util.Map;

public interface ReservoirService {

	//저수지 물량 리스트 개수
	List<Map<String, Object>> tntReservoirList(CmmnVO vo);
}
