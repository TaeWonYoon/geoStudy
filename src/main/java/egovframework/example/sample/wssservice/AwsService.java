package egovframework.example.sample.wssservice;

import java.util.List;
import java.util.Map;

public interface AwsService {

	//집계 리스트
	List<Map<String, Object>> tntAwsList(CmmnVO cmmnVO);
	
}
