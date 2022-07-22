package egovframework.example.sample.service;

import java.util.List;
import java.util.Map;


public interface AnswerService {
	
	//댓글 리스트
	List<AnswerVO> answerList(Map<String, Object> paramMap);
	
	//댓글 리스트 개수
	int answerTotCnt(Map<String, Object> paramMap);
	
	//댓글 등록
	int insertAnswer(AnswerVO vo);
	
	//댓글 삭제
	int deleteAnswer(AnswerVO vo);

	//답글 리스트
	List<AnswerVO> answerReplyList(Map<String, Object> paramMap);
		
	//답글 등록
	int insertReplyAnswer(AnswerVO vo);
}
