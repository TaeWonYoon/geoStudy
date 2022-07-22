package egovframework.example.sample.service;

import java.util.Date;

public class AnswerVO {

	private int pk;
	private String cn;
	private int userPk;
	private Date rgsde;
	private int sttus;
	private int boardPk;
	private String nm;
	private int depth;
	private int depthPk;
	
	
	
	public int getPk() {
		return pk;
	}
	public void setPk(int pk) {
		this.pk = pk;
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
	public Date getRgsde() {
		return rgsde;
	}
	public void setRgsde(Date rgsde) {
		this.rgsde = rgsde;
	}
	public int getSttus() {
		return sttus;
	}
	public void setSttus(int sttus) {
		this.sttus = sttus;
	}
	public int getBoardPk() {
		return boardPk;
	}
	public void setBoardPk(int boardPk) {
		this.boardPk = boardPk;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getDepthPk() {
		return depthPk;
	}
	public void setDepthPk(int depthPk) {
		this.depthPk = depthPk;
	}
	@Override
	public String toString() {
		return "AnswerVO [pk=" + pk + ", cn=" + cn + ", userPk=" + userPk + ", rgsde=" + rgsde + ", sttus=" + sttus
				+ ", boardPk=" + boardPk + ", nm=" + nm + "]";
	}
	
	
}
