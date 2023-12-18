package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.CommentsDao;
import app.dao.UserDao;
import app.dto.CommentsDto;
import app.dto.UserDto;

@WebServlet("/CommentController")
public class CommentController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String location;

    public CommentController(String location){
		this.location = location;
	}

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (location.equals("commentList.do")) {

            CommentsDao rdao = new CommentsDao();
            ArrayList<CommentsDto> list = rdao.commentSelectAll();
            int listCnt = list.size();
            int ReplyiDX = 0;
            String rWriter = "";
            String rContents = "";
            String rDate = "";
            int uidx = 0;
            String str = "";
            
            for (int i = 0; i < listCnt; i++) {
            ReplyiDX = list.get(i).getReplyiDX();
            rWriter = list.get(i).getrWriter();
            rContents = list.get(i).getrContent();
            rDate = list.get(i).getrDate();
            uidx = list.get(i).getUidx();
            
            String comma = "";
            if ( i == listCnt-1) {
            	comma ="";
            } else {
            	comma = ",";
            }
            
            str = str + "{\"replyidx\":\""+ReplyiDX+"\",\"rWriter\":\""+rWriter+"\",\"rContent\":\""+rContents+"\",\"rDate\":\""+rDate+"\",\"uidx\":\""+uidx+"\"}"+comma;	
            }
            
            PrintWriter out = response.getWriter();
            out.println("["+str+"]");
        } else if (location.equals("commentWrite.do")) {
        	
        	
        	HttpSession session = request.getSession();
			int uidx = (Integer)session.getAttribute("uidx");

			
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			
			request.setAttribute("udto", udto);
        	
        	String bidx = request.getParameter("bidx");
            String rwriter = request.getParameter("rWriter");
            String rcontent = request.getParameter("rContent");
            java.util.Date date = new java.util.Date();
            Timestamp timestamp = new Timestamp(date.getTime());
            String rdate = timestamp.toString();

            // replyidx는 댓글에 대한 답글을 작성할 때만 필요하므로, 상황에 맞게 처리해야 함

            CommentsDto cdto = new CommentsDto();
            cdto.setBidx(Integer.parseInt(bidx));
            cdto.setrWriter(rwriter);
            cdto.setrContent(rcontent);
            cdto.setrDate(rdate); // rDate로 수정
            cdto.setUidx(uidx); // 유저 ID 설정

            int value = 0;
            CommentsDao rdao = new CommentsDao();
            value = rdao.commentInsert(cdto);

            String str = "{\"value\":\"" + value + "\"}";

            PrintWriter out = response.getWriter();
            out.println(str);
        } else if (location.equals("commentDelete.do")) {

            String replyidx = request.getParameter("replyidx");
            int value = 0;

            CommentsDao rdao = new CommentsDao();
            value = rdao.commentDelete(Integer.parseInt(replyidx));

            String str = "{\"value\":\"" + value + "\"}";

            PrintWriter out = response.getWriter();
            out.println(str);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}