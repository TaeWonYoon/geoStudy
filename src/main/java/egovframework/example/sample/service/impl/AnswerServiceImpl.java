package egovframework.example.sample.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.service.AnswerService;
import egovframework.example.sample.service.AnswerVO;

@Service("answerService")
public class AnswerServiceImpl implements AnswerService {
	
	@Resource(name="answerMapper")
	private AnswerMapper answerMapper;
	
	@Override
	public List<AnswerVO> answerList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return answerMapper.answerList(paramMap);
	}
	
	@Override
	public int answerTotCnt(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return answerMapper.answerTotCnt(paramMap);
	}
	
	@Override
	public int insertAnswer(AnswerVO vo) {
		return answerMapper.insertAnswer(vo);
	}
	
	@Override
	public int deleteAnswer(AnswerVO vo) {
		return answerMapper.deleteAnswer(vo);
	}
	
	@Override
	public List<AnswerVO> answerReplyList(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return answerMapper.answerReplyList(paramMap);
	}
	
	@Override
	public int insertReplyAnswer(AnswerVO vo) {
		// TODO Auto-generated method stub
		return answerMapper.insertReplyAnswer(vo);
	}
}
