package egovframework.example.sample.service;

public interface FileService {

	//파일등록
	public int insertFile(FileVO vo);
	
	//단일 파일
	public FileVO selectFile(int filePk);
	
	//파일 삭제
	public int deleteFile(int filePk);
	
}
