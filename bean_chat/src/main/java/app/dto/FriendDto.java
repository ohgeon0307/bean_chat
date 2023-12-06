package app.dto;

public class FriendDto {
	
	private int fidx;
	private int uidx1;
	private int uidx2;
	private String fAddYn;
	private String fLike;
	private UserDto fInfo;
	

	public UserDto getfInfo() {
		return fInfo;
	}
	public void setfInfo(UserDto fInfo) {
		this.fInfo = fInfo;
	}
	public int getFidx() {
		return fidx;
	}
	public void setFidx(int fidx) {
		this.fidx = fidx;
	}
	public int getUidx1() {
		return uidx1;
	}
	public void setUidx1(int uidx1) {
		this.uidx1 = uidx1;
	}
	public int getUidx2() {
		return uidx2;
	}
	public void setUidx2(int uidx2) {
		this.uidx2 = uidx2;
	}
	public String getfAddYn() {
		return fAddYn;
	}
	public void setfAddYn(String fAddYn) {
		this.fAddYn = fAddYn;
	}
	public String getfLike() {
		return fLike;
	}
	public void setfLike(String fLike) {
		this.fLike = fLike;
	}
}
