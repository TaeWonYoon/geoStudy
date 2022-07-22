package egovframework.example.sample.service;

import java.sql.Timestamp;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {

	private int pk;
	private String sj;
	private String cn;
	private String nm;
	private int userPk;
	private int sttus;
	private String ty;
	private Timestamp rgsde;
	private Timestamp updde;
	private FileVO fileVO;
	
	public BoardVO() {
	}
	
	
	public int getPk() {
		return pk;
	}
	public void setPk(int pk) {
		this.pk = pk;
	}
	public String getSj() {
		return sj;
	}
	public void setSj(String sj) {
		this.sj = sj;
	}
	public String getCn() {
		return cn;
	}
	public void setCn(String cn) {
		this.cn = cn;
	}
	public int getUserPk() {
		return userPk;
	}
	public void setUserPk(int userPk) {
		this.userPk = userPk;
	}
	public int getSttus() {
		return sttus;
	}
	public void setSttus(int sttus) {
		this.sttus = sttus;
	}
	public Timestamp getRgsde() {
		return rgsde;
	}
	public void setRgsde(Timestamp rgsde) {
		this.rgsde = rgsde;
	}
	public Timestamp getUpdde() {
		return updde;
	}
	public void setUpdde(Timestamp updde) {
		this.updde = updde;
	}

	public String getTy() {
		return ty;
	}


	public void setTy(String ty) {
		this.ty = ty;
	}


	public String getNm() {
		return nm;
	}


	public void setNm(String nm) {
		this.nm = nm;
	}

	
	public FileVO getFileVO() {
		return fileVO;
	}


	public void setFileVO(FileVO fileVO) {
		this.fileVO = fileVO;
	}


	@Override
	public String toString() {
		return "BoardVO [pk=" + pk + ", sj=" + sj + ", cn=" + cn + ", nm=" + nm + ", userPk=" + userPk + ", sttus="
				+ sttus + ", ty=" + ty + ", rgsde=" + rgsde + ", updde=" + updde + ", fileVO=" + fileVO + "]";
	}


	
}
