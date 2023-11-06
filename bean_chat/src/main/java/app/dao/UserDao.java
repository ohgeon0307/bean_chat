package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
	public int userInsert(
			String userId,
			String userPwd,String userName,
			String userBirth,String userGender,
			String userPhone,String userNickname,
			String userDate){
		int exec = 0;
		
		String sql = "insert into usertable(userid,userpwd,username,userbirth,usergender,userphone,usernickname,userdate)"
		        +" values(?,?,?,?,?,?,?,now())";
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userId);
		pstmt.setString(2, userPwd);
		pstmt.setString(3, userName);
		pstmt.setString(4, userBirth);
		pstmt.setString(5, userGender);
		pstmt.setString(6, userPhone);
		pstmt.setString(7, userNickname);
		pstmt.setString(8, userDate);
		exec = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}
		return exec;	
	}
	
	
	
}
