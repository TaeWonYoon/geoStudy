package egovframework.example.sample.service.wssimpl;


import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.sample.wssservice.CmmnVO;
import egovframework.example.sample.wssservice.CrawlingVO;
import egovframework.example.sample.wssservice.MapVO;

@Mapper("mapMapper")
public interface MapMapper {

	//관측소 리스트
	List<Map<String, Object>> mapList(MapVO vo);
	
	//관측소 리스트
	List<Map<String, Object>> awsList(MapVO vo);
	
}
