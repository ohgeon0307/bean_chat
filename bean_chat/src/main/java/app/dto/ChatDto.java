package app.dto;

public class ChatDto {
	private int id;
    private int uidx;
    private String sender;  // 추가: sender 정보
    private String message;
    private int chatRoomId; // 채팅방 id 추가 - 건

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getChatRoomId() {
		return chatRoomId;
	}

	public void setChatRoomId(int chatRoomId) {
		this.chatRoomId = chatRoomId;
	}

	// 기본 생성자
    public ChatDto() {
    }

    // 매개변수를 받는 생성자
    public ChatDto(int id, int uidx, String sender, String message, int chatRoomId) {
    	this.id = id;
        this.uidx = uidx;
        this.sender = sender;
        this.message = message;
        this.chatRoomId = chatRoomId;
    }

    public int getUidx() {
        return uidx;
    }

    public void setUidx(int uidx) {
        this.uidx = uidx;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}