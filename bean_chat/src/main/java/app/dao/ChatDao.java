package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import app.dto.ChatDto;

public class ChatDao {

	DataSource dataSource;
	
	public ChatDao() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env"); 
			dataSource = (DataSource) envContext.lookup("jdbc/bean_chat");
		} catch (Exception e) {
			e.printStackTrace();
		}
		  
	}
	
	public ArrayList<ChatDto> getChatListByID(String cFrom, String cTo, String cidx) {
	    ArrayList<ChatDto> chatList = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	    	 conn = dataSource.getConnection();// 데이터 소스 연결
	        String chatListSQL = "SELECT *, " +
	                             "(SELECT userNickname FROM UserTable WHERE userId = ChatTable.cFrom) AS fromNickname, " +
	                             "(SELECT userNickname FROM UserTable WHERE userId = ChatTable.cTo) AS toNickname " +
	                             "FROM ChatTable WHERE ((cFrom = ? AND cTo = ?) OR (cFrom = ? AND cTo = ?)) AND cidx > ? ORDER BY cTime";
	        pstmt = conn.prepareStatement(chatListSQL);
	        
	        pstmt.setString(1, cFrom);
	        pstmt.setString(2, cTo);
	        pstmt.setString(3, cTo);
	        pstmt.setString(4, cFrom);
	        pstmt.setInt(5, Integer.parseInt(cidx));
	        rs = pstmt.executeQuery();
	        chatList = new ArrayList<ChatDto>();
	        while (rs.next()) {
	            // getChatListByRecent와 유사한 수정 사항
	            ChatDto chat = new ChatDto();
	            chat.setCidx(rs.getInt("cidx"));
	            chat.setcFrom(rs.getString("fromNickname").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
	            chat.setUserNickname(rs.getString("userNickname").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
	            chat.setcTo(rs.getString("toNickname").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
	            chat.setcContents(rs.getString("cContents").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
	            int cTime = Integer.parseInt(rs.getString("cTime").substring(11,13));
	            String timeType = "오전";
	            if(cTime >= 12) {
	                timeType = "오후";
	                cTime -= 12;
	            }
	            //
	            chat.setcTime(rs.getString("cTime").substring(0, 11)+ " " + timeType + " " + cTime + " " + ":" + rs.getString("cTime").substring(14, 16) + "");
	            chatList.add(chat);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	try {
	    		if(rs != null) rs.close();
	    		if(pstmt != null) pstmt.close();
	    		if(conn != null) conn.close();
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	    }
		
	    return chatList;  
	}
	
	public ArrayList<ChatDto> getChatListByRecent(String cFrom, String cTo, int number) {
	    ArrayList<ChatDto> chatList = null;
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String SQL = "SELECT *, " +
	                 "(SELECT userNickname FROM UserTable WHERE userId = ChatTable.cFrom) AS fromNickname, " +
	                 "(SELECT userNickname FROM UserTable WHERE userId = ChatTable.cTo) AS toNickname " +
	                 "FROM ChatTable WHERE ((cFrom = ? AND cTo = ?) OR (cFrom = ? AND cTo = ?)) AND cidx > (SELECT MAX(cidx) - ? FROM ChatTable) ORDER BY cTime";
	    try {
	        conn = dataSource.getConnection();
	        pstmt = conn.prepareStatement(SQL);
	        pstmt.setString(1, cFrom);
	        pstmt.setString(2, cTo);
	        pstmt.setString(3, cTo);
	        pstmt.setString(4, cFrom);
	        pstmt.setInt(5, number);
	        rs = pstmt.executeQuery();
	        chatList = new ArrayList<ChatDto>();
	        while (rs.next()) {
	            ChatDto chat = new ChatDto();
	            chat.setCidx(rs.getInt("cidx"));
	            chat.setcFrom(rs.getString("fromNickname").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
	            chat.setUserNickname(rs.getString("userNickname").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
	            chat.setcTo(rs.getString("toNickname").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
	            chat.setcContents(rs.getString("cContents").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
	            int cTime = Integer.parseInt(rs.getString("cTime").substring(11,13));
	            String timeType = "오전";
	            if(cTime >= 12) {
	                timeType = "오후";
	                cTime -= 12;
	            }
	            chat.setcTime(rs.getString("cTime").substring(0, 11)+ " " + timeType + " " + cTime + " " + ":" + rs.getString("cTime").substring(14, 16) + "");
	            chatList.add(chat);
	        } 
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	    	try {
	    		if(rs != null) rs.close();
	    		if(pstmt != null) pstmt.close();
	    		if(conn != null) conn.close();
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	    }
	    
		return chatList;
   }//
	
	public int submit(String cFrom, String cTo, String cContents) { //채팅을 보내는 submit
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "insert into chattable(cfrom, cto, ccontents, ctime)"
					+" values(?,?,?,now())";
	    try {
             conn = dataSource.getConnection();
             pstmt = conn.prepareStatement(SQL);
             pstmt.setString(1, cFrom);
             pstmt.setString(2, cTo);
             pstmt.setString(3, cContents);
             
             return pstmt.executeUpdate(); //실행한결과를 반환
	    } catch (Exception e) {
	    	e.printStackTrace();
	    } finally {
	    	try {
	    		if(rs != null) rs.close();
	    		if(pstmt != null) pstmt.close();
	    		if(conn != null) conn.close();
	    	} catch (Exception e) {
	    		e.printStackTrace();
	    	}
	    	
	    
	    }
		return -1; // 데이터베이스 오류

}

	public String getUserNickname(String userId) {
		 String nickname = "";
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;

		    try {
		        conn = dataSource.getConnection();
		        String SQL = "SELECT userNickname FROM UserTable WHERE userId = ?";
		        pstmt = conn.prepareStatement(SQL);
		        pstmt.setString(1, userId);
		        rs = pstmt.executeQuery();

		        if (rs.next()) {
		            nickname = rs.getString("userNickname");
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		    	try {
		    		if(rs != null) rs.close();
		    		if(pstmt != null) pstmt.close();
		    		if(conn != null) conn.close();
		    	} catch (Exception e) {
		    		e.printStackTrace();
		    	}
		    }
		   

		    return nickname;
	}

}
