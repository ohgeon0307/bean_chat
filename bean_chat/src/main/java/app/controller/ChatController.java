package app.controller;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
    	  response.setContentType("application/json");
         String path = "/chat/chat_list.jsp";
         // 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
         RequestDispatcher rd = request.getRequestDispatcher(path);
         rd.forward(request, response);
      }

      else if (location.equals("chat_one.do")) {
    	  response.setContentType("application/json");
         
      
         String cFrom = request.getParameter("cFrom");
         String cTo = request.getParameter("cTo");
         String cContents = request.getParameter("cContents");
         
          HttpSession session = request.getSession();
          session.setAttribute("cTo", cTo);
          
         if (cFrom == null || cFrom.equals("") || cTo == null || cTo.equals("") || cContents == null
               || cContents.equals("")) {
            response.getWriter().write("0"); //하나라도 값이 비어있는게 있으면 클라이언트에게 반환

         } else  {
            cFrom = URLDecoder.decode(cFrom, "UTF-8");
            cTo = URLDecoder.decode(cTo, "UTF-8");
            cContents = URLDecoder.decode(cContents, "UTF-8");
            String fromNickname = new ChatDao().getUserNickname(cFrom);
            String toNickname = new ChatDao().getUserNickname(cTo);

            request.setAttribute("fromNickname", fromNickname);
            request.setAttribute("toNickname", toNickname);

            response.getWriter().write(new ChatDao().submit(cFrom, cTo, cContents) + ""); //submit함수를 실행해서 실행한 결과를 반환할수있게 write해줌

         }
         
         String path = "/chat/chat_one.jsp";
         // 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
         RequestDispatcher rd = request.getRequestDispatcher(path);
         rd.forward(request, response);
//
      }
      else if (location.equals("chat_group.do")) {
    	  response.setContentType("application/json");
          //
          
          String cFrom = request.getParameter("cFrom");
          String cTo = request.getParameter("cTo");
          String cContents = request.getParameter("cContents");
          
           HttpSession session = request.getSession();
           session.setAttribute("cTo", cTo);
     
           
           
          if (cFrom == null || cFrom.equals("") || cTo == null || cTo.equals("") || cContents == null
                || cContents.equals("")) {
             response.getWriter().write("0");

          } else  {
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
} 