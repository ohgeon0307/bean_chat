package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.BoardDto;
import app.dto.SearchCriteriaDto;

public class BoardDao {
	
	private Connection conn;
	private PreparedStatement pstmt;
	
	public BoardDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	public ArrayList<BoardDto> boardSelectAll(SearchCriteriaDto scri) {
	    ArrayList<BoardDto> alist = new ArrayList<BoardDto>();
	    ResultSet rs = null;

	    String str = "";
	    if (!scri.getKeyword().equals("")) {
	        str = " and " + scri.getSearchType() + " like concat('%', ?, '%') ";
	    }

	    String sql = "SELECT bidx, subject, writer, viewcnt, writedate "
	            + "FROM boardtable "
	            + "WHERE bDelYn = 'N' "
	            + str
	            + "ORDER BY bidx DESC LIMIT ?, ?";

	    try {
	        pstmt = conn.prepareStatement(sql);

	        if (!scri.getKeyword().equals("")) {
	            pstmt.setString(1, scri.getKeyword());
	            pstmt.setInt(2, (scri.getPage() - 1) * scri.getPerPageNum());
	            pstmt.setInt(3, scri.getPerPageNum());
	        } else {
	            pstmt.setInt(1, (scri.getPage() - 1) * scri.getPerPageNum());
	            pstmt.setInt(2, scri.getPerPageNum());
	        }

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            BoardDto bdto = new BoardDto();
	            bdto.setBidx(rs.getInt("bidx"));
	            bdto.setSubject(rs.getString("subject"));
	            bdto.setWriter(rs.getString("writer"));
	            bdto.setViewCnt(rs.getInt("viewcnt"));

	            // 날짜 형식을 변환하여 저장
	            java.util.Date utilDate = rs.getDate("writedate");
	            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	            bdto.setWriteDate(sqlDate.toString());

	            alist.add(bdto);
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
	        } catch (SQLException e) {
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
				bdto.setWriteDate(rs.getString("writedate"));
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
	
	public int boardModify(BoardDto bdto) {
		int exec = 0;
		String sql = "update boardtable set\r\n"
				+ "subject = ?, \r\n"
				+ "contents = ?, \r\n"
				+ "writer = ?, \r\n"
				+ "modifydate = now() \r\n"
				+ "where bidx = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bdto.getSubject());
			pstmt.setString(2, bdto.getContents());
			pstmt.setString(3, bdto.getWriter());
			pstmt.setInt(4, bdto.getBidx());
			
			exec = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return exec;
	}
	
	public int boardDelete(int bidx) {
		int exec = 0;
		
		String sql = "update boardtable set\r\n"
				+ "bDelYn = 'Y', \r\n"
				+ "modifydate = now() \r\n"
				+ "where bidx = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bidx);
			
			exec = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return exec;
	}
	
	 public String getAuthorUidx(int bidx) {
	        String authorUidx = null;

	        // 해당 글의 작성자 uidx를 가져오는 SQL 쿼리
	        String sql = "SELECT uidx FROM boardtable WHERE bidx = ?";

	        try {
	            // 데이터베이스 연결 등의 초기 작업 수행

	            pstmt = conn.prepareStatement(sql);
	            pstmt.setInt(1, bidx);
	            ResultSet rs = pstmt.executeQuery();

	            if (rs.next()) {
	                // 결과에서 작성자 ID를 가져옴
	            	authorUidx = rs.getString("uidx");
	            }

	            // 사용한 자원 반환 등의 마무리 작업 수행

	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return authorUidx;
	    }
	 
	 public int boardTotalCount(SearchCriteriaDto scri) {
		 int value = 0;
		 
		 String str = "";
		 if (!scri.getKeyword().equals("")) {
			 str =" and " +scri.getSearchType()+" like concat('%', '"+scri.getKeyword()+"', '%') ";
		 }
		 
		 String sql="select count(*) as cnt from boardtable where bDelYn='N' "+str;
		 ResultSet rs = null;
		 try {
			 pstmt = conn.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 
			 if (rs.next()) {
				 value = rs.getInt("cnt");
			 }
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		 return value;
	 }
	 
	 public int boardCntUpdate(int bidx) {
		    int exec = 0;

		    String sql = "UPDATE boardtable SET viewCnt = viewCnt + 1 WHERE bidx = ?";

		    try {
		        conn.setAutoCommit(false);
		        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
		            pstmt.setInt(1, bidx);
		            exec = pstmt.executeUpdate();
		        }
		        conn.commit();
		    } catch (SQLException e) {
		        e.printStackTrace();
		        try {
		            if (conn != null) {
		                conn.rollback();
		            }
		        } catch (SQLException rollbackEx) {
		            rollbackEx.printStackTrace();
		        }
		    } finally {
		        try {
		            if (conn != null) {
		                conn.setAutoCommit(true);
		            }
		        } catch (SQLException autoCommitEx) {
		            autoCommitEx.printStackTrace();
		        }
		    }

		    return exec;
	
	
	}
}
