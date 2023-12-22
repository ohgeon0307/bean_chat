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
	
	public ArrayList<UserDto> friendSelectAll(int uidx) {
		ArrayList<UserDto> alist = new ArrayList<>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    try {
	    	String sql = "SELECT u.* " +
	    			"FROM friendtable f " +
	    			"JOIN usertable u ON (f.Uidx1 = u.uidx OR f.Uidx2 = u.uidx) " +
	    			"WHERE (f.Uidx1 = ? OR f.Uidx2 = ?) AND u.uidx != ?";
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setInt(1, uidx);
	    	pstmt.setInt(2, uidx);
	    	pstmt.setInt(3, uidx);
	    	rs = pstmt.executeQuery();
	    	while (rs.next()) {    	
	    		UserDto udto= new UserDto();
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
	    // 리소스 해제
	    } finally {
	    	try {
	    		if (rs != null) rs.close();
	    		if (pstmt != null) pstmt.close();
	    	} catch (SQLException e) {
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

		
	
	public List<UserDto> receivedRequestSelectAll(int toUidx) {
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
	
	// 보낸 요청 목록 조회 메서드
	public List<UserDto> sentRequestSelectAll(int fromUidx) {
	    List<UserDto> alist = new ArrayList<>();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT u.* " +
	                 "FROM friend_requesttable fr " +
	                 "JOIN usertable u ON fr.toUidx = u.uidx " +
	                 "WHERE fr.fromUidx = ? AND fr.fState = 'W'";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, fromUidx);
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
	
public int friendReject(int fridx) {
		
		int exec = 0;
		String sql ="delete from friend_requesttable\r\n"
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
	
	public boolean areTheyFriends(int uidx1, int uidx2) {
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    boolean areFriends = false;

	    String sql = "SELECT * FROM friendtable WHERE (Uidx1 = ? AND Uidx2 = ?) OR (Uidx1 = ? AND Uidx2 = ?)";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, uidx1);
	        pstmt.setInt(2, uidx2);
	        pstmt.setInt(3, uidx2);
	        pstmt.setInt(4, uidx1);

	        rs = pstmt.executeQuery();
	        areFriends = rs.next(); // 결과가 존재하면 친구임을 의미함

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

	    return areFriends;
	}
	
	public boolean isRequestSent(int fromUidx, int toUidx) {
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    boolean isSent = false;

	    String sql = "SELECT * FROM friend_requesttable WHERE ((fromUidx = ? AND toUidx = ?) OR (fromUidx = ? AND toUidx = ?)) AND fState = 'W'";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, fromUidx);
	        pstmt.setInt(2, toUidx);
	        pstmt.setInt(3, toUidx);
	        pstmt.setInt(4, fromUidx);

	        rs = pstmt.executeQuery();
	        isSent = rs.next(); // 결과가 존재하면 요청이 보내진 상태임을 의미함

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

	    return isSent;
	}
	
	// 친구 삭제 메소드
		public int deleteFriend(int uidx1, int uidx2) {
		    int exec = 0;
		    try {
		        conn.setAutoCommit(false);

		        // 친구 테이블에서 해당 친구 관계 삭제하는 쿼리
		        String deleteSql = "DELETE FROM friendtable WHERE (uidx1=? AND uidx2=?) OR (uidx1=? AND uidx2=?)";
		        pstmt = conn.prepareStatement(deleteSql);
		        pstmt.setInt(1, uidx1);
		        pstmt.setInt(2, uidx2);
		        pstmt.setInt(3, uidx2);
		        pstmt.setInt(4, uidx1);

		        exec = pstmt.executeUpdate();
		        
		     // 친구 요청 테이블에서 해당 요청 삭제하는 쿼리
		        String deleteRequestSql = "DELETE FROM friend_requesttable WHERE (toUidx=? AND fromUidx=?) OR (toUidx=? AND fromUidx=?)";
		        pstmt = conn.prepareStatement(deleteRequestSql);
		        pstmt.setInt(1, uidx1);
		        pstmt.setInt(2, uidx2);
		        pstmt.setInt(3, uidx2);
		        pstmt.setInt(4, uidx1);

		        exec += pstmt.executeUpdate();
		        
		        
		        conn.commit();
		    } catch (SQLException e) {
		        try {
		            conn.rollback();
		        } catch (SQLException e1) {
		            e1.printStackTrace();
		        }
		        e.printStackTrace();
		    } finally {
		        try {
		            conn.setAutoCommit(true);
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		    return exec;
		}
	
	
	
	
	
	
}
