package egovframework.example.sample.wssservice;

import java.sql.Date;

public class CrawlingVO {
	
	private String newsNsprc;
	private int newsCnt;
	private Date kwrdYear;
	private String type;
	private String calendar;
	private String startDate;
	private String finishDate;
	private String searchType;
	
	public String getNewsNsprc() {
		return newsNsprc;
	}
	public void setNewsNsprc(String newsNsprc) {
		this.newsNsprc = newsNsprc;
	}
	public int getNewsCnt() {
		return newsCnt;
	}
	public void setNewsCnt(int newsCnt) {
		this.newsCnt = newsCnt;
	}
	public Date getKwrdYear() {
		return kwrdYear;
	}
	public void setKwrdYear(Date kwrdYear) {
		this.kwrdYear = kwrdYear;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCalendar() {
		return calendar;
	}
	public void setCalendar(String calendar) {
		this.calendar = calendar;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getFinishDate() {
		return finishDate;
	}
	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	@Override
	public String toString() {
		return "CrawlingVO [newsNsprc=" + newsNsprc + ", newsCnt=" + newsCnt + ", kwrdYear=" + kwrdYear + ", type="
				+ type + ", calendar=" + calendar + "]";
	}
	
	
}
