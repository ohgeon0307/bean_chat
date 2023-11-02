package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.BoardDto;

public class BoardDao {
	
	private Connection conn;
	private PreparedStatement pstmt;
	
	public BoardDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	public ArrayList<BoardDto> boardSelectAll() {
		
		ArrayList<BoardDto> alist = new ArrayList<BoardDto>();
		ResultSet rs = null;
		
		String sql = "select bidx, subject,writer,viewcnt,writeday\r\n"
					+ "from boardtable\r\n\""
					+ "where bDelyn ='N'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	
		
		while(rs.next()) {
			BoardDto bdto = new BoardDto();
			bdto.setBidx(rs.getInt("bidx"));
			bdto.setSubject(rs.getString("subject"));
			bdto.setWriter(rs.getString("writer"));
			bdto.setViewCnt(rs.getInt("viewcnt"));
			bdto.setWriteDate(rs.getString("writeday"));
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
}
