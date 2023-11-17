package app.dto;

public class ChatDto {
	
	private int cidx;
	private String cFrom;
	private String cTo;
	private String cContents;
	private String cTime;
	private String delyn;
	private String userNickname;
	
	private int Uidx;
	private int Ridx;
	
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public String getcFrom() {
		return cFrom;
	}
	public void setcFrom(String cFrom) {
		this.cFrom = cFrom;
	}
	public String getcTo() {
		return cTo;
	}
	public void setcTo(String cTo) {
		this.cTo = cTo;
	}
	public String getcContents() {
		return cContents;
	}
	public void setcContents(String cContents) {
		this.cContents = cContents;
	}
	public String getcTime() {
		return cTime;
	}
	public void setcTime(String cTime) {
		this.cTime = cTime;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public int getUidx() {
		return Uidx;
	}
	public void setUidx(int uidx) {
		Uidx = uidx;
	}
	public int getRidx() {
		return Ridx;
	}
	public void setRidx(int ridx) {
		Ridx = ridx;
	}

	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	
  
		
}
