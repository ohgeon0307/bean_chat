package app.controller;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



@WebServlet("/ChatController")
	public class ChatController extends HttpServlet{
	private static final long serialVersionUID = 1L;
		
		private String location;
		public ChatController(String location) {
			this.location = location;		
		}

		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			if(location.equals("chatList.do")) {
				

				String path ="/chat/chat_list.jsp";
				
				RequestDispatcher rd = request.getRequestDispatcher(path);
				rd.forward(request, response);
			}
		
		}
	}


