package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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
import app.dto.ChatRoomDto;

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

	         String path = "/chat/chat_index.jsp";
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

		    
		} else if (location.equals("createChatRoom.do")) {
			
			RequestDispatcher rd = request.getRequestDispatcher("create_chat_room.jsp");
			rd.forward(request, response);
			
		} else if (location.equals("createChatRoomAction.do")) {
			
			String roomName = request.getParameter("roomName");
			
			int chatRoomId = createChatRoom(roomName, request);
			
			HttpSession session = request.getSession();
			session.setAttribute("chatRoomId", chatRoomId);
			
			response.sendRedirect(request.getContextPath() + "/chat/chat_index.jsp");
		} else if(location.equals("joinChatRoom.do")) {
			
			RequestDispatcher rd = request.getRequestDispatcher("/joinChatRoomList.jsp");
			rd.forward(request, response);
		} else if(location.equals("selectChatRoom.do")) {
			
			int selectedChatRoomId = Integer.parseInt(request.getParameter("selectedChatRoomId"));
			
			HttpSession session = request.getSession();
			session.setAttribute("chatRoomId", selectedChatRoomId);
			
			response.sendRedirect(request.getContextPath() + "/chat/chat_index.jsp");
		} else if (location.equals("viewChatRoomList.do")) {
			viewChatRoomList(request, response);
		}
	}
	
	private int createChatRoom(String roomName, HttpServletRequest request) {
	    // 채팅 방 생성 및 데이터베이스에 저장하는 로직을 여기에 추가합니다.
	    // 예시로 ChatDao를 사용한 코드입니다.
	    ChatDao chatDao = new ChatDao();
	    return chatDao.createChatRoom(roomName, request);
	} 
	
	private void viewChatRoomList(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    HttpSession session = request.getSession();
	    int userId = (int) session.getAttribute("uidx");

	    // ChatDao를 통해 사용자의 채팅방 목록을 가져옴
	    ChatDao chatDao = new ChatDao();
	    List<ChatRoomDto> chatRooms = chatDao.getChatRoomsByUserId(userId);

	    // 채팅방 목록을 request에 설정
	    request.setAttribute("chatRooms", chatRooms);

	    // 채팅방 목록을 보여줄 JSP 페이지로 포워드
	    RequestDispatcher rd = request.getRequestDispatcher("/chat/chat_room_list.jsp");
	    rd.forward(request, response);
	}
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
