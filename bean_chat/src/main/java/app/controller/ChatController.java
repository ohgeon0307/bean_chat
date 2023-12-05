package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.ChatDao;
import app.dao.UserDao;
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

		 if (location.equals("chatRoomList.do")) {

	         String path = "/chat/chat_room_list.jsp";
	         // 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
	         RequestDispatcher rd = request.getRequestDispatcher(path);
	         rd.forward(request, response);

	      }
		 	else if (location.equals("saveMessage.do")) {
		    HttpSession session = request.getSession();
		    int uidx = (int) session.getAttribute("uidx");
		    String sender = (String) session.getAttribute("userId");  // 추가: sender 정보

		    // 사용자가 입력한 메시지를 가져옴
		    String message = request.getParameter("message");
		    System.out.println("메세지 뭐라보냈니 ? : " + message);

		    // ChatDto를 생성하고 정보 설정
		    ChatDto chatDto = new ChatDto(uidx, sender, message);  // 수정: sender 정보 추가

		    // ChatDao를 통해 채팅 메시지를 DB에 저장
		    ChatDao cdao = new ChatDao();
		    cdao.saveChatMessage(chatDto);

		    // 응답 없음 (로그아웃을 수행하지 않음)
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
