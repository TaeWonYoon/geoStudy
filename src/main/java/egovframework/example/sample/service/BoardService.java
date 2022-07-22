package egovframework.example.sample.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface BoardService {

	//게시판리스트
	public List<BoardVO> boardList(Map<String, Object> paramMap);
	
	//상세페이지개수
	public int boardTotCnt(Map<String, Object> paramMap);
	
	//상세페이지
	public BoardVO selectBoard(BoardVO vo);
	
	//등록
	public int inserBoard(BoardVO vo);
	
	//수정
	public int updateBoard(BoardVO vo);
	
	//삭제
	public int deleteBoard(BoardVO vo);
}
