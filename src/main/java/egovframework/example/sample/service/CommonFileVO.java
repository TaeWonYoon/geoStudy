package egovframework.example.sample.service;

import org.springframework.web.multipart.MultipartFile;

public class CommonFileVO {

	private MultipartFile mpfile;

	private String id;
	private String fileName;
	private String action;
	public MultipartFile getMpfile() {
		return mpfile;
	}
	public void setMpfile(MultipartFile mpfile) {
		this.mpfile = mpfile;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	@Override
	public String toString() {
		return "CommonFileVO [mpfile=" + mpfile + ", id=" + id + ", fileName=" + fileName + ", action=" + action
				+ ", getMpfile()=" + getMpfile() + ", getId()=" + getId() + ", getFileName()=" + getFileName()
				+ ", getAction()=" + getAction() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
		
		
	
}
