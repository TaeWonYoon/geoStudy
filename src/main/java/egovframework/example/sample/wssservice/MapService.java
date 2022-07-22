package egovframework.example.sample.wssservice;

import java.util.List;
import java.util.Map;

public interface MapService {

	//관측소 리스트
	List<Map<String, Object>> mapList(MapVO vo);
		
	//관측소 리스트
	List<Map<String, Object>> awsList(MapVO vo);
}
