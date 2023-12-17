package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/CommentsController")
public class CommentsController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private String location;

    public CommentsController(String location) {
        this.location = location;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (location.equals("commentList.do")) {
        	
        	HttpSession session = request.getSession();
			int uidx = (Integer)session.getAttribute("uidx");

			
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			
			request.setAttribute("udto", udto);

            CommentsDao rdao = new CommentsDao();
            ArrayList<CommentsDto> list = rdao.commentSelectAll();

            String str = "[";
            for (int i = 0; i < list.size(); i++) {
                CommentsDto comment = list.get(i);
                str += "{\"replyidx\":\"" + comment.getReplyiDX() + "\",\"rwriter\":\"" + comment.getrWriter()
                        + "\",\"rcontent\":\"" + comment.getrContent() + "\",\"rdate\":\"" + comment.getrDate()
                        + "\",\"bidx\":\"" + comment.getBidx() + "\",\"uidx\":\"" + comment.getUidx() + "\"}";

                if (i < list.size() - 1) {
                    str += ",";
                }
            }
            str += "]";

            PrintWriter out = response.getWriter();
            out.println(str);

        } else if (location.equals("commentWrite.do")) {      	
        	HttpSession session = request.getSession();
			int uidx = (Integer)session.getAttribute("uidx");

			
			UserDao udao = new UserDao();
			UserDto udto = udao.UserSelectOne(uidx);
			
			request.setAttribute("udto", udto);
        	
        	String bidx = request.getParameter("bidx");
        	System.out.println(bidx);
            String rwriter = request.getParameter("rWriter");
            System.out.println(rwriter);
            String rcontent = request.getParameter("rContent");
            String rdate = request.getParameter("rDate"); // 댓글 작성일시 받아오기

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