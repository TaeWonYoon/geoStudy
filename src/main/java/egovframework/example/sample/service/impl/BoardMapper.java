/*
 * Copyright 2011 MOPAS(Ministry of Public Administration and Security).
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


import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.sample.service.BoardVO;

@Mapper("boardMapper")
public interface BoardMapper {

	//게시판리스트
	public List<BoardVO> boardList(Map<String, Object> paramMap);
	
	//상세페이지
	public BoardVO selectBoard(BoardVO vo);
	
	//상세페이지개수
	public int boardTotCnt(Map<String, Object> paramMap);
	
	
	//등록
	public int inserBoard(BoardVO vo);
	
	//수정
	public int updateBoard(BoardVO vo);
	
	//삭제
	public int deleteBoard(BoardVO vo);
}
