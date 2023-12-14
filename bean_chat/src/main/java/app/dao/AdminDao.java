package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.SearchCriteriaDto;
import app.dto.UserDto;

public class AdminDao {
	private Connection conn;
	private PreparedStatement pstmt;

	public AdminDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
		
	}


	//유저 리스트 불러오기
	public ArrayList<UserDto> userSelectAll(SearchCriteriaDto scri){
		ArrayList<UserDto> alist = new ArrayList<UserDto>();
		ResultSet rs = null;
		
		 System.out.println(scri.getPage());
		 System.out.println(scri.getPerPageNum());
		
		String str = "";
	    if (!scri.getKeyword().equals("")) {
	        str = " and " + scri.getSearchType() + " like concat('%', ?, '%') ";
	    }
		
	    String sql = "Select uidx, userid, usernickname, username, userdate "
	            + "from usertable "
	            + "where uDelYn='N' and adminYn='N' "
	            + str
	            + "ORDER BY uidx DESC LIMIT ?, ?";

		try{			
			//구문(쿼리)객체
			pstmt = conn.prepareStatement(sql);
			
			 if (!scri.getKeyword().equals("")) {
		            pstmt.setString(1, scri.getKeyword());
		            pstmt.setInt(2, (scri.getPage()-1) * scri.getPerPageNum());
		           
		            //-15
		            pstmt.setInt(3, scri.getPerPageNum());
		            //15
		        } else {
		            pstmt.setInt(1, (scri.getPage() - 1) * scri.getPerPageNum());
		            pstmt.setInt(2, scri.getPerPageNum());
		        }
			//DB에 있는 값을 담아오는 전용객체
			rs = pstmt.executeQuery();
	
			while(rs.next()){
				UserDto udto = new UserDto();
				udto.setUidx( rs.getInt("uidx")); 
				udto.setUserId( rs.getString("userId"));
				udto.setUserNickname( rs.getString("userNickname"));
				udto.setUserName( rs.getString("userName"));
				
				  // 날짜 형식을 변환하여 저장
	            java.util.Date utilDate = rs.getDate("userDate");
	            java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
	            udto.setUserDate(sqlDate.toString());
				
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
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return alist;
	}

	public int userTotalCount(SearchCriteriaDto scri) {
		 int value = 0;
		 
		 String str = "";
		 if (!scri.getKeyword().equals("")) {
			 str =" and " +scri.getSearchType()+" like concat('%', '"+scri.getKeyword()+"', '%') ";
		 }
		 
		 String sql="select count(*) as cnt from usertable where uDelYn='N' and adminYn='N' "+str;
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












}
