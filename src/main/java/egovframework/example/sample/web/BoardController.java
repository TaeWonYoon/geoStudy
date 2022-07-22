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

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import egovframework.example.cmmn.AuthCeck;
import egovframework.example.cmmn.FileUpload;
import egovframework.example.cmmn.JavaDate;
import egovframework.example.cmmn.Page;
import egovframework.example.cmmn.Paging;
import egovframework.example.sample.service.AnswerService;
import egovframework.example.sample.service.AnswerVO;
import egovframework.example.sample.service.AuthorService;
import egovframework.example.sample.service.AuthorVO;
import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.FileService;
import egovframework.example.sample.service.FileVO;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.example.sample.service.UserVO;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springmodules.validation.commons.DefaultBeanValidator;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */
@RequestMapping(value = "/board")
@Controller
public class BoardController {

	
	@Resource(name = "boardService")
	protected BoardService boardService;
	
	@Resource(name = "fileService")
	protected FileService fileService;
	
	@Resource(name = "authorService")
	protected AuthorService authorService;
	
	@Resource(name = "answerService")
	protected AnswerService answerService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	
	@RequestMapping(value = "/boardList.do")
	public String boardList(@ModelAttribute("searchVO") SampleDefaultVO searchVO
							, @ModelAttribute("boardVO") BoardVO boardVO
							, @RequestParam(defaultValue = "1") int num
							, HttpSession session
							, HttpServletRequest req
							, ModelMap model) throws Exception {
		
			num = searchVO.getRedirectNum() > 1 ? searchVO.getRedirectNum() : num;
			
			Map<String, Object> paramMap = new HashMap<String, Object>(); //sql에 넣을 맵생성
			paramMap.put("searchType", searchVO.getSearchType()); //검색타입
			paramMap.put("searchKeyword", searchVO.getSearchKeyword()); //검색 조권
			//페이지
			Page page = new Page();
			
	        page.setNum(num);
	        paramMap.put("ty", "nomal"); //게시판 구분
	        
			int totCnt = boardService.boardTotCnt(paramMap);
			
	        page.setCount(totCnt);
	        page.dataCalc();
	        paramMap.put("postNum",page.getPostNum());
			paramMap.put("displayPost",page.getDisplayPost());
			
	        List<BoardVO> resultMap = boardService.boardList(paramMap);
	        
			model.addAttribute("boardList", resultMap);
			model.addAttribute("page", page);
			model.addAttribute("nowNum", num);
			model.addAttribute("totCnt", totCnt);
			model.addAttribute("searchType", searchVO.getSearchType());
			model.addAttribute("searchKeyword", searchVO.getSearchKeyword());
			
		return "/board/boardList";
	}
	
