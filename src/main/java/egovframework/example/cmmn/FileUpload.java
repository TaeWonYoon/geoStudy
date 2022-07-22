package egovframework.example.cmmn;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import egovframework.example.sample.service.FileVO;

public class FileUpload {

	private String originName;
	private int fileSize;
	private String fileUrl;

    public FileVO saveFile(HttpServletRequest req,MultipartFile upload,int boardPk,int userpk){
    	String mappingPath = JavaDate.getFileDate(); //파일 저장 경로
        String path = req.getServletContext().getRealPath(mappingPath); //리얼패스 경로 설정
        FileVO fvo = new FileVO();
		//톰캣 tmp 패스잡기		//String path = "C:/uploadImg/profile";
		//String path = request.getSession().getServletContext().getRealPath(url);
		// 파일 이름 변경
	    UUID uuid = UUID.randomUUID();
	    String fileName = upload.getOriginalFilename();

	    //...점 제거하기

        String[] status = fileName.split("\\.");

        originName = "";

        for(int i = 0; i < status.length; i++) { //파일명이 .이 있으면 .삭제
			 if(i == (status.length -1))  {
				 originName += "." + status[i];
			 } else {
				originName += status[i];
			 }
		}
        fvo.setFileMappingPath(mappingPath); //파일 호출 경로
		fvo.setFileUserPk(userpk); //유저 키값
		fvo.setBoardPk(boardPk);
		String ext = originName.substring(originName.lastIndexOf(".") + 1);
		fvo.setFileExt(ext); //파일 확장자

		String saveName = uuid + "_" + JavaDate.getRandom() + "." + ext;
        fvo.setFileNm(saveName); //파일 업로드 네임

		fvo.setFileSize((int)upload.getSize()); //파일 사이즈
        fvo.setFileRealNm(originName); // 파일 이름
        fvo.setFileUrlPath(path); // 파일 경로
        fvo.setFileSttus(1); // 파일 상태값
//		fileUrl = path+"/"+saveName;
	    // 저장할 File 객체를 생성(껍데기 파일)
		File file = new File(path);
	    File saveFile = new File(path,saveName); // 저장할 폴더 이름, 저장할 파일 이름
	    
		//디렉토리 생성
		if (!file.exists()) {
            file.mkdirs();
        }
	    try {
	        upload.transferTo(saveFile); // 업로드 파일에 saveFile이라는 껍데기 입힘
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }
	    return fvo;
	}


	public void deleteFile(String path,String fileName){

		File fileDeleted = new File(path+"/"+fileName);
		fileDeleted.delete();

	}

	public void deleteFileMod(String path){

		File fileDeleted = new File(path);
		fileDeleted.delete();

	}
}
