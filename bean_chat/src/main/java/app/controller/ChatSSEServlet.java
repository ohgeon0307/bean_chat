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

      /*
       * int uidx = (Integer)session.getAttribute("uidx");
       * 
       * UserDao udao = new UserDao(); UserDto udto = udao.UserSelectOne(uidx);
       * 
       * request.setAttribute("udto", udto);
       */
        
        int chatRoomId = (int) session.getAttribute("chatRoomId");

        // 최근메세지 끌어오기
        ChatDao cdao = new ChatDao();
        List<ChatDto> messages = cdao.getRecentChatMessages(chatRoomId, 10);

        for (ChatDto chatDto : messages) {
            sendMessageToClient(writer, chatDto.getSender() + ": " + chatDto.getMessage());
        }
    }

    private static void sendMessageToClient(PrintWriter writer, String message) {
        writer.write(message + "\n\n");
        writer.flush();
    }
}