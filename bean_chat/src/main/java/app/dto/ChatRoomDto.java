package app.dto;

public class ChatRoomDto {
	private int id; // chatroomId
	private String roomName;
	
	public ChatRoomDto(int id, String roomName) {
		this.id = id;
		this.roomName = roomName;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}
}
