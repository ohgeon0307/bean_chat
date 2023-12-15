package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.ReplyDao;
import app.dao.UserDao;
import app.dto.CommentsDto;
import app.dto.UserDto;


@WebServlet("/CommentsController")
public class CommentsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private String location; 
	public CommentsController(String location){
		this.location = location;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if (location.equals("commentList.do")) {
			
			ReplyDao rdao =new ReplyDao();
			ArrayList<CommentsDto> list =  rdao.commentSelectAll();
			int listCnt = list.size();
			int replyidx =0;
			String rwriter="";
			String rcontent="";
			String rdate="";
			int bidx =0;
			int uidx =0;
			String str ="";
			
			for(int i=0; i<listCnt; i++) {
				replyidx = list.get(i).getReplyiDx();
				rwriter = list.get(i).getrWriter();
				rcontent = list.get(i).getrContent();
				rdate = list.get(i).getrDate();
				bidx = list.get(i).getBidx();
				uidx = list.get(i).getUidx();
				
				String comma = "";
				if (i == listCnt-1 ) {  //마지막 횟수이면
					comma = "";
				}else {
					comma = ",";
				}
				
				str = str + "{\"replyidx\":\""+replyidx+"\",\"rwriter\":\""+rwriter+"\",\"rcontent\":\""+rcontent+"\",\"rdate\":\""+rdate+"\",\"replyidx\":\""+replyidx+"\"}"+comma;				
			}			
						
			PrintWriter out = response.getWriter();
			out.println("["+str+"]");
			
		}else if(location.equals("commentWrite.do")) {
			
			String bidx = request.getParameter("bidx");
			String replyidx = request.getParameter("replyidx");
			String rwriter = request.getParameter("rwriter");
			String rcontent = request.getParameter("rcontent");
			String rdate = request.getParameter("rdate");
			String uidx = request.getParameter("uidx");
			
			CommentsDto cdto = new CommentsDto();
			cdto.setBidx(Integer.parseInt(bidx));
			cdto.setReplyiDx(Integer.parseInt(replyidx));
			cdto.setrWriter(rwriter);
			cdto.setrContent(rcontent);
			cdto.setrDate(rdate);
			cdto.setUidx(Integer.parseInt(uidx));
			
			int value=0;
			//댓글입력 메소드 만든다
			ReplyDao rdao = new ReplyDao();
			value = rdao.commentInsert(cdto);			
			
			String str ="{\"value\":\""+value+"\"}";
			
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("commentDelete.do")) {
			
			String replyidx = request.getParameter("replyidx");
			int value=0;
			//처리하는 메소드를 만든다
			
			ReplyDao rdao = new ReplyDao();
			value = rdao.commentDelete(Integer.parseInt(replyidx));			
			
			String str ="{\"value\":\""+value+"\"}";
			
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}
		
	}	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
