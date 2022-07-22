/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.sample.service.UserService;
import egovframework.example.sample.wssservice.AsosService;
import egovframework.example.sample.wssservice.AwsService;
import egovframework.example.sample.wssservice.CmmnVO;
import egovframework.example.sample.wssservice.CrawlingService;
import egovframework.example.sample.wssservice.CrawlingVO;
import egovframework.example.sample.wssservice.MapService;
import egovframework.example.sample.wssservice.MapVO;
import egovframework.example.sample.wssservice.ReservoirService;


@RequestMapping(value = "/map")
@Controller
public class MapController {
	
	
	@Resource(name="mapService")
	private MapService mapService;
	
	
	
	@RequestMapping(value = "/map.do")
	public String map() throws Exception {
		
		return "/map/map";
	}
	@RequestMapping(value = "/awsMap.do")
	public String awsMap() throws Exception {
		
		return "/map/awsMap";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mapList.do")
	public Map<String, Object> mapList(MapVO mapVo,@Param("ty") String ty) throws Exception {
		String result = "SUCCESS";
		String resultMsg = "데이터가 있습니다.";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(ty.equals("aws")) {
			resultMap.put("list", mapService.awsList(mapVo));
		} else if(ty.equals("asos")){
			resultMap.put("list", mapService.mapList(mapVo));
		}
		resultMap.put("result", result);
		resultMap.put("resultMsg",resultMsg);
		
		return resultMap;
	}
}
