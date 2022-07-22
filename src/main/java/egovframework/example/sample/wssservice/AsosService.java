package egovframework.example.sample.wssservice;

import java.util.List;
import java.util.Map;

public interface AsosService {

	//집계 리스트
	List<Map<String, Object>> tntAsosList(CmmnVO cmmnVO);
	
}
