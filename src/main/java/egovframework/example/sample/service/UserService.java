package egovframework.example.sample.service;

import java.util.List;
import java.util.Map;


public interface UserService {
	
	//아이디 검증
	int idCeck(String id);
	
	//회원가입
	int regist(UserVO vo);
	
	//로그인
	UserVO login(UserVO vo);
	
	//유저정보
	UserVO userInfo(Map<String, Object> pramMap);
	
	//정보 업데이트
	int userUpdt(UserVO vo);
	
	//회원 리스트
	List<UserVO> userList(Map<String, Object> paramMap);
		
	//회원 리스트 개수
	int userTotCnt(Map<String, Object> paramMap);
	
	//유저 승인 미승인 처리
	int userSttus(UserVO vo);

	//유저 권한 변경
	int userLevel(UserVO vo);
	

	Map<String, Object> userMap(Map<String, Object> paramMap);
}
