package app.dto;

public class CommentsDto {
	
	private int ReplyiDX;
	private int ReplyLikeCnt;
	private String LikeCheck;
    private int Bidx;
    private int Uidx;
	private String rWriter; 
    private String rDate;
    private String rDelYn;
    private String rContent;
    
    public int getReplyiDX() {
		return ReplyiDX;
	}
	public void setReplyiDX(int replyiDX) {
		ReplyiDX = replyiDX;
	}
	public int getReplyLikeCnt() {
		return ReplyLikeCnt;
	}
	public void setReplyLikeCnt(int replyLikeCnt) {
		ReplyLikeCnt = replyLikeCnt;
	}
	public String getLikeCheck() {
		return LikeCheck;
	}
	public void setLikeCheck(String likeCheck) {
		LikeCheck = likeCheck;
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
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

    
	
}
