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
import javax.servlet.http.HttpSession;

import app.dao.ChatDao;
import app.dto.ChatDto;

@WebServlet("/ChatController")
public class ChatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String location;

	public ChatController(String location) {
		this.location = location;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (location.equals("chatList.do")) {

			String path = "/chat/chat_list.jsp";
			// 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (location.equals("chatOne.do")) {

			response.setContentType("application/json");
			String cFrom = request.getParameter("cFrom");
			String cTo = request.getParameter("cTo");
			String listType = request.getParameter("listType");

			if (cFrom == null || cFrom.equals("") || cTo == null || cTo.equals("") || listType == null
					|| listType.equals("")) {
				response.getWriter().write("");
			} else if (listType.equals("ten"))
				response.getWriter().write(getTen(URLDecoder.decode(cFrom, "UTF-8"), URLDecoder.decode(cTo, "UTF-8")));
			else {
				response.setContentType("application/json");
				try {
					response.getWriter()
							.write(getID(URLDecoder.decode(cFrom, "UTF-8"), URLDecoder.decode(cTo, "UTF-8"), listType));
				} catch (Exception e) {
					response.setContentType("application/json");
					response.getWriter().write("");
				}

				// System.out.println("값이담기나?"+cTo);
			}

			String path = "/chat/chat_one.jsp";
			// 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
			

		} else if (location.equals("chat_group.do")) {
			response.setContentType("application/json");

			String cFrom = request.getParameter("cFrom");
			String cTo = request.getParameter("cTo");
			String cContents = request.getParameter("cContents");

			if (cFrom == null || cFrom.equals("") || cTo == null || cTo.equals("") || cContents == null
					|| cContents.equals("")) {
				response.getWriter().write("0");

			} else {
				cFrom = URLDecoder.decode(cFrom, "UTF-8");
				cTo = URLDecoder.decode(cTo, "UTF-8");
				cContents = URLDecoder.decode(cContents, "UTF-8");
				response.getWriter().write(new ChatDao().submit(cFrom, cTo, cContents) + "");

			}

			String path = "/chat/chat_group.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}
	}

	public String getTen(String cFrom, String cTo) {

		StringBuffer result = new StringBuffer("");
	
			

		result.append("{\"result\":[");
		ChatDao chatDao = new ChatDao();
		ArrayList<ChatDto> chatList = chatDao.getChatListByRecent(cFrom, cTo, 10);
		if (chatList.size() == 0)
			return "";
		for (int i = 0; i < chatList.size(); i++) {

			String fromNickname = chatDao.getUserNickname(chatList.get(i).getcFrom());
			String toNickname = chatDao.getUserNickname(chatList.get(i).getcTo());
			System.out.println("fromNickname" + fromNickname);
			System.out.println("toNickname" + toNickname);
			result.append("{");
			result.append("\"fromNickname\":\"" + fromNickname + "\",");
			result.append("\"toNickname\":\"" + toNickname + "\",");
			result.append("\"value\":\"" + chatList.get(i).getcContents() + "\",");
			result.append("\"value\":\"" + chatList.get(i).getcTime() + "\"");
			result.append("}");
			if (i != chatList.size() - 1)
				result.append(",");


	
		}
		result.append("],\"last\":\"" + chatList.get(chatList.size() - 1).getCidx() + "\"}");
		return result.toString();
	}
	public String getID(String cFrom, String cTo, String cidx) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		ChatDao chatDao = new ChatDao();
		ArrayList<ChatDto> chatList = chatDao.getChatListByID(cFrom, cTo, cidx);
		if (chatList.size() == 0)
			return "";
		for (int i = 0; i < chatList.size(); i++) {
			String fromNickname = chatDao.getUserNickname(chatList.get(i).getcFrom());
			String toNickname = chatDao.getUserNickname(chatList.get(i).getcTo());
			result.append("{");
			result.append("\"fromNickname\":\"" + fromNickname + "\",");
			result.append("\"toNickname\":\"" + toNickname + "\",");
			result.append("\"value\":\"" + chatList.get(i).getcContents() + "\",");
			result.append("\"time\":\"" + chatList.get(i).getcTime() + "\"");
			result.append("}");
			if (i != chatList.size() - 1)
				result.append(",");
		}
		result.append("],\"last\":\"" + chatList.get(chatList.size() - 1).getCidx() + "\"}");
		return result.toString();

	}
	
}