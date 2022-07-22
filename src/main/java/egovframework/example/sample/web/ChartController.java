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
import egovframework.example.sample.wssservice.ReservoirService;


@RequestMapping(value = "/map")
@Controller
public class ChartController {
	
	@Resource(name="crawlingService")
	private CrawlingService crawlingService;
	
	@Resource(name="asosService")
	private AsosService asosService;
	
	@Resource(name="awsService")
	private AwsService awsService;
	
	@Resource(name="reservoirService")
	private ReservoirService reservoirService;
	
	
	@RequestMapping(value = "/totalList.do")
	public String totalList(ModelMap model) throws Exception {
		return "/map/totalList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/totalDataList.do")
	public Map<String, Object> totalListDo(ModelMap model, CrawlingVO cvo, @Param("type") String type, CmmnVO cmmnVO) throws Exception {
		List<Map<String, Object>>  list = null;
		String result = "SUCCESS";
		String resultMsg = "데이터가 있습니다.";
		
		if(type.equals("c")) {
			list = crawlingService.tntCrawlingList(cmmnVO);
		} else if(type.equals("a")) {
			list = asosService.tntAsosList(cmmnVO);
		} else if(type.equals("aw")) {
			list = awsService.tntAwsList(cmmnVO);
		} else if(type.equals("r")) {
			list = reservoirService.tntReservoirList(cmmnVO);
		}
		
		if(list.isEmpty()) {
			result = "FAIL";
			resultMsg = "데이터가 없습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", list);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	
	@RequestMapping(value = "/crawling/crawlingList.do")
	public String crawlingList(ModelMap model) throws Exception {
		return "/map/crawling/crawlingList";
	}
	
	@RequestMapping(value = "/crawling/crawling.do")
	public String crawling(ModelMap model) throws Exception {
		return "/map/crawling/crawling";
	}
	
	@RequestMapping(value = "/detailChart.do")
	public String detailChart(@Param("ty") String ty
							, @Param("chartDate") String chartDate
							, @Param("nowYaer") String nowYear
							, ModelMap model) throws Exception {
		
		model.addAttribute("ty", ty);
		model.addAttribute("chartDate", chartDate);
		model.addAttribute("nowYear", nowYear);
		return "/map/detailChart";
	}
	
	@ResponseBody
	@RequestMapping(value = "/crawling/crawlingTy.do")
	public Map<String, Object> crawlingTy(CrawlingVO cvo) {
		List<Map<String, Object>>  crawlingList = crawlingService.crawling(cvo);
		String result = "SUCCESS";
		String resultMsg = "데이터가 있습니다.";
		if(crawlingList.isEmpty()) {
			result = "FAIL";
			resultMsg = "데이터가 없습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("crawlingList", crawlingList);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/crawling/crawlingListTy.do")
	public Map<String, Object> crawlingListTy(CrawlingVO cvo) {
		List<Map<String, Object>>  crawlingList = crawlingService.crawlingList(cvo);
		String result = "SUCCESS";
		String resultMsg = "데이터가 있습니다.";
		if(crawlingList.isEmpty()) {
			result = "FAIL";
			resultMsg = "데이터가 없습니다.";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("crawlingList", crawlingList);
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	
}
