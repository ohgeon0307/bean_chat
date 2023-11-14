package app.controller;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.ChatDao;

@WebServlet("/ChatController")
public class ChatController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String location;

	public ChatController(String location) {
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
			// 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
//
		}
	}

}
