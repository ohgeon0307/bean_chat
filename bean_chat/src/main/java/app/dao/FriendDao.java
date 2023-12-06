package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.FriendDto;
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
			fdto.setfAddYn(rs.getString("fAddYn"));
			fdto.setfLike(rs.getString("fLike"));
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
	public int friendInsert(FriendDto fdto){
		int exec = 0;
		
		String sql = "insert into friendtable(uidx1, uidx2, fAddYn)"
		        +" values(?,?,1)";
		try{
		conn.setAutoCommit(false);
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, fdto.getFidx());
		pstmt.setInt(2, fdto.getUidx1());
		pstmt.setInt(2, fdto.getUidx2());
		pstmt.setString(2, fdto.getfAddYn());
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
