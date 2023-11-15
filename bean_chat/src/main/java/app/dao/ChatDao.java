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
	
	public ArrayList<ChatDto> getChatListByID(String cFrom, String cTo, String cidx) { //특정한 아이디에 따라서 채팅내용을가져옴
		ArrayList<ChatDto> chatList = null; //하나 메세지를 리스트에담아서 보관
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM ChatTable WHERE ((cFrom = ? AND cTo = ?) OR (cFrom = ? AND cTo = ?)) AND cidx > ? ORDER BY cTime"; //보내는사람이든 받는사람이든 두경우 입력된것이 해당이되면 가져올수있다
	    try {
             conn = dataSource.getConnection();// 데이터 소스 연결
             pstmt = conn.prepareStatement(SQL);
             pstmt.setString(1, cFrom); //자신이 받던간에 보내던간에
             pstmt.setString(2, cTo);
             pstmt.setString(3, cTo);
             pstmt.setString(4, cFrom);
             pstmt.setInt(5, Integer.parseInt(cidx));
             rs = pstmt.executeQuery();
             chatList = new ArrayList<ChatDto>();
             while (rs.next()) {
            	 ChatDto chat = new ChatDto();
            	 chat.setCidx(rs.getInt("cidx")); //결과가반환된것중에서 cidx를 가져옴
            	   chat.setUserNickname(rs.getString("userNickname").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
            	 chat.setcFrom(rs.getString("cFrom").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")); //방어하기위하여 사용
            	 chat.setcTo(rs.getString("cTo").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")); 
                 chat.setcContents(rs.getString("cContents").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
                 int cTime = Integer.parseInt(rs.getString("cTime").substring(11,13));
                 String timeType = "오전"; //기본으로 오전설정후
                 if(cTime >= 12) { //12보다크다면
                	 timeType = "오후"; //오후로 바꿔주고
                	 cTime -= 12;// 12를빼줌
                 }
                 chat.setcTime(rs.getString("cTime").substring(0, 11)+ " " + timeType + " " + cTime + " " + ":" + rs.getString("cTime").substring(14, 16) + "");
                 chatList.add(chat); //모든메시지를 가져옴
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
		String SQL = "SELECT * FROM ChatTable WHERE ((cFrom = ? AND cTo = ?) OR (cFrom = ? AND cTo = ?)) AND cidx > (SELECT MAX(cidx) - ? FROM ChatTable) ORDER BY cTime";
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
            	 chat.setcFrom(rs.getString("cFrom").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
            	 chat.setUserNickname(rs.getString("userNickname").replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
            	 chat.setcTo(rs.getString("cTo").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")); 
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

}
