package app.dto;

import java.sql.Date;

public class CommentsDto {
	
	private int ReplyiDx;
	private int Bidx;
	private int Uidx;
    private String rWriter;
    private String rContent;
    private String rDate; 
    private String rDelYn;
    
	public int getReplyiDx() {
		return ReplyiDx;
	}
	public void setReplyiDx(int replyiDx) {
		ReplyiDx = replyiDx;
	}
	public int getBidx() {
		return Bidx;
	}
	public void setBidx(int bidx) {
		Bidx = bidx;
	}
	public int getUidx() {
		return Uidx;
	}
	public void setUidx(int uidx) {
		Uidx = uidx;
	}
	public String getrWriter() {
		return rWriter;
	}
	public void setrWriter(String rWriter) {
		this.rWriter = rWriter;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	public String getrDelYn() {
		return rDelYn;
	}
	public void setrDelYn(String rDelYn) {
		this.rDelYn = rDelYn;
	}
}
