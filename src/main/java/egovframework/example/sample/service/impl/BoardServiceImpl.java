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
package egovframework.example.sample.service.impl;

import java.util.List;
import java.util.Map;



import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.sample.service.BoardService;
import egovframework.example.sample.service.BoardVO;
import egovframework.example.sample.service.FileVO;

/**
 * @Class Name : EgovSampleServiceImpl.java
 * @Description : Sample Business Implement Class
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
@Service("boardService")
public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {
	//public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {

	private static final Logger LOGGER = LoggerFactory.getLogger(BoardServiceImpl.class);

	// TODO mybatis 사용
	@Resource(name="boardMapper")
	private BoardMapper boardMapper;
	
	@Resource(name="fileMapper")
	private FileMapper fileMapper;

	@Override
	public List<BoardVO> boardList(Map<String, Object> paramMap) {
		return boardMapper.boardList(paramMap);
	}
	
	@Override
	public int boardTotCnt(Map<String, Object> paramMap) {
		return boardMapper.boardTotCnt(paramMap);
	}
	
	@Override
	public BoardVO selectBoard(BoardVO vo) {
		FileVO file = fileMapper.selectFile(vo.getPk());
		BoardVO boardVO = boardMapper.selectBoard(vo);
		boardVO.setFileVO(file);
		
		return boardVO;
	}
	
	@Override
	public int inserBoard(BoardVO vo) {
		
		return boardMapper.inserBoard(vo);
	}
	
	@Override
	public int updateBoard(BoardVO vo) {
		return boardMapper.updateBoard(vo);
	}
	
	@Override
	public int deleteBoard(BoardVO vo) {
		return boardMapper.deleteBoard(vo);
	}
}
