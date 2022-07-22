package egovframework.example.sample.service.wssimpl;


import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.sample.wssservice.CmmnVO;

@Mapper("awsMapper")
public interface AwsMapper {

	//집계 리스트
	List<Map<String, Object>> tntAwsList(CmmnVO cmmnVO);
	
}
