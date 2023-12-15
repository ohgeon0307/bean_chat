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

import com.mysql.cj.Session;

import app.dao.ChatDao;
import app.dao.UserDao;
import app.dto.ChatDto;
import app.dto.ChatRoomDto;
import app.dto.UserDto;

@WebServlet("/ChatController")
public class ChatController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String location;

	public ChatController(String location) {
		this.location = location;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if (location.equals("chatIndex.do")) {
		

			String path = "/chat/chat_index.jsp";
			// 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);

		} else if (location.equals("saveMessage.do")) {
		    HttpSession session = request.getSession();
		    int uidx = (Integer) session.getAttribute("uidx");
		    
		    UserDao udao = new UserDao(); 
			UserDto udto = udao.UserSelectOne(uidx);
		    String sender =udto.getUserName();
		    request.setAttribute("userName", sender);
			
		    //String sender = (String) session.getAttribute("userId"); // 추가: sender 정보
		    int chatRoomId = (int) session.getAttribute("chatRoomId"); // 추가: chatRoomId 정보

		    // 사용자가 입력한 메시지를 가져옴
		    String message = request.getParameter("message");
		    System.out.println("메세지 뭐라보냈니 ? : " + message);

		    // ChatDto를 생성하고 정보 설정
		    ChatDto chatDto = new ChatDto();
		    chatDto.setUidx(uidx);
		    chatDto.setSender(sender);
		    chatDto.setMessage(message);
		    chatDto.setChatRoomId(chatRoomId); // 수정: ChatRoomId 추가

		    // ChatDao를 통해 채팅 메시지를 DB에 저장
		    ChatDao cdao = new ChatDao();
		    cdao.saveChatMessage(chatDto);
		    
		 // 새로운 메시지를 클라이언트에게 전송
		    List<ChatDto> newMessages = cdao.getRecentChatMessages(chatRoomId, 1);
		    response.getWriter().write(messagesToJson(newMessages));
		}
		
		else if (location.equals("createChatRoom.do")) {

			RequestDispatcher rd = request.getRequestDispatcher("create_chat_room.jsp");
			rd.forward(request, response);

		} 
		
		else if (location.equals("createChatRoomAction.do")) {

			String roomName = request.getParameter("roomName");

			int chatRoomId = createChatRoom(roomName, request);

			HttpSession session = request.getSession();
			session.setAttribute("chatRoomId", chatRoomId);

			response.sendRedirect(request.getContextPath() + "/chat/viewChatRoomList.do");
		} 
		
		else if (location.equals("joinChatRoom.do")) {

			RequestDispatcher rd = request.getRequestDispatcher("/joinChatRoomList.jsp");
			rd.forward(request, response);
		} 
		
		else if (location.equals("selectChatRoom.do")) {
			int selectedChatRoomId = Integer.parseInt(request.getParameter("selectedChatRoomId"));
			
			System.out.println("선택된 채팅방룸아이디 : " + selectedChatRoomId);

		    HttpSession session = request.getSession();
		    session.setAttribute("chatRoomId", selectedChatRoomId);

		    // ChatDao 인스턴스 생성
		    ChatDao chatDao = new ChatDao();

		    // 여기서 채팅방의 채팅 내용을 가져와서 request에 설정
		    List<ChatDto> chatMessages = chatDao.getChatMessagesByRoomId(selectedChatRoomId);
		    request.setAttribute("chatMessages", chatMessages);
		    //다혜 추가
			
		    int uidx = (Integer) session.getAttribute("uidx");
		    
		    UserDao udao = new UserDao(); 
			UserDto udto = udao.UserSelectOne(uidx);
		    String sender =udto.getUserName();
		    request.setAttribute("userName", sender);
			
			request.setAttribute("udto", udto);
			//다혜추가 끝
			
		    // 채팅방 페이지로 포워드
		    RequestDispatcher rd = request.getRequestDispatcher("/chat/chat_room.jsp");
		    rd.forward(request, response);
		} else if (location.equals("viewChatRoomList.do")) {
			viewChatRoomList(request, response);
		}
	}

	// --------------메소드부분-------------

	private int createChatRoom(String roomName, HttpServletRequest request) {
		// 채팅 방 생성 및 데이터베이스에 저장하는 로직을 여기에 추가합니다.
		// 예시로 ChatDao를 사용한 코드입니다.
		System.out.println("방생성완료");
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
	
	private String messagesToJson(List<ChatDto> messages) {
	    // 여기에 messages를 JSON 형식으로 변환하는 로직을 작성
	    // 예시: 간단한 JSON 배열로 변환
	    StringBuilder json = new StringBuilder("[");
	    for (ChatDto message : messages) {
	        json.append("{\"sender\":\"").append(message.getSender()).append("\",\"message\":\"").append(message.getMessage()).append("\"},");
	    }
	    if (!messages.isEmpty()) {
	        json.deleteCharAt(json.length() - 1); // 마지막 쉼표 제거
	    }
	    json.append("]");
	    return json.toString();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
