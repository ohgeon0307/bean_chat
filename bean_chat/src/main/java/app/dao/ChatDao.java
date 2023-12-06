package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import app.dbconn.DbConn;
import app.dto.ChatDto;

public class ChatDao {
	private Connection conn;
	private PreparedStatement pstmt;

	public ChatDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();

	}

	public void saveChatMessage(ChatDto chatDto) {
	    String sql = "INSERT INTO chattable (uidx, sender, message) VALUES (?, ?, ?)";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, chatDto.getUidx());
	        pstmt.setString(2, chatDto.getSender()); // 추가: sender 정보 저장
	        pstmt.setString(3, chatDto.getMessage());
	        pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	}
	
	public List<ChatDto> getRecentChatMessages(int count) {
	    List<ChatDto> chatMessages = new ArrayList<>();
	    String sql = "SELECT u.userId, c.message FROM chattable c " +
	                 "JOIN usertable u ON c.uidx = u.uidx ORDER BY c.timestamp DESC LIMIT ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, count);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            String sender = rs.getString("userId");
	            String message = rs.getString("message");

	            ChatDto chatDto = new ChatDto(0, sender, message);
	            chatMessages.add(chatDto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    Collections.reverse(chatMessages);
	    return chatMessages;
	}
	
}
