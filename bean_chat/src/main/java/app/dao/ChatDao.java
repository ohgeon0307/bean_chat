package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
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
           String sql = "INSERT INTO chattable (uidx, sender, message, chatRoomId) VALUES (?, ?, ?, ?)";

           try {
               pstmt = conn.prepareStatement(sql);
               pstmt.setInt(1, chatDto.getUidx());
               pstmt.setString(2, chatDto.getSender());
               pstmt.setString(3, chatDto.getMessage());
               pstmt.setInt(4, chatDto.getChatRoomId()); // 추가: 채팅방 ID 설정
               pstmt.executeUpdate();
           } catch (SQLException e) {
               e.printStackTrace();
           } finally {
               closeResources();
           }
       }

     public List<ChatDto> getRecentChatMessages(int chatRoomId, int count) {
          List<ChatDto> chatMessages = new ArrayList<>();
          String sql = "SELECT u.userName, c.message, c.timestamp FROM chattable c " +
                  "JOIN usertable u ON c.uidx = u.uidx " +
                  "WHERE c.chatRoomId = ? ORDER BY c.timestamp DESC LIMIT ?";

          try {
              pstmt = conn.prepareStatement(sql);
              pstmt.setInt(1, chatRoomId);
              pstmt.setInt(2, count);
              ResultSet rs = pstmt.executeQuery();

              while (rs.next()) {
                  String sender = rs.getString("userName");
                  String message = rs.getString("message");
                  Timestamp timestamp = rs.getTimestamp("timestamp");
                  long timeInMillis = timestamp.getTime();

                  // 메시지에 타임스탬프 추가
                  message += " timestamp:" + timeInMillis;

                  ChatDto chatDto = new ChatDto(0, 0, sender, message, chatRoomId);
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
		String addUserSql = "INSERT INTO chatparticipant (chatRoomId, uidx, cState) VALUES (?, ?,'Y')";
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
	// 채팅방에 친구를 초대하는 메서드
   public int sendInvitation(int chatRoomId, int uidx) {
       int exec = 0;
       String sql = "INSERT INTO chatparticipant (chatRoomId, uidx, cState) VALUES (?, ?,'W')";

       try {
           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, chatRoomId);
           pstmt.setInt(2, uidx);

           exec = pstmt.executeUpdate();
       } catch (SQLException e) {
           e.printStackTrace();
       }

       return exec;
   }
   // 채팅방 참여 여부 확인하는 메서드
   public boolean checkParticipant(int chatRoomId, int uidx) {
       boolean isParticipant = false;
       String sql = "SELECT * FROM chatparticipant WHERE chatRoomId = ? AND uidx = ?";
       
       try {
           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, chatRoomId);
           pstmt.setInt(2, uidx);

           ResultSet rs = pstmt.executeQuery();
           if (rs.next()) {
               isParticipant = true; // 이미 채팅방에 참여 중인 상태
           }

           rs.close();
           pstmt.close();
       } catch (SQLException e) {
           e.printStackTrace();
       }

       return isParticipant;
   }
   
   public boolean checkSentInvitation(int chatRoomId, int friendUidx) {
       boolean hasSentInvitation = false;
       String sql = "SELECT COUNT(*) AS count FROM chatparticipant " +
                    "WHERE chatRoomId = ? AND uidx = ? AND cState = 'W'";

       try {
           PreparedStatement pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, chatRoomId);
           pstmt.setInt(2, friendUidx);
           ResultSet rs = pstmt.executeQuery();

           if (rs.next()) {
               int count = rs.getInt("count");
               hasSentInvitation = count > 0;
           }
       } catch (SQLException e) {
           e.printStackTrace();
       } finally {
           closeResources();
       }

       return hasSentInvitation;
   }
   
	public List<ChatRoomDto> chatReceivedSelectAll(int uidx) {
	    List<ChatRoomDto> alist = new ArrayList<>();
	    String sql = "SELECT cp.chatRoomId, cr.roomName " +
	                 "FROM chatparticipant cp " +
	                 "JOIN chatroom cr ON cp.chatRoomId = cr.id " +
	                 "WHERE cp.uidx = ? AND cp.cState = 'W'";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, uidx);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            int chatRoomId = rs.getInt("chatRoomId");
	            String roomName = rs.getString("roomName");

	            // ChatRoomDto를 사용하여 결과 저장
	            ChatRoomDto crdto = new ChatRoomDto(chatRoomId, roomName);
	            alist.add(crdto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        closeResources(); // 필요에 따라 리소스를 닫아줘야 합니다.
	    }

	    return alist;
	}
	
	   public int getInvitedFriendUidx(int chatRoomId) {
	        int invitedFriendUidx = -1; // 초대된 친구의 ID
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	            String sql = "SELECT uidx FROM chatparticipant WHERE chatRoomId = ? and cState='Y'";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, chatRoomId);
	            rs = pstmt.executeQuery();

	            if (rs.next()) {
	                invitedFriendUidx = rs.getInt("uidx");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            // 리소스 해제
	            // 만약 conn, pstmt, rs를 사용하고 있는 경우 close() 메소드를 사용하여 리소스를 닫아줘야 합니다.
	            try {
	                if (rs != null) rs.close();
	                if (pstmt != null) pstmt.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	        

	        return invitedFriendUidx;
	    }
	   
	   public String getInvitedFriendNickname(int uidx) {
		    String friendNickname = null;
		    String sql = "SELECT userNickname FROM usertable WHERE uidx = ?";
		    
		    try {
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, uidx);
		        ResultSet rs = pstmt.executeQuery();
		        
		        if (rs.next()) {
		            friendNickname = rs.getString("userNickname");
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    
		    return friendNickname;
		}
	   
	   public boolean ChatRequestAccecpt(int chatRoomId, boolean acceptRequest) {
		    if (!acceptRequest) { // 거절일 경우
		        String deleteSql = "DELETE FROM chatparticipant WHERE chatRoomId = ? and cState='W'";

		        try {
		            pstmt = conn.prepareStatement(deleteSql);
		            pstmt.setInt(1, chatRoomId);
		            int rowsAffected = pstmt.executeUpdate();

		            return rowsAffected > 0;
		        } catch (SQLException e) {
		            e.printStackTrace();
		        } finally {
		            closeResources();
		        }

		        return false;
		    } else { // 수락일 경우는 'Y'로 업데이트
		        String updateSql = "UPDATE chatparticipant SET cState = 'Y' WHERE chatRoomId = ?";

		        try {
		            pstmt = conn.prepareStatement(updateSql);
		            pstmt.setInt(1, chatRoomId);
		            int rowsAffected = pstmt.executeUpdate();

		            return rowsAffected > 0;
		        } catch (SQLException e) {
		            e.printStackTrace();
		        } finally {
		            closeResources();
		        }

		        return false;
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
	                 "WHERE cp.uidx = ? AND cp.cState = 'Y'"; // 'y'인 경우 필터링 추가

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
       String sql = "SELECT id, uidx, sender, message FROM chattable WHERE chatRoomId = ? ORDER BY timestamp DESC";

       try {
           pstmt = conn.prepareStatement(sql);
           pstmt.setInt(1, roomId);
           ResultSet rs = pstmt.executeQuery();

           while (rs.next()) {
               int id = rs.getInt("id");
               int uidx = rs.getInt("uidx");
               String sender = rs.getString("sender");
               String message = rs.getString("message");

               ChatDto chatDto = new ChatDto(id, uidx, sender, message, roomId);
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