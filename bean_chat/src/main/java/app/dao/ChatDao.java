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
			dataSource = (DataSource) envContext.lookup("jdbc/userid");
		} catch (Exception e) {
			e.printStackTrace();
		}
		  
	}
	
	public ArrayList<ChatDto> getchat_ListByID(String cFrom, String cTo, String cidx) {
		ArrayList<ChatDto> chat_list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CHAT WHERE ((cFrom = ? AND cTo = ?) OR (cfrom = ? AND cTo = ?)) AND Cidx > ? ORDER BY ctime";
	    try {
             conn = dataSource.getConnection();
             pstmt = conn.prepareStatement(SQL);
             pstmt.setString(1, cFrom);
             pstmt.setString(2, cTo);
             pstmt.setString(3, cTo);
             pstmt.setString(4, cFrom);
             pstmt.setInt(5, Integer.parseInt(cidx));
             rs = pstmt.executeQuery();
             chat_list = new ArrayList<ChatDto>();
             while (rs.next()) {
            	 ChatDto chat = new ChatDto();
            	 chat.setCidx(rs.getInt("cidx"));
            	 chat.setcFrom(rs.getString("cFrom").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
            	 chat.setcTo(rs.getString("cTo").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")); 
                 chat.setcContents(rs.getString("Ccontents").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
                 int cTime = Integer.parseInt(rs.getString("Ctime").substring(11,13));
                 String timeType = "오전";
                 if(cTime >= 12) {
                	 timeType = "오후";
                	 cTime = 12;
                 }
                 chat.setcTime(rs.getString("Ctime").substring(0, 11)+ " " + timeType + " " + cTime + " " + ":" + rs.getString("cTime").substring(14, 16) + "");
                 chat_list.add(chat);
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
		
	    return chat_list;  
	}
	
	public ArrayList<ChatDto> getchat_ListByRecent(String cFrom, String cTo, int number) {
		ArrayList<ChatDto> chat_list = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "SELECT * FROM CHAT WHERE ((cFrom = ? AND cTo = ?) OR (cfrom = ? AND cTo = ?)) AND Cidx > (SELECT MAX(cidx) - ? FROM CHAT) ORDER BY ctime";
	    try {
             conn = dataSource.getConnection();
             pstmt = conn.prepareStatement(SQL);
             pstmt.setString(1, cFrom);
             pstmt.setString(2, cTo);
             pstmt.setString(3, cTo);
             pstmt.setString(4, cFrom);
             pstmt.setInt(5, number);
             rs = pstmt.executeQuery();
             chat_list = new ArrayList<ChatDto>();
             while (rs.next()) {
            	 ChatDto chat = new ChatDto();
            	 chat.setCidx(rs.getInt("cidx"));
            	 chat.setcFrom(rs.getString("cFrom").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
            	 chat.setcTo(rs.getString("cTo").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")); 
                 chat.setcContents(rs.getString("Ccontents").replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>"));
                 int cTime = Integer.parseInt(rs.getString("Ctime").substring(11,13));
                 String timeType = "오전";
                 if(cTime >= 12) {
                	 timeType = "오후";
                	 cTime = 12;
                 }
                 chat.setcTime(rs.getString("Ctime").substring(0, 11)+ " " + timeType + " " + cTime + " " + ":" + rs.getString("cTime").substring(14, 16) + "");
                 chat_list.add(chat);
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
		return chat_list;
   }
	
	public int submit(String cFrom, String cTo, String cContents) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "INSERT INTO CHAT VALUES(NULL, ?, ?, ?, NOW())";
	    try {
             conn = dataSource.getConnection();
             pstmt = conn.prepareStatement(SQL);
             pstmt.setString(1, cFrom);
             pstmt.setString(2, cTo);
             pstmt.setString(3, cContents);
             return pstmt.executeUpdate();
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
		return -1;
	
}

}
