package egovframework.example.sample.service.wssimpl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.wssservice.MapService;
import egovframework.example.sample.wssservice.MapVO;

@Service("mapService")
public class MapServiceImpl implements MapService {
	
	@Resource(name="mapMapper")
	private MapMapper mapMapper;
	
	@Override
	public List<Map<String, Object>> mapList(MapVO vo) {
		// TODO Auto-generated method stub
		return mapMapper.mapList(vo);
	}

	@Override
	public List<Map<String, Object>> awsList(MapVO vo) {
		// TODO Auto-generated method stub
		return mapMapper.awsList(vo);
	}
}
