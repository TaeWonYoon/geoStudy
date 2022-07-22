package egovframework.example.sample.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.service.AuthorService;
import egovframework.example.sample.service.AuthorVO;

@Service("authorService")
public class AuthorServiceImpl implements AuthorService{

	// TODO mybatis 사용
	@Resource(name="authorMapper")
	private AuthorMapper authorMapper;
	
	
	
	@Override
	public int authorCeck(AuthorVO vo) {
		return authorMapper.authorCeck(vo);
	}
}
