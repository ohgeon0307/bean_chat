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

@WebServlet("/ChatContentController")
public class ChatContentController extends HttpServlet {
   private static final long serialVersionUID = 1L;
   private String location;

   public ChatContentController(String location) {
      this.location = location;
   }

   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      if (location.equals("chatList.do")){
         String path = "/chat/chat_list.jsp";
         // 화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
         RequestDispatcher rd = request.getRequestDispatcher(path);
         rd.forward(request, response);
      }else if (location.equals("chat_one.do")) {
         request.setCharacterEncoding("UTF-8");
         response.setContentType("text/html;charset=UTF-8");
         String cFrom = request.getParameter("cFrom");
         String cTo = request.getParameter("cTo");
         String listType = request.getParameter("listType");
         
         if (cFrom == null || cFrom.equals("") || cTo == null || cTo.equals("") || listType == null
               || listType.equals("")){
            response.getWriter().write("0");
         }else if(listType.equals("ten")) response.getWriter().write(getTen(URLDecoder.decode( cFrom,"UTF-8"),URLDecoder.decode(cTo,"UTF-8"))); 
         else {
            try {
               
               response.getWriter().write(getID(URLDecoder.decode( cFrom,"UTF-8"),URLDecoder.decode(cTo,"UTF-8"), listType));
            }catch(Exception e) {
               response.getWriter().write("");
            }
         
         //   System.out.println("값이담기나?"+cTo);
         }
      }
         
         }
      
   public String getTen(String cFrom , String cTo) {
      StringBuffer result = new StringBuffer("");
      result.append("{\"result\":[");
      ChatDao chatDao =new ChatDao();
      ArrayList<ChatDto> chatList = chatDao.getChatListByRecent(cFrom, cTo, 10);
      if(chatList.size() == 0) return "";
      for(int i = 0; i <  chatList.size(); i++ ) {
    	  
    	  String fromNickname = chatDao.getUserNickname(chatList.get(i).getcFrom());
          String toNickname = chatDao.getUserNickname(chatList.get(i).getcTo());

          result.append("[{\"fromNickname\":\"" + fromNickname + "\"},");
          result.append("{\"toNickname\":\"" + toNickname + "\"},");
         result.append("{\"value\":\""+chatList.get(i).getcContents()+"\"},");
         result.append("{\"value\":\""+chatList.get(i).getcTime()+"\"}]");
         
      

         result.append("]");
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
    	   String fromNickname = chatDao.getUserNickname(chatList.get(i).getcFrom());
           String toNickname = chatDao.getUserNickname(chatList.get(i).getcTo());

           result.append("[{\"fromNickname\":\"" + fromNickname + "\"},");
           result.append("{\"toNickname\":\"" + toNickname + "\"},");
         result.append("{\"value\":\""+chatList.get(i).getcContents()+"\"},");
         result.append("{\"value\":\""+chatList.get(i).getcTime()+"\"}]");
         if(i !=chatList.size() -1) result.append(",");
         
      }
      result.append("],\"last\":\""+chatList.get(chatList.size()-1).getCidx()+"\"}");
      return result.toString();
      
      //
   }
   
   
}