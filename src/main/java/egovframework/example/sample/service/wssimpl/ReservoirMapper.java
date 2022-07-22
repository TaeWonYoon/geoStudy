package egovframework.example.sample.service.wssimpl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.sample.wssservice.CmmnVO;

@Mapper("reservoirMapper")
public interface ReservoirMapper {

	//저수지 물량 리스트 개수
	List<Map<String, Object>> tntReservoirList(CmmnVO vo);
}
