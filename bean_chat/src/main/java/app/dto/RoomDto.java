package app.dto;

public class RoomDto {

	public int getRidx() {
		return Ridx;
	}
	public void setRidx(int ridx) {
		Ridx = ridx;
	}
	public String getEntry() {
		return entry;
	}
	public void setEntry(String entry) {
		this.entry = entry;
	}
	public String getrName() {
		return rName;
	}
	public void setrName(String rName) {
		this.rName = rName;
	}
	public int getUidx() {
		return Uidx;
	}
	public void setUidx(int uidx) {
		Uidx = uidx;
	}
	private int Ridx;
	private String entry;
	private String rName;
	private int Uidx;
	
	
}