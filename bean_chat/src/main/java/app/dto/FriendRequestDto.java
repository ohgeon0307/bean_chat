package app.dto;

public class FriendRequestDto {
	
	private int fridx;
	private int fromUidx;
	private int toUidx;
	private String fState;
	public int getFridx() {
		return fridx;
	}
	public void setFridx(int fridx) {
		this.fridx = fridx;
	}
	public int getFromUidx() {
		return fromUidx;
	}
	public void setFromUidx(int fromUidx) {
		this.fromUidx = fromUidx;
	}
	public int getToUidx() {
		return toUidx;
	}
	public void setToUidx(int toUidx) {
		this.toUidx = toUidx;
	}
	public String getfState() {
		return fState;
	}
	public void setfState(String fState) {
		this.fState = fState;
	}
	

}
