package egovframework.example.sample.service.impl;

import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.sample.service.AuthorVO;

@Mapper("authorMapper")
public interface AuthorMapper {
	
	//페이지 인증
	public int authorCeck(AuthorVO vo);
}