	@RequestMapping(value = "/boardDetail.do")
	public String boardDetail(@ModelAttribute("boardVO") BoardVO boardVO
								, HttpServletRequest req
								, HttpSession session
								, @ModelAttribute(value="searchVO") SampleDefaultVO vo
								, ModelMap model) throws Exception {
			
			String registerFlag = "create";
			BoardVO resultMap = null;
			if(boardVO.getPk() > 0) { //key 값이 있을때 상세페이지
				registerFlag = "modify";
				resultMap = boardService.selectBoard(boardVO);
			}
			model.addAttribute("pk", boardVO.getPk());
			model.addAttribute("nowDate", JavaDate.getDate());
			model.addAttribute("resultMap", resultMap);
			model.addAttribute("registerFlag", registerFlag);
			model.addAttribute("searchVO", vo);
			
		return "/board/boardDetail";
	}
	
	
	@RequestMapping(value = "/boardRegist.do")
	public String boardResit(@ModelAttribute("boardVO") BoardVO boardVO
								, @ModelAttribute(value="searchVO") SampleDefaultVO vo
								, MultipartFile files
								, @Param("act") String act
								, RedirectAttributes redirect
								, ModelMap model
								, HttpServletRequest req
								, HttpSession session) throws Exception {
		
		/*
		FileUpload fileUpload = new FileUpload();
		FileVO fvo = fileUpload.saveFile(req, files, 0, 0);
		System.out.println(fvo.toString());
		
		return "/board/boardRegist.do";
		*/
			UserVO userVO = (UserVO)session.getAttribute("userVO"); //세션 정보
			Boolean returnData = true;
			
			if(AuthCeck.strCeck(boardVO.getSj(), 50) == false) returnData = false; //length 체크
			if(AuthCeck.strCeck(boardVO.getCn(), 100) == false) returnData = false; //length 체크
			
			if(returnData == true) {
				boardVO.setUserPk(userVO.getPk());
				if(act.equals("create")) {
					boardVO.setTy("nomal");
					int result = boardService.inserBoard(boardVO);
					if(result == 1) {
						if(!files.isEmpty()) { //파일 있을시 업로드처리
							FileUpload fileUpload = new FileUpload();
							FileVO fileVO = fileUpload.saveFile(req, files, boardVO.getPk(), userVO.getPk());
							fileService.insertFile(fileVO);
						}
					}
				} else if(act.equals("modify")) {
					redirect.addFlashAttribute("searchVO", vo);
					int result = boardService.updateBoard(boardVO);
					if(result == 1) {
						if(!files.isEmpty()) { //파일 있을시 업로드처리
							FileUpload fileUpload = new FileUpload();
							FileVO fileVO = fileUpload.saveFile(req, files, boardVO.getPk(), userVO.getPk());
							fileService.insertFile(fileVO);
						}
					}
				} else if(act.equals("delete")){
					boardService.deleteBoard(boardVO);
				}
			} else {
				return "redirect:/msg/alert.do";
			}
			
		return "redirect:/board/boardList.do"; 
	}
	
