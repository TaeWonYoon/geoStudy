package egovframework.example.sample.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.example.sample.service.FileService;
import egovframework.example.sample.service.FileVO;

@Service("fileService")
public class FileServiceImpl implements FileService {
	
	// TODO mybatis 사용
	@Resource(name="fileMapper")
	private FileMapper fileMapper;
	
	@Override
	public int insertFile(FileVO vo) {
		// TODO Auto-generated method stub
		return fileMapper.insertFile(vo);
	}
	
	@Override
	public FileVO selectFile(int filePk) {
		// TODO Auto-generated method stub
		return fileMapper.selectFile(filePk);
	}
	
	@Override
	public int deleteFile(int filePk) {
		// TODO Auto-generated method stub
		return fileMapper.deleteFile(filePk);
	}
}
