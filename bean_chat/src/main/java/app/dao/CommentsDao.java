package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.dto.CommentsDto;

public class CommentsDao {

    private Connection conn;
    private PreparedStatement pstmt;

    public CommentsDao() {
        DbConn dbconn = new DbConn();
        this.conn = dbconn.getConnection();
    }

    public ArrayList<CommentsDto> commentSelectAll() {
        ArrayList<CommentsDto> alist = new ArrayList<CommentsDto>();
        ResultSet rs = null;
        String sql = "select * from replytable where delyn='N' order by replyidx desc";
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CommentsDto cdto = new CommentsDto();
                cdto.setReplyiDX(rs.getInt("replyidx"));
                cdto.setBidx(rs.getInt("bidx"));
                cdto.setrWriter(rs.getString("rwriter"));
                cdto.setrContent(rs.getString("rcontent"));
                cdto.setrDate(rs.getString("rdate"));
                cdto.setUidx(rs.getInt("uidx"));
                alist.add(cdto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                pstmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return alist;
    }

    public int commentInsert(CommentsDto cdto) {
        int exec = 0;
        String sql = "insert into replytable(rwriter,rcontent,rdate,bidx,replyidx,uidx) values(?,?,?,?,?,?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, cdto.getrWriter());
            pstmt.setString(2, cdto.getrContent());
            pstmt.setString(3, cdto.getrDate());
            pstmt.setInt(4, cdto.getBidx());
            pstmt.setInt(5, cdto.getReplyiDX());
            pstmt.setInt(6, cdto.getUidx());
            exec = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return exec;
    }

    public int commentDelete(int replyidx) {
        int exec = 0;
        String sql = "update replytable set delyn='Y' where replyidx=?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, replyidx);
            exec = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
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