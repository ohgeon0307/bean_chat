package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.ChatDao;
import app.dao.UserDao;
import app.dto.ChatDto;
import app.dto.UserDto;

@WebServlet("/ChatSSEServlet")
public class ChatSSEServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final List<HttpServletResponse> clients = new CopyOnWriteArrayList<>();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/event-stream");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        response.setHeader("Connection", "keep-alive");

        HttpSession session = request.getSession();
        PrintWriter writer = response.getWriter();
        
        int chatRoomId = (int) session.getAttribute("chatRoomId");

        // 예시로 최근 1개의 메시지를 가져오도록 함, 현재 이 Dao의 메소드는 크게 의미는 없습니다. 10개를 가져오라고 시켰는데
        // 저희는 클라이언트가 메세지 요청을 보냈을때만 동작을하게끔 처리해놨어요.
        ChatDao cdao = new ChatDao();
        List<ChatDto> messages = cdao.getRecentChatMessages(chatRoomId, 1);

        for (ChatDto chatDto : messages) {
            sendMessageToClient(writer, chatDto.getSender() + ": " + chatDto.getMessage());
        }
    }

    private static void sendMessageToClient(PrintWriter writer, String message) {
        writer.write("data: " + message + "\n\n");
        writer.flush();
    }
}