package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		
		String sql = "select bidx, subject,writer,viewcnt,writedate\r\n"
					+ "from boardtable\r\n"
					+ "where bDelYn ='N'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
	
		
		while(rs.next()) {
			BoardDto bdto = new BoardDto();
			bdto.setBidx(rs.getInt("bidx"));
			bdto.setSubject(rs.getString("subject"));
			bdto.setWriter(rs.getString("writer"));
			bdto.setViewCnt(rs.getInt("viewCnt"));
			bdto.setWriteDate(rs.getString("writeDate"));
			alist.add(bdto);
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
	
	public int boardInsert(BoardDto bdto) {
		int exec = 0;
		
		String sql = "INSERT INTO boardtable(bidx,subject,contents,writer,uidx,filename)\r\n"
				+ "VALUES(?,?,?,?,?,?)";
		
		try{
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bdto.getBidx());
			pstmt.setString(2, bdto.getSubject());
			pstmt.setString(3, bdto.getContents());
			pstmt.setString(4, bdto.getWriter());
			pstmt.setInt(5, bdto.getUidx());	
			pstmt.setString(6, bdto.getFileName());
			
			
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
	
	public BoardDto boardSelectOne(int bidx) {
		BoardDto bdto = null;
		String sql = "select * from boardtable where bidx=?";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bdto = new BoardDto();
				bdto.setSubject(rs.getString("subject"));
				bdto.setContents(rs.getString("contents"));
				bdto.setWriter(rs.getString("writer"));
				bdto.setBidx(rs.getInt("bidx"));
				bdto.setViewCnt(rs.getInt("viewcnt"));
				bdto.setbList(rs.getString("bList"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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
		
		return bdto;
	}
	}
