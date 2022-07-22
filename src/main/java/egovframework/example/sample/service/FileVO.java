package egovframework.example.sample.service;

import java.util.Date;

public class FileVO {

	private int filePk;
	private String fileRealNm;
	private String fileNm;
	private String fileUrlPath;
	private String fileMappingPath;
	private int fileSttus;
	private int fileUserPk;
	private Date fileRgsde;
	private String fileExt;
	private int fileSize;
	private int boardPk;
	
	public FileVO() {
	}

	public int getFilePk() {
		return filePk;
	}

	public void setFilePk(int filePk) {
		this.filePk = filePk;
	}

	public String getFileRealNm() {
		return fileRealNm;
	}

	public void setFileRealNm(String fileRealNm) {
		this.fileRealNm = fileRealNm;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public int getFileUserPk() {
		return fileUserPk;
	}

	public void setFileUserPk(int fileUserPk) {
		this.fileUserPk = fileUserPk;
	}

	public String getFileUrlPath() {
		return fileUrlPath;
	}

	public void setFileUrlPath(String fileUrlPath) {
		this.fileUrlPath = fileUrlPath;
	}

	public String getFileMappingPath() {
		return fileMappingPath;
	}

	public void setFileMappingPath(String fileMappingPath) {
		this.fileMappingPath = fileMappingPath;
	}

	public int getFileSttus() {
		return fileSttus;
	}

	public void setFileSttus(int fileSttus) {
		this.fileSttus = fileSttus;
	}

	public Date getFileRgsde() {
		return fileRgsde;
	}

	public void setFileRgsde(Date fileRgsde) {
		this.fileRgsde = fileRgsde;
	}

	public String getFileExt() {
		return fileExt;
	}

	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public int getBoardPk() {
		return boardPk;
	}

	public void setBoardPk(int boardPk) {
		this.boardPk = boardPk;
	}

	@Override
	public String toString() {
		return "FileVO [filePk=" + filePk + ", FileRealNm=" + fileRealNm + ", fileNm=" + fileNm + ", fileUserPk=" + fileUserPk
				+ ", fileUrlPath=" + fileUrlPath + ", fileMappingPath=" + fileMappingPath + ", fileSttus=" + fileSttus
				+ ", fileRgsde=" + fileRgsde + ", fileExt=" + fileExt + ", fileSize=" + fileSize + ", boardPk="
				+ boardPk + "]";
	}
	
}
