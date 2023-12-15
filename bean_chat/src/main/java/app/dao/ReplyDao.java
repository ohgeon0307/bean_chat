package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.CommentsDto;
import app.dto.UserDto;

public class ReplyDao {
	
		//멤버변수 선언하고 전역으로 활용한다
		private Connection conn;  //멤버변수는 선언만해도 자동초기화됨
		private PreparedStatement pstmt;
			
		//생성자를 만든다 DB연결
		public ReplyDao() {
			DbConn dbconn = new DbConn();
			this.conn = dbconn.getConnection();
		}	
	
		public ArrayList<CommentsDto>  commentSelectAll(){
			//무한배열클래스 객체생성해서 데이터를 담을 준비를 한다
			ArrayList<CommentsDto> alist =new ArrayList<CommentsDto>();
			ResultSet rs = null;
			String sql="select * from replytable where delyn='N' order by replyidx desc";
			try{
				//1.창고(컬렉션)를 만든다
				//2.쿼리를 실행해서 데이터를 전용객체에 담아온다 
				//3.전용객체에 있는 데이터를 회원객체(MemberVo)에 옮겨담는다 
				//4.회원객체를 창고(컬렉션)에 집어넣는다	
				
				//구문(쿼리)객체
				pstmt = conn.prepareStatement(sql);
				//DB에 있는 값을 담아오는 전용객체
				rs = pstmt.executeQuery();
				//rs.next()는 다음값이 있는지 확인하는 메소드 있으면true
				while(rs.next()){
					CommentsDto cdto = new CommentsDto();
					//rs에서 midx값 꺼내서 mv에 옮겨담는다
					cdto.setReplyiDx(rs.getInt("replyidx"));
					cdto.setBidx(rs.getInt("bidx"));
					cdto.setrWriter( rs.getString("rwriter") );
					cdto.setrContent( rs.getString("rcontent"));
					cdto.setrDate( rs.getString("rdate"));
					cdto.setUidx(rs.getInt("uidx"));
					alist.add(cdto);
					//반복문 돌릴때마다 창고(컬렉션)에 추가해서 담는다
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
		
		
		public int commentInsert(CommentsDto cdto){
			System.out.println("내용은?"+cdto.getrContent());
			
			int exec = 0;			
			String sql = "insert into replytable(rwriter,rcontent,rdate,bidx,replyidx,uidx) values(?,?,?,?,?,?)";
			
			try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cdto.getrWriter());
			pstmt.setString(2, cdto.getrContent());
			pstmt.setString(3,cdto.getrDate());
			pstmt.setInt(4, cdto.getBidx());
			pstmt.setInt(5, cdto.getReplyiDx());
			pstmt.setInt(6, cdto.getUidx());
			exec = pstmt.executeUpdate();   //실행이되면 1값 안되면 0값
			}catch(Exception e){
				e.printStackTrace();
			}finally {				
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}			
			
			return exec;	
		}
		
		public int commentDelete(int repiyidx){		
			
			int exec = 0;			
			String sql = "update replytable set delyn='Y' where replyidx=?";
			
			try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, repiyidx);
					
			exec = pstmt.executeUpdate();   //실행이되면 1값 안되면 0값
			}catch(Exception e){
				e.printStackTrace();
			}finally {				
				try {
					pstmt.close();
					conn.close();
				} catch (SQLException e) {					
					e.printStackTrace();
				}
			}			
			
			return exec;	
		}

}
