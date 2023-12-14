package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.UserDto;

public class AdminDao {
	private Connection conn;
	private PreparedStatement pstmt;

	public AdminDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
		
	}


	//유저 리스트 불러오기
	public ArrayList<UserDto> userSelectAll(){
		ArrayList<UserDto> alist = new ArrayList<UserDto>();
		ResultSet rs = null;
		String sql = "Select uidx, userid, usernickname, username, userdate\r\n "
				+ "from usertable\r\n"
				+ "where uDelYn='N' and adminYn='N'";

		try{			
			//구문(쿼리)객체
			pstmt = conn.prepareStatement(sql);
			//DB에 있는 값을 담아오는 전용객체
			rs = pstmt.executeQuery();
	
			while(rs.next()){
				UserDto udto = new UserDto();
				udto.setUidx( rs.getInt("uidx") ); 
				udto.setUserId( rs.getString("userId") );
				udto.setUserNickname( rs.getString("userNickname"));
				udto.setUserName( rs.getString("userName"));
				udto.setUserDate( rs.getString("userDate"));
				
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
}
