package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import app.dbconn.DbConn;
import app.dto.ChatDto;
import app.dto.ChatRoomDto;

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
			pstmt.setString(2, chatDto.getSender());
			pstmt.setString(3, chatDto.getMessage());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
	}

	public List<ChatDto> getRecentChatMessages(int chatRoomId, int count) {
	    List<ChatDto> chatMessages = new ArrayList<>();
	    String sql = "SELECT u.userId, c.message FROM chattable c "
	            + "JOIN usertable u ON c.uidx = u.uidx "
	            + "JOIN chatparticipant cp ON c.id = cp.id "
	            + "WHERE cp.chatRoomId = ? ORDER BY c.timestamp DESC LIMIT ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, chatRoomId);
	        pstmt.setInt(2, count);
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
	        closeResources();
	    }

	    Collections.reverse(chatMessages);
	    return chatMessages;
	}

	public int createChatRoom(String roomName, HttpServletRequest request) {
		String sql = "INSERT INTO chatroom (roomName) VALUES (?)";
	    ResultSet generatedKeys = null;

	    try {
	        pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
	        pstmt.setString(1, roomName);
	        pstmt.executeUpdate();

	        generatedKeys = pstmt.getGeneratedKeys();
	        if (generatedKeys.next()) {
	            int chatRoomId = generatedKeys.getInt(1);

	            // 사용자 추가
	            HttpSession session = request.getSession();
	            Object userIdObject = session.getAttribute("uidx");

	            if (userIdObject != null && userIdObject instanceof Integer) {
	                int userId = (Integer) userIdObject;
	                addUserToChatRoom(chatRoomId, userId);
	            }

	            return chatRoomId;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeResources(generatedKeys);
	    }
	    return -1;
	}

	// 사용자를 채팅 방에 추가하는 메소드
	private void addUserToChatRoom(int chatRoomId, int userId) {
		String addUserSql = "INSERT INTO chatparticipant (chatRoomId, uidx) VALUES (?, ?)";
		try {
			pstmt = conn.prepareStatement(addUserSql);
			pstmt.setInt(1, chatRoomId);
			pstmt.setInt(2, userId);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources();
		}
	}

	// 현재 사용자의 ID를 얻는 메소드
	private int getCurrentUserId(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Object userIdObject = session.getAttribute("uidx");

		// 세션에서 "uidx" 속성을 가져와서 현재 사용자의 ID를 반환
		if (userIdObject != null && userIdObject instanceof Integer) {
			return (Integer) userIdObject;
		} else {
			// 세션에 "uidx" 속성이 없거나 타입이 일치하지 않는 경우, 적절한 처리를 수행
			// 예를 들어, 로그인이 필요한 페이지에 접근할 때 로그인 페이지로 리다이렉션하거나
			// 기본값이나 에러 값을 반환
			return -1; // 예시로 -1을 반환
		}
	}

	// 자원을 닫는 메소드
	private void closeResources() {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// ResultSet을 닫는 메소드
	private void closeResources(ResultSet rs) {
		try {
	        if (pstmt != null && !pstmt.isClosed()) {
	            pstmt.close();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

	public List<ChatRoomDto> getChatRoomsByUserId(int userId) {
	    List<ChatRoomDto> chatRooms = new ArrayList<>();
	    String sql = "SELECT cr.id, cr.roomName FROM chatroom cr " +
	                 "JOIN chatparticipant cp ON cr.Id = cp.chatRoomId " +
	                 "WHERE cp.uidx = ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, userId);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            int chatRoomId = rs.getInt("Id");
	            String roomName = rs.getString("roomName");

	            ChatRoomDto chatRoomDto = new ChatRoomDto(chatRoomId, roomName);
	            chatRooms.add(chatRoomDto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeResources(); // 수정된 부분
	    }

	    return chatRooms;
	}

	public List<ChatDto> getChatMessagesByRoomId(int roomId) {
	    List<ChatDto> chatMessages = new ArrayList<>();
	    String sql = "SELECT u.userId, c.message FROM chattable c "
	            + "JOIN usertable u ON c.uidx = u.uidx WHERE c.id = ? ORDER BY c.timestamp DESC";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, roomId);
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
	        closeResources();
	    }

	    Collections.reverse(chatMessages);
	    return chatMessages;
	}

	// ... (이전 코드 유지)

}