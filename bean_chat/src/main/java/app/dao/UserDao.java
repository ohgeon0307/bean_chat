package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.UserDto;

public class UserDao {
	
	private Connection conn;
	private PreparedStatement pstmt;

	public UserDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
		
	}
	
	//유저 리스트 불러오기
	public ArrayList<UserDto> userSelectAll(){
		ArrayList<UserDto> alist = new ArrayList<UserDto>();
		ResultSet rs = null;
		String sql = "Select * from usertable where udelyn='N' order by uidx desc";
		try{
	
			
			//구문(쿼리)객체
			pstmt = conn.prepareStatement(sql);
			//DB에 있는 값을 담아오는 전용객체
			rs = pstmt.executeQuery();

			while(rs.next()){
				UserDto udto = new UserDto();
	
				udto.setUidx( rs.getInt("uidx") ); 
				udto.setUserId( rs.getString("userid") );
				udto.setUserName( rs.getString("username"));
				udto.setUserDate( rs.getString("userdate"));
				alist.add(udto);
			}		
			
		}catch(Exception e){
			e.printStackTrace();		
		}finally{
			try{
				rs.close();
				pstmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return alist;
		
	}
	
	//회원가입하기
	public int userInsert(UserDto udto){
		int exec = 0;
		
		String sql = "insert into usertable(uidx,userid,userpwd,username,userbirth,usergender,userphone,usernickname)"
		        +" values(?,?,?,?,?,?,?)";
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
	public int userLoginCheck(String userId, String userPwd) {
		
		int value=0;
		
		String sql="select uidx from usertable where userid=? and userpwd=?";
		ResultSet rs = null;
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
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
				conn.close();
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
	
	
	
	
	
}
