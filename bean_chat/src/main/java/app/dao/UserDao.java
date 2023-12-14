package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.PasswordEncoder;
import app.dto.UserDto;

public class UserDao {
	
	private Connection conn;
	private PreparedStatement pstmt;

	public UserDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
		
	}
	
	//회원가입하기
	public int userInsert(UserDto udto){
		int exec = 0;
		
		String sql = "insert into usertable(uidx,userid,userpwd,username,userbirth,usergender,userphone,usernickname)"
		        +" values(?,?,?,?,?,?,?,?)";
		try{
		conn.setAutoCommit(false);
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, udto.getUidx());
		pstmt.setString(2, udto.getUserId());
	    pstmt.setString(3, udto.getUserPwd());
		pstmt.setString(4, udto.getUserName());
		pstmt.setString(5, udto.getUserBirth());
		pstmt.setString(6, udto.getUserGender());
		pstmt.setString(7, udto.getUserPhone());
		pstmt.setString(8, udto.getUserNickname());
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
	
	public int userIdCheck(String userId){
		int value=0;  // 결과값이 0인지 아닌지
		
		String sql="select count(*) as cnt from usertable where userid=?";
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				value =	rs.getInt("cnt");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return value;
	}
	

	//로그인하기
	public int userLoginCheck(String userId) {
		
		int value=0;
		
		String sql="select uidx from usertable where userid=?";
		ResultSet rs = null;
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				value =	rs.getInt("uidx");
				//value가 0이면 일치하지않는다
				//1 일치한다
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				pstmt.close();

			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return value;
	}
	
	public UserDto UserSelectOne(int uidx) {
		UserDto udto = null;
		String sql = "select * from usertable where uidx=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, uidx);
	
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				//결과값 옮겨담기
				udto = new UserDto();
				udto.setUserId(rs.getString("userId"));
				udto.setUserName(rs.getString("userName"));
				udto.setUserBirth(rs.getString("userBirth"));
				udto.setUserNickname(rs.getString("userNickname"));
				udto.setUserPhone(rs.getString("userPhone"));
				udto.setUserDate(rs.getString("userDate"));
				udto.setuDelYn(rs.getString("uDelYn"));
				udto.setUserImage(rs.getString("userImage"));
			}			
		} catch (SQLException e) {			
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}	
		
		return udto;
		
	}
	
	public int userModify(UserDto udto) {
		int exec = 0;
		String sql = "update usertable set\r\n"
				+ "usernickname = ?, \r\n"
				+ "username = ?, \r\n"
				+ "userphone = ?, \r\n"
				+ "userbirth = ? \r\n"
				+"where uidx = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, udto.getUserNickname());
			pstmt.setString(2, udto.getUserName());
			pstmt.setString(3, udto.getUserPhone());
			pstmt.setString(4, udto.getUserBirth());
			pstmt.setInt(5, udto.getUidx());
			exec = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
			
			
		}
		
		
		return exec;
		
	}
	
	public String userHashPassword(String userId) {
		String userHashPwd = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		 try{
			 String sql = "SELECT userpwd FROM usertable WHERE userid = ?";
			 pstmt = conn.prepareStatement(sql);
			 pstmt.setString(1, userId);
			 rs = pstmt.executeQuery();
			 
			 if (rs.next()) {
				 userHashPwd = rs.getString("userpwd"); // 데이터베이스에서 가져온 해시된 비밀번호
		        
			 }
	    }catch(Exception e){
	    	
	        e.printStackTrace();
	        // 예외 처리 등
	    
	    }finally{
	    	
	        // 리소스 해제
	        try {
	        	rs.close();
				pstmt.close();
	      
	        } catch (SQLException e) {
	        	
	            e.printStackTrace();
	        }
	    }
		
		
		
		return userHashPwd;
		
		
	}
	
	public int userImageUpdate(int uidx, String userImage) {
		
		int exec = 0;
		String sql ="update usertable set\r\n"
				+ "userimage = ?\r\n"
				+ "where uidx = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userImage);
			pstmt.setInt(2, uidx);
			exec = pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
			
			
		}
		
		
		return exec;
		
		
		
	}
	
	public int userPwdUpdate(int uidx, String userPwd) {
	
		int exec = 0;
		String sql ="update usertable set\r\n"
				+ "userPwd = ?\r\n"
				+ "where uidx = ?";
		
		try { 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userPwd);
			pstmt.setInt(2, uidx);
			exec = pstmt.executeUpdate();
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}finally{
			try{
				
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}	
		
		return exec;
	
	
	}
	
	public int userDelete(int uidx) {
		int exec = 0;
		
		String sql = "update usertable set\r\r"
				+ "uDelYn = 'Y' \r\n"
				+ "where uidx = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, uidx);
			
			exec = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return exec;
		
	}
	
	public String userFindId(String userName, String userPhone) {
		String userId="null";
		ResultSet rs = null;
		try {
			String sql = "select userId from usertable where username=? and userphone=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			pstmt.setString(2, userPhone);
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userId = rs.getString("userId");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userId;
		
	
	}
	
	public UserDto userFindPwd(String userName, String userId) {
		PreparedStatement pstmt = null;
	    UserDto udto = null;
	    ResultSet rs = null;
	    try {
	        String sql = "SELECT userPwd, uidx FROM usertable WHERE username = ? AND userId = ?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, userName);
	        pstmt.setString(2, userId);
	        
	        rs = pstmt.executeQuery();
	        
	        if (rs.next()) {
	        	udto = new UserDto();
	        	udto.setUidx(rs.getInt("uidx"));
	        	udto.setUserPwd(rs.getString("userPwd"));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }finally{
			try{
				rs.close();
				pstmt.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	    return udto;
	}
	
    public String getUserAdminYn(String userId) {
        String adminYn = ""; // 관리자 여부를 저장할 변수

        try {
            String sql = "SELECT adminYn FROM usertable WHERE userId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                adminYn = rs.getString("adminYn"); // 관리자 여부 가져오기
            }

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return adminYn;
    }
	

	
}
