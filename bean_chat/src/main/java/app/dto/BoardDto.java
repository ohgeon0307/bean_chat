package app.dto;

public class BoardDto {
	private int bidx;
	private String subject;
	private String contents;
	private String writer;
	private int viewCnt;
	private String writeDate;
	private String bDelYn;
	private String modifyDate;
	private String fileName;
	private String bList;
	private int Uidx;
	private int commentCount;
	
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public int getBidx() {
		return bidx;
	}
	public void setBidx(int bidx) {
		this.bidx = bidx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public String getbDelYn() {
		return bDelYn;
	}
	public void setbDelYn(String bDelYn) {
		this.bDelYn = bDelYn;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getbList() {
		return bList;
	}
	public void setbList(String bList) {
		this.bList = bList;
	}
	public int getUidx() {
		return Uidx;
	}
	public void setUidx(int uidx) {
		Uidx = uidx;
	}
}
