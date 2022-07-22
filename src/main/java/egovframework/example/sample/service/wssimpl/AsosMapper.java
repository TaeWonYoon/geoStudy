package egovframework.example.sample.service.wssimpl;


import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.sample.wssservice.CmmnVO;
import egovframework.example.sample.wssservice.CrawlingVO;

@Mapper("asosMapper")
public interface AsosMapper {

	//집계 리스트
	List<Map<String, Object>> tntAsosList(CmmnVO cmmnVO);
	
}
