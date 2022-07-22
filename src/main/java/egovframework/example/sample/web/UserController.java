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

import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import egovframework.example.cmmn.AuthCeck;
import egovframework.example.cmmn.Md5;
import egovframework.example.cmmn.Page;
import egovframework.example.cmmn.SHA256;
import egovframework.example.sample.service.AuthorService;
import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;
import egovframework.example.sample.service.impl.UserMapper;

import org.apache.commons.collections.map.HashedMap;
import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

@RequestMapping(value = "/user")
@Controller
public class UserController {
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="propertise")
	private Properties propertise;
	
	@Resource(name = "authorService")
	protected AuthorService authorService;

	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public String login() throws Exception {
		return "/user/login";
	}
	
	@ResponseBody
	@RequestMapping(value = "/iogin.do", method = RequestMethod.POST)
	public Map<String, Object> loginDo(UserVO userVO, HttpSession session) throws Exception {
		
		String result = "FAIL";
		String resultMsg = "승인 되지 않은 아이디 또는 없는 계정입니다.";
		String resultUrl = "";
		
		Boolean returnData = true;
		if(AuthCeck.strCeck(userVO.getId(), 30) == false) returnData = false; //length 체크
		if(AuthCeck.strCeck(userVO.getPassword(), 30) == false) returnData = false; //length 체크
		UserVO login = null;
		if(returnData == true) {
			login = userService.login(userVO);
			if(login != null) {
				SHA256 sha256 = new SHA256();
				String userPassword = sha256.encrypt(userVO.getPassword());
				if(login.getPassword().equals(userPassword)) { //로그인 성공시
					result = "SUCCESS";
					resultMsg = "로그인이 완료되었습니다.";
					resultUrl = "/";
					session.setAttribute("userVO", login);
				} else { //로그인 실패시
					resultMsg = "아이디 혹은 비밀번호가 틀립니다.";
				}
			} 
		} else { //데이터 크기가 오바될시
			resultMsg = "관리자에게 문의해주세요";
		}

		Map<String, Object> reulstMap = new HashMap<String, Object>();
		reulstMap.put("result", result);
		reulstMap.put("resultMsg", resultMsg);
		reulstMap.put("resultUrl", resultUrl);
		reulstMap.put("users", login);
		return reulstMap;
	}
	
		

	@RequestMapping(value = "/regist.do", method = RequestMethod.GET)
	public String regist(HttpServletRequest req) throws Exception {
		//System.out.println(propertise.getProperty("Globals.id"));
		//System.out.println(propertise.getProperty("Globals.DbType"));
		return "/user/regist";
	}


	@ResponseBody
	@RequestMapping(value = "/regist.do", method = RequestMethod.POST)
	public Map<String, Object> registDo(UserVO userVO) throws Exception {
		
		Boolean returnData = true;
		if(AuthCeck.strCeck(userVO.getNm(), 20) == false) returnData = false; //length 체크
		if(AuthCeck.strCeck(userVO.getId(), 30) == false) returnData = false; //length 체크
		if(AuthCeck.strCeck(userVO.getPassword(), 200) == false) returnData = false; //length 체크
		
		int login = 0;
		
		
		if(returnData == true) {
			SHA256 sha256 = new SHA256();
			String password = sha256.encrypt(userVO.getPassword());
			userVO.setPassword(password);
			userVO.setSttus(0);
			login = userService.regist(userVO);
		} 
		
		String result = login == 1 ? "SUCCESS" : "FAIL";
		String resultMsg = login == 1 ? "회원가입 완료되었습니다." : "회원가입 실패 관리자에게 문의해주세요.";
		String resultUrl = login == 1 ? "/user/login.do" : "";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("resultUrl", resultUrl);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/mngrRegist.do", method = RequestMethod.GET)
	public String mngrRegist() throws Exception {
		
		return "/user/mngrRegist";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mngrRegist.do", method = RequestMethod.POST)
	public Map<String, Object> mngrRegistDo(UserVO userVO) throws Exception {
		Boolean returnData = true;
		if(AuthCeck.strCeck(userVO.getNm(), 20) == false) returnData = false; //length 체크
		if(AuthCeck.strCeck(userVO.getId(), 30) == false) returnData = false; //length 체크
		if(AuthCeck.strCeck(userVO.getPassword(), 200) == false) returnData = false; //length 체크
		int login = 0;
		
		
		if(returnData == true) {
			SHA256 sha256 = new SHA256();
			String password = sha256.encrypt(userVO.getPassword());
			userVO.setPassword(password);
			userVO.setLevel(9); //사용자레벨
			userVO.setSttus(1);
			login = userService.regist(userVO);
		} 
		
		String result = login == 1 ? "SUCCESS" : "FAIL";
		String resultMsg = login == 1 ? "회원가입 완료되었습니다." : "회원가입 실패 관리자에게 문의해주세요.";
		String resultUrl = login == 1 ? "/user/login.do" : "";
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("resultUrl", resultUrl);
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/idCeck.do")
	public Map<String, Object> idCeck(@RequestParam Map<String,Object> paramMap) {
		
		String result = "FAIL";
		String resultMsg = "관리자에게 문의해주세요";
		
		Boolean returnData = true;
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if(AuthCeck.strCeck((String)paramMap.get("id"), 30) == false) returnData = false; //length 체크
		
		if(returnData = true) {
			int cnt = userService.idCeck((String)paramMap.get("id"));
			
			result = cnt != 1 ? "SUCCESS" : result;
			resultMsg = cnt == 1 ? "중복된 아이디입니다." : "사용가능한 아이디입니다.";
		}
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/user/login.do";
	}
	
	@RequestMapping(value = "/userUpdt.do", method = RequestMethod.GET)
	public String userUpdt(HttpSession session, ModelMap model) {
		UserVO user = (UserVO)session.getAttribute("userVO"); //세션 정보
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("pk", user.getPk());
		UserVO userVO = userService.userInfo(paramMap);
		
		
		model.addAttribute("user", userVO);
		
		return "/user/userUpdt";
	}
	
	@ResponseBody
	@RequestMapping(value = "/userUpdt.do", method = RequestMethod.POST)
	public Map<String, Object>  userUpdtDo(UserVO userVO, HttpSession session) throws NoSuchAlgorithmException {
		UserVO user = (UserVO)session.getAttribute("userVO"); //세션 정보
		String result = "FAIL";
		String resultMsg = "관리자에게 문의해주세요.";
		String resultUrl = "/user/logout.do";
		
		if(user != null) {
		
			userVO.setPk(user.getPk());
			
			Boolean returnData = true;
			if(AuthCeck.strCeck(userVO.getNm(), 30) == false) returnData = false; //length 체크
			
			if(returnData) {
				
				SHA256 sha256 = new SHA256(); //암호화
				if((!userVO.getPassword().equals("")) && (userVO.getPassword() != null)) {  //패스워드 입력시에만 처리
					String password = sha256.encrypt(userVO.getPassword());
					userVO.setPassword(password);
				}
				
				int ceck = userService.userUpdt(userVO);
				
				if(ceck == 1) { //쿼리 성공시 
					result = "SUCCESS";
					resultMsg = "회원정보가 변경되었습니다.";
				}
			}
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		resultMap.put("resultUrl", resultUrl);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/userList.do")
	public String userList(HttpSession session
							, @RequestParam(defaultValue = "1") int num
							, @Param("searchType") String searchType
							, @Param("keyword") String keyword
							, @Param("startDate") String startDate
							, @Param("finishDate") String finishDate
							, @Param("levelType") Integer levelType
							, ModelMap model) throws Exception {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		//페이지
		Page page = new Page();

		paramMap.put("searchType", searchType);
		paramMap.put("keyword", keyword);
		paramMap.put("startDate", startDate);
		paramMap.put("finishDate", finishDate);
		paramMap.put("levelType", levelType);
		int totCnt = userService.userTotCnt(paramMap);
        page.setNum(num);
        page.setCount(totCnt);
        page.dataCalc();
        paramMap.put("postNum",page.getPostNum());
		paramMap.put("displayPost",page.getDisplayPost());
		List<UserVO> list = userService.userList(paramMap);
		
		model.addAttribute("page", page);
		model.addAttribute("list", list);
		model.addAttribute("nowNum", num);
		model.addAttribute("searchType", searchType);
		model.addAttribute("keyword", keyword);
		model.addAttribute("startDate", startDate);
		model.addAttribute("finishDate", finishDate);
		model.addAttribute("levelType", levelType);
		model.addAttribute("totCnt", totCnt);
		
		return "/user/userList";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/userSttus.do", method = RequestMethod.POST)
	public Map<String, Object> userSttus(UserVO userVO
							,HttpSession session) {
		
		String result = "SUCCESS";
		String resultMsg = "정보가 변경되었습니다.";
		UserVO user = (UserVO)session.getAttribute("userVO"); //세션 정보
		
		if(user.getPk() == userVO.getPk()) {
			resultMsg = "회원정보가 삭제되었습니다."; //본인이 삭제인지 체크
			userVO.setSttus(9);
		}
		
		if(user != null) userVO.setConfmPk(user.getPk()); //승인,삭제 처리해주는 관리자
		
		
		int query = userService.userSttus(userVO);
		if(query != 1) {
			result = "FAIL";
			resultMsg = "정보 변경 실패";
		}
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/userLevel.do", method = RequestMethod.POST)
	public Map<String, Object> userLevel(UserVO userVO
							,HttpSession session) {
		
		String result = "SUCCESS";
		String resultMsg = "정보가 변경되었습니다.";
		UserVO user = (UserVO)session.getAttribute("userVO"); //세션 정보
		
		if(user != null) userVO.setConfmPk(user.getPk()); //승인,삭제 처리해주는 관리자
		
		
		int query = userService.userLevel(userVO);
		
		if(query != 1) {
			result = "FAIL";
			resultMsg = "정보 변경 실패";
		}
		
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/userMap.do", method = RequestMethod.POST)
	public void userMap (@RequestParam Map<String, Object> paramMap) {
		
		Map<String, Object> inputMap = new HashMap<String, Object>(); //직접 넣는데이터
		inputMap.put("pk", 11);
		Map<String, Object> data2 = userService.userMap(inputMap);
		
		Map<String, Object> data = userService.userMap(paramMap);
		
	}
	
}