	@ResponseBody
	@RequestMapping(value = "/fileDelete.do")
	public Map<String, Object> fileDelete(FileVO fileVO
											, HttpSession session) {
		UserVO userVO = (UserVO)session.getAttribute("userVO"); //세션 정보
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String result = "FAIL";
		String resultMsg = "삭제 실패 관리자에게 문의해주세요";
		
		if(userVO.getLevel() == 9) {
			int file = fileService.deleteFile(fileVO.getFilePk());
			if(file == 1) {
				FileUpload fileUpload = new FileUpload();
				fileUpload.deleteFile(fileVO.getFileUrlPath(), fileVO.getFileNm());
				result = "SUCCESS";
				resultMsg = "파일이 삭제되었습니다.";
			}
		}
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		

		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/fileDownload.do")
	public void fileDownload(FileVO fileVO
							, HttpServletResponse response
							, HttpServletRequest request) {
        try {
        	FileVO fileInfo = fileService.selectFile(fileVO.getBoardPk());
        	String uri = fileInfo.getFileMappingPath() + "/" + fileInfo.getFileNm();
        	String path = request.getServletContext().getRealPath(uri);
        	File file = new File(path);
        	response.setHeader("Content-Disposition", "attachment;filename=" + fileInfo.getFileRealNm()); // 다운로드 되거나 로컬에 저장되는 용도로 쓰이는지를 알려주는 헤더

        	@SuppressWarnings("resource")
			FileInputStream fileInputStream = new FileInputStream(path); // 파일 읽어오기
        	OutputStream out = response.getOutputStream();

        	int read = 0;
                byte[] buffer = new byte[1024];
                while ((read = fileInputStream.read(buffer)) != -1) { // 1024바이트씩 계속 읽으면서 outputStream에 저장, -1이 나오면 더이상 읽을 파일이 없음
                    out.write(buffer, 0, read);
                }
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
		
	}

	@ResponseBody
	@RequestMapping(value = "/answerList.do")
	public Map<String, Object> anserList(@RequestParam Map<String, Object> paramMap
										, @RequestParam(defaultValue = "1") int num) {
		
		
		int boardPk = Integer.parseInt((String)paramMap.get("boardPk"));
		
		paramMap.put("boardPk", boardPk);
		
		Paging page = new Paging();
        page.setNum(num);
        int totCnt = answerService.answerTotCnt(paramMap);
        page.setCount(totCnt);
        page.setPostNum(5);
        page.setPageNumCnt(5);
        page.dataCalc();
        
        paramMap.put("postNum",page.getPostNum());
		paramMap.put("displayPost",page.getDisplayPost());
		
		List<AnswerVO> answerList = answerService.answerList(paramMap);
		
		
		String result = "SUCCESS";
		
		if(answerList.isEmpty()) {
			result = "FAIL";
		}
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("answerList", answerList);
		resultMap.put("result", result);
		resultMap.put("page", page);
		resultMap.put("num", num);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/answerRegist.do")
	public Map<String, Object> answerRegist(AnswerVO answerVO
											, HttpSession session) {
		
		String result = "FAIL";
		String resultMsg = "댓글 등록 실패 관리자에게 문의해주세요";
		UserVO userVO = (UserVO)session.getAttribute("userVO"); //세션 정보
		
		if(userVO != null) {
			Boolean returnData = true; //글자 수 검증
			
			if(AuthCeck.strCeck(answerVO.getCn(), 30) == false) returnData = false; //length 체크
			
			if(returnData == true) {
				answerVO.setSttus(1);
				answerVO.setUserPk(userVO.getPk());
			
				int ceck = answerService.insertAnswer(answerVO);
				if(ceck == 1) {
					result = "SUCCESS";
					resultMsg = "댓글이 등록되었습니다.";
				}
			}
		}
		
		Map<String, Object> resultMap = new HashMap();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/answerReplyList.do")
	public Map<String, Object> answerReplyList(@RequestParam Map<String, Object> paramMap) {
		
		
		int depthPk = Integer.parseInt((String)paramMap.get("depthPk"));
		int depth = Integer.parseInt((String)paramMap.get("depth"));
		
		//paramMap.put("boardPk", boardPk);
		paramMap.put("depthPk", depthPk);
		paramMap.put("depth", depth);
		
        
		List<AnswerVO> answerReplyList = answerService.answerReplyList(paramMap);
		
		String result = "SUCCESS";
		
		if(answerReplyList.isEmpty()) {
			result = "FAIL";
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("answerReplyList", answerReplyList);
		resultMap.put("result", result);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/answerReplyRegist.do")
	public Map<String, Object> answerReplyRegist(AnswerVO answerVO
											, HttpSession session) {
		
		String result = "FAIL";
		String resultMsg = "댓글 등록 실패 관리자에게 문의해주세요";
		UserVO userVO = (UserVO)session.getAttribute("userVO"); //세션 정보
		
		if(userVO != null) {
			Boolean returnData = true; //글자 수 검증
			
			if(AuthCeck.strCeck(answerVO.getCn(), 30) == false) returnData = false; //length 체크
			
			if(returnData == true) {
				answerVO.setSttus(1);
				answerVO.setUserPk(userVO.getPk());
			
				int ceck = answerService.insertReplyAnswer(answerVO);
				if(ceck == 1) {
					result = "SUCCESS";
					resultMsg = "댓글이 등록되었습니다.";
				}
			}
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteAnswer.do")
	public Map<String, Object> deleteAnswer(AnswerVO answerVO
											, HttpSession session) {
		
		String result = "FAIL";
		String resultMsg = "댓글 삭제 실패 관리자에게 문의해주세요";
		
		UserVO userVO = (UserVO)session.getAttribute("userVO"); //세션 정보
		int userPk = 0;
		int query = 0;
		if(userVO != null) userPk = userVO.getPk();
		
		if(answerVO.getUserPk() == userPk) {
			query = answerService.deleteAnswer(answerVO);
			result = query == 1 ? "SUCCESS" : result;
			resultMsg = query == 1 ? "댓글 삭제 성공" : resultMsg;
		}
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("result", result);
		resultMap.put("resultMsg", resultMsg);
		
		return resultMap;
	}
}
