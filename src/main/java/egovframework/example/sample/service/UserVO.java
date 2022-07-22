package egovframework.example.sample.service;

import java.sql.Date;

public class UserVO {

	private int pk;
	private String nm;
	private String id;
	private String password;
	private Date rgsde;
	private Date updde;
	private int sttus;
	private int level;
	private int confmPk;
	
	
	
	public UserVO() {
	}
	
	public int getPk() {
		return pk;
	}
	public void setPk(int pk) {
		this.pk = pk;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public Date getRgsde() {
		return rgsde;
	}

	public Date getUpdde() {
		return updde;
	}

	public int getSttus() {
		return sttus;
	}
	public void setSttus(int sttus) {
		this.sttus = sttus;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}

	public int getConfmPk() {
		return confmPk;
	}

	public void setConfmPk(int confmPk) {
		this.confmPk = confmPk;
	}

	public void setRgsde(Date rgsde) {
		this.rgsde = rgsde;
	}

	public void setUpdde(Date updde) {
		this.updde = updde;
	}

	@Override
	public String toString() {
		return "UserVO [pk=" + pk + ", nm=" + nm + ", id=" + id + ", password=" + password + ", rgsde=" + rgsde
				+ ", updde=" + updde + ", sttus=" + sttus + ", level=" + level + ", confmPk=" + confmPk + "]";
	}

	
	
}
