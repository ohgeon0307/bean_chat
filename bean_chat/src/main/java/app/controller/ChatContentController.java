package app.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.ChatDao;
import app.dto.ChatDto;

@WebServlet("/ChatController")
public class ChatContentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String location;

	public ChatContentController(String location) {
		this.location = location;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (location.equals("chatList.do"))

		{
			String path = "/chat/chat_list.jsp";
			// 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}

		else if (location.equals("chat_group.do")) {

			request.setCharacterEncoding("UTF-8");
			response.setContentType("text/html;charset=UTF-8");
			String cFrom = request.getParameter("cFrom");
			String cTo = request.getParameter("cTo");
			String listType = request.getParameter("listType");
			
			if (cFrom == null || cFrom.equals("") || cTo == null || cTo.equals("") || listType == null
					|| listType.equals("")) 
				response.getWriter().write("0");
			else if(listType.equals("ten")) response.getWriter().write(getTen(cFrom,cTo)); 
			else {
				try {
					
					response.getWriter().write(getID(cFrom,cTo,listType));
				}catch(Exception e) {
					response.getWriter().write("");
				}
			}
			

			String path = "/chat/chat_group.jsp";
			// 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			}
		}
	public String getTen(String cFrom , String cTo) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDao chatDao =new ChatDao();
		ArrayList<ChatDto> chatList = chatDao.getChatListByRecent(cFrom, cTo, 10);
		if(chatList.size() == 0) return "";
		for(int i = 0; i <  chatList.size(); i++ ) {
			result.append("[{\"value\":\""+chatList.get(i).getcFrom()+"\"},");
			result.append("[{\"value\":\""+chatList.get(i).getcTo()+"\"},");
			result.append("[{\"value\":\""+chatList.get(i).getcContents()+"\"},");
			result.append("[{\"value\":\""+chatList.get(i).getcTime()+"\"}]");
			if(i !=chatList.size() -1) result.append(",");
			
		}
		result.append("],\"last\":\""+chatList.get(chatList.size()-1).getCidx()+"\"}");
		return result.toString();
	}
	public String getID(String cFrom , String cTo, String cidx) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDao chatDao =new ChatDao();
		ArrayList<ChatDto> chatList = chatDao.getChatListByID(cFrom, cTo, cidx);
		if(chatList.size() == 0) return "";
		for(int i = 0; i <  chatList.size(); i++ ) {
			result.append("[{\"value\":\""+chatList.get(i).getcFrom()+"\"},");
			result.append("[{\"value\":\""+chatList.get(i).getcTo()+"\"},");
			result.append("[{\"value\":\""+chatList.get(i).getcContents()+"\"},");
			result.append("[{\"value\":\""+chatList.get(i).getcTime()+"\"}]");
			if(i !=chatList.size() -1) result.append(",");
			
		}
		result.append("],\"last\":\""+chatList.get(chatList.size()-1).getCidx()+"\"}");
		return result.toString();
	}

}
