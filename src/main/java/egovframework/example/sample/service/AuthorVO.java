package egovframework.example.sample.service;

public class AuthorVO {

	private int pk;
	private int level;
	private String pageUrl;
	private int sttus;
	
	
	
	public int getPk() {
		return pk;
	}
	public void setPk(int pk) {
		this.pk = pk;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	
	public String getPageUrl() {
		return pageUrl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}
	public int getSttus() {
		return sttus;
	}
	public void setSttus(int sttus) {
		this.sttus = sttus;
	}
	@Override
	public String toString() {
		return "AuthorVO [pk=" + pk + ", level=" + level + ", pageUrl=" + pageUrl + ", sttus=" + sttus + "]";
	}
	
	
	
}
