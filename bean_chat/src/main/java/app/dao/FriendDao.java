package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import app.dbconn.DbConn;
import app.dto.FriendDto;
import app.dto.FriendRequestDto;
import app.dto.UserDto;

public class FriendDao {
	
	private Connection conn;
	private PreparedStatement pstmt;
	
	public FriendDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}

	
	public ArrayList<FriendDto> friendSelectAll(int uidx) {
	
		ArrayList<FriendDto> alist = new ArrayList<FriendDto>();
	
		ResultSet rs = null;
		
		String sql ="SELECT *\r\n"
				+ "FROM friendtable\r\n"
				+ "WHERE uidx1 = ? OR uidx2 = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			 pstmt.setInt(1, uidx);
			 pstmt.setInt(2, uidx);
			rs = pstmt.executeQuery();
	
		
		while(rs.next()) {
			FriendDto fdto = new FriendDto();
			fdto.setFidx(rs.getInt("fidx"));
			fdto.setUidx1(rs.getInt("uidx1"));
			fdto.setUidx2(rs.getInt("uidx2"));
			alist.add(fdto);
		}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{
				rs.close();
				pstmt.close();
				//conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return alist;
	}
	
	public int friendFindId(String userId) {
		int uidx=0;
		ResultSet rs = null;
		try {
			String sql = "select uidx from usertable where userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				uidx = rs.getInt("uidx");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return uidx;
		
	
	}
	
	//친구추가 전송
	public int friendSend(FriendRequestDto frdto){
	      int exec = 0;
			/*
			 * UserDao udao = new UserDao(); UserDto udto =
			 * udao.UserSelectOne(fdto.getUidx2());
			 */
	      
	      
	      String sql = "insert into friend_requesttable(Fridx,fromUidx, toUidx, fState)"
	              +" values(?,?,?,'W')";
	      try{
	      conn.setAutoCommit(false);
	      pstmt = conn.prepareStatement(sql);
	      pstmt.setInt(1, frdto.getFridx());
	      pstmt.setInt(2, frdto.getFromUidx());
	      pstmt.setInt(3, frdto.getToUidx());
	      
	      exec = pstmt.executeUpdate();
	      conn.commit();
	      
	      
	      }catch(Exception e){
	         try {
	            conn.rollback();
	         } catch (SQLException e1) {            
	            e1.printStackTrace();
	         }
	         e.printStackTrace();
	      }
	      return exec;   
	   }

		
	
	public List<UserDto> requestSelectAll(int toUidx) {
	    List<UserDto> alist = new ArrayList<>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT u.* " +
	                 "FROM friend_requesttable fr " +
	                 "JOIN usertable u ON fr.fromUidx = u.uidx " +
	                 "WHERE fr.toUidx = ? AND fr.fState = 'W'";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, toUidx);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            UserDto udto = new UserDto();
	            udto.setUidx(rs.getInt("uidx"));
	            udto.setUserId(rs.getString("userId"));
	            udto.setUserName(rs.getString("userName"));
	            udto.setUserBirth(rs.getString("userBirth"));
	            udto.setUserNickname(rs.getString("userNickname"));
	            udto.setUserPhone(rs.getString("userPhone"));
	            udto.setUserDate(rs.getString("userDate"));
	            udto.setuDelYn(rs.getString("uDelYn"));
	            udto.setUserImage(rs.getString("userImage"));

	            alist.add(udto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) {
	                rs.close();
	            }
	            if (pstmt != null) {
	                pstmt.close();
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }

	    return alist;
	}

	public int findFridxByUidx(int fromUidx, int toUidx) {
	    int fridx = 0;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = "SELECT Fridx FROM friend_requesttable WHERE fromUidx = ? AND toUidx = ?";
	    
	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, fromUidx);
	        pstmt.setInt(2, toUidx);
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	            fridx = rs.getInt("Fridx");
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    
	    return fridx;
	}
	
	
	public int friendAccept(int fridx) {
		
		int exec = 0;
		String sql ="update friend_requesttable set\r\n"
				+ "fstate = 'Y'\r\n"
				+ "where fridx = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fridx);
			exec = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();

		}

		return exec;

		
	}
	
	public int friendInsert(FriendDto fdto){
		int exec = 0;
		
		String sql = "insert into friendtable(fidx, uidx1, uidx2)"
		        +" values(?,?,?)";
		try{
		conn.setAutoCommit(false);
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, fdto.getFidx());
		pstmt.setInt(2, fdto.getUidx1());
		pstmt.setInt(3, fdto.getUidx2());
		
		exec = pstmt.executeUpdate();
		conn.commit();
		}catch(Exception e){
			try {
				conn.rollback();
			} catch (SQLException e1) {				
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return exec;	
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
