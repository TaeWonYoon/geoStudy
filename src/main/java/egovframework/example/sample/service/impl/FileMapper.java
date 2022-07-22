package egovframework.example.sample.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.sample.service.FileVO;

@Mapper("fileMapper")
public interface FileMapper {

	//파일등록
	public int insertFile(FileVO vo);
	
	//단일 파일
	public FileVO selectFile(int filePk);

	//파일 삭제
	public int deleteFile(int filePk);
	
}
