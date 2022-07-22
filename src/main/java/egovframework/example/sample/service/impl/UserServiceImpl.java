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
import egovframework.example.sample.service.UserService;
import egovframework.example.sample.service.UserVO;

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
@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {
	//public class BoardServiceImpl extends EgovAbstractServiceImpl implements BoardService {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);

	// TODO mybatis 사용
	@Resource(name="userMapper")
	private UserMapper userMapper;

	@Override
	public int idCeck(String id) {
		return userMapper.idCeck(id);
	}
	
	@Override
	public int regist(UserVO vo) {
		return userMapper.regist(vo);
	}
	
	@Override
	public UserVO login(UserVO vo) {
		return userMapper.login(vo);
	}
	
	@Override
	public UserVO userInfo(Map<String, Object> pramMap) {
		return userMapper.userInfo(pramMap);
	}
	
	@Override
	public int userUpdt(UserVO vo) {
		return userMapper.userUpdt(vo);
	}
	
	@Override
	public List<UserVO> userList(Map<String, Object> paramMap) {
		return userMapper.userList(paramMap);
	}
	
	@Override
	public int userTotCnt(Map<String, Object> paramMap) {
		return userMapper.userTotCnt(paramMap);
	}
	
	@Override
	public int userSttus(UserVO vo) {
		// TODO Auto-generated method stub
		return userMapper.userSttus(vo);
	}
	
	@Override
	public int userLevel(UserVO vo) {
		// TODO Auto-generated method stub
		return userMapper.userLevel(vo);
	}
	
	@Override
	public Map<String, Object> userMap(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return userMapper.userMap(paramMap);
	}
}
